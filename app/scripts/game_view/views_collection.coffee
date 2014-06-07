define ['view'], (View) ->
  class ViewsCollection
    constructor: (container) ->
      @views = {}

    add: (name, view, z = 0) ->
      @views[name] = 
        view: view
        z: z     

    remove: (name) ->
      if @views[name]?
        @views[name].view.destroy()
        delete @views[name]

    get: (name) ->
      @views[name].view

    exists: (name) ->
      @views[name]?

    render: ->
      _.chain(@views)
      .values()
      .sortBy (view) ->
        view.z
      .each (view) ->
        view.view.render()

    getViews: ->
      _.chain(@views)
      .values()
      .sortBy (view) ->
        view.z
      .map (view) ->
        view.view
      .value()