const {PythonShell} = require('python-shell');

module.exports.home = (req, res, next) => {
  res.send("Server HOME");
};


module.exports.data = (req, res, next) => {
  try {
    // const { name, emotion, genre } = req.body;

    // console.log(req.body);
    return res.json({ status: true, msg: "Jaa jaake spotify premium kharid chindi aadmi" });
  }
  catch (err) {
    next(err);
  }
};


module.exports.predict = async (req, res, next) => {
  try {
    if(req.body === {}) console.log("hello");
    const { text:data } = req.body;
    const options = {
      pythonOptions: ['-u'],
      scriptPath: 'scripts/',
      args: [data]
    };
    let pyshell = new PythonShell('model.py', options);
    await pyshell.on('message', function (message) {
      // console.log(message); 
      return res.json({ status: true, msg: `${data}   ->   ${message}` });
    });
    // return res.json({ status: true, msg: `hello` });
  }
  catch (err) {
    next(err);
  }
};