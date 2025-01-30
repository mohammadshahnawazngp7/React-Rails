import React, { useState } from 'react';
import { TextField, Button, Container, Typography, CircularProgress } from '@mui/material';
import api from '../api/connection';
import { useNavigate } from 'react-router-dom';

const Register = ({ onRegister }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [passwordConfirmation, setPasswordConfirmation] = useState('');
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (password !== passwordConfirmation) {
      setError("Passwords don't match");
      return;
    }

    setLoading(true);
    setError(null);

    try {
      const response = await api.post('/auth/sign_up', {
        user: {
          email,
          password,
          password_confirmation: passwordConfirmation,
        }
      });

      onRegister();
      setEmail('');
      setPassword('');
      setPasswordConfirmation('');
      navigate('/login');
    } catch (err) {
      console.log(err);
      const errorMessage = err.response?.data?.errors || 'Registration failed. Please try again.';
      setError(errorMessage);
    } finally {
      setLoading(false);
    }
  };

  return (
    <Container maxWidth="xs">
      <Typography variant="h5" gutterBottom>
        Register
      </Typography>
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
        <TextField
          label="Confirm Password"
          variant="outlined"
          type="password"
          fullWidth
          margin="normal"
          value={passwordConfirmation}
          onChange={(e) => setPasswordConfirmation(e.target.value)}
          disabled={loading}
        />
        <Button
          type="submit"
          variant="contained"
          color="primary"
          fullWidth
          disabled={loading}
        >
          {loading ? <CircularProgress size={24} color="inherit" /> : 'Register'}
        </Button>
      </form>
    </Container>
  );
};

export default Register;
