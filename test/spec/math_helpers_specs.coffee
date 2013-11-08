define ["math_helpers"] , (MathHelpers) ->
  describe "MathHelpers", ->
    describe "d2r", ->
      it "converts degrees to radians", ->
        expect(MathHelpers.d2r(30)).toEqual 30*Math.PI/180
