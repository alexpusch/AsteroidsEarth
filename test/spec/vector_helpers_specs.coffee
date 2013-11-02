define ['box2d', 'vector_helpers'], (B2D, VectorHelpers) ->
  describe "VectorHelpersSpec", ->
    describe "createDirectionVector", ->
      it "returns a unit vector in the direction of the given angle", ->

        direction = VectorHelpers.createDirectionVector 90*Math.PI/180
        yAxis = new B2D.Vec2(0,1)
        expect(direction).toBeVector yAxis