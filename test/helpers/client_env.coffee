# 
# Using jsdom creates a browser environment with common libraries exposed
# globally.
# 

jsdom = require('jsdom').jsdom

# Stub a generic DOM and globally expose `window` and `document`
global.document = jsdom "<html><head></head><body></body></html>"
global.window = document.createWindow()

# Expose common libraries globally
require "#{process.cwd()}/app/client/vendor/jquery"
global.$ = global.jQuery = window.jQuery
global._ = require "#{process.cwd()}/app/client/vendor/underscore"
global.Backbone = require "#{process.cwd()}/app/client/vendor/backbone"
Backbone.$ = $