import express from "express";
import {
  getCategories,
  getCategory,
  updateCategory,
  deleteCategory,
  createCategory,
} from "../controllers/category.js";

const router = express.Router();

router.post("/create", createCategory);
router.put("/:id", updateCategory);
router.get("/:id", getCategory);
router.get("/", getCategories);
router.delete("/:id", deleteCategory);

export default router;
