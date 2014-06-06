define ['view', 'pixi_animator'], (View, Animator) ->
  class TutorialView extends View
    constructor: (container, camera, astroidSpwaner) ->
      super container, camera

      firstAstroidCallback = (astroid) =>
        astroidSpwaner.events.off "newAstroid", firstAstroidCallback  
        @astroidToFollow = astroid
        @_showFireTutorial astroid

      astroidSpwaner.events.on "newAstroid", firstAstroidCallback
    
    createGraphics: ->
      graphics = new PIXI.DisplayObjectContainer()

      fingerTexture = PIXI.Texture.fromImage("images/finger.png");

      @moveTutorialGraphics = new PIXI.DisplayObjectContainer()
      @moveFingerGraphics = new PIXI.Sprite fingerTexture

      r = 546.430/972.332

      @moveFingerGraphics.height = 100
      @moveFingerGraphics.width = 100 * r
      @moveTutorialGraphics.addChild @moveFingerGraphics
      
      @fireTutorialGraphics = new PIXI.DisplayObjectContainer()

      @fireFingerGraphics = new PIXI.Sprite fingerTexture
      @fireFingerGraphics.height = 100
      @fireFingerGraphics.width = 100 * r
      @fireTutorialGraphics.visible = false

      @fireTutorialGraphics.addChild @fireFingerGraphics

      graphics.addChild @moveTutorialGraphics
      graphics.addChild @fireTutorialGraphics

      @_showMoveTutorial()

      graphics


    updateGraphics: ->
      # @pushToTop()

      if @astroidToFollow?
        astroidPoint = @camera.project @astroidToFollow.getPosition()
        @fireTutorialGraphics.position = astroidPoint

    _showMoveTutorial: ->     
      x = @container.width * 0.8
      y = @container.height * 0.2
      @moveTutorialGraphics.position.x = x
      @moveTutorialGraphics.position.y = y

      @_showTappingFinger @moveFingerGraphics, [1000, 1000, 1000]

    _showFireTutorial: (astroid) ->
      @fireTutorialGraphics.visible = true
      @_showTappingFinger @fireFingerGraphics, [2000, 2000, 100, 100, 100, 100, 1000, 1000, 100, 100, 100, 100]

    _showTappingFinger: (fingerGraphics, tapSequance)->
      async.series
        fadeIn: (done) =>
          promise = (new Animator(fingerGraphics)).animate [
            type: 'fadeIn'
            duration: 700
          ]
          promise.then ->
            done()
        tap: (done) =>
          @_tapAnimation fingerGraphics, tapSequance, done
        fadeOut: (done) =>
          promise = new Animator(fingerGraphics).animate [
            type: 'fadeOut'
            duration: 700
          ]
          promise.then ->
            done()

    _tapAnimation: (fingerGraphics, tapSequance, tapDone)->
      x = fingerGraphics.position.x
      y = fingerGraphics.position.y
      taps = 0
      totalTaps = tapSequance.length
      tapAnimation = ->
        async.series
          tap: (done)->
            fingerGraphics.position.x = x - 5
            fingerGraphics.position.y = y - 5
            fingerGraphics.scale.x = 0.1
            fingerGraphics.scale.y = 0.1
            setTimeout ->
              done()
            , tapSequance[taps]
          hover: (done) ->
            fingerGraphics.position.x = x
            fingerGraphics.position.y = y
            fingerGraphics.scale.x = 0.11
            fingerGraphics.scale.y = 0.11
            setTimeout ->
              done()
            , tapSequance[taps]
        , ->
          taps++
          if taps < totalTaps
            tapAnimation()
          else
            tapDone()
      tapAnimation()
