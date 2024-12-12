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

module.exports = Transactiondetails;
