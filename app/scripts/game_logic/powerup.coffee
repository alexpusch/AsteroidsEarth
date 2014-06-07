define ['entity', 'spaceship', 'collision_helpers'], (Entity, Spaceship, CollisionHelpers) ->
  class Powerup extends Entity
    @categoryBits: CollisionHelpers.getAviliableCategoryBit()

    constructor: (powerupType) ->
      super powerupType
      @applied = false

    handleCollision: (entity, contactPoint) ->
      unless @applied
        if entity instanceof Spaceship
          @apply entity, contactPoint
          @destroy()

    shouldPassThrough: (entity) ->
      entity instanceof Spaceship