import express from "express";
import {
  register,
  getUsers,
  getUser,
  updateUser,
  deleteUser,
  login,
  logout,
} from "../controllers/user.js";

const router = express.Router();

router.post("/register", register);
router.post("/login",login)
router.post("/logout",logout)
router.put("/:id", updateUser);
router.get("/:id", getUser);
router.get("/", getUsers);
router.delete("/:id", deleteUser);

export default router;
