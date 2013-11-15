require ['entity_factory', 'world', 'spaceship', 'player', 'spaceship_renderer', 'bullet_renderer', 'world_renderer'], (EntityFactory, World, Spaceship, Player, SpaceshipRenderer, BulletRenderer, WorldRenderer) ->
  console.log "main works!!"
  if $('#game-container').length > 0
    width = $('#game-container').width()
    height = $('#game-container').height()

    world = new World
      size:
        width: width
        height: height
    
    window.EntityFactory = new EntityFactory world

    # world.setupDebugRenderer $('canvas')[0]

    window.spaceship = window.EntityFactory.createSpaceship()

    player = new Player()
    player.control spaceship

    world_renderer = new WorldRenderer()
    world_renderer.setupRenderer
      container: $('#game-container')

    world_renderer.registerRenderer('spaceship', SpaceshipRenderer)
    world_renderer.registerRenderer('bullet', BulletRenderer)

    mainLoop = ->
      world.update()
      world_renderer.render(world)

      requestAnimFrame mainLoop

    requestAnimFrame mainLoop
