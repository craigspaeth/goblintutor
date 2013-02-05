express = require 'express'
routes = require './app/routes'
http = require 'http'
path = require 'path'
db = require './lib/db'

# Configure App
app = express()
app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/app/templates"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

# Load routes
for route, fn of routes
  verb = route.split(' ')[0]
  path = route.split(' ')[1]
  app[verb.toLowerCase()] path, fn

db.open (err) ->
  throw err if err
  http.createServer(app).listen app.get("port"), ->
    console.log "Express server listening on port " + app.get("port")