requirejs.config
  baseUrl: 'scripts'
  paths:
    'pixi': "../bower_components/pixi/bin/pixi.dev",
  shim:
    'pixi':
      deps: []
      exports: 'PIXI'

# CocoonJS.App.setAntialias true
require  ['stage', 'asset_loader', 'splashscreen_view', 'game', 'dom_events'], (Stage, AssetLoader, SplashScreenView, Game, DOMEvents) ->
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
    pause = ->
      game.pause()
      stage.pause()

    resume = ->
      game.resume()
      stage.resume()

    DOMEvents.bind window, 'blur', ->
      pause()

    DOMEvents.bind window, 'focus', ->
      resume()

    CocoonJS.App.onSuspended.addEventListener ->
      pause()

    CocoonJS.App.onActivated.addEventListener ->
      resume()


  if document.getElementById("game")?
    stage = new Stage document.body

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
    stage.startMainLoop()

    showSplashScreen(stage).then (splashScreen)->
      Promise.all([
        AssetLoader.loadAudioAssets(audioAssets),
        AssetLoader.loadGraphicAssets(graphicAssets),
        getDelayedPromise 2000
      ]).then ->
        splashScreen.fadeOut().then ->
          splashScreen.destroy()
          game = new Game(stage)
          game.start()

          bindPauseEvents game, stage
      .catch (e)->
        console.log e
