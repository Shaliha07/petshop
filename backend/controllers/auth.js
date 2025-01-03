const User = require("../models/User.js");
const bcrypt = require("bcryptjs");
const dotenv = require("dotenv");
const { Op } = require("sequelize");
const jwt = require("jsonwebtoken");
const logger = require("../middlewares/logger.js");

dotenv.config();

const JWT_SECRET = process.env.JWT;

// Register a new user
exports.register = async (req, res) => {
  const { username, email, password, firstName, lastName, role } = req.body;

  try {
    // Check if the user already exists
    const existingUser = await User.findOne({
      where: {
        [Op.or]: [{ username: username }, { email: email }],
      },
    });

    if (existingUser) {
      return res.status(400).json({ message: "User already exists" });
    }

    // Hash the password
    const salt = await bcrypt.genSalt(12);
    const hashedPassword = await bcrypt.hash(password, salt);

    // Create a new user
    const newUser = await User.create({
      username,
      email,
      password: hashedPassword,
      firstName,
      lastName,
      role,
      status: true,
    });

    // Generate a JWT Token
    const token = jwt.sign(
      {
        id: newUser.id,
        username: newUser.username,
        role: newUser.role,
      },
      JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Send the token and user details (without the password)
    const { password: userPassword, ...userData } = newUser.toJSON();

    logger.info("User created successfully!");
    return res
      .cookie("accessToken", token, { httpOnly: true, secure: true })
      .status(201)
      .json({ message: "User created successfully", token, user: userData });
  } catch (error) {
    logger.error("Error in registering a user: ", error);
    return res
      .status(500)
      .json({ message: "Unable to create a user", error: error.message });
  }
};

// Login a user
exports.login = async (req, res) => {
  const { username, password } = req.body;

  try {
    // Find user by username
    const user = await User.findOne({ where: { username, status: true } });

    if (!user) {
      return res.status(400).json({ message: "User not found" });
    }

    // Check if the password is correct
    const isMatch = bcrypt.compareSync(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ message: "Incorrect credentials" });
    }

    // Generate a JWT Token
    const token = jwt.sign(
      {
        id: user.id,
        username: user.username,
        role: user.role,
      },
      JWT_SECRET,
      { expiresIn: "1h" }
    );

    // Send the token and user details (without the password)
    const { password: userPassword, ...userData } = user.toJSON();

    logger.info(`User logged in successfully: ${JSON.stringify(userData)}`);
    res
      .cookie("accessToken", token, { httpOnly: true, secure: true })
      .status(200)
      .json({ message: "User logged in successfully!", token, user: userData });
  } catch (error) {
    logger.error("Error logging in user: ", error);
    return res
      .status(500)
      .json({ message: "Unable to login user", error: error.message });
  }
};

// Logout a user
exports.logout = (req, res) => {
  res.clearCookie("accessToken");
  res.status(200).json({ message: "User logged out successfully!" });
};
