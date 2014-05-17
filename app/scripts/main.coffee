requirejs.config
  baseUrl: 'scripts'
  paths: {}


require  ['stage', 'game'], (Stage, Game) ->
  canvas = document.createElement "canvas"
  
  # canvas.width = window.innerWidth * window.devicePixelRatio;
  # canvas.height = window.innerHeight * window.devicePixelRatio;  

  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  document.body.appendChild canvas

  stage = new Stage canvas
  game = new Game(stage)
  game.start()