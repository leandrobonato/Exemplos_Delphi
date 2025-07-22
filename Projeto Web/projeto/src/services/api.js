import axios from "axios";

const URL = "http://localhost:8082";

const api = axios.create({
    baseURL: URL
});

export default api;