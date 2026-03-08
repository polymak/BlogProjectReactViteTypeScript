import { useState } from "react";
import { useNavigate } from "react-router-dom";
import API from "../services/api";

export default function Login() {
  const navigate = useNavigate();

  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = async () => {
    try {
      const res = await API.post("/auth/login", { username, password });

      localStorage.setItem("token", res.data.token);
      localStorage.setItem("admin", JSON.stringify(res.data.admin));

      navigate("/dashboard");
    } catch (error) {
      console.error("Erreur login :", error);
      alert("Échec de connexion");
    }
  };

  return (
    <div className="flex min-h-[calc(100vh-80px)] items-center justify-center px-6 py-10">
      <div className="w-full max-w-md rounded-3xl border border-slate-200 bg-white p-8 shadow-sm">
        <h2 className="mb-2 text-2xl font-bold text-slate-900">Connexion Admin</h2>
        <p className="mb-6 text-sm text-slate-600">
          Connecte-toi pour gérer les articles et les utilisateurs.
        </p>

        <div className="space-y-4">
          <input
            type="text"
            placeholder="Username"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            className="w-full rounded-2xl border border-slate-300 px-4 py-3 outline-none transition focus:border-slate-900"
          />

          <input
            type="password"
            placeholder="Mot de passe"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="w-full rounded-2xl border border-slate-300 px-4 py-3 outline-none transition focus:border-slate-900"
          />

          <button
            onClick={handleLogin}
            className="w-full rounded-2xl bg-slate-900 px-4 py-3 font-medium text-white transition hover:opacity-90"
          >
            Se connecter
          </button>
        </div>
      </div>
    </div>
  );
}