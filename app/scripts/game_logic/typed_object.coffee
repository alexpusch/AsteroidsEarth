define ->
  class TypedObject
    constructor: (@type) ->
      @id = "#{@type}_#{Math.random()}"
      
    toString: ->
      @id