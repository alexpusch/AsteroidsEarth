define ['entity_factory', 'world', 'spaceship', 'bullet', 'astroid'], (EntityFactory, World, Spaceship, Bullet, Astroid) ->
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

    describe "createAstroid", ->
      beforeEach ->
        @astroid = @ef.createAstroid()

      it "returns a new astroid", ->
        expect(@astroid).toEqual(jasmine.any Astroid)

      it "registerEntity it with the given world", ->
        expect(@world.registerEntity).toHaveBeenCalledWith @astroid