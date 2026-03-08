import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import path from "path";
import { connectDB } from "./config/db";
import { initDB } from "./config/initDb";
import authRoutes from "./routes/authRoutes";
import postRoutes from "./routes/postRoutes";
import adminRoutes from "./routes/adminRoutes";

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

app.use("/uploads", express.static(path.join(process.cwd(), "uploads")));

app.get("/", (_req, res) => {
  res.send("Blog API running...");
});

app.use("/api/auth", authRoutes);
app.use("/api/posts", postRoutes);
app.use("/api/admins", adminRoutes);

const PORT = process.env.PORT || 5000;

const startServer = async () => {
  await connectDB();
  await initDB();

  app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
  });
};

startServer();