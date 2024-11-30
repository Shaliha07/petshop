const Appointment = require("../models/Appointment.js");
const logger = require("../middlewares/logger.js");

//Create appointment
exports.createAppointment = async (req, res) => {
  const {userId,serviceId,additionalInformation,appointmentDate,appointmentTime} = req.body;
  try {
    //Check if appointment already exists
    const existingAppointment = await Appointment.findOne({
      where: {
        userId,
        serviceId,
        additionalInformation,
        appointmentDate,
        appointmentTime,
      },
    });
    if (existingAppointment) {
      return res.status(400).json({ error: "Appointment already exists." });
    }
    //Create new appointment
    const newAppointment = await Appointment.create({
      userId,
      serviceId,
      additionalInformation,
      appointmentDate,
      appointmentTime,
      status: true,
    });
    logger.info("Appointment created successfully.", newAppointment);
    res.status(201).json({
      message: "Appointment created successfully.",
      Appointment: newAppointment,
    });
  } catch (error) {
    logger.error("Error creating Appointment.", error);
    res.status(500).json({ error: "Internel server " });
  }
};
//Update Appointment
exports.updateAppointment = async (req, res) => {
  const { id } = req.params;
  const {
    userId,
    serviceId,
    additionalInformation,
    appointmentDate,
    appointmentTime,
  } = req.body;

  try {
    const appointment = await Appointment.findByPk(id);
    if (!appointment) {
      return req.status(404).json({ MediaSession: "Appointment not found" });
    }
    if (userId) {
      appointment.userId = userId;
    }
    if (serviceId) {
      appointment.serviceId = serviceId;
    }
    if (additionalInformation) {
      appointment.additionalInformation = additionalInformation;
    }
    if (appointmentDate) {
      appointment.appointmentDate = appointmentDate;
    }
    if (appointmentTime) {
      appointment.appointmentTime = appointmentTime;
    }
    await appointment.save();
    logger.info("Appointment updated successfully");
    return res
      .status(200)
      .json({ message: "Appointment updated", appointment });
  } catch (error) {
    logger.error("Error in updating appointment", error);
    return res
      .status(500)
      .json({ message: "Unable to update appointment", error: error.message });
  }
};

// Get all appointments
exports.getAppointments = async (req, res) => {
  try {
    // Find the appointment with the status filter
    const appointments = await Appointment.findAll({ where: { status: true } });

    logger.info("Appointments fetched successfully");
    return res.status(200).json({ appointments });
  } catch (error) {
    logger.error("Error fetching appointments", error);
    return res
      .status(500)
      .json({ message: "Unable to get appointments", error: error.message });
  }
};

// Get a appointment by ID
exports.getAppointment = async (req, res) => {
  const { id } = req.params;

  try {
    // Find the appointment by ID
    const appointment = await Appointment.findByPk(id);

    if (!appointment) {
      return res.status(404).json({ message: "Appointment not found" });
    }

    logger.info("Appointment fetched successfully");
    return res.status(200).json({ appointment });
  } catch (error) {
    logger.error("Error fetching the appointment", error);
    return res
      .status(500)
      .json({ message: "Unable to get the appointment", error: error.message });
  }
};

// Delete a appointment (set status to false)
exports.deleteAppointment = async (req, res) => {
  const { id } = req.params;

  try {
    // Find the appointment by ID
    const appointment = await Appointment.findByPk(id);

    if (!appointment) {
      return res.status(404).json({ message: "Appointment not found" });
    }

    // Set appointment status to inactive/false
    appointment.status = false;
    await appointment.save();

    logger.info("Appointment deleted successfully");
    return res
      .status(200)
      .json({ message: "Appointment deleted successfully" });
  } catch (error) {
    logger.error("Error deleting the appointment", error);
    return res
      .status(500)
      .json({
        message: "Unable to delete the appointment",
        error: error.message,
      });
  }
};
