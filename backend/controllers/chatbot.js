const { GoogleGenerativeAI } = require("@google/generative-ai");
const dotenv = require("dotenv");

dotenv.config();

const apiKey = process.env.API_KEY;

// Initialize the GoogleGenerativeAI client
const genAI = new GoogleGenerativeAI(apiKey);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

// List of pet-related keywords
const petKeywords = [
  "dog",
  "cat",
  "pet",
  "vet",
  "hii",
  "how are you",
  "grooming",
  "puppy",
  "kitten",
  "fish",
  "bird",
  "rabbit",
  "training",
  "checkups",
  "medicine",
  "hamster",
];

// Function to check if the query is pet-related
function isPetRelated(query) {
  const lowerCaseQuery = query.toLowerCase();
  return petKeywords.some((keyword) => lowerCaseQuery.includes(keyword));
}

// Route handler to handle user queries
const ask = async (req, res) => {
  const userQuery = req.body.query;

  if (!userQuery) {
    return res.status(400).json({ message: "Query is required." });
  }

  // Check if the query is pet-related
  if (!isPetRelated(userQuery)) {
    return res.json({
      message: "Please ask only pet-related questions.",
    });
  }

  try {
    // Call the Gemini API using the GoogleGenerativeAI library
    const result = await model.generateContent(userQuery);
    res.json({
      response: result.response.text(),
    });
  } catch (error) {
    console.error("Error communicating with Gemini API:", error.message);
    res.status(500).json({ message: "Error communicating with Gemini API" });
  }
};

module.exports = { ask };
