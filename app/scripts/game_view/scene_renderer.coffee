define ->
  class SceneRenderer
    constructor: (options) ->
      @renderersTypes = {}
      @renderers = {}
      @camera = options.camera
      @stage = options.stage

    render: (world, score, astroidSpwaner) ->
      @renderEntities(world.getEntities())
      @renderHud([astroidSpwaner])
      @stage.getPixiRenderer()?.render(@stage.getPixiStage())

    renderHud: (entities) ->
      _.each entities, (entity) =>
        @getRenderer(entity).render(entity)

    renderEntities: (entities) ->
      _.each entities, (entity) =>
        if entity.exists()
          @getRenderer(entity).render(entity)
        else
          @getRenderer(entity).destroy()
          delete @renderers[entity.toString()]

    getRenderer: (entity) ->
      unless @renderers[entity.toString()]?
        @renderers[entity.toString()] = new (@getRendererType(entity.type))(@stage, @camera, entity)

      @renderers[entity.toString()]
    
    # getHudRenderer: (entity) ->
    #   unless @renderers[entity.toString()]?
    #     @renderers[entity.toString()] = new (@getRendererType(entity.type))(@stage, entity)

      @renderers[entity.toString()]

    getRendererType: (type) ->
      @renderersTypes[type]

    registerRenderer: (type, renderer) ->
      @renderersTypes[type] = renderer
