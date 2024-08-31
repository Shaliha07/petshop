import { db } from "../connect.js";
import bcrypt from "bcryptjs";
import dotenv from "dotenv";
import jwt from "jsonwebtoken";

// load env files from .env file
dotenv.config();

// making a variable to store jwt token from .env file
const JWT_SECRET = process.env.JWT_SECRET;

// register
export const register = (req, res) => {
  const { empid, empname, username, password, role, status } = req.body;

  // Check if the User already exists
  const checkQuery =
    "SELECT * FROM employees WHERE empid = $1 OR username = $2";

  db.query(checkQuery, [empid, username], (err, result) => {
    if (err) return res.status(500).json(err);
    if (result.rows.length > 0)
      return res.status(409).json("Employee already exists!");

    // Encrypt the password
    const salt = bcrypt.genSaltSync(10);
    const hashedPassword = bcrypt.hashSync(password, salt);

    const insertQuery =
      "INSERT INTO employees (empname,username, password,role, status) VALUES ($1, $2, $3, $4, $5)";

    const values = [empname, username, hashedPassword, role, "active"];

    db.query(insertQuery, values, (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Employee has been created!");
    });
  });
};

// login

export const login = (req, res) => {
  // Check if the employee exists
  const checkQuery =
    "SELECT * FROM employees WHERE username = $1 AND status = 'active'";

  db.query(checkQuery, [req.body.username], (err, data) => {
    if (err) return res.status(500).json(err);
    if (data.rows.length === 0)
      return res.status(404).json("Employee not found!");

    const employee = data.rows[0];

    const checkPassword = bcrypt.compareSync(
      req.body.password,
      employee.password
    );

    if (!checkPassword)
      return res.status(400).json("Wrong Password or Username!");

    // Generate a JWT token
    const token = jwt.sign(
      { empid: employee.empid, username: employee.username },
      JWT_SECRET,
      { expiresIn: "1h" } // Token expiry time
    );

    return res.status(200).json({ token });
  });
};

// logout

export const logout = (req, res) => {
  res
    .clearCookie("accessToken", {
      secure: true,
      sameSite: "none",
    })
    .status(200)
    .json("Employee has been logged out!");
};

// Update

export const updateEmployee = (req, res) => {
  const empid = req.params.id;
  const { empname, username, password, role, status } = req.body;

  // Check if password is provided before hashing
  let hashedPassword = "";
  if (password) {
    const salt = bcrypt.genSaltSync(10);
    hashedPassword = bcrypt.hashSync(password, salt);
  }

  const q =
    'UPDATE employees SET "empname" = $2, "username" = $3, "password" = $4, "role" = $5, "status" = $6 WHERE "empid" = $1';

  const values = [empid, empname, username, hashedPassword, role, status];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Employee has been updated successfully");
  });
};

// Get employee

export const getEmployee = (req, res) => {
  const empid = req.params.id;
  const q = "SELECT * FROM employees WHERE empid = $1";
  db.query(q, [empid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// get employees

export const getEmployees = (req, res) => {
  const q = "SELECT * FROM employees";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete employee

export const deleteEmployee = (req, res) => {
  const empid = req.params.id;
  const q = "DELETE FROM employees WHERE empid = $1";

  db.query(q, [empid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Employee has been deleted");
  });
};
