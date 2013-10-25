describe "Spaceship", ->
  describe "step", ->
    describe "without thrusters or any forces", ->
      it "does not move", ->

    describe "with main thrusters on", ->
      it "moves forwards", ->

    describe "with left thrusters on", ->
      it "rotates left", ->

    describe "with right thrusters on", ->
      it "rotates right", ->

  describe "fire main thrusters", ->
    it "main thrusters are enabled", ->
      spaceship = new Spaceship
      spaceship.fireMainThrusters()

      expect(spaceship.mainThrustersStatus()).toBeTruthy()

  describe "fire left thruster", ->
    it "left thrusters are enabled", ->

  describe "fire right thruster", ->
    it "right thrusters are enabled", ->
