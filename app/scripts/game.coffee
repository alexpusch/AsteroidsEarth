define ['entity_factory',
         'world', 
         'scene_renderer',
         'spaceship', 
         'player', 
         'spaceship_view', 
         'bullet_view', 
         'astroid_view'
         'camera', 
         'planet', 
         'astroid_spwaner', 
         'score', 
         'score_view',
         'start_screen_view'], (
          EntityFactory, 
          World, 
          SceneRenderer,
          Spaceship, 
          Player, 
          SpaceshipView, 
          BulletView, 
          AstroidView,
          Camera, 
          Planet, 
          AstroidSpwaner, 
          Score, 
          ScoreView,
          StartScreenView) ->

  class Game
    constructor: (@stage) ->
      @gameState = "startScreen"
      @viewportWidth = @stage.getWidth()
      @viewportHeight = @stage.getHeight()
      
      @pixleToUnitRatio = 8
      @zoom = @pixleToUnitRatio
      @worldWidth = @viewportWidth/@pixleToUnitRatio
      @worldHeight = @viewportWidth/@pixleToUnitRatio

    start: ->
      @world = @createWorld()

      window.EntityFactory = new EntityFactory @world

      # world.setupDebugRenderer $('canvas')[0]

      spaceship = window.EntityFactory.createSpaceship()

      player = new Player()
      player.control spaceship

      @planet = @createPlanet()
      @astroidSpwaner = @createAstroidSpawner()
      @sceneRenderer = @createSceneRenderer()
      @score = @createScore()

      @registerRenderers()

      @startScreen = @createStartScreen()

      @mainLoop()

    createWorld: ->
      world = new World
        size:
          width: @worldWidth
          height: @worldHeight
      
      world.events.on "astroidWorldCollistion", =>
        @endGame()
        console.log "game over"

      world

    createPlanet: ->
      planet = window.EntityFactory.createPlanet()
      planet.setPosition(new B2D.Vec2(@worldWidth/2, @worldHeight/2))

      planet

    createAstroidSpawner: ->
      new AstroidSpwaner
        width: @worldWidth
        height: @worldHeight
        planet: @planet

    createSceneRenderer: ->
      camera = new Camera()
      camera.zoom(@zoom)
      window.camera = camera
      
      new SceneRenderer
        stage: @stage
        camera: camera
      
    createScore: ->
      @score = new Score
        upInterval: 10

    createStartScreen: ->
      startScreen = new StartScreenView @stage
      startScreen.events.on "gameStartClicked", =>
        @startScreen.destroy()
        delete @startScreen
        @startGame()

      startScreen

    registerRenderers: ->
      @sceneRenderer.registerRenderer('spaceship', SpaceshipView)
      @sceneRenderer.registerRenderer('bullet', BulletView)
      @sceneRenderer.registerRenderer('astroid', AstroidView)
      @sceneRenderer.registerRenderer('planet', BulletView)
      @sceneRenderer.registerRenderer('score', ScoreView)

    startGame: ->
      @gameState = "gameOn"
      @score.start()
      @astroidSpwaner.startSpwaning()

    mainLoop: ->
      switch @gameState
        when "startScreen" then @startScreen.render()
        when "gameOn" 
          @world.update()
          @sceneRenderer.render(@world, @score)

      @stage.render()
      requestAnimFrame => @mainLoop()

    endGame: ->
      @gameState = "gameOver"
