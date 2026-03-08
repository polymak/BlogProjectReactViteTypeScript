import express from "express";
import { pool } from "../config/db";
import { upload } from "../middleware/upload";
import cloudinary from "../config/cloudinary";

const router = express.Router();

router.get("/", async (_req, res) => {
  try {
    const result = await pool.query(
      "SELECT * FROM posts ORDER BY created_at DESC"
    );

    return res.json(result.rows);
  } catch (error) {
    console.error("Get posts error:", error);
    return res.status(500).json({ message: "Server error" });
  }
});

router.get("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query("SELECT * FROM posts WHERE id = $1", [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Post not found" });
    }

    return res.json(result.rows[0]);
  } catch (error) {
    console.error("Get single post error:", error);
    return res.status(500).json({ message: "Server error" });
  }
});

const uploadToCloudinary = (buffer: Buffer): Promise<string> => {
  return new Promise((resolve, reject) => {
    const stream = cloudinary.uploader.upload_stream(
      {
        folder: "blog-project/posts",
        resource_type: "image",
      },
      (error, result) => {
        if (error) {
          reject(error);
        } else if (result?.secure_url) {
          resolve(result.secure_url);
        } else {
          reject(new Error("Cloudinary upload failed"));
        }
      }
    );

    stream.end(buffer);
  });
};

const extractPublicIdFromCloudinaryUrl = (imageUrl: string): string | null => {
  try {
    if (!imageUrl.includes("res.cloudinary.com")) {
      return null;
    }

    const parts = imageUrl.split("/");
    const uploadIndex = parts.findIndex((part) => part === "upload");

    if (uploadIndex === -1) {
      return null;
    }

    // Tout ce qui vient après "upload"
    let publicIdParts = parts.slice(uploadIndex + 1);

    // Si présence de version type v123456789, on l'enlève
    if (publicIdParts.length > 0 && /^v\d+$/.test(publicIdParts[0])) {
      publicIdParts = publicIdParts.slice(1);
    }

    const lastPart = publicIdParts[publicIdParts.length - 1];
    publicIdParts[publicIdParts.length - 1] = lastPart.replace(/\.[^/.]+$/, "");

    return publicIdParts.join("/");
  } catch (error) {
    console.error("Extract public_id error:", error);
    return null;
  }
};

router.post("/", upload.single("image"), async (req, res) => {
  try {
    const { title, content } = req.body;

    if (!title || !content) {
      return res
        .status(400)
        .json({ message: "Title and content are required" });
    }

    let imageUrl: string | null = null;

    if (req.file) {
      imageUrl = await uploadToCloudinary(req.file.buffer);
    }

    const result = await pool.query(
      "INSERT INTO posts (title, content, image_url) VALUES ($1, $2, $3) RETURNING *",
      [title, content, imageUrl]
    );

    return res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error("Create post error:", error);
    return res.status(500).json({ message: "Server error" });
  }
});

router.put("/:id", upload.single("image"), async (req, res) => {
  try {
    const { id } = req.params;
    const { title, content, existing_image_url } = req.body;

    let imageUrl = existing_image_url || null;

    if (req.file) {
      imageUrl = await uploadToCloudinary(req.file.buffer);
    }

    const result = await pool.query(
      `UPDATE posts
       SET title = $1, content = $2, image_url = $3, updated_at = CURRENT_TIMESTAMP
       WHERE id = $4
       RETURNING *`,
      [title, content, imageUrl, id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Post not found" });
    }

    return res.json(result.rows[0]);
  } catch (error) {
    console.error("Update post error:", error);
    return res.status(500).json({ message: "Server error" });
  }
});

router.delete("/:id", async (req, res) => {
  try {
    const { id } = req.params;

    const postResult = await pool.query("SELECT * FROM posts WHERE id = $1", [
      id,
    ]);

    if (postResult.rows.length === 0) {
      return res.status(404).json({ message: "Post not found" });
    }

    const post = postResult.rows[0];
    const imageUrl: string | null = post.image_url;

    if (imageUrl) {
      const publicId = extractPublicIdFromCloudinaryUrl(imageUrl);

      if (publicId) {
        await cloudinary.uploader.destroy(publicId);
      }
    }

    await pool.query("DELETE FROM posts WHERE id = $1", [id]);

    return res.json({
      message: "Post and image deleted successfully",
    });
  } catch (error) {
    console.error("Delete post error:", error);
    return res.status(500).json({ message: "Server error" });
  }
});

export default router;