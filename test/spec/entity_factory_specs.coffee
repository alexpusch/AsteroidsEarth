define ['entity_factory', 'world', 'spaceship', 'bullet', 'asteroid', 'speed_powerup'], (EntityFactory, World, Spaceship, Bullet, Asteroid, SpeedPowerup) ->
  describe "EntityFactory", ->
    beforeEach ->
      config =
        Spaceship: 1

      @world = jasmine.createSpyObj('world', ['registerEntity'])
      @ef = new EntityFactory @world, config

    describe "createSpaceship", ->
      it "returns a new spaceship", ->
        expect(@ef.createSpaceship()).toEqual(jasmine.any Spaceship)

      it "registers it with the given world", ->
        spaceship = @ef.createSpaceship()
        expect(@world.registerEntity).toHaveBeenCalledWith spaceship

    describe "createBullet", ->
      beforeEach ->
        @bullet = @ef.createBullet()

      it "returns a new bullet", ->
        expect(@bullet).toEqual(jasmine.any Bullet)

      it "registerEntity it with the given world", ->
        expect(@world.registerEntity).toHaveBeenCalledWith @bullet

    describe "createAsteroid", ->
      beforeEach ->
        @planet = @ef.createPlanet()
        @asteroid = @ef.createAsteroid()

      it "returns a new asteroid using the previously created planet", ->

        expect(@asteroid).toEqual(jasmine.any Asteroid)
        expect(@asteroid.planet).toEqual @planet

      it "registerEntity it with the given world", ->
        expect(@world.registerEntity).toHaveBeenCalledWith @asteroid

    describe "createSpeedPowerup", ->
      beforeEach ->
        @speedPowerup = @ef.createSpeedPowerup()

      it "returns a new speedPowerup", ->
        expect(@speedPowerup).toEqual(jasmine.any SpeedPowerup)

      it "registerEntity it with the given world", ->
        expect(@world.registerEntity).toHaveBeenCalledWith @speedPowerup