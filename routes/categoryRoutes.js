const {
  createCategory,
  updateCategory,
  getCategories,
  getCategory,
  deleteCategory,
} = require("../controllers/category.js");

const express = require("express");

const router = express.Router();

//Create category
router.post("/", createCategory);

// Update a category
router.put("/:id", updateCategory);

// Get all categories
router.get("/", getCategories);

// Get a category by ID
router.get("/:id", getCategory);

// Delete a category
router.delete("/:id", deleteCategory);

module.exports = router;
