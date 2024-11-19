const {
  createService,
  updateService,
  getServices,
  getService,
  deleteService,
} = require("../controllers/service.js");

const express = require("express");

const router = express.Router();

//Create Service
router.post("/", createService);

// Update a Service
router.put("/:id", updateService);

// Get all ServiceS
router.get("/", getServices);

// Get a Service by ID
router.get("/:id", getService);

// Delete a Service
router.delete("/:id", deleteService);

module.exports = router;
