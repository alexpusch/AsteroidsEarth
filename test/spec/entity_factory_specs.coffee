define ['entity_factory', 'world', 'spaceship'], (EntityFactory, World, Spaceship) ->
  describe "EntityFactory", ->
    describe "createSpaceship", ->
      beforeEach ->
        @world = jasmine.createSpyObj('world', ['registerEntity'])

        @ef = new EntityFactory @world

      it "returns a new spaceship", ->
        expect(@ef.createSpaceship()).toEqual(jasmine.any Spaceship)

      it "registers it with the given world", ->
        spaceship = @ef.createSpaceship()
        expect(@world.registerEntity).toHaveBeenCalledWith spaceship
