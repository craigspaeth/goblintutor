tutor = require 'tutor'
scrape = require './lib/scrape'

task 'scrape', ->
  scrape.scrapeSet 'Magic 2013', (err, docs) ->
    console.log docs.length