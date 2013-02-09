class window.AutocompleteView extends Backbone.View
  
  initialize: ->
    @search = _.debounce @search, 100
    @$results = @$el.after("<div class='results'></div>").next('.results')
    
  events:
    'keyup': 'search'
    
  search: =>
    $.ajax(
      url: @options.url
      data: term: @$el.val()
    ).then (res) =>
      @$results.html @resToHTML res
      
  resToHTML: (res) =>
    """
      <ul>
        #{("<li>#{obj.name}</li>" for obj in res).join('')}
      </ul>
    """