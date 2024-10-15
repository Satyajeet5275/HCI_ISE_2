const express = require('express');
const cors = require('cors');
const db = require('./db');

const app = express();
const port = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.get('/api/search', async (req, res) => {
  const { query, entity } = req.query;
  let sql = '';

  switch (entity) {
    case 'classroom':
      sql = 'SELECT * FROM Classroom WHERE building LIKE ? OR room_number LIKE ?';
      break;
    case 'department':
      sql = 'SELECT * FROM Department WHERE dept_name LIKE ? OR building LIKE ?';
      break;
    case 'course':
      sql = 'SELECT * FROM Course WHERE course_id LIKE ? OR title LIKE ? OR dept_name LIKE ?';
      break;
    case 'instructor':
      sql = 'SELECT * FROM Instructor WHERE name LIKE ? OR dept_name LIKE ?';
      break;
    case 'student':
      sql = 'SELECT * FROM Student WHERE name LIKE ? OR dept_name LIKE ?';
      break;
    default:
      return res.status(400).json({ error: 'Invalid entity type' });
  }

  try {
    const results = await db.query(sql, [`%${query}%`, `%${query}%`, `%${query}%`]);
    res.json(results);
  } catch (error) {
    console.error('Error executing query:', error);
    res.status(500).json({ error: 'An error occurred while searching' });
  }
});

app.get('/api/visualize', async (req, res) => {
  const { entity } = req.query;
  let sql = '';

  switch (entity) {
    case 'department':
      sql = 'SELECT dept_name, budget FROM Department';
      break;
    case 'course':
      sql = 'SELECT dept_name, COUNT(*) as course_count FROM Course GROUP BY dept_name';
      break;
    case 'instructor':
      sql = 'SELECT dept_name, AVG(salary) as avg_salary FROM Instructor GROUP BY dept_name';
      break;
    case 'student':
      sql = 'SELECT dept_name, COUNT(*) as student_count FROM Student GROUP BY dept_name';
      break;
    default:
      return res.status(400).json({ error: 'Invalid entity type for visualization' });
  }

  try {
    const results = await db.query(sql);
    res.json(results);
  } catch (error) {
    console.error('Error executing query:', error);
    res.status(500).json({ error: 'An error occurred while fetching visualization data' });
  }
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});