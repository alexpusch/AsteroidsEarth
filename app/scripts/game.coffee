define ['entity_factory',
         'world', 
         'world_view',
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
         'background_view',
         'box2d',
         'shockwave_view',
         'camera_shaker',
         'stopwatch',
         'tutorial_view',
         'views_collection',
         'speed_powerup_view',
         'powerup_spawner'], (
          EntityFactory, 
          World, 
          WorldView,
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
          BackgroundView,
          B2D,
          ShockwaveView,
          CameraShaker,
          Stopwatch,
          TutorialView,
          ViewsCollection,
          SpeedPowerupView,
          PowerupSpawner) ->

  class Game
   constructor: (@stage) ->
      @gameState = "startScreen"
      @viewportWidth = @stage.getWidth()
      @viewportHeight = @stage.getHeight()

      @views = new ViewsCollection()

      @pixleToUnitRatio = 8
      @zoom = @pixleToUnitRatio
      @cameraShiftDivider = 10
      @stopwatch = new Stopwatch()
      [@worldWidth, @worldHeight] = @calculateWorldDimenstion()

    start: ->
      @views.add "startScreen", @createStartScreen(), 1
      @createGameObjects()
      @mainLoop()

    startGame: ->
      @gameState = "gameOn"
      @player.control @spaceship
      @astroidSpwaner.startSpwaning()
      @powerupSpawner.startSpwaning()
    reset: ->
      @world.destroy()
      @player.destroy()
      @spaceship.destroy()
      @astroidSpwaner.destroy()
      @powerupSpawner.destroy()
      @stage.clear()
      delete @world

    endGame: ->
      @views.add "gameOverScreen", @createGameOverScreen()
      @views.get("backgroundView").fadeAudioOut()
      @player.stopControling()
      @stopwatch.setMark("gameOver")
      @gameState = "gameOver"

    createGameObjects: ->
      @world = @createWorld()

      window.EntityFactory = new EntityFactory @world

      @spaceship = window.EntityFactory.createSpaceship()

      if navigator.isCocoonJS
        @spaceship.setSuperCannon()

      @spaceship.setPosition new B2D.Vec2 0, -20

      @planet = @createPlanet()
      @astroidSpwaner = @createAstroidSpawner()
      @camera = @createCamera()
      @views.add "worldView", @createWorldView()
      @player = new Player @camera, @world
      @score = @createScore()
      @powerupSpawner = @createPowerupSpawner()

      @views.add "waveView", @createWaveView(), 1
      @views.add "backgroundView", @createBackgroundView(), -1

    createWorld: ->
      world = new World
        size:
          width: @worldWidth
          height: @worldHeight
          
      world

    createPlanet: ->
      planet = window.EntityFactory.createPlanet()
      planet.setPosition(new B2D.Vec2(0, 0))
      planet.events.on "worldDistruction",  (contactPoint) =>
        unless @gameState == "gameOver"
          @showGameOverEffect contactPoint
          @endGame()
          console.log "game over"

      planet

    createAstroidSpawner: ->
      new AstroidSpwaner
        width: @worldWidth
        height: @worldHeight
        planet: @planet

    createPowerupSpawner: ->
      new PowerupSpawner
        width: @worldWidth
        height: @worldHeight

    createCamera: ->
      @camera = new Camera @stage.getWidth(), @stage.getHeight()
      @camera.zoom(@zoom)

      @camera

    createWorldView: ->     
      worldView = new WorldView @stage.getContainer(), @camera, @world
      @registerViewTypes worldView

      worldView
      
    createScore: ->
      score = new Score
        upInterval: 10

      @astroidSpwaner.events.on "newWave", (index) ->
        score.setMultiplier index

      score

    createWaveView: ->
      new WaveView @stage.getContainer(), @camera, @astroidSpwaner

    createStartScreen: ->
      startScreen = new StartScreenView @stage.getContainer()
      startScreen.events.on "gameStartClicked", =>
        @views.add "tutorialView", @createTutorialView(), 1
        @views.get("startScreen").fadeOut().then =>
          @views.remove "startScreen"
        @startGame()

      startScreen

    createGameOverScreen: ->
      gameOverScreen = new GameOverView @stage.getContainer(), @score.getScore()

      gameOverScreen.events.on "gameStartClicked", =>
        @views.remove "waveView"
        @views.remove "shockwaveView"
        @views.remove "gameOverScreen"
        @reset()
        @createGameObjects()
        @startGame()

      gameOverScreen

    createBackgroundView: ->
      new BackgroundView @stage.getContainer(), @camera

    createTutorialView: ->
      new TutorialView @stage.getContainer(), @camera, @astroidSpwaner

    registerViewTypes: (worldView) ->
      worldView.registerView('spaceship', SpaceshipView)
      worldView.registerView('bullet', BulletView)
      worldView.registerView('astroid', AstroidView)
      worldView.registerView('planet', PlanetView)
      worldView.registerView('score', ScoreView)
      worldView.registerView('speedPowerup', SpeedPowerupView)

    showGameOverEffect: (contactPoint) ->
      @world.startShockWave contactPoint
      CameraShaker shaker = new CameraShaker(@camera)
      shaker.shake()
      @views.add "shockwaveView", new ShockwaveView @stage.getContainer(), @camera, contactPoint     

    calculateWorldDimenstion: ->
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

    mainLoop: ->
      if @gameState != "gameOver" or (@gameState == "gameOver" and @stopwatch.getTimeSinceMark("gameOver") < 3000)
        @world.update()

      dt = @stopwatch.getFrameTime()
      @score.update(dt)    

      @views.render()

      unless @gameState == "gameOver"
        @updateParalex()        

      @stage.render()

      requestAnimFrame => @mainLoop()

    updateParalex: ->
      spaceshipPosition = @spaceship.getPosition()
      @camera.lookAt((-spaceshipPosition.x/@cameraShiftDivider), (-spaceshipPosition.y/@cameraShiftDivider))



