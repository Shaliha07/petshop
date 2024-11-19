const { DataTypes } = require("sequelize");
const User = require("./User.js");
const sequelize = require("../connect.js");

const Transaction = sequelize.define(
  "Transaction",
  {
    userId: {
      type: DataTypes.INTEGER,
      references: {
        model: User,
        key: "id",
      },
    },
    date: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    netTotal: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    tax: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    discount: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    total: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    amountPaid: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    balance: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    paymentMethod: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    status: {
      type: DataTypes.BOOLEAN,
      defaultValue: true,
      allowNull: false,
    },
  },
  { timestamps: true }
);

module.exports = Transaction;
