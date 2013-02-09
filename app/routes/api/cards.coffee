tutor = require 'tutor'
Card = require "#{process.cwd()}/app/models/card"

@['GET cards/:id'] = (req, res) ->
  card = new Card _id: req.params.id
  card.fetch (err) ->
    return res.send 404, "Can not find card by id #{req.params.id}" if err
    res.send card.toJSON()
    
@['GET cards'] = (req, res) ->
  Card.find().limit(100).toArray (err, docs) ->
    return res.send 500, err if err
    res.send Card.docsToJSON(docs)
    
@['GET match/cards'] = (req, res) ->
  Card.find({ name: { $regex: req.query.term } })
    .limit(20).toArray (err, docs) ->
      return res.send 500, err if err
      res.send Card.docsToJSON(docs)