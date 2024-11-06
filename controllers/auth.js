const User=require('../models/User');
const bcrypt=require('bcryptjs');
const jwt=require('dotenv');
const {op}=require('sequelize');

dotenv.config();

const JWT_SECRET = process.env.JWT;
