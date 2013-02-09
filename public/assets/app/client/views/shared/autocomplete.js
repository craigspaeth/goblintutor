(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.AutocompleteView = (function(_super) {

    __extends(AutocompleteView, _super);

    function AutocompleteView() {
      this.onKeyUp = __bind(this.onKeyUp, this);

      this.select = __bind(this.select, this);

      this.search = __bind(this.search, this);
      return AutocompleteView.__super__.constructor.apply(this, arguments);
    }

    AutocompleteView.prototype.defaults = {
      field: 'name',
      delay: 300
    };

    AutocompleteView.prototype.initialize = function() {
      this.options = _.extend(this.defaults, this.options);
      this.search = _.debounce(this.search, this.options.delay);
      return this.$results = this.$el.after("<div class='ac_results'></div>").next('.ac_results');
    };

    AutocompleteView.prototype.renderLi = function(obj) {
      return "<li>" + obj[this.options.field] + "</li>";
    };

    AutocompleteView.prototype.renderResults = function(arr) {
      var obj;
      return "<ul>" + (((function() {
        var _i, _len, _results;
        _results = [];
        for (_i = 0, _len = arr.length; _i < _len; _i++) {
          obj = arr[_i];
          _results.push(this.renderLi(obj));
        }
        return _results;
      }).call(this)).join('')) + "</ul>";
    };

    AutocompleteView.prototype.search = function() {
      var _this = this;
      return $.ajax({
        url: this.options.url,
        data: {
          term: this.$el.val()
        }
      }).then(function(res) {
        _this.res = res;
        _this.$results.html(_this.renderResults(_this.res));
        return _this.$results.find('li').click(_this.select);
      });
    };

    AutocompleteView.prototype.over = function(dir) {
      var $next, $over;
      $over = this.$results.find('.ac_over');
      $over.parent().children().removeClass('ac_over');
      $next = $over[dir]();
      if (!$next.length) {
        if (dir === 'next') {
          this.$results.find('li:first').addClass('ac_over');
        }
        if (dir === 'prev') {
          this.$results.find('li:last').addClass('ac_over');
        }
        return;
      }
      return $next.addClass('ac_over');
    };

    AutocompleteView.prototype.select = function(e) {
      var index;
      index = $(e.target).index();
      this.trigger('select', this.res[index]);
      return console.log(this.res[index]);
    };

    AutocompleteView.prototype.events = {
      'keyup': 'onKeyUp'
    };

    AutocompleteView.prototype.onKeyUp = function(e) {
      var down, enter, up, _ref;
      _ref = {
        up: 38,
        down: 40,
        enter: 13
      }, up = _ref.up, down = _ref.down, enter = _ref.enter;
      switch (e.which) {
        case up:
          return this.over('prev');
        case down:
          return this.over('next');
        case enter:
          return this.select({
            target: this.$results.find('.ac_over')
          });
        default:
          return this.search();
      }
    };

    return AutocompleteView;

  })(Backbone.View);

}).call(this);
