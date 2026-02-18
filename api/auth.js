export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).json({ error: 'Method not allowed' });

  const { password } = req.body;
  const APP_PASSWORD = process.env.APP_PASSWORD || 'iotfanenlic';

  if (password !== APP_PASSWORD) {
    return res.status(401).json({ error: 'Invalid password' });
  }

  const token = 'authenticated_' + Date.now();
  res.status(200).json({ token });
}