sinon = require 'sinon'

methods = [
  'find', 'findOne', 'update', 'insert', 'findAndModify', 'drop', 'count' 
  'remove'
]
module.exports = class  
  constructor: ->
    @[method] = sinon.stub() for method in methods
