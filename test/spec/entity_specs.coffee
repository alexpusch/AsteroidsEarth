define ['box2d', 'entity'], (B2D, Entity)->
  describe "Entity", ->
    describe "setBody", ->
      it "sets the entities body to the given body", ->
        entity = new Entity
        body = {}
        entity.setBody body
        expect(entity.body).toBe body

    describe "destroy", ->
      it "calls the destroy event", ->
        entity = new Entity
        callback = jasmine.createSpy()

        entity.on 'destroy', callback
        entity.destroy()
        expect(callback).toHaveBeenCalledWith(entity)
