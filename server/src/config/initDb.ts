import bcrypt from "bcryptjs";
import { pool } from "./db";

export const initDB = async () => {
  try {
    await pool.query(`
      CREATE TABLE IF NOT EXISTS admins (
        id SERIAL PRIMARY KEY,
        username VARCHAR(100) NOT NULL UNIQUE,
        email VARCHAR(150) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        role VARCHAR(50) NOT NULL DEFAULT 'admin',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    await pool.query(`
      CREATE TABLE IF NOT EXISTS posts (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        image_url TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    const checkAdmin = await pool.query(
      `SELECT * FROM admins WHERE username = $1`,
      ["Admin"]
    );

    if (checkAdmin.rows.length === 0) {
      const hashedPassword = await bcrypt.hash("Admin123", 10);

      await pool.query(
        `INSERT INTO admins (username, email, password, role)
         VALUES ($1, $2, $3, $4)`,
        ["Admin", "admin@example.com", hashedPassword, "admin"]
      );

      console.log("Default admin created: Admin / Admin123");
    } else {
      console.log("Default admin already exists");
    }

    console.log("Database tables initialized");
  } catch (error) {
    console.error("Database initialization error:", error);
  }
};