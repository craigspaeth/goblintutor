{ Db, Server, Collection } = mongodb = require 'mongodb'
_ = require 'underscore'

@open = (callback, options) =>
  return callback? null, @client if @client  
  options = _.extend
    host: '127.0.0.1'
    port: 27017
    db: 'test'
  , options
  server = new Server options.host, options.port, {}
  client = new Db options.db, server, { w: 1 }
  client.open (@err, @client) =>
    callback? @err if @err
    callback? null, @client if @client
    
@close = =>
  ensureConnected()
  @client.close()

@collection = (name) =>
  ensureConnected()
  new Collection @client, name
  
ensureConnected = =>
  throw @err || "No database client open." unless @client?