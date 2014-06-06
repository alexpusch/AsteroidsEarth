define ['events'], (Events) ->
  describe 'Events', ->
    beforeEach ->
      @events = new Events()
      @callback = jasmine.createSpy('callback')

    describe 'trigger', ->
      it "activates subscribed callbacks", ->
        @events.on 'name', @callback
        @events.trigger 'name'

        expect(@callback).toHaveBeenCalled()

      it 'calls the callback with the given arguments', ->
        @events.on 'name', @callback
        @events.trigger 'name', 'arg'

        expect(@callback).toHaveBeenCalledWith 'arg'

      it 'does not call the callback if it was removed', ->
        @events.on 'name', @callback
        @events.off 'name', @callback
        @events.trigger 'name'

        expect(@callback).not.toHaveBeenCalled()

      it 'works fine if no callback was registerd', ->
        test = =>
          @events.trigger 'empty'
        expect(test).not.toThrow()

    describe 'clear', ->
      it 'clears all events', ->
        @events.on 'name', @callback
        @events.clear()

        @events.trigger 'name'

        expect(@callback).not.toHaveBeenCalled()