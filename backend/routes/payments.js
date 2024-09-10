import express from "express";
import {
  createPayment,
  getPayment,
  getPaymentsForOrder,
  updatePaymentStatus,
  deletePayment,
} from "../controllers/payments.js";

const router = express.Router();

router.post("/create", createPayment);
router.get("/:id", getPayment);
router.get("/order/:salesorderid", getPaymentsForOrder);
router.put("/:id", updatePaymentStatus);
router.delete("/:id", deletePayment);

export default router;