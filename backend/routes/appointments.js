import express from "express";
import {
  getAppointments,
  getAppointment,
  updateAppointment,
  deleteAppointment,
  createAppointment,
} from "../controllers/appointment.js";

const router = express.Router();

router.post("/create", createAppointment);
router.put("/:id", updateAppointment);
router.get("/:id", getAppointment);
router.get("/", getAppointments);
router.delete("/:id", deleteAppointment);

export default router;