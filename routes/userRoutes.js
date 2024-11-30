const {
  updateUser,
  getUsers,
  getUserById,
  deleteUser,
} = require("../controllers/user.js");
const { verifyToken, isOwnerOrAdmin,isAdmin } = require("../middlewares/authRole.js");
const express = require("express");

const router = express.Router();

// Update a user
router.put("/:id", verifyToken,isOwnerOrAdmin, updateUser);

// Get all users
router.get("/", verifyToken, isAdmin, getUsers);

// Get a user by ID
router.get("/:id", verifyToken, isOwnerOrAdmin, getUserById);

// Delete a user
router.delete("/:id", verifyToken, isOwnerOrAdmin, deleteUser);

module.exports = router;
