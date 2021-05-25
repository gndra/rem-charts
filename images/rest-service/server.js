const express = require('express')
const { createProxyMiddleware } = require('http-proxy-middleware')

const app = express()

app.use(express.json())

app.use('/', createProxyMiddleware({
  target: process.env.PROXY_URL,
  changeOrigin: true
}));

app.listen(process.env.PORT || 3000, () => {})