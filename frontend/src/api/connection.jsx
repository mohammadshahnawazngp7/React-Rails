import axios from 'axios';

const apiUrl = process.env.REACT_APP_API_URL;
const api = axios.create({
  baseURL: `${apiUrl}/api/v1`,
  headers: {
    'Content-Type': 'application/json',
  },
});

export default api;