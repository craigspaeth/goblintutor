{ Db, Server, Collection } = mongodb = require 'mongodb'
_ = require 'underscore'

@open = (callback, options) =>
  return callback? null, @client if @client  
  options = _.extend
    host: process.env.GT_MONGO_HOST or '127.0.0.1'
    port: process.env.GT_MONGO_PORT or 27017
    db: process.env.GT_MONGO_DB or 'test'
    username: process.env.GT_MONGO_USERNAME or undefined
    password: process.env.GT_MONGO_PASSWORD or undefined
  , options
  server = new Server options.host, options.port, {}
  client = new Db options.db, server, { w: 1 }
  open = =>
    client.open (@err, @client) =>
      if options.username and options.password
        client.authenticate options.username, options.password, (@err, @client) =>
          console.log 'AUTH', arguments
          callback? @err if @err
          callback? null, @client if @client
      else
        console.log 'NO AUTH', arguments
        callback? @err if @err
        callback? null, @client if @client
  if options.password
    client.authenticate options.username, options.password, (err) ->
    return throw(err) if err
    open()
  else
   open()
    
@close = =>
  ensureConnected()
  @client.close()

@collection = (name) =>
  ensureConnected()
  new Collection @client, name
  
ensureConnected = =>
  throw @err or "No database client open." unless @client?