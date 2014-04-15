define ['entity_factory',
         'world', 
         'scene_renderer',
         'spaceship', 
         'player', 
         'spaceship_renderer', 
         'bullet_renderer', 
         'camera', 
         'planet', 
         'astroid_spwaner', 
         'score', 
         'score_renderer'], (
          EntityFactory, 
          World, 
          SceneRenderer,
          Spaceship, 
          Player, 
          SpaceshipRenderer, 
          BulletRenderer, 
          Camera, 
          Planet, 
          AstroidSpwaner, 
          Score, 
          ScoreRenderer) ->

  class Game
    constructor: (@container) ->
      @width = container.width()
      @height = container.height()

      @scale = 10
      @world = new World
        size:
          width: @width/@scale
          height: @height/@scale
      
      window.EntityFactory = new EntityFactory @world

      # world.setupDebugRenderer $('canvas')[0]

      spaceship = window.EntityFactory.createSpaceship()

      player = new Player()
      player.control spaceship

      @createPlanet()
      @createAstroidSpawner()

      @createRenderer()
      
      @createHUD()
      @registerRenderers()

    createPlanet: ->
      @planet = window.EntityFactory.createPlanet()
      @planet.setPosition(new B2D.Vec2(@width/@scale/2, @height/@scale/2))

    createAstroidSpawner: ->
      astroidSpwaner = new AstroidSpwaner
        width: @width/@scale
        height: @height/@scale
        planet: @planet

      astroidSpwaner.startSpwaning()

    createRenderer: ->
      camera = new Camera()
      camera.zoom(@scale)

      @renderer = new SceneRenderer
        camera: camera
      
      @renderer.setupRenderer
        container: @container

    createHUD: ->
      @score = new Score
        upInterval: 10

    registerRenderers: ->
      @renderer.registerRenderer('spaceship', SpaceshipRenderer)
      @renderer.registerRenderer('bullet', BulletRenderer)
      @renderer.registerRenderer('astroid', BulletRenderer)
      @renderer.registerRenderer('planet', BulletRenderer)
      @renderer.registerRenderer('score', ScoreRenderer)

    start: ->
      @score.start()

      mainLoop = =>
        @world.update()
        @renderer.render(@world, @score)

        requestAnimFrame mainLoop

      requestAnimFrame mainLoop
