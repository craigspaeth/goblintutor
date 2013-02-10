tutor = require 'tutor'
scrape = require './lib/scrape'
db = require './lib/db'

task 'scrape', ->
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