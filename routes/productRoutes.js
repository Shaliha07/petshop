const {
  createProduct,
  updateProduct,
  getProducts,
  getProduct,
  deleteProduct,
} = require("../controllers/product.js");
const { verifyToken, isAdmin } = require("../middlewares/authRole.js");

const express = require("express");

const router = express.Router();

//Create Product
router.post("/", isAdmin, verifyToken, createProduct);

// Update a Product
router.put("/:id", isAdmin, verifyToken, updateProduct);

// Get all ProductS
router.get("/", verifyToken, getProducts);

// Get a Product by ID
router.get("/:id", verifyToken, getProduct);

// Delete a Product
router.delete("/:id", isAdmin, verifyToken, deleteProduct);

module.exports = router;
