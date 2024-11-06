const { DataTypes } = require('sequelize');
const User = require('./User.js');
const sequelize = require('../connect.js');

const Paymenthistory = sequelize.define('Paymenthistory', {
  userId: {
    type: DataTypes.INTEGER,
    references: {
      model: User,
      key: 'id',
    },
  },
  paymentMethod: {
    type: DataTypes.ENUM('credit card', 'debit card', 'payhere', 'cash'),
    allowNull: false,
  },
  paymentStatus: {
    type: DataTypes.ENUM('pending', 'completed', 'failed'),
    allowNull: false,
  },
  paymentDate: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  amount: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  status: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
    allowNull: false,
  },
}, { timestamps: true });

module.exports = Paymenthistory;
