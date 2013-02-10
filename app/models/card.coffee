Base = require './base'

module.exports = class Card extends Base
  
  collectionName: 'cards'
  
  @gathererToSchema: (data) ->
    name:         data.name
    mana_cost:    data.mana_cost
    types:        data.types
    subtypes:     data.subtypes
    text:         data.text
    power:        data.power
    toughness:    data.toughness
    image_url:    data.image_url
    gatherer_url: data.gatherer_url
    expansion:    data.expansion