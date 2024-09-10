import { db } from "../connect.js";

// Create a new payment
export const createPayment = (req, res) => {
  const { salesorderid, paymentmethod, paymentstatus, amount } = req.body;

  const q = "INSERT INTO payments (salesorderid, paymentmethod, paymentstatus, amount) VALUES ($1, $2, $3, $4)";

  const values = [salesorderid, paymentmethod, paymentstatus, amount];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json({ error: err });
    return res.status(201).json({ message: "Payment created successfully" });
  });
};

// Get Payment by ID
export const getPaymentById = (req, res) => {
  const { id } = req.params;
  const q = "SELECT * FROM payments WHERE paymentid" = $1;

  db.query(q, [id], (err, data) => {
    if (err) return res.status(500).json({ error: err });
    return res.status(200).json(data.rows);
  });
};

// Get all Payments for a specific Sales Order
export const getPaymentsBySalesOrder = (req, res) => {
  const { salesorderid } = req.params;
  const q = "SELECT * FROM payments WHERE salesorderid" = $1;

  db.query(q, [salesorderid], (err, data) => {
    if (err) return res.status(500).json({ error: err });
    return res.status(200).json(data.rows);
  });
};

// Update payment status
export const updatePaymentStatus = (req, res) => {
  const { id } = req.params;
  const { paymentstatus } = req.body;

  const q = "UPDATE payments SET paymentstatus = $1 WHERE paymentid" = $2;

  db.query(q, [paymentstatus, id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    return res
      .status(200)
      .json({ message: "Payment status updated successfully" });
  });
};

// Delete a payment
export const deletePayment = (req, res) => {
  const { id } = req.params;
  const q = "DELETE FROM payments WHERE paymentid" = $1;

  db.query(q, [id], (err, result) => {
    if (err) return res.status(500).json({ error: err });
    return res.status(200).json({ message: "Payment deleted successfully" });
  });
};
