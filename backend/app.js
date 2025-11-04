import express from 'express';
import cors from 'cors';
import { getSensorData } from '../../db/database.js';

const app = express();
app.use(cors());

app.get('/api/sensor-data', async (req, res) => {
  try {
    const data = await getSensorData();
    res.json(data);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

app.listen(3001, () => {
  console.log('Backend running on http://localhost:3001');
});
