(function() {

  $(function() {
    Backbone.history.start({
      pushState: true
    });
    return new AutocompleteView({
      el: $('input'),
      url: '/api/match/cards'
    });
  });

}).call(this);
