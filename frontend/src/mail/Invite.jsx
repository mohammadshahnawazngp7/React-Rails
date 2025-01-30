import React, { useState } from 'react';
import { TextField, Button, Snackbar, Alert } from '@mui/material';
import axios from 'axios';
import api from '../api/connection';

const Invite = ({ isAuthenticated }) => {
  const [email, setEmail] = useState('');
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (!isAuthenticated) {
      setSnackbarMessage('You must be logged in to send a referral.');
      setOpenSnackbar(true);
      return;
    }

    const token = localStorage.getItem('authToken');

    if (!token) {
      setSnackbarMessage('You must be logged in to send a referral.');
      setOpenSnackbar(true);
      return;
    }

    try {
      const response = await api.post(
        '/referrals',
        { email },
        {
          headers: {
            'Authorization': `Bearer ${token}`
          }
        }
      );
      setSnackbarMessage(response.data.message || 'Referral sent!');
      setOpenSnackbar(true);
    } catch (error) {
      console.log(error);
      setSnackbarMessage(error.response?.data?.error || 'Something went wrong!');
      setOpenSnackbar(true);
    }
  };

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <TextField
          label="Invite Email"
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          fullWidth
          required
        />
        <Button type="submit" variant="contained" color="primary" sx={{ marginTop: 2 }}>
          Send Invite
        </Button>
      </form>

      <Snackbar
        open={openSnackbar}
        autoHideDuration={3000}
        onClose={() => setOpenSnackbar(false)}
      >
        <Alert onClose={() => setOpenSnackbar(false)} severity="success" sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </div>
  );
};

export default Invite;
