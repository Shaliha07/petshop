const Category = require("../models/Category.js");
const logger = require("../middlewares/logger.js");

//Create category
exports.createCategory = async (req, res) => {
  const { categoryName } = req.body;
  try {
    //Check if category already exists
    const existingCategory = await Category.findOne({
      where: { categoryName },
    });
    if (existingCategory) {
      return res.status(400).json({ error: "Category already exists." });
    }
    //Create new category
    const newCategory = await Category.create({ categoryName, status: true });
    logger.info("Category created successfully.", newCategory);
    res.status(201).json({
      message: "Category created successfully.",
      Category: newCategory,
    });
  } catch (error) {
    logger.error("Error creating category.", error);
    res.status(500).json({ error: "Internel server " });
  }
};
//Update category
exports.updateCategory = async (req, res) => {
  const { id } = req.params;
  const { categoryName } = req.body;

  try {
    const category = await Category.findByPk(id);
    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }
    if (categoryName) {
      category.categoryName = categoryName;
    }
    await category.save();
    logger.info("Category updated successfully");
    return res.status(200).json({ message: "Category updated", category });
  } catch (error) {
    logger.error("Error in updating category", error);
    return res
      .status(500)
      .json({ message: "Unable to update category", error: error.message });
  }
};

// Get all categories
exports.getCategories = async (req, res) => {
  try {
    // Find the category with the status filter
    const categories = await Category.findAll({ where: { status: true } });

    logger.info("Categories fetched successfully");
    return res.status(200).json({ categories });
  } catch (error) {
    logger.error("Error fetching categories", error);
    return res
      .status(500)
      .json({ message: "Unable to get categories", error: error.message });
  }
};

// Get a category by ID
exports.getCategory = async (req, res) => {
  const { id } = req.params;

  try {
    // Find the user by ID
    const category = await Category.findByPk(id);

    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }

    logger.info("Category fetched successfully");
    return res.status(200).json({ category });
  } catch (error) {
    logger.error("Error fetching the category", error);
    return res
      .status(500)
      .json({ message: "Unable to get the category", error: error.message });
  }
};

// Delete a category (set status to false)
exports.deleteCategory = async (req, res) => {
  const { id } = req.params;

  try {
    // Find the category by ID
    const category = await Category.findByPk(id);

    if (!category) {
      return res.status(404).json({ message: "Category not found" });
    }

    // Set category status to inactive/false
    category.status = false;
    await category.save();

    logger.info("Category deleted successfully");
    return res.status(200).json({ message: "Category deleted successfully" });
  } catch (error) {
    logger.error("Error deleting the category", error);
    return res
      .status(500)
      .json({ message: "Unable to delete the category", error: error.message });
  }
};
