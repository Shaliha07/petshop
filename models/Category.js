const { DataTypes } = require('sequelize');
const sequelize = require('../connect.js');

const Category = sequelize.define('Category', {
  categoryName: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  status: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
    allowNull: false,
  },
}, { timestamps: true });

module.exports = Category;