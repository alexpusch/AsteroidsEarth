define ['entity_factory', 'world', 'spaceship', 'bullet'], (EntityFactory, World, Spaceship, Bullet) ->
  describe "EntityFactory", ->
    beforeEach ->
      @world = jasmine.createSpyObj('world', ['registerEntity'])
      @ef = new EntityFactory @world

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
