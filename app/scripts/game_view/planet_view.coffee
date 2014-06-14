define ['conversions', 'view', 'earth_graphics_points', 'pixi_animator'], (Conversions, View, earthGraphicsPoints, Animator)  ->
  class PlanetView extends View
    constructor: (container, camera, @planet) ->
      super container, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()
      innerGraphics = new PIXI.Graphics()

      # PIXI's WebGLRenderer does not handle small rendering very well.
      # In this workaround we'll draw the planet bigger in a container with small scale
      innerGraphics.scale = new PIXI.Point(1/@camera.getZoom(), 1/@camera.getZoom())

      @planetGraphics = @_getPlanetGraphics()
      @shieldGraphics = @_getShieldGraphics()
      innerGraphics.addChild @shieldGraphics
      innerGraphics.addChild @planetGraphics

      graphics.addChild innerGraphics

      @_bindPlanetEvents()
      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@planet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    _getPlanetGraphics: ->
      planetGraphics = new PIXI.Graphics()
      planetGraphics.beginFill(0x75baef)
      planetGraphics.drawCircle(0,0, @_getScaledRadius())
      planetGraphics.endFill()

      @_drawContinents planetGraphics

      planetGraphics

    _drawContinents: (graphics) ->
      continentsGraphics = new PIXI.Graphics()

      continentsTexture = PIXI.Texture.fromImage("images/continents.png");
      continentsGraphics = new PIXI.Sprite(continentsTexture);
      continentsGraphics.width = @_getScaledRadius() *  2
      continentsGraphics.height = @_getScaledRadius() * 2
      continentsGraphics.position = new PIXI.Point -@_getScaledRadius(),-@_getScaledRadius()
      continentsGraphics
      graphics.addChild continentsGraphics

    _getShieldGraphics: ->
      shieldGraphics = new PIXI.Graphics()
      lineWidth = 0.5 * @camera.getZoom()
      shieldGraphics.lineStyle lineWidth , 0xcccccc, 0.5
      shieldGraphics.drawCircle 0, 0, @_getScaledRadius() - lineWidth

      shieldGraphics

    _getScaledRadius: ->
      @planet.getRadius() * @camera.getZoom()

    _bindPlanetEvents: ->
      @planet.events.on "rasingShield", =>
        new Animator(@shieldGraphics).animateParallel [
          type: "grow"
          by: 1.2
          duration: 200
        ]

      @planet.events.on "dropingShield", =>
        new Animator(@shieldGraphics).animateParallel [
          type: "grow"
          by: 1.2
          duration: 200
        ,
          type: "fadeOut"
          duration: 200
        ]