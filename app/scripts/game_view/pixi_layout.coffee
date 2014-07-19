define ->
  class PIXILayout
    @order: (container, elements, options = {}) ->
      for element, i in elements
        if i == 0
          element.y = 0
        else
          element.y = lastElement.y + lastElement.height

        lastElement = element
        container.addChild element

    @strach: (container, layout) ->
      padding = @_calculatePadding container, layout

      for item, i in layout
        element = item.element

        r = element.width / element.height
        z = container.height * item.height / element.height
        element.scale = new PIXI.Point z, z
        element.x = (container.width - @_getWidth element)/2

        if i == 0
          element.y = 0
        else
          element.y = lastItem.element.y + @_getHeight(lastItem.element) + padding

        container.addChild element

        lastItem = item

    @justify: (container, elements, options = {}) ->
      lineSpacing = options.lineSpacing
      totalWidth = container.width

      for element, i in elements
        r = element.height / element.width
        element.width = totalWidth
        element.height = totalWidth * r

        if i == 0
          element.y = 0
        else
          element.y = lastElement.y + lastElement.height * 0.85

        container.addChild element

        lastElement = element

      heightSum = _(elements).reduce (result, element)->
        result + element.height
      , 0

      container.height = heightSum

    @scaleToFit: (graphics, width, height) ->
      rx = width / graphics.width
      ry = height / graphics.height

      r = Math.min rx, ry
      graphics.scale = new PIXI.Point r, r

    @center: (elementToCenter, container) ->
      elementToCenter.x = @_getWidth(container)/2 - @_getWidth(elementToCenter)/2
      elementToCenter.y = @_getHeight(container)/2 - @_getHeight(elementToCenter)/2

    @_getHeight: (element) ->
      if element instanceof PIXI.Sprite
        element._height
      else
        element.height * element.scale.y

    @_getWidth: (element) ->
      if element instanceof PIXI.Sprite
        element._width
      else
        element.width * element.scale.x

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