const {
  createAppointment,
  updateAppointment,
  getAppointments,
  getAppointment,
  deleteAppointment,
} = require("../controllers/appointment.js");

const express = require("express");

const router = express.Router();

//Create Appointment
router.post("/", createAppointment);

// Update a Appointment
router.put("/:id", updateAppointment);

// Get all AppointmentS
router.get("/", getAppointments);

// Get a Appointment by ID
router.get("/:id", getAppointment);

// Delete a Appointment
router.delete("/:id", deleteAppointment);

module.exports = router;
