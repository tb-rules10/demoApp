

module.exports.home = (req, res, next) => {
  res.send("Server HOME");
};


module.exports.data = (req, res, next) => {
  try {
    const { name, emotion, genre } = req.body;

    // console.log(req.body);
    return res.json({ status: true, response: "Jaa jaake spotify premium kharid chindi aadmi" });
  }
  catch (err) {
    next(err);
  }
};

