define ['camera'], (Camera)->
  describe 'Camera', ->
    describe 'project', ->
      beforeEach ->
        @viewportHeight = 1000
        @viewportWidth = 1000

        @camera = new Camera @viewportWidth, @viewportHeight
        @point = new B2D.Vec2(10, 10)

      it 'moves the point so (0,0) would be the center of the screen', ->
        projectedPoint = @camera.project new B2D.Vec2(0,0)
        expect(projectedPoint).toBeVector(new B2D.Vec2(@viewportWidth/2, @viewportHeight/2))

      it 'projects a zoomed in camera', ->
        @camera.zoom(30)
        projectedPoint = @camera.project @point

        expect(projectedPoint).toBeVector(new B2D.Vec2(300 + @viewportWidth/2,300 + @viewportHeight/2))

      it 'projects a translated camera', ->
        @camera.lookAt(20, 20)
        projectedPoint = @camera.project @point

        expect(projectedPoint).toBeVector(new B2D.Vec2(30 + @viewportWidth/2, 30 + @viewportHeight/2))

      it 'projects a zoomed and translated camera', ->
        @camera.lookAt(20, 20)
        @camera.zoom(10)
        projectedPoint = @camera.project @point

        expect(projectedPoint).toBeVector(new B2D.Vec2(300 + @viewportWidth/2, 300 + @viewportHeight/2))

  describe 'Back project', ->
    beforeEach ->
      @viewportHeight = 1000
      @viewportWidth = 1000

      @camera = new Camera @viewportWidth, @viewportHeight
      @viewPoint = new B2D.Vec2(300, 300)

    it 'moves the viewPoint so (0,0) would be the center of the screen', ->
      backProjectedPoint = @camera.backProject new B2D.Vec2(@viewportWidth/2,@viewportHeight/2)
      expect(backProjectedPoint).toBeVector(new B2D.Vec2(0, 0))

    it 'projects a zoomed in camera', ->
      @camera.zoom(3)
      backProjectedPoint = @camera.backProject @viewPoint

      expect(backProjectedPoint).toBeVector(new B2D.Vec2( (300 - @viewportWidth/2)/3  ,(300 - @viewportHeight/2)/3 ))

    it 'projects a translated camera', ->
      @camera.lookAt(20, 20)
      backProjectedPoint = @camera.backProject @viewPoint

      expect(backProjectedPoint).toBeVector(new B2D.Vec2( 300 - @viewportWidth/2 - 20  ,300 - @viewportHeight/2 - 20))

    it 'projects a zoomed and translated camera', ->
      @camera.lookAt(20, 20)
      @camera.zoom(10)
      backProjectedPoint = @camera.backProject @viewPoint

      expect(backProjectedPoint).toBeVector(new B2D.Vec2( (300 - @viewportWidth/2 - 20 *10 )/10  ,(300 - @viewportHeight/2 - 20 * 10)/10 ))