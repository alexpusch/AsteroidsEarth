define ['world_renderer', 'hud_renderer'], (WorldRenderer, HudRenderer) ->
  class SceneRenderer
    constructor: (options) ->
      @renderersTypes = {}
      @renderers = {}
      @camera = options.camera

    setupRenderer: (options) ->
      @stage = new PIXI.Stage(0xFFFFFF, true) 
      @stage.setInteractive(false)

      width = options.container.width()
      height = options.container.height()

      @pixiRenderer = PIXI.autoDetectRenderer(width, height, null, false, true)
      options.container.append(@pixiRenderer.view)

    render: (world, score) ->
      @renderEntities(world.getEntities())
      @renderHud([score])
      @pixiRenderer?.render(@stage)

    renderHud: (entities) ->
      _.each entities, (entity) =>
        @getHudRenderer(entity).render(entity)

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
    
    getHudRenderer: (entity) ->
      unless @renderers[entity.toString()]?
        @renderers[entity.toString()] = new (@getRendererType(entity.type))(@stage, entity)

      @renderers[entity.toString()]

    getRendererType: (type) ->
      @renderersTypes[type]

    registerRenderer: (type, renderer) ->
      @renderersTypes[type] = renderer
