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

    describe "call handleEnterWorld", ->
      it "calls the handleEnterWorld callback for entities that enters the world", ->
        spyOn @entity, "handleEnterWorld"

        @world.registerEntity @entity
        @entity.setPosition(new B2D.Vec2 103, 0)
        @world.update()
        @entity.setPosition(new B2D.Vec2 97, 0)
        @world.update()

        expect(@entity.handleEnterWorld).toHaveBeenCalled()

      it "calles the handleEnterWorld callback only once", ->
        @world.registerEntity @entity
        @entity.setPosition(new B2D.Vec2 103, 0)
        @world.update()
        @entity.setPosition(new B2D.Vec2 97, 0)
        @world.update()

        spyOn @entity, "handleEnterWorld"
        @entity.setPosition(new B2D.Vec2 95, 0)
        @world.update()       

        expect(@entity.handleEnterWorld).not.toHaveBeenCalled()

    describe "call handleExitWorld", ->
      it "calls the handleExitWorld callback for entities that exists the world", ->
        spyOn @entity, "handleExitWorld"

        @world.registerEntity @entity
        @entity.setPosition(new B2D.Vec2 97, 0)
        @world.update()
        @entity.setPosition(new B2D.Vec2 103, 0)
        @world.update()

        expect(@entity.handleExitWorld).toHaveBeenCalled()

      it "calles the handleExitWorld callback only once", ->
        @world.registerEntity @entity
        @entity.setPosition(new B2D.Vec2 97, 0)
        @world.update()
        @entity.setPosition(new B2D.Vec2 103, 0)
        @world.update()

        spyOn @entity, "handleExitWorld"
        @entity.setPosition(new B2D.Vec2 105, 0)
        @world.update()       

        expect(@entity.handleExitWorld).not.toHaveBeenCalled()

      it "does not call the handleExitWorld callback for entites that where created in the world", ->
        spyOn @entity, "handleExitWorld"
        @world.registerEntity @entity
      
        @entity.setPosition(new B2D.Vec2 195, 0)
        @world.update()       

        expect(@entity.handleExitWorld).not.toHaveBeenCalled()