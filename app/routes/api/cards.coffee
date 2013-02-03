tutor = require 'tutor'

@['GET card/:id'] = (req, res) ->
  tutor.card parseInt(req.params.id), (err, card) ->
    res.send 404, "Can not find card by id #{req.params.id}" if err
    res.send card