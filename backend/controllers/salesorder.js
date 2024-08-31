import { db } from "../connect.js";

// Create
export const createSalesOrder = (req, res) => {
  const {
    salesorderid,
    orderdate,
    tax,
    discount,
    total,
    amountpaid,
    balance,
    status,
  } = req.body;

  const q =
    "INSERT INTO salesorders (orderdate, tax, discount, total, amountpaid, balance, status) VALUES ($1, $2, $3, $4, $5, $6, $7)";

  const values = [
    orderdate,
    tax,
    discount,
    total,
    amountpaid,
    balance,
    "active",
  ];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order has been created!");
  });
};

// Update
export const updateSalesOrder = (req, res) => {
  const salesorderid = req.params.id;
  const { orderdate, tax, discount, total, amountpaid, balance, status } =
    req.body;

  const q =
    'UPDATE salesorders SET "orderdate"=$2, "tax"=$3, "discount"=$4, "amountpaid"=$5, "balance"=$6, "status"=$7 WHERE "salesorderid" = $1';

  const values = [
    salesorderid,
    orderdate,
    tax,
    discount,
    total,
    amountpaid,
    balance,
    status,
  ];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Sales Order has been updated successfully");
  });
};

// Get SalesOrder
export const getSalesOrder = (req, res) => {
  const salesorderid = req.params.id;
  const q = "SELECT * FROM salesorders WHERE salesorderid = $1";
  db.query(q, [salesorderid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Get SalesOrders
export const getSaleOrders = (req, res) => {
  const q = "SELECT * FROM salesorders";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete SalesOrder
export const deleteSalesOrder = (req, res) => {
  const salesorderid = req.params.id;
  const q = "DELETE FROM salesorders WHERE salesorderid = $1";

  db.query(q, [salesorderid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Sales Order has been deleted");
  });
};
