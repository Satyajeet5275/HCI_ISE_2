import React, { useState } from 'react';
import { TextField, Button, Select, MenuItem, FormControl, InputLabel, Typography, Box } from '@mui/material';

function Search() {
  const [searchQuery, setSearchQuery] = useState('');
  const [searchEntity, setSearchEntity] = useState('classroom');
  const [searchResults, setSearchResults] = useState([]);

  const handleSearch = async () => {
    const response = await fetch(`http://localhost:5000/api/search?query=${searchQuery}&entity=${searchEntity}`);
    const data = await response.json();
    setSearchResults(data);
  };

  return (
    <>
      <Typography variant="h5" gutterBottom>Information Search</Typography>
      <FormControl fullWidth margin="normal">
        <InputLabel>Search Entity</InputLabel>
        <Select value={searchEntity} onChange={(e) => setSearchEntity(e.target.value)}>
          <MenuItem value="classroom">Classroom</MenuItem>
          <MenuItem value="department">Department</MenuItem>
          <MenuItem value="course">Course</MenuItem>
          <MenuItem value="instructor">Instructor</MenuItem>
          <MenuItem value="student">Student</MenuItem>
        </Select>
      </FormControl>
      <TextField
        fullWidth
        margin="normal"
        label="Search Query"
        value={searchQuery}
        onChange={(e) => setSearchQuery(e.target.value)}
      />
      <Button variant="contained" color="primary" onClick={handleSearch}>
        Search
      </Button>
      {searchResults.length > 0 && (
        <Box mt={2}>
          <Typography variant="h6">Search Results:</Typography>
          <pre>{JSON.stringify(searchResults, null, 2)}</pre>
        </Box>
      )}
    </>
  );
}

export default Search;