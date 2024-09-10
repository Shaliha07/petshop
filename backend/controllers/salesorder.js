import { db } from "../connect.js";

// Function to calculate the subtotal for a single item
const calculateSubtotal = (qty, unitPrice) => {
  return qty * unitPrice;
};

// Function to calculate the total for the order
const calculateTotal = (subtotals, tax = 0, discount = 0) => {
  const totalSubtotal = subtotals.reduce((acc, subtotal) => acc + subtotal, 0);
  const total = totalSubtotal + tax - discount;
  return total;
};

export const createSalesOrder = (req, res) => {
  const { userId, goods, tax = 0, discount = 0 } = req.body;

  // Check if goods array is empty
  if (!goods || goods.length === 0) {
    return res.status(400).json("No goods provided for the order.");
  }

  // Calculate subtotals for each good
  const subtotals = goods.map((good) => calculateSubtotal(good.qty, good.unitPrice));

  // Calculate total for the order
  const total = calculateTotal(subtotals, tax, discount);

  // Insert the sales order into the database
  const q = `
    INSERT INTO salesorder (userid, orderdate, tax, discount, total, amountpaid, balance, status)
    VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING salesorderid;
  `;
  const values = [userId, new Date(), tax, discount, total, 0, total, "active"];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json(err);

    const salesOrderId = result.rows[0].salesorderid;

    // Insert order details (goods) for the sales order
    goods.forEach((good) => {
      const insertDetail = `
        INSERT INTO salesorderdetails (salesorderid, goodid, qty, total, status)
        VALUES ($1, $2, $3, $4, $5);
      `;
      const valuesDetail = [salesOrderId, good.goodId, good.qty, calculateSubtotal(good.qty, good.unitPrice), "active"];

      db.query(insertDetail, valuesDetail, (err, detailResult) => {
        if (err) return res.status(500).json(err);
      });
    });

    return res.status(200).json("Sales Order has been created with total!");
  });
};

// Fetch a single sales order by ID
export const getSalesOrder = (req, res) => {
  const { id } = req.params;
  const q = "SELECT * FROM salesorder WHERE salesorderid = $1";

  db.query(q, [id], (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json(data.rows);
  });
};

// Fetch all sales orders
export const getSaleOrders = (req, res) => {
  const q = "SELECT * FROM salesorder";

  db.query(q, (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json(data.rows);
  });
};

// Update sales order by ID
export const updateSalesOrder = (req, res) => {
  const { id } = req.params;
  const { orderdate, tax, discount, total, amountpaid, status } = req.body;

  const q = `
    UPDATE salesorder 
    SET orderdate = $2, tax = $3, discount = $4, total = $5, amountpaid = $6, status = $7 
    WHERE salesorderid = $1;
  `;
  const values = [id, orderdate, tax, discount, total, amountpaid, status];

  db.query(q, values, (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order has been updated successfully");
  });
};

// Delete sales order by ID
export const deleteSalesOrder = (req, res) => {
  const { id } = req.params;
  const q = "DELETE FROM salesorder WHERE salesorderid = $1";

  db.query(q, [id], (err, data) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Sales Order has been deleted");
  });
};
