const { DataTypes } = require('sequelize');
const Category = require('./Category.js');
const sequelize = require('../connect.js');

const Product = sequelize.define('Product', {
  categoryId: {
    type: DataTypes.INTEGER,
    references: {
      model: Category,
      key: 'id',
    },
  },
  productName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  description: {
    type: DataTypes.STRING,
  },
  stockQty: {
    type: DataTypes.INTEGER,
    allowNull: false,
  },
  purchasingPrice: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  sellingPrice: {
    type: DataTypes.FLOAT,
    allowNull: false,
  },
  imageUrl: {
    type: DataTypes.STRING,
  },
  status: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
    allowNull: false,
  },
}, { timestamps: true });

module.exports = Product;
