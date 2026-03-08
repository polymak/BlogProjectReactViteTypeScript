"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const db_1 = require("../config/db");
const upload_1 = require("../middleware/upload");
const router = express_1.default.Router();
router.get("/", async (_req, res) => {
    try {
        const result = await db_1.pool.query("SELECT * FROM posts ORDER BY created_at DESC");
        return res.json(result.rows);
    }
    catch (error) {
        console.error("Get posts error:", error);
        return res.status(500).json({ message: "Server error" });
    }
});
router.get("/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const result = await db_1.pool.query("SELECT * FROM posts WHERE id = $1", [id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ message: "Post not found" });
        }
        return res.json(result.rows[0]);
    }
    catch (error) {
        console.error("Get single post error:", error);
        return res.status(500).json({ message: "Server error" });
    }
});
router.post("/", upload_1.upload.single("image"), async (req, res) => {
    try {
        const { title, content } = req.body;
        if (!title || !content) {
            return res.status(400).json({ message: "Title and content are required" });
        }
        const imageUrl = req.file ? `/uploads/${req.file.filename}` : null;
        const result = await db_1.pool.query("INSERT INTO posts (title, content, image_url) VALUES ($1, $2, $3) RETURNING *", [title, content, imageUrl]);
        return res.status(201).json(result.rows[0]);
    }
    catch (error) {
        console.error("Create post error:", error);
        return res.status(500).json({ message: "Server error" });
    }
});
router.put("/:id", upload_1.upload.single("image"), async (req, res) => {
    try {
        const { id } = req.params;
        const { title, content, existing_image_url } = req.body;
        let imageUrl = existing_image_url || null;
        if (req.file) {
            imageUrl = `/uploads/${req.file.filename}`;
        }
        const result = await db_1.pool.query(`UPDATE posts
       SET title = $1, content = $2, image_url = $3, updated_at = CURRENT_TIMESTAMP
       WHERE id = $4
       RETURNING *`, [title, content, imageUrl, id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ message: "Post not found" });
        }
        return res.json(result.rows[0]);
    }
    catch (error) {
        console.error("Update post error:", error);
        return res.status(500).json({ message: "Server error" });
    }
});
router.delete("/:id", async (req, res) => {
    try {
        const { id } = req.params;
        const result = await db_1.pool.query("DELETE FROM posts WHERE id = $1 RETURNING *", [id]);
        if (result.rows.length === 0) {
            return res.status(404).json({ message: "Post not found" });
        }
        return res.json({ message: "Post deleted successfully" });
    }
    catch (error) {
        console.error("Delete post error:", error);
        return res.status(500).json({ message: "Server error" });
    }
});
exports.default = router;
