import AdminLayout from "../layouts/AdminLayout";

export default function Dashboard() {
  const admin = localStorage.getItem("admin");
  const adminData = admin ? JSON.parse(admin) : null;

  return (
    <AdminLayout>
      <div className="rounded-3xl border border-slate-200 bg-white p-8 shadow-sm">
        <h1 className="text-3xl font-bold text-slate-900">Dashboard Admin</h1>
        <p className="mt-3 text-slate-600">
          Bienvenue {adminData?.username || "Admin"}
        </p>
      </div>
    </AdminLayout>
  );
}