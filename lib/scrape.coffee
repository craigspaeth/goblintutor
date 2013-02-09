tutor = require 'tutor'
db = require './db'
Card = require '../app/models/card'

# Fetches all of the cards in a set and calls a callback with the
# data of the cards returned from tutor.
# 
# @param {String} setName
# @param {Function} callback

@fetchSet = (setName, callback) ->
  page = 0
  cards = []
  fetch = ->
    page++
    tutor.set { name: setName, page: page }, (err, set) ->
      callback?(err) if err and not err.toString().match(/page not found/)
      if set?.cards
        cards = cards.concat set.cards
        fetch()
      else
        callback? null, cards
  fetch()
  
# Scrapes a set of cards and saves it in the database
# 
# @param {String} setName
# @param {Function} callback

@scrapeSet = (setName, callback) =>
  db.open =>
    @fetchSet setName, (err, cards) ->
      return callback(err) if err
      docs = (Card.gathererToSchema(card) for card in cards)
      Card.insert docs, {}, (err, docs) ->
        return callback(err) if err
        callback null, docs
        db.close()