(function() {

  $(function() {
    var autocomplete;
    Backbone.history.start({
      pushState: true
    });
    autocomplete = new AutocompleteView({
      el: $('input'),
      url: '/api/match/cards'
    });
    return autocomplete.renderLi = function(item) {
      return JST['cards/list_item']({
        item: item
      });
    };
  });

}).call(this);
