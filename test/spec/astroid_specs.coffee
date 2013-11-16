define ['box2d', 'astroid'], (B2D, Astroid) ->
  describe 'Astroid', ->
    describe 'update', ->
      it 'moves it self towards a planet', ->
        planet = 
          getPosition: ->
            new B2D.Vec2(0,0)

        astroid = new Astroid
          radius: 1
          planet: planet


        @world = new B2D.World(new B2D.Vec2(0, 0),  true)

        fixtureDef =  astroid.getEntityDef().fixtureDef
        bodyDef = astroid.getEntityDef().bodyDef

        @body = @world.CreateBody bodyDef
        @body.CreateFixture fixtureDef

        astroid.setBody @body
        astroid.setPosition(new B2D.Vec2(1,1))
        astroid.update()
        @world.Step(1/60, 10, 10)

        speed = @body.GetLinearVelocity()
        speed.Normalize()
        expect(speed).toBeInDirection(new B2D.Vec2(-1,-1))
