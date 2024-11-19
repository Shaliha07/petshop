const express = require("express");
const { ask } = require("../controllers/chatbot.js");

const router = express.Router();

router.post("/", ask);

module.exports = router;
