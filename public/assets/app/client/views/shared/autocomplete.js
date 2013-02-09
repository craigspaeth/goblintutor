(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.AutocompleteView = (function(_super) {

    __extends(AutocompleteView, _super);

    function AutocompleteView() {
      this.resToHTML = __bind(this.resToHTML, this);

      this.search = __bind(this.search, this);
      return AutocompleteView.__super__.constructor.apply(this, arguments);
    }

    AutocompleteView.prototype.initialize = function() {
      this.search = _.debounce(this.search, 100);
      return this.$results = this.$el.after("<div class='results'></div>").next('.results');
    };

    AutocompleteView.prototype.events = {
      'keyup': 'search'
    };

    AutocompleteView.prototype.search = function() {
      var _this = this;
      return $.ajax({
        url: this.options.url,
        data: {
          term: this.$el.val()
        }
      }).then(function(res) {
        return _this.$results.html(_this.resToHTML(res));
      });
    };

    AutocompleteView.prototype.resToHTML = function(res) {
      var obj;
      return "<ul>\n  " + (((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = res.length; _i < _len; _i++) {
          obj = res[_i];
          _results.push("<li>" + obj.name + "</li>");
        }
        return _results;
      })()).join('')) + "\n</ul>";
    };

    return AutocompleteView;

  })(Backbone.View);

}).call(this);
