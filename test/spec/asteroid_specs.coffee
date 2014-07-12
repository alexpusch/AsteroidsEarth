define ['box2d', 'asteroid'], (B2D, Asteroid) ->
  describe 'Asteroid', ->
    beforeEach ->
      planet =
          getPosition: ->
            new B2D.Vec2(0,0)

      @asteroid = new Asteroid
        radius: 1
        planet: planet


      @world = new B2D.World(new B2D.Vec2(0, 0),  true)

      fixtureDef =  @asteroid.getEntityDef().fixtureDef
      bodyDef = @asteroid.getEntityDef().bodyDef

      @body = @world.CreateBody bodyDef
      @body.CreateFixture fixtureDef

      @asteroid.setBody @body

    describe 'update', ->
      it 'moves it self towards a planet', ->
        @asteroid.setPosition(new B2D.Vec2(1,1))
        @asteroid.update()
        @world.Step(1/60, 10, 10)

        speed = @body.GetLinearVelocity()
        speed.Normalize()
        expect(speed).toBeInDirection(new B2D.Vec2(-1,-1))

    describe 'handleExitWorld', ->
      it 'destories the asteroid', ->
        @asteroid.handleExitWorld()
        expect(@asteroid.exists()).toBe false