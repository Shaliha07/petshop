import { db } from "../connect.js";
import bcrypt from "bcryptjs";
import dotenv from "dotenv";
import jwt from "jsonwebtoken"

dotenv.config();
const JWT_SECRET = process.env.JWT_SECRET;
export const register = (req, res) => {
  const { userid, username, password, email, dob } = req.body;

  // Check if the User already exists
  const checkQuery = "SELECT * FROM users WHERE userid = $1 OR username = $2";

  db.query(checkQuery, [userid, username], (err, result) => {
    if (err) return res.status(500).json(err);
    if (result.rows.length > 0)
      return res.status(409).json("User already exists!");

    // Encrypt the password
    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = bcrypt.hashSync(password, salt);

    const insertQuery =
      "INSERT INTO users (username, password, email, dob, status) VALUES ($1, $2, $3, $4, $5)";

    const values = [username, hashedPassword, email, dob, "active"];

    db.query(insertQuery, values, (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("User has been created!");
    });
  });
};

// export const login = (req, res) => {
//   // Check if the user exists
//   const checkQuery =
//     "SELECT * FROM users WHERE username = $1 AND status = 'active'";

//   db.query(checkQuery, [req.body.username], (err, data) => {
//     if (err) return res.status(500).json(err);
//     if (data.rows.length === 0) return res.status(404).json("User not found!");

//     const user = data.rows[0];

//     // Check the password
//     const checkPassword = bcrypt.compareSync(req.body.password, user.password);

//     if (!checkPassword)
//       return res.status(400).json("Wrong Password or Username!");

//     // Generate a JWT token
//     const token = jwt.sign(
//       { userid: user.userid, username: user.username },
//       JWT_SECRET,
//       { expiresIn: "1h" } // Token expiry time
//     );

//     // Exclude password from the response
//     const { password: userPassword, ...userData } = user;

//     // Set the token as an HTTP-only cookie
//     res
//       .cookie("accessToken", token, {
//         httpOnly: true,
//       })
//       .status(200)
//       .json(userData);
//   });
// };

export const login = (req, res) => {
  // Check if the user exists
  const checkQuery =
    "SELECT * FROM users WHERE username = $1 AND status = 'active'";

  db.query(checkQuery, [req.body.username], (err, data) => {
    if (err) return res.status(500).json(err);
    if (data.rows.length === 0) return res.status(404).json("User not found!");

    const user = data.rows[0];

    const checkPassword = bcrypt.compareSync(req.body.password, user.password);

    if (!checkPassword)
      return res.status(400).json("Wrong Password or Username!");

    // Generate a JWT token
    const token = jwt.sign(
      { userid: user.userid, username: user.username },
      JWT_SECRET,
      { expiresIn: "1h" } // Token expiry time
    );

    return res.status(200).json({ token });
   });
 };

export const logout = (req, res) => {
  res
    .clearCookie("accessToken", {
      secure: true,
      sameSite: "none",
    })
    .status(200)
    .json("User has been logged out!");
};

export const updateUser = (req, res) => {
  const userid = req.params.id;
  const q =
    'UPDATE users SET "username" = $2, "password" = $3, "email" = $4, "dob" = $5, "status" = $6 WHERE "userid" = $1';

  const values = [
    req.body.username,
    req.body.password,
    req.body.email,
    req.body.dob,
    req.body.status,
  ];

  db.query(q, [userid, ...values], (err, data) => {
    if (err) return res.json(err);
    return res.json("User has been updated successfully");
  });
};

export const getUser = (req, res) => {
  const userid = req.params.id;
  const q = "SELECT * FROM users WHERE userid = $1";
  db.query(q, [userid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

export const getUsers = (req, res) => {
  const q = "SELECT * FROM users";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

export const deleteUser = (req, res) => {
  const userid = req.params.id;
  const q = "DELETE FROM users WHERE userid = $1";

  db.query(q, [userid], (err, data) => {
    if (err) return res.json(err);
    return res.json("User has been deleted");
  });
};
