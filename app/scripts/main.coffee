require ['entity_factory',
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

  if $('#game-container').length > 0
    width = $('#game-container').width()
    height = $('#game-container').height()

    scale = 10
    world = new World
      size:
        width: width/scale
        height: height/scale
    
    window.EntityFactory = new EntityFactory world

    # world.setupDebugRenderer $('canvas')[0]

    window.spaceship = window.EntityFactory.createSpaceship()

    player = new Player()
    player.control spaceship

    camera = new Camera()
    camera.zoom(scale)

    planet = window.EntityFactory.createPlanet()
    planet.setPosition(new B2D.Vec2(width/scale/2, height/scale/2))

    # astroid = window.EntityFactory.createAstroid planet
    # astroid.setPosition new B2D.Vec2(10,10)
    astroidSpwaner = new AstroidSpwaner
      width: width/scale
      height: height/scale
      planet: planet

    astroidSpwaner.startSpwaning()

    renderer = new SceneRenderer
      camera: camera
    
    renderer.setupRenderer
      container: $('#game-container')

    score = new Score
      upInterval: 10
    score.start()

    renderer.registerRenderer('spaceship', SpaceshipRenderer)
    renderer.registerRenderer('bullet', BulletRenderer)
    renderer.registerRenderer('astroid', BulletRenderer)
    renderer.registerRenderer('planet', BulletRenderer)
    renderer.registerRenderer('score', ScoreRenderer)

    mainLoop = ->
      world.update()
      renderer.render(world, score)

      requestAnimFrame mainLoop

    requestAnimFrame mainLoop
