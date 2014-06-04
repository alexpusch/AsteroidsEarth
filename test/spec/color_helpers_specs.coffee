define ['color_helpers'], (ColorHelpers) ->
  describe "ColorHelpers", ->
    describe "combineRgb", ->
      it "combines rgb chanels into hex value", ->
        r = 0xff
        g = 0xff
        b = 0xff

        expected = 0xffffff
        actual = ColorHelpers.combineRgb r,g,b

        expect(actual).toEqual expected

    describe "splitRgb", ->
      it "splits hex color into rgb chanels", ->
        color = 0xffee11
        expectedChanels = [0xff, 0xee, 0x11]
        actual = ColorHelpers.splitRgb color
        expect(actual).toEqual expectedChanels

    describe "colorAverage", ->
      it "interpulates the two received colors using the received value", ->
        color1 = 0x884422
        color2 = 0x000000
        t = 0.5

        expectedColor = 0x442211
        actual = ColorHelpers.colorAverage color1, color2, t
        expect(actual).toEqual expectedColor
