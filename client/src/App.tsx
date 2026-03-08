import { BrowserRouter, Route, Routes } from "react-router-dom";
import Navbar from "./components/Navbar";
import Home from "./pages/Home";
import Login from "./pages/Login";
import Dashboard from "./pages/Dashboard";
import BlogList from "./pages/BlogList";
import UsersList from "./pages/UsersList";
import AdminLayout from "./layouts/AdminLayout";
import PostDetails from "./pages/PostDetails";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route
          path="/"
          element={
            <>
              <Navbar />
              <Home />
            </>
          }
        />

        <Route
          path="/login"
          element={
            <>
              <Navbar />
              <Login />
            </>
          }
        />

        <Route
          path="/posts/:id"
          element={
            <>
              <Navbar />
              <PostDetails />
            </>
          }
        />

        <Route path="/dashboard" element={<Dashboard />} />

        <Route
          path="/dashboard/blogs"
          element={
            <AdminLayout>
              <BlogList />
            </AdminLayout>
          }
        />

        <Route
          path="/dashboard/users"
          element={
            <AdminLayout>
              <UsersList />
            </AdminLayout>
          }
        />
      </Routes>
    </BrowserRouter>
  );
}

export default App;