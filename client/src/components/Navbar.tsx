import { Link } from "react-router-dom";

export default function Navbar() {
  return (
    <nav className="sticky top-0 z-50 border-b border-slate-200 bg-white/90 backdrop-blur">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-6 py-4">
        <Link to="/" className="text-xl font-bold tracking-tight text-slate-900">
          Mon Blog
        </Link>

        <div className="flex items-center gap-6 text-sm font-medium">
          <Link to="/" className="text-slate-700 transition hover:text-black">
            Accueil
          </Link>
          <Link
            to="/login"
            className="rounded-full bg-slate-900 px-4 py-2 text-white transition hover:opacity-90"
          >
            Login
          </Link>
        </div>
      </div>
    </nav>
  );
}