import type { ReactNode } from "react";
import { Link, useNavigate } from "react-router-dom";

interface Props {
  children: ReactNode;
}

export default function AdminLayout({ children }: Props) {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("admin");
    navigate("/login");
  };

  return (
    <div className="flex min-h-screen bg-slate-100">
      <aside className="w-72 bg-slate-950 p-6 text-white">
        <h2 className="mb-8 text-2xl font-bold">Dashboard</h2>

        <div className="flex flex-col gap-3 text-sm">
          <Link to="/dashboard" className="rounded-xl px-3 py-2 hover:bg-slate-800">
            Accueil dashboard
          </Link>
          <Link to="/dashboard/blogs" className="rounded-xl px-3 py-2 hover:bg-slate-800">
            Liste des blogs
          </Link>
          <Link to="/dashboard/users" className="rounded-xl px-3 py-2 hover:bg-slate-800">
            Liste des utilisateurs
          </Link>

          <button
            onClick={handleLogout}
            className="mt-6 rounded-2xl bg-white px-4 py-3 font-medium text-slate-900 transition hover:bg-slate-200"
          >
            Se déconnecter
          </button>
        </div>
      </aside>

      <main className="flex-1 p-8">{children}</main>
    </div>
  );
}