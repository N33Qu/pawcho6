const express = require('express');
const os = require('os');

const app = express();
const hostname = os.hostname();
let ip;

// Find the IPv4 address of the first non-internal interface
const interfaces = os.networkInterfaces();
Object.keys(interfaces).forEach((iface) => {
  interfaces[iface].forEach((ifaceInfo) => {
    if (!ifaceInfo.internal && ifaceInfo.family === 'IPv4') {
      ip = ifaceInfo.address;
    }
  });
});

const version = process.env.VERSION;

app.get('/', (req, res) => {
  res.send(`Server IP: ${ip}\nServer hostname: ${hostname}\nVersion: ${version}\n`);
});

app.listen(5000, 'localhost', () => {
  console.log(`Server running at http://localhost:5000/`);
});
