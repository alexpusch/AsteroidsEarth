class Spaceship
  constructor: ->
    @thrusters = 
      main: false
      left: false
      right: false

  fireMainThrusters: ->
    @thrusters.main = true

  mainThrustersStatus: ->
    @thrusters.main

window.Spaceship = Spaceship