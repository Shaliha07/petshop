const {
  createAppointment,
  updateAppointment,
  getAppointments,
  getAppointment,
  deleteAppointment,
} = require("../controllers/appointment.js");
const { verifyToken, isOwnerOrAdmin } = require("../middlewares/authRole.js");

const express = require("express");

const router = express.Router();

//Create Appointment
router.post("/", verifyToken, createAppointment);

// Update a Appointment
router.put("/:id", isOwnerOrAdmin,verifyToken, updateAppointment);

// Get all AppointmentS
router.get("/", verifyToken,isOwnerOrAdmin, getAppointments);

// Get a Appointment by ID
router.get("/:id", verifyToken,isOwnerOrAdmin, getAppointment);

// Delete a Appointment
router.delete("/:id", isOwnerOrAdmin, verifyToken, deleteAppointment);

module.exports = router;
