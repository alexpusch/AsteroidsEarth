define ['view'], (View) ->
  class ViewsCollection
    constructor: ->
      @views = {}

    add: (name, view, z = 0) ->
      @views[name] = 
        view: view
        z: z

    remove: (name) ->
      @views[name].view.destroy()
      delete @views[name]

    get: (name) ->
      @views[name].view

    render: ->
      _.chain(@views)
      .values()
      .sortBy (view) ->
        view.z
      .each (view) ->
        view.view.render()