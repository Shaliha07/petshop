import express from "express";
import {
  register,
  login,
  logout,
  updateUser,
  getUser,
  getUsers,
  deleteUser,
} from "../controllers/user.js";
import { authRole } from "../middleware/authRole.js";
import { checkProfileOwnership } from "../middleware/checkProfileOwnership.js";

const router = express.Router();

router.post("/register", register);
router.post("/login", login);
router.post("/logout", logout);
router.put("/:id", authRole(), checkProfileOwnership, updateUser);
router.get("/:id", authRole("admin"), getUser);
router.get("/", authRole("admin"), getUsers);
router.delete("/:id", authRole("admin"), deleteUser);

export default router;
