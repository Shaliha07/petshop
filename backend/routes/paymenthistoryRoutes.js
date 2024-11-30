const {
  getAllPaymenthistories,
  getPaymenthistory,
} = require("../controllers/paymenthistory.js");
const { verifyToken, isOwnerOrAdmin } = require("../middlewares/authRole.js");

const express = require("express");

const router = express.Router();

// Get all payment histories
router.get("/", isOwnerOrAdmin, verifyToken, getAllPaymenthistories);

// Get a payment history by ID
router.get("/:id", isOwnerOrAdmin, verifyToken, getPaymenthistory);

module.exports = router;
