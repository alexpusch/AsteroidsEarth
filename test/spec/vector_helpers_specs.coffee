describe "VectorHelpersSpec", ->
  beforeEach ->
    this.addMatchers
      toBeVector: (expected) ->
        EPSILON = 0.001
        
        Math.abs(this.actual.x - expected.x) < EPSILON and
        Math.abs(this.actual.y - expected.y) < EPSILON

  describe "createDirectionVector", ->
    it "returns a unit vector in the direction of the given angle", ->

      direction = VectorHelpers.createDirectionVector 90*Math.PI/180
      yAxis = new Box2D.Common.Math.b2Vec2(0,1)
      expect(direction).toBeVector yAxis