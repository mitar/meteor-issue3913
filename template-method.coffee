if Meteor.isClient
  class DataContextBase
    @templateHelper: (helper) ->
      ->
        args = this._arguments or []
        delete this._arguments
        helper.apply this, args

  class DataContext extends DataContextBase
    dataContextHelper: =>
      console.log 'dataContextHelper', arguments, this
      "dataContextHelper WORKS"

    dataContextTemplate: @templateHelper ->
      console.log 'dataContextTemplate', arguments, this
      Template.works

  Template.hello.helpers
    dataContext: ->
      new DataContext()
  
  Template.registerHelper 'args', ->
    @_arguments = arguments
    @
