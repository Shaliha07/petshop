export const checkProfileOwnership = (req, res, next) => {
  const userid = req.params.id;

  // Check if the logged-in user is trying to update their own profile
  if (req.user.userid !== userid && req.user.role !== "admin") {
    return res.status(403).json("You can only update your own profile.");
  }

  next();
};
