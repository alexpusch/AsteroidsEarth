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
  loadAudioAssets = (assetes, done) ->
    console.log "loading sounds"
    loaded = 0
    createjs.Sound.alternateExtensions = ["wav"];
    createjs.Sound.addEventListener "fileload", (e) ->
      console.log "loaded #{e.src}"
      loaded += 1
      if loaded == assetes.length
        console.log "done loading sounds"
        done()

    createjs.Sound.registerManifest assetes, "audio/"

  loadGraphicAssets = (assets, done) ->
    console.log "loading graphcis"
    assetLoader = new PIXI.AssetLoader assets
    assetLoader.load()

    assetLoader.addEventListener "onComplete", ->   
      console.log "done loading graphics"
      done()

  loadAssets = (graphicAssets, audioAssets, done) ->
    loaded = 0
    async.parallel
      loadSounds : (done) ->
        loadAudioAssets audioAssets, done     
      loadGraphics: (done) ->
        loadGraphicAssets graphicAssets, done
      , ->   
        done()

  if document.getElementById("game")?
    canvas = document.createElement "canvas"
    canvas.style.width = window.innerWidth
    canvas.style.height = window.innerHeight
    canvas.width = window.innerWidth * window.devicePixelRatio;
    canvas.height = window.innerHeight * window.devicePixelRatio;  

    document.body.appendChild canvas

    createjs.Sound.initializeDefaultPlugins()
    createjs.Sound.registerPlugins([createjs.CocoonJSAudioPlugin]);
    audioAssets = [
        src: "shoot.ogg"
        id: "shoot"
      ,
        src: "explosion.ogg"
        id: "explosion"
      ,
        src: "background.ogg"
        id: "background"
    ]

    graphicAssets = [
      "images/refresh.png",
      "images/finger.png",
      "images/continents.png",
      "images/mass.png",
      "images/shield.png",
      "images/shockwave.png",
      "images/speed.png"
    ]

  loadAssets graphicAssets, audioAssets, ->
    stage = new Stage canvas
    game = new Game(stage)
    
    game.start()  