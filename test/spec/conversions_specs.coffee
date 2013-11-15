define ['conversions', 'box2d'], (Conversions, B2D)->
  describe 'Conversions', ->
    describe 'Box2D to PIXI', ->
      it 'converts Vec2 to Point', ->
        vec2 = new B2D.Vec2(10, 20)
        expectedPoint = new PIXI.Point(10, 20)

        expect(Conversions.B2DtoPIXI.toPoint vec2).toEqual expectedPoint

    describe 'PIXI to Box2D', ->
      it 'converts Point to Vec2', ->
        point = new PIXI.Point(10, 20)
        expectedVec2 = new B2D.Vec2(10, 20)

        expect(Conversions.PIXI2Box2D.toVec2 point).toEqual expectedVec2