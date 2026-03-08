"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.initDB = void 0;
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const db_1 = require("./db");
const initDB = async () => {
    try {
        await db_1.pool.query(`
      CREATE TABLE IF NOT EXISTS admins (
        id SERIAL PRIMARY KEY,
        username VARCHAR(100) NOT NULL UNIQUE,
        email VARCHAR(150) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL,
        role VARCHAR(50) NOT NULL DEFAULT 'admin',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);
        await db_1.pool.query(`
      CREATE TABLE IF NOT EXISTS posts (
        id SERIAL PRIMARY KEY,
        title VARCHAR(255) NOT NULL,
        content TEXT NOT NULL,
        image_url TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);
        const checkAdmin = await db_1.pool.query(`SELECT * FROM admins WHERE username = $1`, ["Admin"]);
        if (checkAdmin.rows.length === 0) {
            const hashedPassword = await bcryptjs_1.default.hash("Admin123", 10);
            await db_1.pool.query(`INSERT INTO admins (username, email, password, role)
         VALUES ($1, $2, $3, $4)`, ["Admin", "admin@example.com", hashedPassword, "admin"]);
            console.log("Default admin created: Admin / Admin123");
        }
        else {
            console.log("Default admin already exists");
        }
        console.log("Database tables initialized");
    }
    catch (error) {
        console.error("Database initialization error:", error);
    }
};
exports.initDB = initDB;
