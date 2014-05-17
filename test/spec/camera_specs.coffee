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