require ['entity_factory', 'world', 'spaceship', 'player', 'spaceship_renderer', 'bullet_renderer', 'world_renderer', 'camera', 'planet', 'astroid_spwaner'], (EntityFactory, World, Spaceship, Player, SpaceshipRenderer, BulletRenderer, WorldRenderer, Camera, Planet, AstroidSpwaner) ->
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
    camera.zoom(scale/2)

    planet = window.EntityFactory.createPlanet()
    planet.setPosition(new B2D.Vec2(width/scale/2, height/scale/2))

    # astroid = window.EntityFactory.createAstroid planet
    # astroid.setPosition new B2D.Vec2(10,10)
    astroidSpwaner = new AstroidSpwaner
      width: width/scale
      height: height/scale
      planet: planet

    astroidSpwaner.startSpwaning()

    world_renderer = new WorldRenderer
      camera: camera

    world_renderer.setupRenderer
      container: $('#game-container')

    world_renderer.registerRenderer('spaceship', SpaceshipRenderer)
    world_renderer.registerRenderer('bullet', BulletRenderer)
    world_renderer.registerRenderer('astroid', BulletRenderer)
    world_renderer.registerRenderer('planet', BulletRenderer)

    mainLoop = ->
      world.update()
      world_renderer.render(world)

      requestAnimFrame mainLoop

    requestAnimFrame mainLoop
