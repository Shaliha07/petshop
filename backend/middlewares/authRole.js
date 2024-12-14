const jwt = require("jsonwebtoken");

const JWT_SECRET = process.env.JWT;

//Middleware to verify the token and extract user information
exports.verifyToken = (req, res, next) => {
  const token =
    req.cookies.accessToken || req.headers.authorization?.split(" ")[1];

  console.log("Token from request:", token);
  console.log("Authorization header:", req.headers.authorization);
  console.log("Extracted Token:", token);

  if (!token) {
    return res.status(403).json({ message: "Access denied.No Token provided" });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    console.error("Error verifying token :", error);
    return res
      .status(500)
      .json({ message: "Unable to verify token", error: error.message });
  }
};

//Midleware to check if the user is an admin
exports.isAdmin = (req, res, next) => {
  if (req.user.role !== "admin") {
    return res.status(403).json({ message: "Access ddenied.Admin only" });
  }
  next();
};

// Middleware to check if the user is the owner of the account or an admin
exports.isOwnerOrAdmin = (req, res, next) => {
  // Extract the userId from various possible locations
  const requestedUserId = parseInt(
    req.params.userId || req.body.userId || req.query.userId,
    10
  );

  if (!requestedUserId) {
    return res.status(400).json({ message: "Invalid or missing user ID" });
  }

  // Check if the logged-in user is an admin or the owner of the account
  if (req.user.role !== "admin" && req.user.id !== requestedUserId) {
    return res
      .status(403)
      .json({ message: "Access denied. Admin or Owner only" });
  }

  next();
};
