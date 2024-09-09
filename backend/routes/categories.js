import express from "express";
import {
  getCategories,
  getCategory,
  updateCategory,
  deleteCategory,
  createCategory,
} from "../controllers/category.js";
import { authRole } from "../middleware/authRole.js";

const router = express.Router();

router.post("/create",authRole("admin"), createCategory)
router.put("/:id",authRole("admin"), updateCategory);
router.get("/:id", getCategory);
router.get("/", getCategories);
router.delete("/:id", authRole("admin"),deleteCategory);

export default router;
