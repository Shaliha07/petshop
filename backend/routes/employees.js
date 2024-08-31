import express from "express";
import {
  register,
  getEmployees,
  getEmployee,
  updateEmployee,
  deleteEmployee,
  login,
  logout,
} from "../controllers/employee.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", logout);
router.put("/:id", updateEmployee);
router.get("/:id", getEmployee);
router.get("/", getEmployees);
router.delete("/:id", deleteEmployee);

export default router;
