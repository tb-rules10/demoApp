const express = require("express");
const app = express();
const userRoutes = require("./routes/userRoutes");
const {home} = require('./controllers/userController.js');
require("dotenv").config();


app.use(express.urlencoded({ extended: true }))

app.use("/api",userRoutes);


const server = app.listen(process.env.PORT, () => {
    console.log("Server started on " + process.env.PORT);
})