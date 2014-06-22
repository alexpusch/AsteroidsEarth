define ->
  class AssetPreloader
    @loadAudioAssets: (assetes) ->
      console.log "loading sounds"
      loaded = 0
      createjs.Sound.alternateExtensions = ["wav"];

      promise = new Promise (resolve, reject) ->
        createjs.Sound.addEventListener "fileload", (e) ->
          console.log "loaded #{e.src}"
          loaded += 1
          if loaded == assetes.length
            console.log "done loading sounds"
            resolve()

        createjs.Sound.registerManifest assetes, "audio/"

    @loadGraphicAssets: (assets) ->
      console.log "loading graphcis"

      new Promise (resolve, reject) ->
        assetLoader = new PIXI.AssetLoader assets
        assetLoader.load()

        assetLoader.addEventListener "onComplete", ->
          console.log "done loading graphics"
          resolve()

    @loadAssets: (graphicAssets, audioAssets) ->
      Promise.all [@loadAudioAssets audioAssets, @loadGraphicAssets graphicAssets]
