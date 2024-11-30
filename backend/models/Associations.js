const Appointment = require("./Appointment.js");
const PaymentHistory = require("./Paymenthistory.js");
const Category = require("./Category.js");
const Product = require("./Product.js");
const Service = require("./Service.js");
const Transaction = require("./Transaction.js");
const TransactionDetails = require("./Transactiondetails.js");
const User = require("./User.js");

// User assoociation with Appointment
User.hasMany(Appointment, { foreignKey: "userId" });
Appointment.belongsTo(User, { foreignKey: "userId" });

//User association with Paymenthistory
User.hasMany(PaymentHistory, { foreignKey: "userId" });
PaymentHistory.belongsTo(User, { foreignKey: "userId" });

//User association with Transaction
User.hasMany(Transaction, { foreignKey: "userId" });
Transaction.belongsTo(User, { foreignKey: "userId" });

//Category association with Product
Category.hasMany(Product, { foreignKey: "categoryId" });
Product.belongsTo(Category, { foreignKey: "categoryId" });

//Service association with Appointment
Service.hasMany(Appointment, { foreignKey: "serviceId" });
Appointment.belongsTo(Service, { foreignKey: "serviceId" });

//Product association with Transactiondetails
Product.hasMany(TransactionDetails, { foreignKey: "productId" });
TransactionDetails.belongsTo(Product, { foreignKey: "productId" });

//Transaction assosiation with Transactiondetails
Transaction.hasMany(TransactionDetails, { foreignKey: "transactionId" });
TransactionDetails.belongsTo(Transaction, { foreignKey: "transactionId" });

//Paymenthistory association with Transaction
PaymentHistory.hasOne(Transaction, { foreignKey: "paymentHistoryId" });
Transaction.belongsTo(PaymentHistory, { foreignKey: "paymentHistoryId" });

module.exports = {
  User,
  Appointment,
  PaymentHistory,
  Category,
  Product,
  Service,
  Transaction,
  TransactionDetails,
};
