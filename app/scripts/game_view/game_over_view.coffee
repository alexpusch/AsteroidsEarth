define ['events', 'view', 'pixi_animator'], (Events, View, Animator) ->
  class GameOverScreen extends View
    constructor: (container, @score)->
      super container

    createGraphics: ->
      graphics = new PIXI.Graphics()
      gameOverText = new PIXI.Text "GAME OVER",
        fill: "white"
        font: "70pt DroidSans"
        align: "center"

      gameOverText.anchor = new PIXI.Point 0.5,0.5

      gameOverTextHeight = @container.height/3 - gameOverText.height/2
      gameOverText.position.x = @container.width/2
      gameOverText.position.y = gameOverTextHeight


      scoreText = new PIXI.Text "score: #{@score}",
        fill: "white"
        font: "40pt DroidSans"
        align: "center"

      scoreText.anchor = new PIXI.Point 0.5,0.5

      scoreTextHeight = gameOverText.position.y + 10 + scoreText.height
      scoreText.position.x = @container.width/2
      scoreText.position.y = scoreTextHeight

      refreshTexture = PIXI.Texture.fromImage("images/refresh.png");
      refreshGraphics = new PIXI.Sprite(refreshTexture);

      refreshGraphics.width = 100
      refreshGraphics.height = 100

      refreshGraphics.position.x = @container.width/2
      refreshGraphics.position.y = scoreText.position.y + refreshGraphics.height + 5
      refreshGraphics.anchor = new PIXI.Point 0.5,0.5

      refreshGraphics.buttonMode = true
      refreshGraphics.interactive = true

      

      refreshGraphics.click = refreshGraphics.touchstart = =>
        @events.trigger "gameStartClicked"

      graphics.addChild scoreText
      graphics.addChild gameOverText
      graphics.addChild refreshGraphics

      graphics.alpha = 0

      graphics

    updateGraphics: ->
      unless @fadedIn
        @fadeIn()
        @fadedIn = true

    fadeIn: ->
      new Animator(@graphics).animate [
        type: "fadeIn", 
        duration: 1000
      ]
