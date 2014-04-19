define  ['stage','start_screen', 'game'], (Stage, StartScreen, Game) ->

  container = $("#game-container")

  if container.length > 0
    stage = new Stage container
    game = new Game(stage)
    game.start()