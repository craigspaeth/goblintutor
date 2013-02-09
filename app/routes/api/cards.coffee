tutor = require 'tutor'
Card = require "#{process.cwd()}/app/models/card"

@['GET cards/:id'] = (req, res) ->
  card = new Card _id: req.params.id
  card.fetch (err) ->
    return res.send 404, "Can not find card by id #{req.params.id}" if err
    res.send card.toJSON()