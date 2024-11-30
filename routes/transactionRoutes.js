const {
  addTransaction,
  updateTransaction,
  getTransactionById,
  getAllTransactions,
  deleteTransaction,
} = require("../controllers/transaction.js");
const { verifyToken, isOwnerOrAdmin } = require("../middlewares/authRole.js");
const express = require("express");

const router = express.Router();

// Create Transaction
router.post("/", verifyToken, addTransaction);
// Update transaction
router.put("/:id", verifyToken,isOwnerOrAdmin, updateTransaction);
// Get transaction by ID
router.get("/:id", verifyToken,isOwnerOrAdmin, getTransactionById);
//Get all trasactions
router.get("/", verifyToken,isOwnerOrAdmin,getAllTransactions);
//Delete transaction
router.delete("/:id", verifyToken, isOwnerOrAdmin, deleteTransaction);

module.exports = router;
