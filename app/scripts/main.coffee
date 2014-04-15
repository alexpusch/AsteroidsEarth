define  ['game'], (Game) ->

  container = $("#game-container")
  if container.length > 0
    game = new Game(container)
    game.start()