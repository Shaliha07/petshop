import express from "express";
import {
  getGoods,
  getGood,
  updateGood,
  deleteGood,
  createGood,
} from "../controllers/good.js";
import { authRole } from "../middleware/authRole.js";

const router = express.Router();

router.post("/create",authRole("admin"), createGood);
router.put("/:id",authRole("admin"), updateGood);
router.get("/:id", getGood);
router.get("/", getGoods);
router.delete("/:id",authRole("admin"), deleteGood);

export default router;
