define ['view', 'pixi_animator'], (View, Animator) ->
  class SplashScreenView extends View
    constructor: (container) ->
      super container

    createGraphics: ->
      splashTexture = PIXI.Texture.fromImage("images/splashscreen2.png");
      splashGraphics = new PIXI.Sprite(splashTexture);

      rx = @container.width / splashGraphics.width
      ry = @container.height / splashGraphics.height

      r = Math.min rx, ry

      splashGraphics.scale = new PIXI.Point r,r
      splashGraphics.position = new PIXI.Point @container.width/2, @container.height/2
      splashGraphics.anchor = new PIXI.Point 0.5,0.5

      splashGraphics.alpha = 0

      splashGraphics

    onAppearance: ->
      new Animator(@graphics).animate [
        type: 'fadeIn'
        duration: 1000
      ]

    fadeOut: ->
      new Animator(@graphics).animate [
        type: 'fadeOut'
        duration: 1000
      ]

    updateGraphics: ->