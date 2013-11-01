describe "Spaceship", ->
  beforeEach ->
    @spaceship = new Spaceship
    @body = {};
    @spaceship.setBody(@body)

  describe "setBody", ->
    it "sets the spaceship body to the givven body", ->
      expect(@spaceship.body).toBe @body

  describe "fire main thrusters", ->
    it "a force is applied forwards", ->
      @spaceship.body.applyForce = jasmine.createSpy('applyForce')
      @spaceship.body.GetAngle = jasmine.createSpy('getAngle').andReturn(0)
      @spaceship.fireMainThrusters()
      expect(@spaceship.body.applyForce).toHaveBeenCalledWith(new Box2D.Common.Math.b2Vec2(1,0), new Box2D.Common.Math.b2Vec2(0,0))

  describe "fire left thruster", ->
    it "a force is applied to the left", ->

  describe "fire right thruster", ->
    it "a force is applied to the right", ->
      