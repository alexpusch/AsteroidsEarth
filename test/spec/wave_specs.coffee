define ['wave', 'entity'], (Wave, Entity) ->
  describe 'Wave', ->
    beforeEach ->
      @wavePlan = [
          offset: 100
          radius: 3
          position:
            x: 120
            y: 130
       ,
          offset: 100
          radius: 4
          position:
            x: -20
            y: -30
      ]

      @wave = new Wave @wavePlan
      window.EntityFactory = jasmine.createSpyObj('EntityFactory', ['createAstroid'])
      @astroid = new Entity()
      window.EntityFactory.createAstroid.andReturn @astroid
      jasmine.Clock.useMock()

    describe 'start', ->
      it 'creates the astroid in the correct order', ->
        @wave.start()
        expect(window.EntityFactory.createAstroid.calls.length).toBe(0)
        jasmine.Clock.tick(101);
        expect(window.EntityFactory.createAstroid.calls.length).toBe(1)
        jasmine.Clock.tick(90);
        expect(window.EntityFactory.createAstroid.calls.length).toBe(1)
        jasmine.Clock.tick(200);
        expect(window.EntityFactory.createAstroid.calls.length).toBe(2)

      it 'creates the astroids with the correct paramets', ->
        @wave.start()
        jasmine.Clock.tick(1000)
        expect(window.EntityFactory.createAstroid.calls[0].args[0]).toEqual
          radius: 3
          position:
            x: 120
            y: 130

        expect(window.EntityFactory.createAstroid.calls[1].args[0]).toEqual
          radius: 4
          position:
            x: -20
            y: -30

    describe 'wave end', ->
      it 'triggers the wave end event when all the astroids are destroied', ->
        waveEndCallback = jasmine.createSpy('waveEndCallback')
        @wave.on 'waveDestroyed', waveEndCallback
        @wave.start()
        jasmine.Clock.tick(1000)
        @astroid.destroy()

        expect(waveEndCallback).toHaveBeenCalled()