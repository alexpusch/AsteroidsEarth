beforeEach ->
  this.addMatchers
    toBeVector: (expected) ->
      EPSILON = 0.001
      
      Math.abs(this.actual.x - expected.x) < EPSILON and
      Math.abs(this.actual.y - expected.y) < EPSILON