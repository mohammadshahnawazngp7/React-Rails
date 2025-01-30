import React, { useState } from 'react';
import { TextField, Button, Container, Typography, CircularProgress } from '@mui/material';
import api from '../api/connection';
import axios from 'axios';

const Login = ({ onLogin }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError(null);

    try {
      const response = await api.post('/auth/sign_in', {
        auth: {
          email,
          password,
        },
      });
      const token = response.data.token;
      localStorage.setItem('authToken', token);
      axios.defaults.headers['Authorization'] = `Bearer ${token}`;

      onLogin();

    } catch (err) {
      const errorMessage = err.response?.data?.errors || 'Login failed. Please try again.';
      setError(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Container maxWidth="xs">
      <Typography variant="h5" gutterBottom>Login</Typography>
      {error && <Typography color="error" variant="body2" gutterBottom>{error}</Typography>}

      <form onSubmit={handleSubmit}>
        <TextField
          label="Email"
          variant="outlined"
          fullWidth
          margin="normal"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          disabled={loading}
        />
        <TextField
          label="Password"
          variant="outlined"
          type="password"
          fullWidth
          margin="normal"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          disabled={loading}
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          disabled={loading}
        >
          {loading ? <CircularProgress size={24} color="inherit" /> : 'Login'}
        </Button>
      </form>
    </Container>
  );
};

export default Login;
