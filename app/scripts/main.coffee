requirejs.config
  baseUrl: 'scripts'
  paths:
    'pixi': "../bower_components/pixi/bin/pixi.dev",
  shim:
    'pixi':
      deps: []
      exports: 'PIXI'

# CocoonJS.App.setAntialias true
require  ['stage', 'asset_loader', 'splashscreen_view', 'game', 'dom_events', 'configuration'], (Stage, AssetLoader, SplashScreenView, Game, DOMEvents, Configuration) ->
  getDelayedPromise = (delay) ->
    deleyedPromise = new Promise (resolve, reject) ->
      setTimeout ->
        resolve()
      , delay

  showSplashScreen = (stage) ->
    splashscrenAssets = [
      "images/splashscreen.png"
    ]

    AssetLoader.loadGraphicAssets(splashscrenAssets).then ->
      splashScreen = new SplashScreenView stage.getContainer()
      stage.events.on "frame", ->
        splashScreen.render()

      Promise.resolve(splashScreen)

  bindPauseEvents = (game, stage) ->
    paused = false

    pause = ->
      unless paused
        game.pause()
        stage.pause()
        paused = true

    resume = ->
      if paused
        game.resume()
        stage.resume()
        paused = false

    DOMEvents.bind window, 'blur', ->
      console.log "blur"
      pause()

    DOMEvents.bind window, 'focus', ->
      console.log "focus"
      resume()

    CocoonJS.App.onSuspended.addEventListener ->
      console.log "pause"
      pause()

    CocoonJS.App.onActivated.addEventListener ->
      console.log "resume"
      resume()

  isMobileWeb = ->
    /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)

  window.isCocoonJS = ->
    navigator.isCocoonJS

  if document.getElementById("game")?
    if isCocoonJS()
      options =
        width: window.innerWidth
        height: window.innerHeight
        container: document.body
      gameConfig = Configuration.Mobile
    else
      gameEl = document.getElementById "game"
      options =
        width: gameEl.clientWidth
        height: gameEl.clientHeight
        container: gameEl
      gameConfig = Configuration.Desktop

    stage = new Stage options

    audioAssets = [
      src: "shoot.ogg"
      id: "shoot"
    ,
      src: "explosion.ogg"
      id: "explosion"
    ,
      # src: "Broke_For_Free_-_01_-_Night_Owl.ogg"
      # src: "nightowl2.ogg"
      src: "background.ogg"
      id: "background"
    # ,
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
    stage.startMainLoop()

    showSplashScreen(stage).then (splashScreen)->
      Promise.all([
        AssetLoader.loadAudioAssets(audioAssets),
        AssetLoader.loadGraphicAssets(graphicAssets),
        getDelayedPromise 2000
      ]).then ->
        splashScreen.fadeOut().then ->
          splashScreen.destroy()
          game = new Game stage, gameConfig
          game.start()

          bindPauseEvents game, stage
      .catch (e)->
        console.log e
