const {
    createProduct,updateProduct,getProducts,getProduct,deleteProduct}=require('../controllers/product.js')

    const express = require("express");
  
  const router = express.Router();

  //Create Product
  router.post("/",createProduct)
  
  // Update a Product
  router.put("/:id", updateProduct);
  
  // Get all ProductS
  router.get("/", getProducts);
  
  // Get a Product by ID
  router.get("/:id", getProduct);
  
  // Delete a Product
  router.delete("/id", deleteProduct);
  
  module.exports = router;