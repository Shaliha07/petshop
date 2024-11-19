const Transaction = require("../models/Transaction.js");
const Transactiondetails = require("../models/Transactiondetails.js");
const logger = require("../middlewares/logger.js");

exports.addTransaction = async (req, res) => {
  const { userId, date, tax, discount, amountPaid, paymentMethod, items } =
    req.body;

  try {
    // Calculate netTotal as the sum of total prices of all items
    const netTotal = items.reduce(
      (sum, item) => sum + item.quantity * item.price,
      0
    );

    // Calculate the final total after applying tax and discount
    const total = netTotal + tax - discount;

    // Calculate the balance amount
    const balance = total - amountPaid;

    // Start a transaction to ensure atomicity
    const sequelizeTransaction = await Transaction.sequelize.transaction();

    // Create the main record
    const transaction = await Transaction.create(
      {
        userId,
        date,
        netTotal,
        tax,
        discount,
        total,
        amountPaid,
        balance,
        paymentMethod,
        status: true,
      },
      { transaction: sequelizeTransaction }
    );

    // Map and bulk insert Transactiondetails records
    const transactionDetailsData = items.map((item) => ({
      transactionId: transaction.id, // The ID of the main record
      productId: item.productId,
      userId: userId,
      quantity: item.quantity,
      price: item.price,
      total: item.quantity * item.price,
      status: true,
    }));

    await Transactiondetails.bulkCreate(transactionDetailsData, {
      transaction: sequelizeTransaction,
    });

    // Commit the transaction
    await sequelizeTransaction.commit();

    return res
      .status(201)
      .json({ message: "Transaction created successfully" });
  } catch (error) {
    logger.error("Error creating transaction: ", error);

    // Rollback the transaction in case of an error
    if (sequelizeTransaction) await sequelizeTransaction.rollback();

    return res.status(500).json({ message: "Internal server error" });
  }
};

// Update Transaction
exports.updateTransaction = async (req, res) => {
  const { id } = req.params;
  const { userId, date, tax, discount, amountPaid, paymentMethod, items } =
    req.body;

  try {
    // Fetch the main transaction record
    const transaction = await Transaction.findByPk(id, {
      include: [Transactiondetails],
    });

    if (!transaction) {
      return res.status(404).json({ message: "Transaction not found" });
    }

    // Update only the fields that are provided in the request
    if (userId) {
      transaction.userId = userId;
    }
    if (date) {
      transaction.date = date;
    }
    if (tax) {
      transaction.tax = tax;
    }
    if (discount) {
      transaction.discount = discount;
    }
    if (amountPaid) {
      transaction.amountPaid = amountPaid;
    }
    if (paymentMethod) {
      transaction.paymentMethod = paymentMethod;
    }

    // Recalculate netTotal and total based on provided items
    if (items) {
      const netTotal = items.reduce(
        (sum, item) => sum + item.quantity * item.price,
        0
      );
      transaction.netTotal = netTotal;
      transaction.total = netTotal + transaction.tax - transaction.discount;
      transaction.balance = transaction.total - transaction.amountPaid;

      // Fetch existing transaction details
      const existingDetails = await Transactiondetails.findAll({
        where: { transactionId: id },
      });

      // Create a map of existing details for comparison
      const existingDetailsMap = new Map(
        existingDetails.map((detail) => [detail.productId, detail])
      );

      // Process new items
      for (const item of items) {
        if (existingDetailsMap.has(item.productId)) {
          // Update existing detail
          const detail = existingDetailsMap.get(item.productId);
          detail.quantity = item.quantity;
          detail.price = item.price;
          detail.total = item.quantity * item.price;
          await detail.save();
          existingDetailsMap.delete(item.productId);
        } else {
          // Add new detail
          await Transactiondetails.create({
            transactionId: id,
            productId: item.productId,
            userId: userId,
            quantity: item.quantity,
            price: item.price,
            total: item.quantity * item.price,
            status: true,
          });
        }
      }

      // Remove details not in the updated items
      for (const remainingDetail of existingDetailsMap.values()) {
        await remainingDetail.destroy();
      }
    }

    // Save the updated transaction
    await transaction.save();

    return res
      .status(200)
      .json({ message: "Transaction updated successfully" });
  } catch (error) {
    logger.error("Error updating transaction: ", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

// Get Transaction by ID
exports.getTransactionById = async (req, res) => {
  const { id } = req.params;

  try {
    const transaction = await Transaction.findByPk(id, {
      include: [Transactiondetails], // Include associated Transaction details
    });

    if (!transaction) {
      return res.status(404).json({ message: "Transaction not found" });
    }

    return res.status(200).json(transaction);
  } catch (error) {
    logger.error("Error getting transaction: ", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

// Get all Transactions
exports.getAllTransactions = async (req, res) => {
  try {
    const transactions = await Transaction.findAll({
      include: [Transactiondetails], // Include associated Transaction details
    });

    return res.status(200).json(transactions);
  } catch (error) {
    logger.error("Error getting transactions: ", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

// Delete a Transaction (set status to false)
exports.deleteTransaction = async (req, res) => {
  const { id } = req.params;

  try {
    const transaction = await Transaction.findByPk(id, {
      include: [Transactiondetails], // Include associated Transaction details
    });

    if (!transaction) {
      return res.status(404).json({ message: "Transaction not found" });
    }

    // Update the status of the main transaction to false
    transaction.status = false;

    // Update the status of all associated transaction details to false
    await Promise.all(
      transaction.Transactiondetails.map(async (detail) => {
        detail.status = false;
        await detail.save();
      })
    );

    // Save the updated transaction
    await transaction.save();

    return res
      .status(200)
      .json({ message: "Transaction deleted successfully" });
  } catch (error) {
    logger.error("Error deleting transaction: ", error);
    return res.status(500).json({ message: "Internal server error" });
  }
};
