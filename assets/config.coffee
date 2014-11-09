require.config
  baseUrl: '/javascripts'

  paths:
    text: '../vendor/requirejs-text/text'
    moment: '../vendor/moment/moment'
    jquery: '../vendor/jquery/dist/jquery'
    underscore: '../vendor/lodash/dist/lodash'
    bootstrap: '../vendor/bootstrap/dist/js/bootstrap'
    backbone: '../vendor/backbone/backbone'
    marionette: '../vendor/marionette/lib/backbone.marionette'

  shim:
    backbone:
      deps: ['underscore', 'jquery']
      exports: 'Backbone'
    marionette:
      deps: ['underscore', 'jquery', 'backbone']
      exports: 'Marionette'

  config:
    moment:
      noGlobal: true

require ['app'], (app) ->
  _.defer _.bind app.start, app
