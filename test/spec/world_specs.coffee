define ['box2d', 'world', 'entity'], (B2D, World, Entity) ->
  describe "World", ->
    beforeEach ->
      @world = new World
        size: 
          width: 100
          height: 100

      @entity = new Entity

    describe "registerEntity", ->
      it "added the entity to the worlds bodies", ->     
        bodyCount = @world.getBodyCount()
        @world.registerEntity @entity

        expect(@world.getBodyCount()).toEqual(bodyCount + 1)

      it "sets the entity body to the created body", ->
        spyOn @entity, 'setBody'

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

      it "warps entities from one edge of the screen to the oposite", ->
        @world.registerEntity @entity
        @entity.setPosition(new B2D.Vec2 103, 0)
        @world.update()
        expect(@entity.getPosition()).toBeVector new B2D.Vec2 3, 0

      it "warps entities from the start of the screen to the end", ->
        @world.registerEntity @entity
        @entity.setPosition(new B2D.Vec2 -3, 0)
        @world.update()
        expect(@entity.getPosition()).toBeVector new B2D.Vec2 97, 0        


