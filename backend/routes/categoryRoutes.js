const {
  createCategory,
  updateCategory,
  getCategories,
  getCategory,
  deleteCategory,
} = require("../controllers/category.js");
const { verifyToken,isAdmin } = require("../middlewares/authRole.js");

const express = require("express");

const router = express.Router();

//Create category
router.post("/",verifyToken,isAdmin,createCategory);

// Update a category
router.put("/:id", verifyToken,isAdmin, updateCategory);

// Get all categories
router.get("/",verifyToken, getCategories);

// Get a category by ID
router.get("/:id", verifyToken, getCategory);

// Delete a category
router.delete("/:id", isAdmin, verifyToken, deleteCategory);

module.exports = router;
