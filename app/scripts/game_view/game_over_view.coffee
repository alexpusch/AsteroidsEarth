define ['events', 'view', 'pixi_animator', 'pixi_layout', 'math_helpers'], (Events, View, Animator, PixiLayout, MathHelpers) ->
  class GameOverScreen extends View
    constructor: (container, @score)->
      super container

    createGraphics: ->
      graphics = new PIXI.Graphics()

      gameOverText = @_createGameOverText()
      scoreText = @_createScoreText()
      highScoreText = @_createHighScoreText()

      graphics.alpha = 0
      graphics.width = @container.width * 0.7
      graphics.height = @container.height * 0.7
      graphics.y = @container.height * 0.1
      graphics.x = (@container.width - graphics.width) / 2

      textGraphics = new PIXI.DisplayObjectContainer()
      textGraphics.width = graphics.width
      PixiLayout.justify textGraphics, [
        gameOverText,
        scoreText,
        highScoreText,
      ]

      bottomGraphics = new PIXI.DisplayObjectContainer()
      bottomGraphics.width = graphics.width
      bottomGraphics.height = textGraphics.height * 0.7

      @refreshGraphics = @_createRefreshButton()
      @refreshGraphics.x = 20
      @refreshGraphics.width = bottomGraphics.height
      @refreshGraphics.height = bottomGraphics.height

      playstoreGraphics = @_createGetInPlaystoreButton()
      PixiLayout.scaleToFit playstoreGraphics, @refreshGraphics.width * 0.7, @refreshGraphics.height * 0.7
      playstoreGraphics.x = @refreshGraphics.x + @refreshGraphics.width + (bottomGraphics.width - (@refreshGraphics.x + @refreshGraphics.width))/2 - playstoreGraphics.width/2
      playstoreGraphics.y = bottomGraphics.height/2 - playstoreGraphics.height/2

      bottomGraphics.addChild @refreshGraphics
      bottomGraphics.addChild playstoreGraphics

      PixiLayout.order graphics, [
        textGraphics,
        bottomGraphics
      ]

      graphics.height = textGraphics.height + bottomGraphics.height

      PixiLayout.scaleToFit graphics, @container.width * 0.8, @container.height * 0.8
      PixiLayout.center graphics, @container

      graphics

    updateGraphics: ->

    onAppearance: ->
        @fadeIn()
        setTimeout =>
          new Animator(@refreshGraphics).animate([
              type: "fadeIn"
              duration: 1000
          ]).then =>
            @refreshGraphics.interactive = true
        , 1000

    fadeIn: ->
      new Animator(@graphics).animate [
        type: "fadeIn",
        duration: 1000
      ]

    _createGameOverText: ->
      new PIXI.Text "GAME OVER",
        fill: "#EEEEEE"
        font: "100px DroidSans"
        align: "center"

    _createScoreText: ->
      new PIXI.Text "SCORE: #{@score.getScore()}",
        fill: "#EEEEEE"
        font: "100px DroidSans"
        align: "center"

    _createHighScoreText: ->
      if @score.getHighScore() == @score.getScore()
        new PIXI.Text "NEW HIGHSCORE!",
          fill: "#ffcc00"
          font: "100px DroidSans"
          align: "center"
      else
        new PIXI.Text "HIGHSCORE: #{@score.getHighScore()}",
          fill: "#EEEEEE"
          font: "100px DroidSans"
          align: "center"

    _createRefreshButton: ->
      refreshTexture = PIXI.Texture.fromImage("images/refresh.png");
      refreshGraphics = new PIXI.Sprite(refreshTexture);

      refreshGraphics.width = 10
      refreshGraphics.height = 10
      refreshGraphics.buttonMode = true
      refreshGraphics.interactive = false
      refreshGraphics.alpha = 0

      refreshGraphics.click = refreshGraphics.touchstart = =>
        @events.trigger "gameStartClicked"

      refreshGraphics

    _createGetInPlaystoreButton: ->
      playstoreTexture = PIXI.Texture.fromImage("images/playstore_bag.png");
      playstoreGraphics = new PIXI.Sprite(playstoreTexture);

      playstoreGraphics.buttonMode = true
      playstoreGraphics.interactive = true

      playstoreGraphics.click = ->
        url = "https://play.google.com/store/apps/details?id=alex.games.asteroidsearth"
        # window.location = url
        window.open(url)
      playstoreGraphics