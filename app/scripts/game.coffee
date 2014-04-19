define ['entity_factory',
         'world', 
         'scene_renderer',
         'spaceship', 
         'player', 
         'spaceship_renderer', 
         'bullet_renderer', 
         'astroid_renderer'
         'camera', 
         'planet', 
         'astroid_spwaner', 
         'score', 
         'score_renderer',
         'start_screen'], (
          EntityFactory, 
          World, 
          SceneRenderer,
          Spaceship, 
          Player, 
          SpaceshipRenderer, 
          BulletRenderer, 
          AstroidRenderer,
          Camera, 
          Planet, 
          AstroidSpwaner, 
          Score, 
          ScoreRenderer,
          StartScreen) ->

  class Game
    constructor: (@stage) ->
      @gameState = "startScreen"
      @viewportWidth = @stage.getWidth()
      @viewportHeight = @stage.getHeight()
      
      @pixleToUnitRatio = 8
      @zoom = @pixleToUnitRatio
      @worldWidth = @viewportWidth/@pixleToUnitRatio
      @worldHeight = @viewportWidth/@pixleToUnitRatio

      @world = new World
        size:
          width: @worldWidth
          height: @worldHeight
      
      @world.events.on "astroidWorldCollistion", =>
        @endGame()
        console.log "game over"

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

      @startScreen = new StartScreen @stage
      @startScreen.events.on "gameStartClicked", =>
        @startScreen.remove()
        delete @startScreen
        @startGame()

    createPlanet: ->
      @planet = window.EntityFactory.createPlanet()
      @planet.setPosition(new B2D.Vec2(@worldWidth/2, @worldHeight/2))

    createAstroidSpawner: ->
      @astroidSpwaner = new AstroidSpwaner
        width: @worldWidth
        height: @worldHeight
        planet: @planet

    createRenderer: ->
      camera = new Camera()
      camera.zoom(@zoom)
      window.camera = camera
      @renderer = new SceneRenderer
        stage: @stage
        camera: camera
      
    createHUD: ->
      @score = new Score
        upInterval: 10

    registerRenderers: ->
      @renderer.registerRenderer('spaceship', SpaceshipRenderer)
      @renderer.registerRenderer('bullet', BulletRenderer)
      @renderer.registerRenderer('astroid', AstroidRenderer)
      @renderer.registerRenderer('planet', BulletRenderer)
      @renderer.registerRenderer('score', ScoreRenderer)

    start: ->
      @startScreen.show()
      @mainLoop()

    startGame: ->
      @gameState = "gameOn"
      @score.start()
      @astroidSpwaner.startSpwaning()

    mainLoop: ->
      switch @gameState
        when "gameOn" 
          @world.update()
          @renderer.render(@world, @score)

      @stage.getRenderer().render(@stage.getStage())
      requestAnimFrame => @mainLoop()

    endGame: ->
      @gameState = "gameOver"
