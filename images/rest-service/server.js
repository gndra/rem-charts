const express = require('express')
const { createProxyMiddleware } = require('http-proxy-middleware')

const app = express()

// app.use(express.json())

const router = (req) => {
  if (process.env.PLATFORM_SERVE) {
    const user = req.headers['x-user']
    if (!user) return process.env.PROXY_URL
    const extraPath = process.env.EXTRA_PATH || ''
    return `https://${user}-${process.env.PLATFORM_SERVE}.rem.tools${extraPath}`
  }
  return process.env.PROXY_URL
}

app.use('/', createProxyMiddleware({
  target: process.env.PROXY_URL,
  changeOrigin: true,
  router
}));

app.listen(process.env.PORT || 3000, () => {
  console.log("Server listening for request on port:", process.env.PORT || 3000)
})
