scrape = require './lib/scrape'
Card = require './app/models/card'
db = require './lib/db'

task 'scrape', ->
  scrape.fetchSet 'Magic 2013', (cards) ->
    console.log cards[0]
    
task 'card', ->
  db.open ->
    card = new Card title: 'foo'
    card.save ->
      card.fetch (err) ->
        console.log arguments