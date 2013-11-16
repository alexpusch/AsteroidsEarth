beforeEach ->
  EPSILON = 0.001

  this.addMatchers
    toBeVector: (expected) ->
      Math.abs(@actual.x - expected.x) < EPSILON and
      Math.abs(@actual.y - expected.y) < EPSILON

    toBeInDirection: (expected) ->
      expected.Normalize()
      @actual.Normalize()

      Math.abs(@actual.x - expected.x) < EPSILON and
      Math.abs(@actual.y - expected.y) < EPSILON
