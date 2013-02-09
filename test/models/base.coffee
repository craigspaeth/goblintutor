Base = require "#{process.cwd()}/app/models/base"
collectionStub = require '../helpers/collection_stub'
sinon = require 'sinon'

describe 'Base', ->
  
  class NoCollection extends Base
  class Model extends Base
    collectionName: 'foo'
  
  beforeEach ->
    @model = new Model
    @model.collection = -> @stub ?= new collectionStub

  it 'throws an error without a collectionName', ->
    (-> new NoCollection).should.throw()
    
  describe '#id', ->
    
    it 'returns null with no _id', ->
      (@model.id()?).should.not.be.ok
      
    it 'returns an ObjectID wrapped _id', ->
      @model.set _id: '51166320ad2baad05c000001'
      (typeof @model.id()).should.not.equal 'string'
      @model.id().toString().should.equal '51166320ad2baad05c000001'
      
  describe '#get', ->
    
    it 'gets attributes', ->
      @model = new Model foo: 'bar'
      @model.get('foo').should.equal 'bar'
  
  describe '#set', ->
    
    it 'sets attributes', ->
      @model.set foo: 'bar'
      @model.get('foo').should.equal 'bar'
      @model.attrs.foo.should.equal 'bar'
      
  describe '#save', ->
    
    it 'inerts a new model', ->
      @model.set foo: 'bar'
      @model.save (cb = ->)
      @model.collection().insert.args[0][0].foo.should.equal 'bar'
      @model.collection().insert.args[0][1].should.equal cb
      
    it 'updates an existing model', ->
      @model.set _id: '51166320ad2baad05c000001', foo: 'bar'
      @model.save()
      @model.collection().update.args[0][0]._id
        .toString().should.equal '51166320ad2baad05c000001'
      @model.collection().update.args[0][1].foo.should.equal 'bar'
      
  describe '#fetch', ->
    
    it 'finds one document', ->
      @model.set _id: '51166320ad2baad05c000001'
      @model.collection().findOne.callsArgWith 1, null, { foo: 'bar' }
      @model.fetch (cb = sinon.spy())
      @model.collection().findOne.args[0][0]._id
        .toString().should.equal '51166320ad2baad05c000001'
      @model.get('foo').should.equal 'bar'
      cb.args[0][1].foo.should.equal 'bar'
  
  describe '#destroy', ->
    
    it 'removes that document by _id', ->
      @model.set _id: '51166320ad2baad05c000001'
      @model.destroy()
      @model.collection().remove.args[0][0]._id
        .toString().should.equal '51166320ad2baad05c000001'
        
  describe 'static methods', ->
    
    it 'aliases static methods', ->
      (Model.find?).should.be.ok