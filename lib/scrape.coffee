tutor = require 'tutor'

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
      if set?.cards
        cards = cards.concat set.cards
        fetch()
      else
        callback? cards
  fetch()