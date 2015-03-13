if Meteor.isClient
  argsConstructor = ->
    # This class should never really be created.
    assert false

  class DataContextBase
    @templateHelper: (helper) ->
      ->
        obj = @
        if obj.constructor is argsConstructor
          args = @_arguments or []
          # Unwrap to get the original data context.
          obj = Object.getPrototypeOf obj
        else
          args = []
        helper.apply obj, args

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
    # We wrap current data context with new object so that we do not modify
    # original data context when we add _arguments, but that all properties
    # from current data context are still available.
    obj = Object.create @
    # We use custom constructor to know that it is not a real DataContext.
    obj.constructor = argsConstructor
    obj._arguments = arguments
    obj
