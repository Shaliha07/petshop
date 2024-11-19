const Paymenthistory = require("../models/Paymenthistory.js");
const logger = require("../middlewares/logger.js");

// Get paymenthistory by ID
exports.getPaymenthistory = async (req, res) => {
  const { id } = req.params;

  try {
    const paymenthistory = await Paymenthistory.findByPk(id);

    if (!paymenthistory) {
      return res.status(404).json({ message: "Paymenthistory not found" });
    }

    return res.status(200).json(paymenthistory);
  } catch (error) {
    logger.error("Error getting paymenthistory: ", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

// Get all Paymenthistories
exports.getAllPaymenthistories = async (req, res) => {
    try {
      const paymenthistories = await Paymenthistory.findAll({
        where: { status: true },
      });
  
      return res.status(200).json(paymenthistories);
    } catch (error) {
      logger.error("Error getting paymenthistories: ", error);
      return res.status(500).json({ message: "Internal server error" });
    }
  };