import express from 'express';
import { ask } from '../controllers/chatbot.js';

const router = express.Router();

router.post('/', ask);

export default router;