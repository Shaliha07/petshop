import express from "express";
import {
  createSalesOrderDetail,
  deleteSalesOrderDetail,
  getSalesOrderDetail,
  getSalesOrderDetails,
  updateSalesOrderDetail,
} from "../controllers/salesorderdetail.js";

const router = express.Router();

router.post("/create", createSalesOrderDetail);
router.put("/:id", updateSalesOrderDetail);
router.get("/:id", getSalesOrderDetail);
router.get("/", getSalesOrderDetails);
router.delete("/:id", deleteSalesOrderDetail);

export default router;
