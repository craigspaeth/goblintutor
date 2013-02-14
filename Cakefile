tutor = require 'tutor'
scrape = require './lib/scrape'
db = require './lib/db'

task 'scrape', 'scrapes all of the sets and saves to db', ->
  db.open ->
    tutor.sets (err, setNames) ->
      i = 0
      recur = ->
        scrape.scrapeSet setNames[i], (err, docs) ->
          throw err if err
          console.log "Saved #{docs?.length} cards."
          i++
          recur()
      recur()

task 'scrape:first', 'scrapes the first set and saves to db', ->
  db.open ->
    tutor.sets (err, setNames) ->
      scrape.scrapeSet setNames[0], (err, docs) ->
        throw err if err
        console.log "Saved #{docs?.length} cards."