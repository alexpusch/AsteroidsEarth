define ->
  class AssetPreloader
    @loadAudioAssets: (assetes) ->
      loaded = 0
      createjs.Sound.alternateExtensions = ["wav"];

      promise = new Promise (resolve, reject) ->
        createjs.Sound.addEventListener "fileload", (e) ->
          loaded += 1
          if loaded == assetes.length
            resolve()

        createjs.Sound.registerManifest assetes, "audio/"

    @loadGraphicAssets: (assets) ->
      new Promise (resolve, reject) ->
        assetLoader = new PIXI.AssetLoader assets
        assetLoader.load()

        assetLoader.addEventListener "onComplete", ->
          resolve()

    @loadAssets: (graphicAssets, audioAssets) ->
      Promise.all [@loadAudioAssets audioAssets, @loadGraphicAssets graphicAssets]
