import React from 'react';
import { Button } from '@mui/material';
import api from '../api/connection';

const Logout = ({ onLogout }) => {
  const handleLogout = async () => {
    try {
      await api.delete('/auth/sign_out');
      onLogout();
    } catch (err) {
      console.error('Logout failed:', err);
    }
  };

  return <Button onClick={handleLogout}>Logout</Button>;
};

export default Logout;