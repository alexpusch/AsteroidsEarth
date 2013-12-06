define ['score'], (Score)->
  describe 'Score', ->
    beforeEach ->
      @score = new Score
        upInterval: 10

      jasmine.Clock.useMock()

    describe 'start', ->
      it 'should raise as time goes by', ->
        @score.start()
        jasmine.Clock.tick(100)
        expect(@score.getScore()).toEqual 10

    describe 'stop', ->
      it 'stops the raising of the score', ->
        @score.start()
        jasmine.Clock.tick(100)
        @score.stop()
        jasmine.Clock.tick(200)
        expect(@score.getScore()).toEqual 10