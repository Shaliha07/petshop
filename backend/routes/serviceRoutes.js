const {
  createService,
  updateService,
  getServices,
  getService,
  deleteService,
} = require("../controllers/service.js");
const { verifyToken, isAdmin } = require("../middlewares/authRole.js");

const express = require("express");

const router = express.Router();

//Create Service
router.post("/", verifyToken, isAdmin, createService);

// Update a Service
router.put("/:id", verifyToken, isAdmin, updateService);

// Get all ServiceS
router.get("/", verifyToken, getServices);

// Get a Service by ID
router.get("/:id", verifyToken, getService);

// Delete a Service
router.delete("/:id", verifyToken, isAdmin, deleteService);

module.exports = router;
