define ['pauseable_timeout'], (PauseableTimeout) ->
  describe "PauseableTimeout", ->
    beforeEach ->
      jasmine.Clock.useMock()
      @callback = jasmine.createSpy "callback"
      @handler = PauseableTimeout.setTimeout @callback, 500

    describe "setTimeout", ->
      it "does not call the givn callback before timeout expires", ->
        jasmine.Clock.tick 450
        expect(@callback).not.toHaveBeenCalled()

      it "calls a callback after the timeout expires", ->
        jasmine.Clock.tick 505
        expect(@callback).toHaveBeenCalled()

      it "returns a handler to the timeout", ->
        expect(@handler).toEqual jasmine.any PauseableTimeout

    describe "clear", ->
      it "clears the timeout", ->
        @handler.clear()
        jasmine.Clock.tick 10000
        expect(@callback).not.toHaveBeenCalled()

    describe "pause", ->
      it "pauses the timeout execution", ->
        @handler.pause()
        jasmine.Clock.tick 10000
        expect(@callback).not.toHaveBeenCalled()

    describe "resume", ->
      beforeEach ->
        flag = false

        runs ->
          console.log "runs"
          jasmine.Clock.real.setTimeout.call window, ->
            flag = true
          , 300

        waitsFor ->
          flag

        runs ->
          @handler.pause()

        runs ->
          flag = false
          jasmine.Clock.real.setTimeout.call window, ->
            flag = true
          , 250

        waitsFor ->
          flag

      it "resumes a paused timeout and calls the callback in the remaining timeout", ->
        runs ->
          @handler.resume()
          jasmine.Clock.tick 201
          expect(@callback).toHaveBeenCalled()

      it "does not call the callback before the remaning time runs out", ->
        runs ->
          @handler.resume()
          jasmine.Clock.tick 180
          expect(@callback).not.toHaveBeenCalled()