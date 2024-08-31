import express from "express";
import {
  getGoods,
  getGood,
  updateGood,
  deleteGood,
  createGood,
} from "../controllers/good.js";

const router = express.Router();

router.post("/create", createGood);
router.put("/:id", updateGood);
router.get("/:id", getGood);
router.get("/", getGoods);
router.delete("/:id", deleteGood);

export default router;
