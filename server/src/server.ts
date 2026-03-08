import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import { pool } from "./config/db";
import { initDB } from "./config/initDb";
import authRoutes from "./routes/authRoutes";
import postRoutes from "./routes/postRoutes";
import adminRoutes from "./routes/adminRoutes";

dotenv.config();

const app = express();

app.use(
  cors({
    origin: "*",
  })
);

app.use(express.json());

app.get("/", (_req, res) => {
  res.send("Blog API running...");
});

app.use("/api/auth", authRoutes);
app.use("/api/posts", postRoutes);
app.use("/api/admins", adminRoutes);

const startServer = async () => {
  try {
    await pool.connect();
    console.log("PostgreSQL connected");

    await initDB();

    const PORT = process.env.PORT || 5000;

    app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Database connection error:", error);
  }
};

startServer();