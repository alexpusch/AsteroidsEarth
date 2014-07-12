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
      window.EntityFactory = jasmine.createSpyObj('EntityFactory', ['createAsteroid'])
      @asteroid = new Entity()
      window.EntityFactory.createAsteroid.andReturn @asteroid
      jasmine.Clock.useMock()

    describe 'start', ->
      it 'creates the asteroid in the correct order', ->
        @wave.start()
        expect(window.EntityFactory.createAsteroid.calls.length).toBe(0)
        jasmine.Clock.tick(101);
        expect(window.EntityFactory.createAsteroid.calls.length).toBe(1)
        jasmine.Clock.tick(90);
        expect(window.EntityFactory.createAsteroid.calls.length).toBe(1)
        jasmine.Clock.tick(200);
        expect(window.EntityFactory.createAsteroid.calls.length).toBe(2)

      it 'creates the asteroids with the correct paramets', ->
        @wave.start()
        jasmine.Clock.tick(1000)
        expect(window.EntityFactory.createAsteroid.calls[0].args[0]).toEqual
          radius: 3
          position:
            x: 120
            y: 130

        expect(window.EntityFactory.createAsteroid.calls[1].args[0]).toEqual
          radius: 4
          position:
            x: -20
            y: -30

    describe 'wave end', ->
      it 'triggers the wave end event when all the asteroids are destroied', ->
        waveEndCallback = jasmine.createSpy('waveEndCallback')
        @wave.events.on 'waveDestroyed', waveEndCallback
        @wave.start()
        jasmine.Clock.tick(1000)
        @asteroid.destroy()

        expect(waveEndCallback).toHaveBeenCalled()