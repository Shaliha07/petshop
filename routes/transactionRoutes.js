const {
  addTransaction,
  updateTransaction,
  getTransactionById,
  getAllTransactions,
  deleteTransaction,
} = require("../controllers/transaction.js");
const express = require("express");

const router = express.Router();

// Create Transaction
router.post("/", addTransaction);
// Update transaction
router.put("/:id", updateTransaction);
// Get transaction by ID
router.get("/:id", getTransactionById);
//Get all trasactions
router.get("/", getAllTransactions);
//Delete transaction
router.delete("/:id", deleteTransaction);

module.exports = router;
