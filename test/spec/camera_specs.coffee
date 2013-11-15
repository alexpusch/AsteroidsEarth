define ['camera'], (Camera)->
  describe 'Camera', ->
    describe 'project', ->
      beforeEach ->
        @camera = new Camera()
        @point = new B2D.Vec2(10, 10)

      it 'projects a zoomed in camera', ->
        @camera.zoom(30)
        projectedPoint = @camera.project @point

        expect(projectedPoint).toBeVector(new B2D.Vec2(300,300))

      it 'projects a translated camera', ->
        @camera.move(20, 20)
        projectedPoint = @camera.project @point

        expect(projectedPoint).toBeVector(new B2D.Vec2(30, 30))

      it 'projects a zoomed and translated camera', ->
        @camera.move(20, 20)
        @camera.zoom(10)
        projectedPoint = @camera.project @point

        expect(projectedPoint).toBeVector(new B2D.Vec2(300, 300))