define ['events'], (Events) ->
  class StartScreen
    constructor: (@stage) ->
      @events = new Events()    
      
    show: ->
      @startButton = @_createStartButton()
      @pixiStage = @stage.getStage()     
      @pixiStage.addChild @startButton

    remove: ->
      @pixiStage.removeChild @startButton

    _createStartButton: ->
      startButton = new PIXI.Text("Start Game")
      startButton.position.x = @stage.getWidth()/2
      startButton.position.y = @stage.getHeight()/2 +  @stage.getHeight()/5

      startButton.buttonMode = true
      startButton.interactive = true
      
      startButton.click = =>
        @events.trigger "gameStartClicked"

      startButton