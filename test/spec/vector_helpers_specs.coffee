define ['box2d', 'vector_helpers', 'math_helpers'], (B2D, VectorHelpers, MathHelpers) ->
  describe "VectorHelpersSpec", ->
    describe "rotate", ->
      it "returns a rotated vector" , ->
        vec = new B2D.Vec2(1,0)
        result = VectorHelpers.rotate(vec, MathHelpers.d2r 90)
        expect(result).toBeVector new B2D.Vec2(0,1)

    describe "createDirectionVector", ->
      it "returns a unit vector in the direction of the given angle", ->

        direction = VectorHelpers.createDirectionVector(MathHelpers.d2r 90)
        yAxis = new B2D.Vec2(0,1)
        expect(direction).toBeVector yAxis
