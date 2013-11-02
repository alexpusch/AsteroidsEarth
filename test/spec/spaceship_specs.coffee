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
      it "turns on main thrusters", ->
        @spaceship.fireMainThrusters()
        expect(@spaceship.thrusters.main).toBe 'on'

    describe "fire left thruster", ->
      it "turns on left thrusters", ->
        @spaceship.fireLeftThrusters()
        expect(@spaceship.thrusters.left).toBe 'on'

    describe "fire right thruster", ->
      it "turns on right thrusters", ->
        @spaceship.fireRightThrusters()
        expect(@spaceship.thrusters.right).toBe 'on'

    describe "turn main thrusters off", ->
      it "turns off main thrusters", ->
        @spaceship.turnMainThrustersOff()
        expect(@spaceship.thrusters.main).toBe 'off'

    describe "turn left thrusters off", ->
      it "turns off left thrusters", ->
        @spaceship.turnLeftThrustersOff()
        expect(@spaceship.thrusters.left).toBe 'off'

    describe "turn right thrusters off", ->
      it "turns off right thrusters", ->
        @spaceship.turnRightThrustersOff()
        expect(@spaceship.thrusters.right).toBe 'off'

    describe "update", ->
      describe "main thrusters are on", ->
        it "a force is applied forwards", ->
          @spaceship.body.ApplyForce = jasmine.createSpy('applyForce')
          @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
          @spaceship.fireMainThrusters()
          @spaceship.update()
          expect(@spaceship.body.ApplyForce).toHaveBeenCalledWith(new B2D.Vec2(10,0), new B2D.Vec2(0,0))

      describe "left thrusters are on", ->
        it "a toruqe is applied to the left", ->
          @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
          @spaceship.body.ApplyTorque = jasmine.createSpy('ApplyTorque')
          @spaceship.fireLeftThrusters()
          @spaceship.update()
          expect(@spaceship.body.ApplyTorque).toHaveBeenCalledWith(-10)

      describe "right thrusters are on", ->
        it "a toruqe is applied to the right", ->
          @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
          @spaceship.body.ApplyTorque = jasmine.createSpy('ApplyTorque')
          @spaceship.fireRightThrusters()
          @spaceship.update()
          expect(@spaceship.body.ApplyTorque).toHaveBeenCalledWith(10)

      describe "both right and main thrusters are on", ->
        it "applies a force forwards and a toruqe to the right", ->
          @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
          @spaceship.body.ApplyTorque = jasmine.createSpy('ApplyTorque')
          @spaceship.body.ApplyForce = jasmine.createSpy('ApplyForce')
          @spaceship.fireMainThrusters()
          @spaceship.fireRightThrusters()
          @spaceship.update()
          expect(@spaceship.body.ApplyForce).toHaveBeenCalledWith(new B2D.Vec2(10,0), new B2D.Vec2(0,0))
          expect(@spaceship.body.ApplyTorque).toHaveBeenCalledWith(10)