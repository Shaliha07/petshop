const Product = require("../models/Product.js");
const logger = require("../middlewares/logger.js");

//Create product
exports.createProduct = async (req, res) => {
  const {
    categoryId,
    productName,
    description,
    stockQty,
    purchasingPrice,
    sellingPrice,
    imageUrl,
  } = req.body;
  try {
    // Check if product already exists
    const existingProduct = await Product.findOne({
      where: {
        categoryId,
        productName,
        description,
        stockQty,
        purchasingPrice,
        sellingPrice,
        imageUrl,
      },
    });
    if (existingProduct) {
      return res.status(400).json({ error: "Product already exists." });
    }
    // Create new product
    const newProduct = await Product.create({
      categoryId,
      productName,
      description,
      stockQty,
      purchasingPrice,
      sellingPrice,
      imageUrl,
      status: true,
    });
    logger.info("Product created successfully.", newProduct);
    res.status(201).json({
      message: "Product created successfully.",
      Product: newProduct,
    });
  } catch (error) {
    logger.error("Error creating Product.", error);
    res.status(500).json({ error: "Internel server " });
  }
};
//Update Product
exports.updateProduct = async (req, res) => {
  const { id } = req.params;
  const {
    categoryId,
    productName,
    description,
    stockQty,
    purchasingPrice,
    sellingPrice,
    imageUrl,
  } = req.body;

  try {
    const product = await Product.findByPk(id);
    if (!product) {
      return req.status(404).json({ message: "Product not found" });
    }
    if (categoryId) {
      product.categoryId = categoryId;
    }
    if (productName) {
      product.productName = productName;
    }
    if (description) {
      product.description = description;
    }
    if (stockQty) {
      product.stockQty = stockQty;
    }
    if (purchasingPrice) {
      product.purchasingPrice = purchasingPrice;
    }
    if (sellingPrice) {
      product.sellingPrice = sellingPrice;
    }
    if (imageUrl) {
      product.imageUrl = imageUrl;
    }
    await product.save();
    logger.info("Product updated successfully");
    return res.status(200).json({ message: "Product updated", product });
  } catch (error) {
    logger.error("Error in updating product", error);
    return res
      .status(500)
      .json({ message: "Unable to update product", error: error.message });
  }
};

// Get all products
exports.getProducts = async (req, res) => {
  try {
    // Find the product with the status filter
    const products = await Product.findAll({ where: { status: true } });

    logger.info("Products fetched successfully");
    return res.status(200).json({ products });
  } catch (error) {
    logger.error("Error fetching products", error);
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

    logger.info("Product fetched successfully");
    return res.status(200).json({ product });
  } catch (error) {
    logger.error("Error fetching the product", error);
    return res
      .status(500)
      .json({ message: "Unable to get the product", error: error.message });
  }
};

// Get a product by Category id
exports.getProductByCategoryid = async (req, res) => {
  const { categoryId } = req.params;

  try {
    // Find the product by ID
    const product = await Product.findAll({
        where:{categoryId},
    });
    logger.info("Product fetched successfully");
    return res.status(200).json({ product });
  } catch (error) {
    logger.error("Error fetching the product", error);
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

    logger.info("Product deleted successfully");
    return res.status(200).json({ message: "Product deleted successfully" });
  } catch (error) {
    logger.error("Error deleting the product", error);
    return res
      .status(500)
      .json({ message: "Unable to delete the product", error: error.message });
  }
};
