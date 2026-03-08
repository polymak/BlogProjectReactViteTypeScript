import express from "express";
import bcrypt from "bcryptjs";
import { pool } from "../config/db";

const router = express.Router();

router.get("/", async (_req, res) => {
  try {
    const result = await pool.query(
      "SELECT id, username, email, role, created_at FROM admins ORDER BY created_at DESC"
    );
    res.json(result.rows);
  } catch (error) {
    console.error("Get admins error:", error);
    res.status(500).json({ message: "Server error" });
  }
});

router.post("/", async (req, res) => {
  try {
    const { username, email, password, role } = req.body;

    const existingUser = await pool.query(
      "SELECT * FROM admins WHERE username = $1 OR email = $2",
      [username, email]
    );

    if (existingUser.rows.length > 0) {
      return res.status(400).json({ message: "Username or email already exists" });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const result = await pool.query(
      `INSERT INTO admins (username, email, password, role)
       VALUES ($1, $2, $3, $4)
       RETURNING id, username, email, role, created_at`,
      [username, email, hashedPassword, role || "admin"]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Create admin error:", error);
    res.status(500).json({ message: "Server error" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      "DELETE FROM admins WHERE id = $1 RETURNING id, username, email, role",
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Admin not found" });
    }

    res.json({ message: "Admin deleted successfully", admin: result.rows[0] });
  } catch (error) {
    console.error("Delete admin error:", error);
    res.status(500).json({ message: "Server error" });
  }
});

export default router;