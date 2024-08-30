import pkg from "pg";
const { Client } = pkg;
import dotenv from "dotenv";

// Load environment variables from .env file
dotenv.config();

// Set up PostgreSQL client connection
const db = new Client({
  host: process.env.PG_HOST,
  user: process.env.PG_USER,
  password: process.env.PG_PASSWORD,
  database: process.env.PG_DATABASE,
  port: process.env.PG_PORT,
});

db.connect()
  .then(() => console.log("Connected to PostgreSQL Database"))
  .catch((err) => console.error("Connection error", err.stack));

export { db };