import React from 'react';
import { Container, Typography, Box } from '@mui/material';
import Search from './components/Search';
import Visualization from './components/Visualization';

function App() {
  return (
    <Container maxWidth="lg">
      <Typography variant="h4" gutterBottom>University Information System</Typography>
      <Box mb={4}>
        <Search />
      </Box>
      <Box>
        <Visualization />
      </Box>
    </Container>
  );
}

export default App;