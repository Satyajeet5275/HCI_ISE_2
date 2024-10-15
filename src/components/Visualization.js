import React, { useState } from 'react';
import { Button, Select, MenuItem, FormControl, InputLabel, Typography, Box } from '@mui/material';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';

function Visualization() {
  const [visualizationData, setVisualizationData] = useState([]);
  const [visualizationEntity, setVisualizationEntity] = useState('department');

  const handleVisualize = async () => {
    const response = await fetch(`http://localhost:5000/api/visualize?entity=${visualizationEntity}`);
    const data = await response.json();
    setVisualizationData(data);
  };

  return (
    <>
      <Typography variant="h5" gutterBottom>Data Visualization</Typography>
      <FormControl fullWidth margin="normal">
        <InputLabel>Visualization Entity</InputLabel>
        <Select value={visualizationEntity} onChange={(e) => setVisualizationEntity(e.target.value)}>
          <MenuItem value="department">Department Budget</MenuItem>
          <MenuItem value="course">Courses per Department</MenuItem>
          <MenuItem value="instructor">Average Salary per Department</MenuItem>
          <MenuItem value="student">Students per Department</MenuItem>
        </Select>
      </FormControl>
      <Button variant="contained" color="secondary" onClick={handleVisualize}>
        Visualize
      </Button>
      {visualizationData.length > 0 && (
        <Box mt={2} height={400}>
          <ResponsiveContainer width="100%" height="100%">
            <BarChart data={visualizationData}>
              <XAxis dataKey="dept_name" />
              <YAxis />
              <Tooltip />
              <Legend />
              <Bar dataKey={Object.keys(visualizationData[0])[1]} fill="#8884d8" />
            </BarChart>
          </ResponsiveContainer>
        </Box>
      )}
    </>
  );
}

export default Visualization;