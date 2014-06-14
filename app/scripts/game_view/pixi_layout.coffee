define ->
  class PIXILayout
    @order: (container, layout) ->
      padding = @_calculatePadding container, layout

      for item, i in layout
        element = item.element

        element.anchor = new PIXI.Point 0.5, 0
        element.x = container.width / 2

        r = element.width / element.height

        element.height = container.height * item.height
        element.width = element.height * r

        if i == 0
          element.y = 0
        else
          element.y = lastItem.element.y + lastItem.element.height + padding

        container.addChild element

        lastItem = item

    @_calculatePadding: (container, layout) ->
      totalHeight = @_sumHeights layout
      padding = container.height * (1 - totalHeight)/(layout.length - 1)

      padding

    @_sumHeights: (layout) ->
      totalHeight = _.chain(layout)
        .map (item) ->
          item.height
        .reduce((result, number) ->
          result + number
        , 0)
        .value()

      totalHeight