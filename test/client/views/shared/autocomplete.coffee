sinon = require 'sinon'
require "#{process.cwd()}/test/helpers/client_env"
require "#{process.cwd()}/app/client/views/shared/autocomplete"

describe 'AutocompleteView', ->
  
  before ->
    $('body').html "<input>"
  
  beforeEach ->
    @view = new window.AutocompleteView
      el: $('input')
      url: '/foo/bar'
    
  describe '#initialize', ->
    
    it 'extends options with defaults', ->
      @view.options.delay.should.equal 300
    
    it 'appends a results element', ->
      @view.initialize()
      $('body').html().should.include 'ac_results'
      
  describe '#renderLi', ->
    
    it 'renders an li with the field', ->
      @view.renderLi(name: 'foo').should.include 'foo'
      
  describe "#renderResults", ->
    
    it 'rendrs a ul of names', ->
      @view.renderResults([{ name: 'bar' }]).should.include 'bar'
      
  describe '#search', ->
    
    it 'sends an ajax request depending on the inputs val', ->
      spy = sinon.spy $, 'ajax'
      clock = sinon.useFakeTimers()
      @view.$el.val 'foobar'
      @view.search()
      clock.tick(@view.options.delay * 2)
      spy.args[0][0].url.should.equal '/foo/bar'
      spy.args[0][0].data.term.should.equal 'foobar'
      clock.restore()
      
  describe '#over', ->
    
    it 'highlights the next element', ->
      @view.$results.html """
        <li class='ac_over'></li>
        <li class='foo'></li>
      """
      @view.over('next')
      @view.$results.children('.foo').hasClass('ac_over').should.be.ok
    
    it 'highlights the prev element', ->
      @view.$results.html """
        <li class='foo'></li>
        <li class='ac_over'></li>
      """
      @view.over('prev')
      @view.$results.children('.foo').hasClass('ac_over').should.be.ok
      
  describe '#select', ->
    
    it 'triggers select with the response obj at index', ->
      $fixture = $ """
        <ul>
          <li></li>
          <li class='foo'></li>
          <li></li>
        </ul>
      """
      @view.res = [{}, { foo: 'bar' }, {}]
      @view.on 'select', (spy = sinon.spy())
      @view.select target: $fixture.children('.foo')
      spy.args[0][0].foo.should.equal 'bar'
      
  describe '#onKeyup', ->
    
    it 'goes over prev on arrow up', ->
      @view.over = sinon.stub()
      @view.onKeyUp which: 38      
      @view.over.args[0][0].should.equal 'prev'
      
    it 'goes over next on arrow down', ->
      @view.over = sinon.stub()
      @view.onKeyUp which: 40
      @view.over.args[0][0].should.equal 'next'
      
    it 'selects the current highlighted item on enter', ->
      @view.$results.html $ """
        <ul>
          <li></li>
          <li class='ac_over foo'></li>
        </ul>
      """
      @view.select = sinon.stub()
      @view.onKeyUp which: 13
      @view.select.args[0][0].target.hasClass('foo').should.be.ok
    
    it 'searches otherwise', ->
      @view.search = sinon.stub()
      @view.onKeyUp which: 100
      @view.search.called.should.be.ok