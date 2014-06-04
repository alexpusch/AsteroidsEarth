define ["math_helpers"], (MathHelpers) ->
  ColorHelpers =
    combineRgb: (r, g, b) ->
      shiftedRed = r << 16
      shiftedGreen = g << 8

      color = b + shiftedGreen + shiftedRed      
      color

    splitRgb: (hex) ->
      lowBitsMask = 0x0000FF 
      blue = hex & lowBitsMask
      hex = hex >> 8
      green = hex & lowBitsMask
      hex = hex >> 8
      red = hex & lowBitsMask

      [red, green, blue]

    colorAverage: (color1, color2, t) ->
      [r1, g1, b1] = ColorHelpers.splitRgb color1
      [r2, g2, b2] = ColorHelpers.splitRgb color2

      r = MathHelpers.average r1, r2, t
      g = MathHelpers.average g1, g2, t
      b = MathHelpers.average b1, b2, t

      ColorHelpers.combineRgb r, g, b
