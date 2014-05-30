define ['conversions', 'view', 'earth_graphics_points'], (Conversions, View, earthGraphicsPoints)  ->
  class PlanetView extends View
    constructor: (stage, camera, @planet) ->
      super stage, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()

      graphics.beginFill(0x75baef)

      graphics.drawCircle(0,0, @planet.getRadius())
      graphics.endFill()

      @_drawContinents graphics

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@planet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    _drawContinents: (graphics)->
      continentsGraphics = new PIXI.Graphics()

      continentsTexture = PIXI.Texture.fromImage("images/continents.png");
      continentsGraphics = new PIXI.Sprite(continentsTexture);
      continentsGraphics.width = @planet.getRadius() * 2
      continentsGraphics.height = @planet.getRadius() * 2
      continentsGraphics.position = new PIXI.Point -@planet.getRadius(),-@planet.getRadius()
      continentsGraphics
      graphics.addChild continentsGraphics