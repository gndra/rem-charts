const express = require('express')
const { createProxyMiddleware } = require('http-proxy-middleware')

const app = express()

// app.use(express.json())

const router = (req) => {
  if (process.env.PLATFORM_SERVE) {
    const user = req.headers['x-user'] || req.path.split('/')[1]
    if (!user) return process.env.PROXY_URL
    const extraPath = process.env.EXTRA_PATH || ''
    return `https://${user}-${process.env.PLATFORM_SERVE}.rem.tools${extraPath}`
  }
  return process.env.PROXY_URL
}

const pathRewrite = (path, req) => {
  if (req.headers['x-user'] || !process.env.PLATFORM_SERVE) return path
  const user = path.split('/')[1]
  return path.replace(new RegExp(`/${user}`), '')
}

const onError = (err, req, res, target) => {
  res.writeHead(403, {
    'Content-Type': 'application/json'
  })
  res.end(JSON.stringify({
    message: 'Invalid route or access'
  }))
}

app.use('/', createProxyMiddleware({
  target: process.env.PROXY_URL,
  changeOrigin: true,
  pathRewrite,
  router,
  onError
}));

app.listen(process.env.PORT || 3000, () => {
  console.log("Server listening for request on port:", process.env.PORT || 3000)
})
