import { db } from "../connect.js";

// Create
export const createService = (req, res) => {
  const { serviceid, servicename, description, sellingprice, status } =
    req.body;

  const q =
    "INSERT INTO services (servicename, description, sellingprice, status) VALUES ($1, $2, $3, $4)";

  const values = [servicename, description, sellingprice, "active"];

  db.query(q, values, (err, result) => {
    if (err) return res.status(500).json(err);
    return res.status(200).json("Service has been created!");
  });
};

// Update
export const updateService = (req, res) => {
  const serviceid = req.params.id;
  const { servicename, description, sellingprice, status } = req.body;

  const q =
    'UPDATE services SET "servicename"=$2, "description"=$3, "sellingprice"=$4, "status"=$5 WHERE "serviceid" = $1';

  const values = [serviceid, servicename, description, sellingprice, status];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Service has been updated successfully");
  });
};

// Get Service
export const getService = (req, res) => {
  const serviceid = req.params.id;
  const q = "SELECT * FROM services WHERE serviceid = $1";
  db.query(q, [serviceid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Get Services
export const getServices = (req, res) => {
  const q = "SELECT * FROM services";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete Service
export const deleteService = (req, res) => {
  const serviceid = req.params.id;
  const q = "DELETE FROM services WHERE serviceid = $1";

  db.query(q, [serviceid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Service has been deleted");
  });
};
