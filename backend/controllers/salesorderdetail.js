import { db } from "../connect.js";

// Create sales order detail
export const createSalesOrderDetail = (req, res) => {
  const { salesorderid, goodid, qty, unitprice } = req.body;

  // Calculate subtotal for the good
  const subtotal = qty * unitprice;

  const q = `
    INSERT INTO salesorderdetails (salesorderid, goodid, qty, total, status)
    VALUES ($1, $2, $3, $4, $5)
  `;
  const values = [salesorderid, goodid, qty, subtotal, "active"];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order Detail has been created!");
  });
};

// Fetch a single sales order detail by ID
export const getSalesOrderDetail = (req, res) => {
  const { id } = req.params;
  const q = "SELECT * FROM salesorderdetails WHERE orderdetailsid = $1";

  db.query(q, [id], (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json(data.rows);
  });
};

// Fetch all sales order details
export const getSalesOrderDetails = (req, res) => {
  const q = "SELECT * FROM salesorderdetails";

  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json(data.rows);
  });
};

// Update sales order detail by ID
export const updateSalesOrderDetail = (req, res) => {
  const { id } = req.params;
  const { salesorderid, goodid, qty, total, status } = req.body;

  const q = `
    UPDATE salesorderdetails 
    SET salesorderid = $2, goodid = $3, qty = $4, total = $5, status = $6 
    WHERE orderdetailsid = $1
  `;
  const values = [id, salesorderid, goodid, qty, total, status];

  db.query(q, values, (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order Detail has been updated successfully");
  });
};

// Delete sales order detail by ID
export const deleteSalesOrderDetail = (req, res) => {
  const { id } = req.params;
  const q = "DELETE FROM salesorderdetails WHERE orderdetailsid = $1";

  db.query(q, [id], (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order Detail has been deleted");
  });
};
