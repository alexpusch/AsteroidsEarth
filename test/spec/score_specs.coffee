define ['score', 'events'], (Score, Events) ->
  describe 'Score', ->
    beforeEach ->
      @score = new Score
        upInterval: 10

      jasmine.Clock.useMock()

    describe 'update', ->
      it 'should raise as time goes by', ->
        @score.update 1
        expect(@score.getScore()).toEqual 100

      it 'should multipy the added score by current multiplier', ->
        @score.update 1
        @score.setMultiplier 2
        @score.update 1
        expect(@score.getScore()).toEqual 300