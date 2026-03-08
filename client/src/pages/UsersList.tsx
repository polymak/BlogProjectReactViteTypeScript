import { useEffect, useState } from "react";
import API from "../services/api";

interface AdminUser {
  id: number;
  username: string;
  email: string;
  role: string;
}

export default function UsersList() {
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [username, setUsername] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [role, setRole] = useState("admin");

  const fetchUsers = async () => {
    try {
      const res = await API.get("/admins");
      setUsers(res.data);
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleAddUser = async () => {
    try {
      await API.post("/admins", { username, email, password, role });
      setUsername("");
      setEmail("");
      setPassword("");
      setRole("admin");
      fetchUsers();
    } catch (error) {
      console.error(error);
      alert("Erreur lors de l'ajout");
    }
  };

  const handleDelete = async (id: number) => {
    try {
      await API.delete(`/admins/${id}`);
      fetchUsers();
    } catch (error) {
      console.error(error);
      alert("Erreur lors de la suppression");
    }
  };

  return (
    <div className="space-y-8">
      <div className="rounded-3xl border border-slate-200 bg-white p-6 shadow-sm">
        <h2 className="mb-4 text-2xl font-bold text-slate-900">
          Liste des utilisateurs admin
        </h2>

        <div className="grid gap-4 md:grid-cols-2">
          <input
            type="text"
            placeholder="Nom utilisateur"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            className="rounded-2xl border border-slate-300 px-4 py-3 outline-none focus:border-slate-900"
          />

          <input
            type="email"
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            className="rounded-2xl border border-slate-300 px-4 py-3 outline-none focus:border-slate-900"
          />

          <input
            type="password"
            placeholder="Mot de passe"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            className="rounded-2xl border border-slate-300 px-4 py-3 outline-none focus:border-slate-900"
          />

          <input
            type="text"
            placeholder="Rôle"
            value={role}
            onChange={(e) => setRole(e.target.value)}
            className="rounded-2xl border border-slate-300 px-4 py-3 outline-none focus:border-slate-900"
          />

          <div className="md:col-span-2">
            <button
              onClick={handleAddUser}
              className="rounded-2xl bg-slate-900 px-5 py-3 font-medium text-white hover:opacity-90"
            >
              Ajouter nouveau utilisateur
            </button>
          </div>
        </div>
      </div>

      <div className="overflow-hidden rounded-3xl border border-slate-200 bg-white shadow-sm">
        <table className="w-full text-sm">
          <thead className="bg-slate-50 text-left text-slate-700">
            <tr>
              <th className="px-4 py-3">Email</th>
              <th className="px-4 py-3">Nom utilisateur</th>
              <th className="px-4 py-3">Rôle</th>
              <th className="px-4 py-3">Action</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id} className="border-t border-slate-200">
                <td className="px-4 py-3">{user.email}</td>
                <td className="px-4 py-3">{user.username}</td>
                <td className="px-4 py-3">{user.role}</td>
                <td className="px-4 py-3">
                  <button
                    onClick={() => handleDelete(user.id)}
                    className="rounded-xl bg-rose-600 px-3 py-2 text-white"
                  >
                    Supprimer
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}