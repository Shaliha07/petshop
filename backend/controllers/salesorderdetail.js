import { db } from "../connect.js";

// Create
export const createSalesOrderDetail = (req, res) => {
  const {orderdetailsid, salesorderid, goodid, qty, total, status } = req.body;

  const q =
    "INSERT INTO salesorderdetails(salesorderid, goodid, qty, total, status) VALUES ($1, $2, $3, $4, $5)";

  const values = [salesorderid, goodid, qty, total, "active"];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order Details has been created!");
  });
};

// Update
export const updateSalesOrderDetail = (req, res) => {
  const orderdetailsid = req.params.id;
  const { salesorderid, goodid, qty, total, status } = req.body;

  const q =
    'UPDATE salesorderdetails SET "salesorderid"=$2, "goodid"=$3, "qty"=$4, "total"=$5, "status"=$6 WHERE "orderdetailsid" = $1';

  const values = [orderdetailsid, salesorderid, goodid, qty, total, status];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Sales Order Details has been updated successfully");
  });
};

// Get SalesOrderDetail
export const getSalesOrderDetail = (req, res) => {
  const orderdetailsid = req.params.id;
  const q = "SELECT * FROM salesorderdetails WHERE orderdetailsid = $1";
  db.query(q, [orderdetailsid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Get SalesOrderDetails
export const getSalesOrderDetails = (req, res) => {
  const q = "SELECT * FROM salesorderdetails";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete SalesOrderDetail
export const deleteSalesOrderDetail = (req, res) => {
  const orderdetailsid = req.params.id;
  const q = "DELETE FROM salesorderdetails WHERE orderdetailsid = $1";

  db.query(q, [orderdetailsid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Sales Order Details has been deleted");
  });
};
