{ Db, Server, Collection } = mongodb = require 'mongodb'
_ = require 'underscore'

@open = (callback, options) =>
  return callback? null, @client if @client
  
  # Extend Mongo options & setup client
  options = _.extend
    host: process.env.MONGO_HOST or '127.0.0.1'
    port: process.env.MONGO_PORT or 27017
    db: process.env.MONGO_DB or 'test'
    username: process.env.MONGO_USERNAME or undefined
    password: process.env.MONGO_PASSWORD or undefined
  , options
  db = new Db(
    options.db
    new Server(
      options.host
      options.port
      { auto_reconnect: true }
      {}
    )
  )
  
  # Open the db connection & authenticate 
  db.open (@err, @client) =>
    if options.username and options.password
      db.authenticate options.username, options.password, (err) =>
        console.log 'AUTH'
        if err
          delete @client
          callback? (@err = err)
        else 
          callback? null, @client
    else
      console.log 'NO AUTH'
      callback? @err if @err
      callback? null, @client if @client
    
@close = =>
  ensureConnected()
  @client.close()

@collection = (name) =>
  ensureConnected()
  new Collection @client, name
  
ensureConnected = =>
  throw @err or "No database client open." unless @client?