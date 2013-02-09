Card = require "#{process.cwd()}/app/models/card"
collectionStub = require '../helpers/collection_stub'
sinon = require 'sinon'
routes = require "#{process.cwd()}/app/routes/api/cards"
fabricate = require '../helpers/fabricate'

describe 'api/cards', ->
  
  describe '/:id', ->
    
    beforeEach ->
      @fetchStub = sinon.stub Card::, 'fetch'
      @fetchStub.callsArgWith 0, null, { foo: 'bar' }
      routes['GET cards/:id'](
        { params: { id: '51166320ad2baad05c000001' } }
        { send: (@res) => }
      )
    
    afterEach ->
      @fetchStub.restore()
    
    it 'fetches a card by id', ->
      @fetchStub.called.should.be.ok
      @res.id.should.equal '51166320ad2baad05c000001' 
      
  describe '/', ->
    
    beforeEach ->
      @cards = cards = [fabricate.card(), fabricate.card()]
      @findStub = sinon.stub Card, 'find'
      @findStub.returns { limit: -> toArray: (cb) -> cb(null, cards) }
      routes['GET cards'] {}, { send: (@res) => }
      
    afterEach ->
      @findStub.restore()
    
    it 'returns an array of cards', ->
      @findStub.called.should.be.ok
      @res.length.should.equal @cards.length
      @res[0].name.should.equal @cards[0].name
      
  describe '/cards/match/:query', ->
    
    beforeEach ->
      @cards = cards = [fabricate.card(), fabricate.card()]
      @findStub = sinon.stub Card, 'find'
      @findStub.returns { limit: -> toArray: (cb) -> cb(null, cards) }
      routes['GET cards/match/:query'](
        { params: query: 'foobar' }
        { send: (@res) => }
      )
      
    afterEach ->
      @findStub.restore()
    
    it 'regex queries mongo and returns an array of cards', ->
      @findStub.args[0][0].name.$regex.should.equal 'foobar'
      @res.length.should.equal @cards.length
      @res[0].name.should.equal @cards[0].name