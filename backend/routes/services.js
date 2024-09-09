import express from "express";
import {
  getServices,
  getService,
  updateService,
  deleteService,
  createService,
} from "../controllers/service.js";
import { authRole } from "../middleware/authRole.js";

const router = express.Router();

router.post("/create",authRole("admin"), createService);
router.put("/:id",authRole("admin"), updateService);
router.get("/:id", getService);
router.get("/", getServices);
router.delete("/:id",authRole("admin"), deleteService);

export default router;
