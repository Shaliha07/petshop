import express from "express";
import {
  getServices,
  getService,
  updateService,
  deleteService,
  createService,
} from "../controllers/service.js";

const router = express.Router();

router.post("/create", createService);
router.put("/:id", updateService);
router.get("/:id", getService);
router.get("/", getServices);
router.delete("/:id", deleteService);

export default router;
