import express from "express";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import userRoutes from "./routes/users.js";

// Create an Express application
const app = express();

// Load environment variables from .env file
dotenv.config();

// // Set up PostgreSQL client connection
// const db = new Client({
//   host: process.env.PG_HOST,
//   user: process.env.PG_USER,
//   password: process.env.PG_PASSWORD,
//   database: process.env.PG_DATABASE,
//   port: process.env.PG_PORT,
// });

// // Test the Database Connection
// db.connect()
//   .then(() => console.log("Connected to PostgreSQL database"))
//   .catch((err) => console.error("Connection error", err.stack));

// // Define a simple route to test server
// app.get("/", (req, res) => {
//   res.send("Hello, your server is running!");
// });

// Middlewares
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Credentials", true);
  next();
});
app.use(express.json());
app.use(cookieParser());

// Routes
app.use("/api/users", userRoutes);

// Start the server
const PORT = process.env.PORT;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
