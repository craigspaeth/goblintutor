_ = require 'underscore'

@card = (data) ->
  _.extend
    name: "Acidic Slime"
    mana_cost: "{3}{G}{G}"
    type: "Creature - Ooze"
    text: "Deathtouch (Any amount of damage this deals to a creature..."
    power: 2
    toughness: 2
    image_url: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=265718&type=card"
    gatherer_url: "http://gatherer.wizards.com/Pages/Card/Details.aspx?multiverseid=265718"
    id: "511678c8092ee0975e000001"
  , data