import React, { useState, useEffect } from 'react';
import { Route, Routes, Navigate } from 'react-router-dom';
import Login from './components/Login';
import Register from './components/Register';
import Logout from './components/Logout';
import { Container, AppBar, Toolbar, Typography, Button, Box, Snackbar, Alert } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import Invite from './mail/Invite';

const App = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [openSnackbar, setOpenSnackbar] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState('');
  const navigate = useNavigate();

  useEffect(() => {
    const authStatus = sessionStorage.getItem('isAuthenticated');
    if (authStatus) {
      setIsAuthenticated(true);
    }
  }, []);

  const handleLogout = () => {
    setIsAuthenticated(false);
    sessionStorage.removeItem('isAuthenticated');
    setSnackbarMessage('Logged out successfully');
    setOpenSnackbar(true);
    navigate('/login');
  };

  const handleLoginSuccess = () => {
    setIsAuthenticated(true);
    sessionStorage.setItem('isAuthenticated', 'true');
    setSnackbarMessage('Logged in successfully');
    setOpenSnackbar(true);
    navigate('/');
  };

  const handleRegisterSuccess = () => {
    setIsAuthenticated(true);
    sessionStorage.setItem('isAuthenticated', 'true');
    setSnackbarMessage('Registered successfully');
    setOpenSnackbar(true);
    navigate('/');
  };

  return (
    <div>
      <AppBar position="sticky">
        <Toolbar>
          <Typography variant="h6" sx={{ flexGrow: 1 }}>
            My App
          </Typography>

          <Box>
            {isAuthenticated ? (
              <Button color="inherit" onClick={handleLogout}>
                Logout
              </Button>
            ) : (
              <>
                <Button color="inherit" onClick={() => navigate('/login')}>
                  Login
                </Button>
                <Button color="inherit" onClick={() => navigate('/register')}>
                  Register
                </Button>
              </>
            )}
          </Box>
        </Toolbar>
      </AppBar>

      <Container sx={{ marginTop: 3 }}>
        <Routes>
          <Route
            path="/"
            element={isAuthenticated ? ( 
            <div>
              <Typography variant="h4">Welcome to the React + Rails App!</Typography> 
              <Invite isAuthenticated={isAuthenticated} />
              </div>
              ) : ( <Navigate to="/login" /> )}
          />
          <Route path="/login" element={<Login onLogin={handleLoginSuccess} />} />
          <Route path="/register" element={<Register onRegister={handleRegisterSuccess} />} />
          <Route path="/logout" element={<Logout onLogout={handleLogout} />} />
        </Routes>
      </Container>

      <Snackbar
        open={openSnackbar}
        autoHideDuration={3000}
        onClose={() => setOpenSnackbar(false)}
      >
        <Alert onClose={() => setOpenSnackbar(false)} variant="filled" severity="success" sx={{ width: '100%' }}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </div>
  );
};

export default App;
