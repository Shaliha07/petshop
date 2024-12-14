const {
  getAllPaymenthistories,
  getPaymenthistory,
} = require("../controllers/paymenthistory.js");
const { verifyToken, isOwnerOrAdmin } = require("../middlewares/authRole.js");

const express = require("express");

const router = express.Router();

// Get all payment histories
router.get("/", verifyToken, isOwnerOrAdmin,  getAllPaymenthistories);

// Get a payment history by ID
router.get("/:id", verifyToken, isOwnerOrAdmin, getPaymenthistory);

module.exports = router;