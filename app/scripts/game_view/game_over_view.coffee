define ['events', 'view'], (Events, View) ->
  class GameOverScreen extends View
    constructor: (stage)->
      super stage
      @events = new Events

    createGraphics: ->
      graphics = new PIXI.Graphics()
      startButton = new PIXI.Text("Start over")
      startButton.position.x = @stage.width/2
      startButton.position.y = @stage.height/2 +  @stage.height/5

      startButton.buttonMode = true
      startButton.interactive = true
      
      startButton.click = startButton.touchstart = =>
        @events.trigger "gameStartClicked"

      graphics.addChild startButton
      graphics