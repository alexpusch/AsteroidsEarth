define ['world_renderer', 'entity'], (WorldRenderer, Entity)->
  describe 'world renderer', ->
    beforeEach ->
      class @MockRenderer

      camera = {}
      @worldRenderer = new WorldRenderer 
        camera: camera 

    describe 'register renderer', ->
      it 'adds the renderer to the registry', ->
        @worldRenderer.registerRenderer('name', @MockRenderer)

        expect(@worldRenderer.getRendererType('name')).toEqual @MockRenderer

    describe 'getRenderer', ->
      it 'returns an instance of the registered renderer', ->
        class @MockRenderer         

        @worldRenderer.registerRenderer('name', @MockRenderer)

        entity = 
          type: 'name'
        
        expect(@worldRenderer.getRenderer(entity)).toEqual jasmine.any(@MockRenderer)

      it 'returns the same instance if called twice', ->

    describe 'render', ->
      it 'calls all the render functions of the given entities', ->
        world = jasmine.createSpyObj('world', ['getEntities'])
        entity1 = new Entity 'type1'
        entity2 = new Entity 'type2'

        world.getEntities.andReturn [entity1, entity2]

        render1 = jasmine.createSpy('r1')
        render2 = jasmine.createSpy('r2')

        class MockRenderer1
          render: render1

        class MockRenderer2
          render: render2

        @worldRenderer.registerRenderer('type1', MockRenderer1)
        @worldRenderer.registerRenderer('type2', MockRenderer2)

        @worldRenderer.render world

        expect(render1).toHaveBeenCalled()
        expect(render2).toHaveBeenCalled()