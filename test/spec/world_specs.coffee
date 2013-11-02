define ['box2d', 'world'], (B2D, World) ->
  describe "World", ->
    beforeEach ->
      @world = new World
      @entity = createEntitySpy()
      @entity.setBody = jasmine.createSpy('setBody')

    describe "registerEntity", ->
      it "added the entity to the worlds bodies", ->     
        bodyCount = @world.getBodyCount()
        @world.registerEntity @entity

        expect(@world.getBodyCount()).toEqual(bodyCount + 1)

      it "sets the entity body to the created body", ->
        @world.registerEntity @entity
        expect(@entity.setBody).toHaveBeenCalled()

    describe "update", ->
      it "advances the world in one step", ->
        spyOn(@world.world, 'Step')
        @world.update()
        expect(@world.world.Step).toHaveBeenCalled

      it "calls udpate of all the registerd entities", ->
        @entity.update = jasmine.createSpy('update')
        @world.registerEntity @entity
        @world.update()
        expect(@entity.update).toHaveBeenCalled()


