import axios from "axios";

export const API_URL = "https://blog-backend-kf3i.onrender.com/api";
export const BASE_UPLOAD_URL = "https://blog-backend-kf3i.onrender.com";

const API = axios.create({
  baseURL: API_URL,
});

export default API;