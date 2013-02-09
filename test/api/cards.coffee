Card = require "#{process.cwd()}/app/models/card"
collectionStub = require '../helpers/collection_stub'
sinon = require 'sinon'
routes = require "#{process.cwd()}/app/routes/api/cards"

describe 'api/cards', ->
  
  describe '/:id', ->
    
    beforeEach ->
      @fetchStub = sinon.stub Card::, 'fetch'
      @fetchStub.callsArgWith 0, null, { foo: 'bar' }
    
    afterEach ->
      @fetchStub.restore()
    
    it 'fetches a card by id', ->
      routes['GET cards/:id'](
        { params: { id: '51166320ad2baad05c000001' } }
        { send: (res = sinon.spy()) }
      )
      @fetchStub.called.should.be.ok
      res.args[0][0].id.should.equal '51166320ad2baad05c000001' 