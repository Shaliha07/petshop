import { db } from "../connect.js";

// Create
export const createGood = (req, res) => {
    const { goodid, categoryid,goodname,description,stockqty,purchasingprice,sellingprice, status } = req.body;
  
    const q = "INSERT INTO goods (categoryid,goodname,description,stockqty,purchasingprice,sellingprice, status) VALUES ($1, $2,$3,$4,$5,$6,$7)";
  
    const values = [categoryid,goodname,description,stockqty,purchasingprice,sellingprice, "active"];
  
    db.query(q, values, (err, result) => {
      if (err) return res.status(500).json(err);
      return res.status(200).json("Good has been created!");
    });
  };  
// Update
export const updateGood = (req, res) => {
  const goodid = req.params.id;
  const { categoryid,goodname,description,stockqty,purchasingprice,sellingprice, status } = req.body;

  const q =
    'UPDATE goods SET "categoryid"=$2,"goodname"=$3,"description"=$4,"stockqty"=$5,"purchasingprice"=$6,"sellingprice"=$7, "status"=$8 WHERE "goodid" = $1';

  const values = [goodid,categoryid,goodname,description,stockqty,purchasingprice,sellingprice, status];

  db.query(q, values, (err, data) => {
    if (err) return res.json(err);
    return res.json("Good has been updated successfully");
  });
};

// Get good
export const getGood = (req, res) => {
  const goodid = req.params.id;
  const q = "SELECT * FROM goods WHERE goodid = $1";
  db.query(q, [goodid], (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// get goods

export const getGoods = (req, res) => {
  const q = "SELECT * FROM goods";
  db.query(q, (err, data) => {
    if (err) return res.json(err);
    return res.json(data);
  });
};

// Delete category

export const deleteGood = (req, res) => {
  const goodid = req.params.id;
  const q = "DELETE FROM goods WHERE goodid = $1";

  db.query(q, [goodid], (err, data) => {
    if (err) return res.json(err);
    return res.json("Good has been deleted");
  });
};
