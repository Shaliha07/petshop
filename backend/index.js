import express from "express";
import dotenv from "dotenv";
import cookieParser from "cookie-parser";
import userRoutes from "./routes/users.js";
import employeeRoutes from "./routes/employees.js";
import categoryRoutes from "./routes/categories.js";
import goodRoutes from "./routes/goods.js";
import serviceRoutes from "./routes/services.js";
import appointmentRoutes from "./routes/appointments.js";
import salesOrderRoutes from "./routes/salesorders.js";
import salesOrderDetailsRoutes from "./routes/salesorderdetails.js";

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
app.use("/api/employees", employeeRoutes);
app.use("/api/category", categoryRoutes);
app.use("/api/goods", goodRoutes);
app.use("/api/service", serviceRoutes);
app.use("/api/appointment", appointmentRoutes);
app.use("/api/salesorder", salesOrderRoutes);
app.use("/api/salesorderdetails", salesOrderDetailsRoutes);

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
