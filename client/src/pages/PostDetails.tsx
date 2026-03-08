import { useEffect, useState } from "react";
import { Link, useParams } from "react-router-dom";
import API from "../services/api";

interface Post {
  id: number;
  title: string;
  content: string;
  image_url: string | null;
  created_at?: string;
}

export default function PostDetails() {
  const { id } = useParams();
  const [post, setPost] = useState<Post | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchPost = async () => {
      try {
        const res = await API.get(`/posts/${id}`);
        setPost(res.data);
      } catch (error) {
        console.error("Erreur chargement article :", error);
      } finally {
        setLoading(false);
      }
    };

    fetchPost();
  }, [id]);

  if (loading) {
    return (
      <div className="mx-auto max-w-4xl px-6 py-10">
        <p className="text-slate-600">Chargement de l’article...</p>
      </div>
    );
  }

  if (!post) {
    return (
      <div className="mx-auto max-w-4xl px-6 py-10">
        <h2 className="text-2xl font-bold text-slate-900">Article introuvable</h2>
        <Link to="/" className="mt-4 inline-block text-slate-700 underline">
          Retour à l’accueil
        </Link>
      </div>
    );
  }

  const imageSrc = post.image_url
    ? post.image_url
    : "https://placehold.co/1200x600?text=No+Image";

  return (
    <div className="mx-auto max-w-4xl px-6 py-10">
      <Link to="/" className="mb-6 inline-block text-sm text-slate-600 underline">
        ← Retour à l’accueil
      </Link>

      <article className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
        <img
          src={imageSrc}
          alt={post.title}
          className="h-72 w-full object-cover md:h-96"
        />

        <div className="p-8">
          <h1 className="mb-4 text-3xl font-bold text-slate-900">{post.title}</h1>

          {post.created_at && (
            <p className="mb-6 text-sm text-slate-500">
              Publié le {new Date(post.created_at).toLocaleDateString()}
            </p>
          )}

          <div className="whitespace-pre-line text-base leading-8 text-slate-700">
            {post.content}
          </div>
        </div>
      </article>
    </div>
  );
}