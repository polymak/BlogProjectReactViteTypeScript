import { useEffect, useState } from "react";
import API, { BASE_UPLOAD_URL } from "../services/api";

interface Post {
  id: number;
  title: string;
  content: string;
  image_url: string | null;
}

export default function BlogList() {
  const [posts, setPosts] = useState<Post[]>([]);
  const [title, setTitle] = useState("");
  const [content, setContent] = useState("");
  const [image, setImage] = useState<File | null>(null);
  const [editingId, setEditingId] = useState<number | null>(null);
  const [existingImageUrl, setExistingImageUrl] = useState("");

  const fetchPosts = async () => {
    try {
      const res = await API.get("/posts");
      setPosts(res.data);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  const resetForm = () => {
    setTitle("");
    setContent("");
    setImage(null);
    setEditingId(null);
    setExistingImageUrl("");
  };

  const handleSubmit = async () => {
    try {
      const formData = new FormData();
      formData.append("title", title);
      formData.append("content", content);

      if (image) {
        formData.append("image", image);
      }

      if (editingId) {
        formData.append("existing_image_url", existingImageUrl);
        await API.put(`/posts/${editingId}`, formData, {
          headers: { "Content-Type": "multipart/form-data" },
        });
      } else {
        await API.post("/posts", formData, {
          headers: { "Content-Type": "multipart/form-data" },
        });
      }

      resetForm();
      fetchPosts();
    } catch (error) {
      console.error(error);
      alert("Erreur lors de l'enregistrement");
    }
  };

  const handleEdit = (post: Post) => {
    setEditingId(post.id);
    setTitle(post.title);
    setContent(post.content);
    setExistingImageUrl(post.image_url || "");
    setImage(null);
  };

  const handleDelete = async (id: number) => {
    try {
      await API.delete(`/posts/${id}`);
      fetchPosts();
    } catch (error) {
      console.error(error);
      alert("Erreur lors de la suppression");
    }
  };

  return (
    <div className="space-y-8">
      <div className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
        <h2 className="mb-4 text-2xl font-bold text-slate-900">Liste des blogs</h2>

        <div className="grid gap-4 md:grid-cols-2">
          <input
            type="text"
            placeholder="Titre"
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            className="rounded-2xl border border-slate-300 px-4 py-3 outline-none focus:border-slate-900"
          />

          <input
            type="file"
            accept=".jpg,.jpeg,.png,.webp"
            onChange={(e) => setImage(e.target.files?.[0] || null)}
            className="rounded-2xl border border-slate-300 px-4 py-3"
          />

          <textarea
            placeholder="Contenu"
            value={content}
            onChange={(e) => setContent(e.target.value)}
            rows={5}
            className="md:col-span-2 rounded-2xl border border-slate-300 px-4 py-3 outline-none focus:border-slate-900"
          />

          <div className="md:col-span-2 flex gap-3">
            <button
              onClick={handleSubmit}
              className="rounded-2xl bg-slate-900 px-5 py-3 font-medium text-white hover:opacity-90"
            >
              {editingId ? "Modifier l'article" : "Ajouter l'article"}
            </button>

            {editingId && (
              <button
                onClick={resetForm}
                className="rounded-2xl border border-slate-300 px-5 py-3 font-medium text-slate-700"
              >
                Annuler
              </button>
            )}
          </div>
        </div>
      </div>

      <div className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
        <table className="w-full text-sm">
          <thead className="bg-slate-50 text-left text-slate-700">
            <tr>
              <th className="px-4 py-3">Titre</th>
              <th className="px-4 py-3">Contenu</th>
              <th className="px-4 py-3">Image</th>
              <th className="px-4 py-3">Actions</th>
            </tr>
          </thead>
          <tbody>
            {posts.map((post) => {
              const imageSrc = post.image_url
                ? `${BASE_UPLOAD_URL}${post.image_url}`
                : "https://placehold.co/120x80?text=No+Image";

              return (
                <tr key={post.id} className="border-t border-slate-200">
                  <td className="px-4 py-3 font-medium text-slate-900">{post.title}</td>
                  <td className="px-4 py-3 text-slate-600">{post.content}</td>
                  <td className="px-4 py-3">
                    <img
                      src={imageSrc}
                      alt={post.title}
                      className="h-16 w-24 rounded-lg object-cover"
                    />
                  </td>
                  <td className="px-4 py-3">
                    <div className="flex gap-2">
                      <button
                        onClick={() => handleEdit(post)}
                        className="rounded-xl bg-amber-500 px-3 py-2 text-white"
                      >
                        Modifier
                      </button>
                      <button
                        onClick={() => handleDelete(post.id)}
                        className="rounded-xl bg-rose-600 px-3 py-2 text-white"
                      >
                        Supprimer
                      </button>
                    </div>
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
      </div>
    </div>
  );
}