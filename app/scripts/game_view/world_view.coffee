define ['view'], (View) ->
  class WorldView extends View
    constructor: (container, camera, @world) ->
      super container, camera
      @viewsTypes = {}
      @views = {}

    createGraphics: ->
      graphics = new PIXI.DisplayObjectContainer()
      graphics.width = @container.width
      graphics.height = @container.height

      graphics

    updateGraphics: ->
      @renderEntities(@world.getEntities())

    renderEntities: (entities) ->
      _.each entities, (entity) =>
        if entity.exists()
          @getView(entity).render(entity)
        else
          @getView(entity).destroy()
          delete @views[entity.toString()]

    getView: (entity) ->
      unless @views[entity.toString()]?
        viewContructor = @getViewType(entity.type)
        @views[entity.toString()] = new viewContructor(@graphics, @camera, entity)

      @views[entity.toString()]
    
    getViewType: (type) ->
      @viewsTypes[type]

    registerView: (type, renderer) ->
      @viewsTypes[type] = renderer
