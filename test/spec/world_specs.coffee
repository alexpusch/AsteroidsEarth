describe "World", ->
  describe "registerEntity", ->
    beforeEach ->
      @world = new World
      @entity = createEntitySpy()
      @entity.setBody = jasmine.createSpy('setBody')

    it "added the entity to the worlds bodies", ->     
      bodyCount = @world.getBodyCount()
      @world.registerEntity @entity

      expect(@world.getBodyCount()).toEqual(bodyCount + 1)

    it "sets the entity body to the created body", ->
      @world.registerEntity @entity
      expect(@entity.setBody).toHaveBeenCalled()