define ['entity_factory',
         'world', 
         'scene_renderer',
         'spaceship', 
         'player', 
         'spaceship_view', 
         'bullet_view', 
         'planet_view'
         'astroid_view'
         'camera', 
         'planet', 
         'astroid_spwaner', 
         'score', 
         'score_view',
         'start_screen_view'
         'game_over_view', 
         'wave_view', 
         'background_view'], (
          EntityFactory, 
          World, 
          SceneRenderer,
          Spaceship, 
          Player, 
          SpaceshipView, 
          BulletView, 
          PlanetView
          AstroidView,
          Camera, 
          Planet, 
          AstroidSpwaner, 
          Score, 
          ScoreView,
          StartScreenView, 
          GameOverView,
          WaveView,
          BackgroundView) ->

  class Game
    constructor: (@stage) ->
      @gameState = "startScreen"
      @viewportWidth = @stage.getWidth()
      @viewportHeight = @stage.getHeight()

      @pixleToUnitRatio = 8
      @zoom = @pixleToUnitRatio
      @cameraShiftDivider = 10

      [@worldWidth, @worldHeight] = @_calculateWorldDimenstion()

    start: ->
      @createGameObjects()
      @mainLoop()

    reset: ->
      @world.destroy()
      @player.destroy()
      @spaceship.destroy()
      @astroidSpwaner.destroy()
      @stage.clear()

      delete @world

    createGameObjects: ->
      @world = @createWorld()

      window.EntityFactory = new EntityFactory @world

      @spaceship = window.EntityFactory.createSpaceship()
      @spaceship.setPosition new B2D.Vec2 0, -20

      @player = new Player()

      @planet = @createPlanet()
      @astroidSpwaner = @createAstroidSpawner()
      @sceneRenderer = @createSceneRenderer()
      @score = @createScore()

      @registerRenderers()

      @startScreen = @createStartScreen()
      @gameOverScreen = @createGameOverScreen()
      @backgroundView = @createBackgroundView()

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
      planet.setPosition(new B2D.Vec2(0, 0))

      planet

    createAstroidSpawner: ->
      new AstroidSpwaner
        width: @worldWidth
        height: @worldHeight
        planet: @planet

    createSceneRenderer: ->
      @camera = new Camera @stage.getWidth(), @stage.getHeight()
      @camera.zoom(@zoom)
      
      new SceneRenderer
        stage: @stage
        camera: @camera
      
    createScore: ->
      @score = new Score
        upInterval: 10

    createStartScreen: ->
      startScreen = new StartScreenView @stage
      startScreen.events.on "gameStartClicked", =>
        @startScreen.fadeOut().done =>
          @startScreen.destroy()
        @startGame()

      startScreen

    createGameOverScreen: ->
      gameOverScreen = new GameOverView @stage

      gameOverScreen.events.on "gameStartClicked", =>
        @createGameObjects()
        @startGame()
        gameOverScreen.destroy()

      gameOverScreen

    registerRenderers: ->
      @sceneRenderer.registerRenderer('spaceship', SpaceshipView)
      @sceneRenderer.registerRenderer('bullet', BulletView)
      @sceneRenderer.registerRenderer('astroid', AstroidView)
      @sceneRenderer.registerRenderer('planet', PlanetView)
      @sceneRenderer.registerRenderer('score', ScoreView)
      @sceneRenderer.registerRenderer('astroidSpwaner', WaveView)

    startGame: ->
      @gameState = "gameOn"
      @score.start()
      @player.control @spaceship
      @astroidSpwaner.startSpwaning()

    mainLoop: ->
      if @gameState == "startScreen"
        @startScreen.render()

      if @gameState == "gameOn"
        @world.update()
        # stage might change in the world.update function
        unless @gameState == "gameOver"
          

      if @gameState == "gameOver"
        @gameOverScreen.render()

      @backgroundView.render()
      @sceneRenderer.render(@world, @score, @astroidSpwaner)
      spaceshipPosition = @spaceship.getPosition()
      @camera.lookAt((-spaceshipPosition.x/@cameraShiftDivider), (-spaceshipPosition.y/@cameraShiftDivider))

      @stage.render()
      requestAnimFrame => @mainLoop()

    endGame: ->
      @reset()
      @gameState = "gameOver"

    createBackgroundView: ->
      new BackgroundView @stage, @camera

    _calculateWorldDimenstion: ->
      worldWidth = @viewportWidth/@pixleToUnitRatio
      worldHeight = @viewportHeight/@pixleToUnitRatio

      originalWidth = worldWidth
      originalHeight = worldHeight

      # when camera shifts it adds some more space for the ship to get into
      # We need to add this new space to world width/height
      for i in [0..5]
        paralexX = worldWidth/@cameraShiftDivider
        paralexY = worldHeight/@cameraShiftDivider
        worldWidth = originalWidth + paralexX
        worldHeight = originalHeight + paralexY

      [worldWidth, worldHeight]