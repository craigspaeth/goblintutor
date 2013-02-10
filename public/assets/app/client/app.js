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
    autocomplete.renderLi = function(item) {
      return JST['cards/list_item']({
        item: item
      });
    };
    return $('input').val('Acid').focus().keyup();
  });

}).call(this);
