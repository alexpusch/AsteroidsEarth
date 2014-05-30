define ['box2d', 'cannon', 'math_helpers'], (B2D, Cannon, MathHelpers)->
  describe "Cannon", ->
    beforeEach ->
      @cannonHeatRate = 0.01
      @cannonCooldownRate = 0.05
      @cannon = new Cannon
        cannonHeatRate: @cannonHeatRate
        cannonCooldownRate: @cannonCooldownRate
        bulletSpeed: 30
        cannonOffset: new B2D.Vec2 30, 0

    describe "fire bullet", ->
      beforeEach ->
        @bullet = jasmine.createSpyObj 'bullet', ['setPosition', 'setSpeed', 'setAngle']
        window.EntityFactory = jasmine.createSpyObj 'EntityFactory', ['createBullet']
        window.EntityFactory.createBullet.andReturn @bullet

      it "creates a bullet", ->
        @cannon.fireBullet()
        expect(EntityFactory.createBullet).toHaveBeenCalled()

      it "fires the bullet in the current cannon position", ->
        @cannon.setAngle MathHelpers.d2r 90
        @cannon.setPosition new B2D.Vec2(0,0)

        @cannon.fireBullet()
        expect(@bullet.setPosition.mostRecentCall.args[0]).toBeVector new B2D.Vec2(0, 30)
      
      it "fires the bullet in the angle of the cannon", ->
        @cannon.setAngle 3

        @cannon.fireBullet()
        expect(@bullet.setAngle).toHaveBeenCalledWith 3

      it "fires the bullet with the speed of the cannon plus 30", ->
        @cannon.setSpeed new B2D.Vec2 1000, 0
        @cannon.fireBullet()

        expect(@bullet.setSpeed).toHaveBeenCalledWith new B2D.Vec2 1030, 0

      it "adds to the cannon temperature", ->
        @cannon.fireBullet()
        expect(@cannon.getCannonTemperature()).toBe @cannonHeatRate

      it "does not raise temperature over 1", ->
        @cannon.cannonTemperature = 1 - @cannonHeatRate/2
        @cannon.fireBullet()
        expect(@cannon.getCannonTemperature()).toEqual 1

      describe "cannon temperature hit threashost", ->
        beforeEach ->
          @cannon.cannonTemperature = 1 - @cannonHeatRate
          @cannon.fireBullet()
                  
        it "jams the cannon", ->
          @cannon.fireBullet()
          expect(@cannon.isCannonJammed()).toBeTruthy()

      describe "cannon jammed", ->
        beforeEach ->
          @cannon.cannonTemperature = 1 - @cannonHeatRate
          @cannon.fireBullet()
          EntityFactory.createBullet.reset()

        it "does not fire", ->
          @cannon.fireBullet()
          expect(EntityFactory.createBullet).not.toHaveBeenCalled()

        it "does not raise temperature", ->
          @cannon.fireBullet()
          expect(@cannon.getCannonTemperature()).toEqual 1

    describe "update", ->