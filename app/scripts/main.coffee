requirejs.config
  baseUrl: 'scripts'
  paths: 
    'pixi': "../bower_components/pixi/bin/pixi.dev",
  shim: 
    'pixi': 
      deps: []
      exports: 'PIXI'

require  ['stage', 'game'], (Stage, Game) ->
  if document.getElementById("game")?
    canvas = document.createElement "canvas"
    canvas.style.width = window.innerWidth
    canvas.style.height = window.innerHeight
    canvas.width = window.innerWidth * window.devicePixelRatio;
    canvas.height = window.innerHeight * window.devicePixelRatio;  

    # canvas.width = window.innerWidth;
    # canvas.height = window.innerHeight;

    document.body.appendChild canvas

    stage = new Stage canvas
    game = new Game(stage)
    game.start()