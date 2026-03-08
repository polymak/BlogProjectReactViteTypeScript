import axios from "axios";

const API = axios.create({
  baseURL: "http://localhost:5000/api",
});

export const BASE_UPLOAD_URL = "http://localhost:5000";

export default API;