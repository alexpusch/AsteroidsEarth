define ['events', 'view', 'math_helpers', 'pixi_animator'], (Events, View, MathHelpers, Animator) ->
  class StartScreen extends View
    constructor: (container) ->
      super container
    
    createGraphics: ->
      graphics = new PIXI.Graphics()
      startButton = @_createStartButton()
      graphics.addChild startButton

      graphics

    fadeOut: ->
      new Animator(@graphics).animate [
        type: "fadeOut"
        duration: 1000
      ]

    _createStartButton: ->
      size = @container.height/3
      startButton = new PIXI.Text "START",
        fill: "white"
        font: "#{size}px DroidSans"
        align: "center"

      startButton.position.x = @container.width/2 
      startButton.position.y = @container.height/2
      startButton.anchor = new PIXI.Point 0.5, 0.5
      startButton.buttonMode = true
      startButton.interactive = true
     
      startButton.click = startButton.touchstart = =>
        @events.trigger "gameStartClicked" unless @buttonClicked
        @buttonClicked = true  
      
      startButton