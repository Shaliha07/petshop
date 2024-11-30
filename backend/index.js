const express = require("express");
const dotenv = require("dotenv");
const sequelize = require("./connect.js");
require("./models/Associations.js");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const logger = require("./middlewares/logger.js");
const globalRateLimiter = require("./middlewares/rateLimit.js");
const authRoutes = require("./routes/authRoutes.js");
const userRoutes = require("./routes/userRoutes.js");
const categoryRoutes = require("./routes/categoryRoutes.js");
const productRotes = require("./routes/productRoutes.js");
const serviceRoutes = require("./routes/serviceRoutes.js");
const appointmentRoutes = require("./routes/appointmentRoutes.js");
const transactionRoutes = require("./routes/transactionRoutes.js");
const paymenthistoryRoutes = require("./routes/paymenthistoryRoutes.js");
const chatbotRoutes = require("./routes/chatbotRoutes.js");

dotenv.config();

// Initialize the database
const initializeDatabase = async () => {
  try {
    await sequelize.authenticate();
    console.log("Database connection has been established successfully.");

    // Synchronize the models
    await sequelize.sync({ force: false });
    console.log("All models were synchronized successfully.");
  } catch (error) {
    console.error("Unable to connect to the database:", error);
  }
};

initializeDatabase();

const app = express();
const PORT = process.env.PORT || 8080;

//Middleware to log errors
app.use((err, req, res, next) => {
  logger.error(err.message, err);
  res.status(500).json({
    message: "Something went wrong. Please try again later.",
  });
});

// Middleware to rate limit requests
app.use(globalRateLimiter);

// Middleware to parse JSON requests
app.use(express.json());

// Middleware to parse cookies
app.use(cookieParser());

app.use((req, res, next) => {
  res.header("Access-Control-Allow-Credentials", true);
  next();
});
app.use(cors({
  credentials: true,
  allowedHeaders: ["Content-Type", "Authorization"],
}));

//Middleware to routes
app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/categories", categoryRoutes);
app.use("/products", productRotes);
app.use("/services", serviceRoutes);
app.use("/appointments", appointmentRoutes);
app.use("/transactions", transactionRoutes);
app.use("/payment", paymenthistoryRoutes);
app.use("/chatbot", chatbotRoutes);

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
