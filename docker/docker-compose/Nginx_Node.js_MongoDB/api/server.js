const express = require("express");
const mongoose = require("mongoose");

const app = express();
app.use(express.json());

const mongoUrl = process.env.MONGO_URL || "mongodb://localhost:27017/microdb";

mongoose
  .connect(mongoUrl)
  .then(() => console.log("Connected to MongoDB"))
  .catch((err) => console.log("MongoDB Error:", err));

const UserSchema = new mongoose.Schema({
  name: String,
  email: String,
});

const User = mongoose.model("User", UserSchema);

app.get("/", (req, res) => {
  res.send("Node.js API is running through Nginx Gateway!");
});

app.post("/users", async (req, res) => {
  const user = await User.create(req.body);
  res.json(user);
});

app.get("/users", async (req, res) => {
  const users = await User.find();
  res.json(users);
});

app.listen(3000, () => console.log("API started on port 3000"));
