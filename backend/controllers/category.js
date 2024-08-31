import { db } from "../connect.js";

// Create
export const createCategory = (req, res) => {
    const { categoryid, categoryname, status } = req.body;
  
    const q = "INSERT INTO category (categoryname, status) VALUES ($1, $2)";
  
    const values = [categoryname, "active"];
  
    db.query(q, values, (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Category has been created!");
    });
  };  
// Update
export const updateCategory = (req, res) => {
  const categoryid = req.params.id;
  const { categoryname, status } = req.body;

  const q =
    'UPDATE category SET "categoryname" = $2,"status" = $3 WHERE "categoryid" = $1';

  const values = [categoryid, categoryname, status];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Category has been updated successfully");
  });
};

// Get category
export const getCategory = (req, res) => {
  const categoryid = req.params.id;
  const q = "SELECT * FROM category WHERE categoryid = $1";
  db.query(q, [categoryid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// get categories

export const getCategories = (req, res) => {
  const q = "SELECT * FROM category";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete category

export const deleteCategory = (req, res) => {
  const categoryid = req.params.id;
  const q = "DELETE FROM category WHERE categoryid = $1";

  db.query(q, [categoryid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Category has been deleted");
  });
};
