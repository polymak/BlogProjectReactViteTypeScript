import { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import API, { BASE_UPLOAD_URL } from "../services/api";

interface Post {
  id: number;
  title: string;
  content: string;
  image_url: string | null;
}

export default function Home() {
  const [posts, setPosts] = useState<Post[]>([]);

  useEffect(() => {
    const fetchPosts = async () => {
      try {
        const res = await API.get("/posts");
        setPosts(res.data);
      } catch (error) {
        console.error("Erreur chargement articles :", error);
      }
    };

    fetchPosts();
  }, []);

  return (
    <div className="mx-auto max-w-7xl px-6 py-8">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-slate-900">Articles récents</h1>
        <p className="mt-2 text-slate-600">
          Cliquez sur un article pour lire son contenu complet.
        </p>
      </div>

      <div className="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
        {posts.map((post) => {
          const imageSrc = post.image_url
            ? `${BASE_UPLOAD_URL}${post.image_url}`
            : "https://placehold.co/800x500?text=No+Image";

          return (
            <Link
              to={`/posts/${post.id}`}
              key={post.id}
              className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm transition hover:-translate-y-1 hover:shadow-lg"
            >
              <img
                src={imageSrc}
                alt={post.title}
                className="h-56 w-full object-cover"
              />

              <div className="p-5">
                <h2 className="mb-3 text-xl font-semibold text-slate-900 hover:underline">
                  {post.title}
                </h2>
                <p className="line-clamp-4 text-sm leading-6 text-slate-600">
                  {post.content}
                </p>
              </div>
            </Link>
          );
        })}
      </div>
    </div>
  );
}