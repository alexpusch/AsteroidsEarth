define ['view', 'views_collection'], (View, ViewsCollection) ->
  class WorldView extends View
    constructor: (container, camera, @world) ->
      super container, camera
      @viewsTypes = {}
      @views = new ViewsCollection()

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
          @views.remove entity
      @_sortViewsInContainer()

    getView: (entity) ->
      unless @views.exists entity
        viewConstructor = @getViewType(entity.type)
        @views.add entity, new viewConstructor(@graphics, @camera, entity), @getViewTypeZ(entity.type)
        

      @views.get entity
    
    getViewType: (type) ->
      @viewsTypes[type].type

    getViewTypeZ: (type) ->
      @viewsTypes[type].z      

    registerView: (type, view, z = 0) ->
      @viewsTypes[type] = 
        type: view
        z: z

    _sortViewsInContainer: ->
      views = @views.getViews()
      _(views).each (view) =>
        @graphics.removeChild view.graphics

      _(views).each (view) =>
        @graphics.addChild view.graphics