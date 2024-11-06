const express = require("express");
const dotenv = require("dotenv");
const sequelize = require("./connect.js");
require("./models/Associations.js");

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

// Start the server
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
