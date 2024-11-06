const { DataTypes } = require('sequelize');
const User = require('./User.js');
const Service = require('./Service.js');
const sequelize = require('../connect.js');

const Appointment = sequelize.define('Appointment', {
  userId: {
    type: DataTypes.INTEGER,
    references: {
      model: User,
      key: 'id',
    },
  },
  serviceId: {
    type: DataTypes.INTEGER,
    references: {
      model: Service,
      key: 'id',
    },
  },
  additionalInformation: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  appointmentDate: {
    type: DataTypes.DATE,
    allowNull: false,
  },
  appointmentTime: {
    type: DataTypes.TIME,
    allowNull: false,
  },
  status: {
    type: DataTypes.BOOLEAN,
    defaultValue: true,
    allowNull: false,
  },
}, { timestamps: true });

module.exports = Appointment;
