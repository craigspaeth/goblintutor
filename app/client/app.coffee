$ ->
  Backbone.history.start pushState: true
  new AutocompleteView
    el: $('input')
    url: '/api/match/cards'