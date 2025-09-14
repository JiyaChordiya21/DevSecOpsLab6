// app.js
const http = require('http');

const PORT = process.env.PORT || 8888;

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello from Swaraj - CI/CD Lab!\n');
});

server.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
