define ['events', 'view'], (Events, View) ->
  class StartScreen extends View
    constructor: (stage) ->
      super stage
      @events = new Events()
    
    createGraphics: ->
      console.log "creagin start game button"
      startButton = new PIXI.Text("Start Game")
      startButton.position.x = @stage.width/2
      startButton.position.y = @stage.height/2 +  @stage.height/5

      startButton.buttonMode = true
      startButton.interactive = true
      
      startButton.click = =>
        @events.trigger "gameStartClicked"

      startButton    