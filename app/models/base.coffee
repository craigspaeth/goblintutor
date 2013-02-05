{ ObjectID } = mongodb = require 'mongodb'
db = require "#{process.cwd()}/lib/db"
_ = require 'underscore'

module.exports = class Base
  
  constructor: (@attrs) ->
    throw "You must specify a collection" unless @collection?
  
  id: ->
    return false unless @get('_id')
    new ObjectID(@get('_id').toString())
  
  get: (attr) ->
    @attrs[attr]
  
  set: (attrs) ->
    @attrs[key] = val for key, val of attrs
    
  save: (cb) ->
    attrs = _.extend @attrs, id: undefined
    if @id()
      db.collection(@collection).update(
        { _id: @id() }, attrs, { upsert: true }, cb
      )
    else
      db.collection(@collection).insert attrs, cb
        
  fetch: (cb) ->
    return callback("Must have id to fetch.") unless @id()
    db.collection(@collection).findOne { _id: @id() }, (err, doc) =>
      @set doc unless err
      cb? arguments...
    
  destroy: (cb) ->
    db.collection(@collection).remove { _id: @id() }, cb
  
  for method in ['find', 'findOne', 'update', 'insert', 'findAndModify', 'drop', 'count']
    @[method] = _.partial ((method, args...) ->
      db.collection(@::collection)[method] args...
    ), method