const {
    getAllPaymenthistories,
    getPaymenthistory,
} = require("../controllers/paymenthistory.js");

const express = require("express");

const router = express.Router();

// Get all payment histories
router.get("/", getAllPaymenthistories);

// Get a payment history by ID
router.get("/:id", getPaymenthistory);

module.exports = router;
