"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const db_1 = require("../config/db");
const router = express_1.default.Router();
router.get("/", async (_req, res) => {
    try {
        const result = await db_1.pool.query("SELECT id, username, email, role, created_at FROM admins ORDER BY created_at DESC");
        res.json(result.rows);
    }
    catch (error) {
        console.error("Get admins error:", error);
        res.status(500).json({ message: "Server error" });
    }
});
router.post("/", async (req, res) => {
    try {
        const { username, email, password, role } = req.body;
        const existingUser = await db_1.pool.query("SELECT * FROM admins WHERE username = $1 OR email = $2", [username, email]);
        if (existingUser.rows.length > 0) {
            return res.status(400).json({ message: "Username or email already exists" });
        }
        const hashedPassword = await bcryptjs_1.default.hash(password, 10);
        const result = await db_1.pool.query(`INSERT INTO admins (username, email, password, role)
       VALUES ($1, $2, $3, $4)
       RETURNING id, username, email, role, created_at`, [username, email, hashedPassword, role || "admin"]);
        res.status(201).json(result.rows[0]);
    }
    catch (error) {
        console.error("Create admin error:", error);
        res.status(500).json({ message: "Server error" });
    }
});
router.delete("/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const result = await db_1.pool.query("DELETE FROM admins WHERE id = $1 RETURNING id, username, email, role", [id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ message: "Admin not found" });
        }
        res.json({ message: "Admin deleted successfully", admin: result.rows[0] });
    }
    catch (error) {
        console.error("Delete admin error:", error);
        res.status(500).json({ message: "Server error" });
    }
});
exports.default = router;
