const { DataTypes } = require('sequelize');
const Transaction = require('./Transaction.js');
const Product = require('./Product.js');
const User = require('./User.js');
const sequelize = require('../connect.js');

const Transactiondetails = sequelize.define('Transactiondetails', {
  transactionId: {
    type: DataTypes.INTEGER,
    references: {
      model: Transaction,
      key: 'id',
    },
  },
  productId: {
    type: DataTypes.INTEGER,
    references: {
      model: Product,
      key: 'id',
    },
  },
  userId: {
    type: DataTypes.INTEGER,
    references: {
      model: User,
      key: 'id',
    },
  },
  quantity: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  price: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  total: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  status: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
    allowNull: false,
  },
}, { timestamps: true });

// Add a trigger to update the product stock after a transaction detail is created
Transactiondetails.afterCreate(async (transactionDetail, options) => {
  try {
    // Find the associated product based on productId in the transaction detail
    const product = await Product.findByPk(transactionDetail.productId);

    // Check if the product exists
    if (!product) {
      throw new Error('Product not found');
    }

    // Check if there is enough stock
    if (product.stockQty < transactionDetail.quantity) {
      throw new Error('Insufficient stock');
    }

    // Decrement the stock quantity by the quantity sold in the transaction
    product.stockQty -= transactionDetail.quantity;

    // Save the updated product with the new stock quantity
    await product.save();
  } catch (error) {
    console.error('Error in stock quantity update trigger:', error.message);
    throw error; // Re-throw the error so the transaction can handle it
  }
});

module.exports = Transactiondetails;
