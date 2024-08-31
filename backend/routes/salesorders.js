import express from "express";
import {
 getSaleOrders,
  getSalesOrder,
  updateSalesOrder,
  deleteSalesOrder,
  createSalesOrder,
} from "../controllers/salesorder.js";

const router = express.Router();

router.post("/create", createSalesOrder);
router.put("/:id", updateSalesOrder);
router.get("/:id", getSalesOrder);
router.get("/", getSaleOrders);
router.delete("/:id", deleteSalesOrder);

export default router;