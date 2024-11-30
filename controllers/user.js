const User = require("../models/User.js");
const logger = require("../middlewares/logger.js");
const bcrypt = require("bcryptjs");

exports.updateUser = async (req, res) => {
  const { id } = req.params;
  const {
    username,
    email,
    password,
    firstName,
    lastName,
    role,
    contactNumber,
    address,
  } = req.body;

  try {
    //Find the user by ID
    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    //Update the field
    if (username) {
      user.username = username;
    }
    if (email) {
      user.email = email;
    }
    if (password) {
      const salt = bcrypt.genSaltSync(12);
      const hashedPassword = bcrypt.hashSync(password, salt);
      user.password = hashedPassword;
    }
    if (firstName) {
      user.firstName = firstName;
    }
    if (lastName) {
      user.lastName = lastName;
    }
    if (role) {
      user.role = role;
    }
    if (contactNumber) {
      user.contactNumber = contactNumber;
    }
    if (address) {
      user.address = address;
    }

    //Save the updated user
    await user.save();

    logger.info("User updated succesfully:${user.username}(${user.email})");
    return res
      .status(200)
      .json({ message: "User updated successfully!", user });
  } catch (error) {
    logger.error("Error updating user:", error);
    return res
      .status(500)
      .json({ message: "Unable to update user", error: error.message });
  }
};

//Get all users

exports.getUsers = async (req, res) => {
  try {
    //Find all user with the status filter
    const users = await User.findAll({ where: { status: true } });

    logger.info("Users fetched successfully");
    return res.status(200).json({ users });
  } catch (error) {
    logger.error("Error getting users:", error);
    return res
      .status(500)
      .json({ message: "Unable to update user", error: error.message });
  }
};

//Get a user by ID

exports.getUserById = async (req, res) => {
  const { id } = req.params;

  try {
    //Find the user by ID
    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    logger.info("User fetched successfully : ${user.username} (${user.email})");
    return res.status(200).json({ user });
  } catch (error) {
    logger.error("Error fetching user:", error);
  }
};

// Delete a user (Set status to false)
exports.deleteUser = async (req, res) => {
  const { id } = req.params;

  try {
    // Find the user by ID
    const user = await User.findByPk(id);

    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }

    // Set user status to inactive
    user.status = false;
    await user.save();

    logger.info("User deleted successfully: ${user.username} (${user.email})");
    return res.status(200).json({ message: "User deleted successfully!" });
  } catch (error) {
    logger.error("Error deleting user:", error);
    return res
      .status(500)
      .json({ message: "Unable to delete user", error: error.message });
  }
};
