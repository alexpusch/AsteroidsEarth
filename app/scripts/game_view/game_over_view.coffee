define ['events', 'view', 'pixi_animator'], (Events, View, Animator) ->
  class GameOverScreen extends View
    constructor: (stage)->
      super stage
      @events = new Events

    createGraphics: ->
      graphics = new PIXI.Graphics()
      gameOverText = new PIXI.Text "GAME OVER",
        fill: "white"
        font: "80pt DroidSans"
        align: "center"

      gameOverText.anchor = new PIXI.Point 0.5,0.5

      gameOverTextHeight = @stage.height/2 - gameOverText.height/2
      gameOverText.position.x = @stage.width/2
      gameOverText.position.y = gameOverTextHeight

      restartButton = new PIXI.Text "\uf021",
        fill: "white"
        font: "50pt fontawesome"
        align: "center"

      restartButton.position.x = @stage.width/2
      restartButton.position.y = gameOverTextHeight + restartButton.height * 2
      restartButton.anchor = new PIXI.Point 0.5,0.5

      restartButton.buttonMode = true
      restartButton.interactive = true
      
      restartButton.click = restartButton.touchstart = =>
        @events.trigger "gameStartClicked"

      graphics.addChild gameOverText
      graphics.addChild restartButton

      graphics.alpha = 0
      graphics

    fadeIn: ->
      new Animator(@graphics).animate [
        type: "fadeIn", 
        duration: 1000
      ]
