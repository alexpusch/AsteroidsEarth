requirejs.config
  baseUrl: 'scripts'
  paths: 
    'pixi': "../bower_components/pixi/bin/pixi.dev",
  shim: 
    'pixi': 
      deps: []
      exports: 'PIXI'

CocoonJS.App.setAntialias true
require  ['stage', 'game'], (Stage, Game) ->
  if document.getElementById("game")?
    canvas = document.createElement "canvas"
    canvas.style.width = window.innerWidth
    canvas.style.height = window.innerHeight
    canvas.width = window.innerWidth * window.devicePixelRatio;
    canvas.height = window.innerHeight * window.devicePixelRatio;  

    document.body.appendChild canvas

    assetLoader = new PIXI.AssetLoader ["images/refresh.png", "images/finger.png"]
    assetLoader.load()

    assetLoader.addEventListener "onComplete", ->   
      stage = new Stage canvas
      game = new Game(stage)
      game.start()