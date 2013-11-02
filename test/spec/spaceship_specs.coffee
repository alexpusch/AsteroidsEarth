define ['box2d', 'spaceship'], (B2D, Spaceship)->
  describe "Spaceship", ->
    beforeEach ->
      @spaceship = new Spaceship
        speed: 10
        angularSpeed: 10

      @body = {};
      @body.GetWorldPoint = (x) -> x
      @spaceship.setBody(@body)

    describe "setBody", ->
      it "sets the spaceship body to the given body", ->
        expect(@spaceship.body).toBe @body

    describe "fire main thrusters", ->
      it "a force is applied forwards", ->
        @spaceship.body.ApplyForce = jasmine.createSpy('applyForce')
        @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
        @spaceship.fireMainThrusters()
        expect(@spaceship.body.ApplyForce).toHaveBeenCalledWith(new B2D.Vec2(10,0), new B2D.Vec2(0,0))

    describe "fire left thruster", ->
      it "a toruq is applied to the left", ->
        @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
        @spaceship.body.ApplyTorque = jasmine.createSpy('ApplyTorque')
        @spaceship.fireLeftThrusters()
        expect(@spaceship.body.ApplyTorque).toHaveBeenCalledWith(10)

    describe "fire right thruster", ->
      it "a toruq is applied to the right", ->
        @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
        @spaceship.body.ApplyTorque = jasmine.createSpy('ApplyTorque')
        @spaceship.fireRightThrusters()
        expect(@spaceship.body.ApplyTorque).toHaveBeenCalledWith(-10)