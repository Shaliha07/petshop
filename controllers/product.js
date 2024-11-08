const Product = require("../models/Product.js");

//Create product
exports.createProduct=async(req,res)=>{
    const{productName,description,stockQty,purchasingPrice,sellingPrice,imageUrl}=req.body;
    try{
        //Check if product already exists
        const existingProduct=await Product.findOne({
            where:{productName,description,stockQty,purchasingPrice,sellingPrice,imageUrl},
        });
        if(existingProduct){
            return res.status(400).json({error:"Product already exists."});
        }
        //Create new product 
        const newProduct =await Product.create({productName,description,stockQty,purchasingPrice,sellingPrice,imageUrl,status:true});
        console.log("Product created successfully.",newProduct);
        res.status(201).json({
            message:"Product created successfully.",Product:newProduct
        });

    }catch(error){
        console.error("Error creating Product.",error);
        res.status(500).json({error:"Internel server "});
    }
}
//Update Product
exports.updateProduct= async (req,res)=>{
    const {id} =req.params;
    const{
      productName,
      description,
      stockQty,
      purchasingPrice,
      sellingPrice,
      imageUrl
    }=req.body;

    try{
        const product = await product.findPK(id);
        if(!product){
            return req.status(404).json({MediaSession:"Product not found"});
        }
        if(productName){
            product.productName=productName;
        }
        if(description){
          product.description=description;
        }
        if(stockQty){
          product.stockQty=stockQty;
        }
        if(purchasingPrice){
          product.purchasingPrice=purchasingPrice;
        }
        if(sellingPrice){
          product.sellingPrice=sellingPrice;
        }
        if(imageUrl){
          product.imageUrl=imageUrl;
        }
        await user.save();
        console.log("Product updated successfully");
        return res.status(200).json({message:"Product updated",product})

    }catch(error){
        console.error("Error in updating product",error);
        return res.status(500).json({message:"Unable to update product",error:error.message});
    }
};

// Get all products
exports.getProducts = async (req, res) => {
    try {
      // Find the product with the status filter
      const products = await Product.findAll({ where: { status: true } });
  
      console.log("Products fetched successfully");
      return res.status(200).json({ products });
    } catch (error) {
      console.error("Error fetching products", error);
      return res
        .status(500)
        .json({ message: "Unable to get products", error: error.message });
    }
  };
  
  // Get a product by ID
  exports.getProduct = async (req, res) => {
    const { id } = req.params;
  
    try {
      // Find the product by ID
      const product = await Product.findByPk(id);
  
      if (!product) {
        return res.status(404).json({ message: "Product not found" });
      }
  
      console.log("Product fetched successfully");
      return res.status(200).json({ product });
    } catch (error) {
      console.error("Error fetching the product", error);
      return res
        .status(500)
        .json({ message: "Unable to get the product", error: error.message });
    }
  };
  
  // Delete a product (set status to false)
  exports.deleteProduct = async (req, res) => {
    const { id } = req.params;
  
    try {
      // Find the product by ID
      const product = await Product.findByPk(id);
  
      if (!product) {
        return res.status(404).json({ message: "Product not found" });
      }
  
      // Set product status to inactive/false
      product.status = false;
      await product.save();
  
      console.log("Product deleted successfully");
      return res.status(200).json({ message: "Product deleted successfully" });
    } catch (error) {
      console.error("Error deleting the product", error);
      return res
        .status(500)
        .json({ message: "Unable to delete the product", error: error.message });
    }
  };
