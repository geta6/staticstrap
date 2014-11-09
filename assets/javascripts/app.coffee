define [
  'lib/mixin'
  'backbone'
  'marionette'
], (_, Backbone) ->

  app = new Backbone.Marionette.Application()

  app.once 'start', ->
    Backbone.history.start pushState: true

  return app
