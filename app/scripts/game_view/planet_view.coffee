define ['conversions', 'view'], (Conversions, View)  ->
  class PlanetView extends View
    constructor: (stage, camera, @planet) ->
      super stage, camera

    createGraphics: ->
      graphics = new PIXI.Graphics()

      graphics.beginFill(0x75baef)

      graphics.drawCircle(0,0, @planet.getRadius())
      graphics.endFill()

      @_drawContinents graphics

      graphics

    updateGraphics: ->
      vec2Position = @camera.project(@planet.getPosition())
      pixiPosition = Conversions.B2DtoPIXI.toPoint vec2Position
      @graphics.position = pixiPosition
      @graphics.scale = new PIXI.Point @camera.getZoom() ,@camera.getZoom()

    _drawContinents: (graphics)->
      continentsGraphics = new PIXI.Graphics()

      continentsGraphics.beginFill 0x00AA00

      continentsGraphics.moveTo 107.6879,1950.8501  
      continentsGraphics.lineTo 110.25271,1949.0547 
      continentsGraphics.lineTo 110.02057,1946.4349 
      continentsGraphics.lineTo 109.98702,1943.3578 
      continentsGraphics.lineTo 123.97756,1938.6138 
      continentsGraphics.lineTo 120.35493,1921.0041 
      continentsGraphics.lineTo 118.07724,1910.0041 
      continentsGraphics.lineTo 127.9421,1897.4081 
      continentsGraphics.lineTo 141.75417,1885.7273 
      continentsGraphics.lineTo 167.94409,1847.5008 
      continentsGraphics.lineTo 163.63432,1844.0126 
      continentsGraphics.lineTo 146.95245,1847.7628 
      continentsGraphics.lineTo 139.22536,1848.3095 
      continentsGraphics.lineTo 135.13432,1841.5061 
      continentsGraphics.lineTo 123.63433,1828.2175 
      continentsGraphics.lineTo 112.13433,1814.9883 
      continentsGraphics.lineTo 107.08115,1805.2076 
      continentsGraphics.lineTo 105.13433,1798.9013 
      continentsGraphics.lineTo 102.23158,1788.6513 
      continentsGraphics.lineTo 95.134328,1772.2581 
      continentsGraphics.lineTo 94.248038,1769.4972 
      continentsGraphics.lineTo 90.733808,1756.0999 
      continentsGraphics.lineTo 99.091668,1756.238 
      continentsGraphics.lineTo 109.35202,1772.2608 
      continentsGraphics.lineTo 114.60925,1782.2608 
      continentsGraphics.lineTo 117.10616,1790.0537 
      continentsGraphics.lineTo 121.42339,1798.0537 
      continentsGraphics.lineTo 128.67339,1807.143 
      continentsGraphics.lineTo 133.41805,1814.143 
      continentsGraphics.lineTo 134.77124,1819.1965 
      continentsGraphics.lineTo 136.13715,1825.6965 
      continentsGraphics.lineTo 139.01252,1832.5108 
      continentsGraphics.lineTo 144.13432,1833.7608 
      continentsGraphics.lineTo 149.00676,1832.229 
      continentsGraphics.lineTo 154.57545,1830.729 
      continentsGraphics.lineTo 158.24872,1829.2608 
      continentsGraphics.lineTo 162.81607,1826.8751 
      continentsGraphics.lineTo 169.31231,1822.9598 
      continentsGraphics.lineTo 174.08726,1819.3487 
      continentsGraphics.lineTo 184.61923,1813.2608 
      continentsGraphics.lineTo 187.17111,1810.664 
      continentsGraphics.lineTo 190.11324,1807.5561 
      continentsGraphics.lineTo 192.66893,1805.1518 
      continentsGraphics.lineTo 195.20204,1802.2246 
      continentsGraphics.lineTo 197.13432,1798.3481 
      continentsGraphics.lineTo 198.63432,1794.2608 
      continentsGraphics.lineTo 200.13432,1791.5427 
      continentsGraphics.lineTo 201.88432,1787.0975 
      continentsGraphics.lineTo 203.63432,1784.1255 
      continentsGraphics.lineTo 200.13432,1781.2201 
      continentsGraphics.lineTo 193.9568,1778.2877 
      continentsGraphics.lineTo 188.75763,1775.0387 
      continentsGraphics.lineTo 186.23598,1771.8167 
      continentsGraphics.lineTo 183.9215,1773.991 
      continentsGraphics.lineTo 177.90279,1777.7131 
      continentsGraphics.lineTo 167.13432,1774.4524 
      continentsGraphics.lineTo 164.87601,1772.6108 
      continentsGraphics.lineTo 158.28447,1766.9021 
      continentsGraphics.lineTo 153.14246,1758.6173 
      continentsGraphics.lineTo 155.21241,1745.736 
      continentsGraphics.lineTo 164.98586,1750.5193 
      continentsGraphics.lineTo 176.7144,1761.2042 
      continentsGraphics.lineTo 180.79447,1763.4381 
      continentsGraphics.lineTo 184.2144,1761.3532 
      continentsGraphics.lineTo 193.57513,1762.635 
      continentsGraphics.lineTo 206.3076,1766.7107 
      continentsGraphics.lineTo 220.15012,1765.8511 
      continentsGraphics.lineTo 236.88742,1769.384 
      continentsGraphics.lineTo 241.63742,1772.2618 
      continentsGraphics.lineTo 245.13432,1776.1694 
      continentsGraphics.lineTo 247.65453,1780.2716 
      continentsGraphics.lineTo 252.29874,1777.7723 
      continentsGraphics.lineTo 254.33797,1775.4601 
      continentsGraphics.lineTo 259.13434,1785.0445 
      continentsGraphics.lineTo 259.81964,1789.6128 
      continentsGraphics.lineTo 263.11924,1798.9727 
      continentsGraphics.lineTo 266.83014,1807.9708 
      continentsGraphics.lineTo 273.18394,1823.7589 
      continentsGraphics.lineTo 277.23814,1831.7608 
      continentsGraphics.lineTo 281.03364,1826.7608 
      continentsGraphics.lineTo 283.53364,1809.736 
      continentsGraphics.lineTo 285.88434,1794.8511 
      continentsGraphics.lineTo 288.13434,1791.0643 
      continentsGraphics.lineTo 291.47374,1782.9491 
      continentsGraphics.lineTo 297.68134,1764.9852 
      continentsGraphics.lineTo 301.79044,1758.2608 
      continentsGraphics.lineTo 305.29204,1754.7181 
      continentsGraphics.lineTo 309.25834,1752.873 
      continentsGraphics.lineTo 311.13434,1755.9158 
      continentsGraphics.lineTo 313.35424,1759.4807 
      continentsGraphics.lineTo 319.13434,1770.9723 
      continentsGraphics.lineTo 322.13434,1770.7608 
      continentsGraphics.lineTo 325.61944,1772.5108 
      continentsGraphics.lineTo 328.68784,1779.6019 
      continentsGraphics.lineTo 332.06234,1781.4029 
      continentsGraphics.lineTo 336.08504,1774.3009 
      continentsGraphics.lineTo 333.45774,1752.371 
      continentsGraphics.lineTo 332.68884,1724.1086 
      continentsGraphics.lineTo 331.16494,1706.6086 
      continentsGraphics.lineTo 309.36024,1661.052 
      continentsGraphics.lineTo 304.25564,1656.5227 
      continentsGraphics.lineTo 297.95414,1644.041 
      continentsGraphics.lineTo 293.63434,1633.7164 
      continentsGraphics.lineTo 288.13434,1626.2663 
      continentsGraphics.lineTo 270.19694,1608.2971 
      continentsGraphics.lineTo 252.80749,1598.636 
      continentsGraphics.lineTo 241.67617,1593.8446 
      continentsGraphics.lineTo 233.84432,1588.7849 
      continentsGraphics.lineTo 228.91896,1584.2363 
      continentsGraphics.lineTo 222.57398,1579.235 
      continentsGraphics.lineTo 217.39753,1575.1593 
      continentsGraphics.lineTo 205.50311,1569.2608 
      continentsGraphics.lineTo 198.96235,1567.2918 
      continentsGraphics.lineTo 189.39182,1569.3279 
      continentsGraphics.lineTo 186.36214,1570.6101 
      continentsGraphics.lineTo 179.13432,1573.5379 
      continentsGraphics.lineTo 157.51944,1572.629 
      continentsGraphics.lineTo 151.60527,1575.0233 
      continentsGraphics.lineTo 152.25071,1580.6258 
      continentsGraphics.lineTo 154.15708,1585.1258 
      continentsGraphics.lineTo 155.66385,1591.2608 
      continentsGraphics.lineTo 153.66358,1589.7608 
      continentsGraphics.lineTo 149.81522,1585.9604 
      continentsGraphics.lineTo 142.32222,1586.9401 
      continentsGraphics.lineTo 132.9955,1589.7242 
      continentsGraphics.lineTo 128.5924,1592.2608 
      continentsGraphics.lineTo 123.78711,1595.2608 
      continentsGraphics.lineTo 117.11458,1596.737 
      continentsGraphics.lineTo 121.21154,1590.8145 
      continentsGraphics.lineTo 124.63433,1589.7341 
      continentsGraphics.lineTo 120.45069,1584.9277 
      continentsGraphics.lineTo 112.45069,1582.1877 
      continentsGraphics.lineTo 100.13433,1588.8127 
      continentsGraphics.lineTo 88.634328,1594.9737 
      continentsGraphics.lineTo 75.760118,1602.2937 
      continentsGraphics.lineTo 75.634328,1606.8502 
      continentsGraphics.lineTo 76.634328,1611.6066 
      continentsGraphics.lineTo 75.134328,1616.2287 
      continentsGraphics.lineTo 80.145068,1614.2457 
      continentsGraphics.lineTo 85.079478,1609.7892 
      continentsGraphics.lineTo 88.469158,1605.3367 
      continentsGraphics.lineTo 99.253738,1595.7812 
      continentsGraphics.lineTo 107.86803,1591.6612 
      continentsGraphics.lineTo 102.1956,1598.2018 
      continentsGraphics.lineTo 96.613848,1605.2277 
      continentsGraphics.lineTo 100.69335,1606.2608 
      continentsGraphics.lineTo 104.13433,1608.1538 
      continentsGraphics.lineTo 98.651318,1611.2608 
      continentsGraphics.lineTo 94.266828,1614.7608 
      continentsGraphics.lineTo 89.693738,1618.2608 
      continentsGraphics.lineTo 85.612108,1621.3038 
      continentsGraphics.lineTo 74.580918,1625.7058 
      continentsGraphics.lineTo 67.384328,1625.3053 
      continentsGraphics.lineTo 65.134328,1623.8828 
      continentsGraphics.lineTo 67.384328,1620.9781 
      continentsGraphics.lineTo 68.339638,1618.1115 
      continentsGraphics.lineTo 63.839638,1620.4176 
      continentsGraphics.lineTo 56.728224,1624.6247 
      continentsGraphics.lineTo 50.228224,1627.6195 
      continentsGraphics.lineTo 29.720325,1636.6773 
      continentsGraphics.lineTo 24.966535,1640.9968 
      continentsGraphics.lineTo 17.674204,1654.7608 
      continentsGraphics.lineTo 14.181844,1658.7608 
      continentsGraphics.lineTo 8.6894039,1655.8128 
      continentsGraphics.lineTo 2.8001939,1653.3128 
      continentsGraphics.lineTo 0.38318606,1658.2608 
      continentsGraphics.lineTo 5.4329761,1664.8845 
      continentsGraphics.lineTo 11.162896,1679.0816 
      continentsGraphics.lineTo 6.6557961,1683.2608 
      continentsGraphics.lineTo 5.1945639,1675.2608 
      continentsGraphics.lineTo 14.811634,1667.2608 
      continentsGraphics.lineTo 19.396405,1664.5108 
      continentsGraphics.lineTo 27.451115,1661.5478 
      continentsGraphics.lineTo 35.634325,1661.0478 
      continentsGraphics.lineTo 38.634325,1660.7608 
      continentsGraphics.lineTo 38.295425,1667.3284 
      continentsGraphics.lineTo 40.545424,1676.9728 
      continentsGraphics.lineTo 43.134324,1681.6552 
      continentsGraphics.lineTo 45.134324,1683.2608 
      continentsGraphics.lineTo 47.134324,1682.9332 
      continentsGraphics.lineTo 44.634324,1676.4531 
      continentsGraphics.lineTo 44.723214,1659.3375 
      continentsGraphics.lineTo 50.439654,1662.6276 
      continentsGraphics.lineTo 54.498414,1674.7452 
      continentsGraphics.lineTo 56.516534,1684.5947 
      continentsGraphics.lineTo 57.743064,1695.3511 
      continentsGraphics.lineTo 58.599324,1699.4202 
      continentsGraphics.lineTo 62.598198,1699.9563 
      continentsGraphics.lineTo 62.928618,1694.5268 
      continentsGraphics.lineTo 68.278118,1686.4394 
      continentsGraphics.lineTo 75.134328,1696.3118 
      continentsGraphics.lineTo 76.712308,1705.6959 
      continentsGraphics.lineTo 84.277348,1708.7154 
      continentsGraphics.lineTo 89.657108,1709.843 
      continentsGraphics.lineTo 97.045928,1710.4054 
      continentsGraphics.lineTo 100.77145,1731.814 
      continentsGraphics.lineTo 87.939958,1739.6826 
      continentsGraphics.lineTo 76.838528,1739.1312 
      continentsGraphics.lineTo 59.345414,1730.5447 
      continentsGraphics.lineTo 51.817914,1726.2608 
      continentsGraphics.lineTo 45.134324,1732.1175 
      continentsGraphics.lineTo 36.836575,1734.9779 
      continentsGraphics.lineTo 31.897185,1730.9633 
      continentsGraphics.lineTo 27.084895,1725.1639 
      continentsGraphics.lineTo 22.131825,1719.4446 
      continentsGraphics.lineTo 17.807104,1714.1097 
      continentsGraphics.lineTo 18.716104,1706.5937 
      continentsGraphics.lineTo 19.152435,1694.2705 
      continentsGraphics.lineTo 13.402434,1693.3304 
      continentsGraphics.lineTo 4.8445839,1692.2664 
      continentsGraphics.lineTo 1.1881861,1692.1135 
      continentsGraphics.lineTo 11.197556,1693.2229 
      continentsGraphics.lineTo -14.750586,1691.3186 
      continentsGraphics.lineTo -19.920496,1694.7977 
      continentsGraphics.lineTo 30.840836,1707.1917 
      continentsGraphics.lineTo 38.547586,1715.2275 
      continentsGraphics.lineTo 49.427996,1731.2562 
      continentsGraphics.lineTo 52.456086,1744.7562 
      continentsGraphics.lineTo 54.770986,1761.7608 
      continentsGraphics.lineTo 45.574946,1814.099 
      continentsGraphics.lineTo 36.290046,1826.766 
      continentsGraphics.lineTo 30.416956,1831.1778 
      continentsGraphics.lineTo 25.661516,1832.2608 
      continentsGraphics.lineTo 10.610306,1842.346 
      continentsGraphics.lineTo 2.9865961,1849.6995 
      continentsGraphics.lineTo 6.5557239,1867.19 
      continentsGraphics.lineTo 8.2197939,1875.1276 
      continentsGraphics.lineTo 17.134324,1886.7918 
      continentsGraphics.lineTo 37.134325,1916.7143 
      continentsGraphics.lineTo 66.169558,1940.6377 
      continentsGraphics.lineTo 88.169558,1948.6984 
      continentsGraphics.lineTo 88.6879,1950.8501 


      continentsGraphics.moveTo 154.1796,1711.8154  
      continentsGraphics.lineTo 149.46393,1708.7541 
      continentsGraphics.lineTo 147.21393,1697.2877 
      continentsGraphics.lineTo 146.91674,1691.7877 
      continentsGraphics.lineTo 138.13432,1678.9668 
      continentsGraphics.lineTo 137.13432,1675.7608 
      continentsGraphics.lineTo 141.6284,1665.7239 
      continentsGraphics.lineTo 149.3784,1660.9939 
      continentsGraphics.lineTo 152.63432,1671.2608 
      continentsGraphics.lineTo 150.17403,1673.4861 
      continentsGraphics.lineTo 160.83634,1684.6662 
      continentsGraphics.lineTo 164.69517,1687.994 
      continentsGraphics.lineTo 164.28463,1692.077 
      continentsGraphics.lineTo 163.64189,1696.6506 
      continentsGraphics.lineTo 167.48288,1711.3123 
      continentsGraphics.lineTo 161.08653,1712.8366 
      continentsGraphics.lineTo 161.1796,1711.8154 


      continentsGraphics.moveTo 112.34088,1690.5265  
      continentsGraphics.lineTo 104.45134,1687.7012 
      continentsGraphics.lineTo 92.634328,1686.7897 
      continentsGraphics.lineTo 81.151108,1684.7781 
      continentsGraphics.lineTo 77.775548,1681.2954 
      continentsGraphics.lineTo 81.049718,1674.7797 
      continentsGraphics.lineTo 88.876608,1664.2565 
      continentsGraphics.lineTo 93.429328,1660.249 
      continentsGraphics.lineTo 96.531828,1662.0671 
      continentsGraphics.lineTo 99.634328,1665.9827 
      continentsGraphics.lineTo 102.42084,1666.1189 
      continentsGraphics.lineTo 110.38433,1659.8459 
      continentsGraphics.lineTo 112.5828,1665.3605 
      continentsGraphics.lineTo 114.4009,1673.1909 
      continentsGraphics.lineTo 124.13433,1685.9962 
      continentsGraphics.lineTo 118.38433,1691.0861 
      continentsGraphics.lineTo 118.34088,1690.5265 


      continentsGraphics.moveTo 144.52942,1951.3765  
      continentsGraphics.lineTo 159.12532,1934.0108 
      continentsGraphics.lineTo 154.09923,1934.9438 
      continentsGraphics.lineTo 146.27251,1938.7982 
      continentsGraphics.lineTo 141.30424,1942.8653 
      continentsGraphics.lineTo 138.94947,1947.9368 
      continentsGraphics.lineTo 137.58857,1951.1868 
      continentsGraphics.lineTo 137.52942,1951.3765 


      continentsGraphics.moveTo 287.73534,1834.7142  
      continentsGraphics.lineTo 286.77504,1831.3441 
      continentsGraphics.lineTo 286.09624,1837.2608 
      continentsGraphics.lineTo 286.73534,1834.7142 


      continentsGraphics.moveTo 41.716664,1627.6149  
      continentsGraphics.lineTo 48.134324,1617.0066 
      continentsGraphics.lineTo 42.134324,1620.842 
      continentsGraphics.lineTo 36.800995,1628.5941 
      continentsGraphics.lineTo 36.716664,1627.6149 


      continentsGraphics.moveTo 40.134324,1616.7608  
      continentsGraphics.lineTo 40.982954,1614.2608 
      continentsGraphics.lineTo 37.134325,1616.7608 
      continentsGraphics.lineTo 36.285695,1619.2608 
      continentsGraphics.lineTo 36.134324,1616.7608 


      continentsGraphics.moveTo 55.692254,1606.4854  
      continentsGraphics.lineTo 49.134324,1613.2644 
      continentsGraphics.lineTo 52.754654,1610.5826 
      continentsGraphics.lineTo 52.692254,1606.4854 


      continentsGraphics.moveTo 76.134328,1584.2608  
      continentsGraphics.lineTo 75.134328,1583.2608 
      continentsGraphics.lineTo 74.134328,1584.2608 
      continentsGraphics.lineTo 75.134328,1585.2608 
      continentsGraphics.lineTo 75.134328,1584.2608 


      continentsGraphics.moveTo 148.13432,1581.7608  
      continentsGraphics.lineTo 146.34932,1580.7125 
      continentsGraphics.lineTo 147.13432,1582.7608 
      continentsGraphics.lineTo 148.91932,1583.8091 
      continentsGraphics.lineTo 148.13432,1581.7608 

      continentsGraphics.moveTo 65.634328, 1578.0629 
      continentsGraphics.lineTo 90.634328, 1574.3466 
      continentsGraphics.lineTo 103.13433, 1571.9096 
      continentsGraphics.lineTo 119.38433, 1567.6977 
      continentsGraphics.lineTo 131.13432, 1564.212 
      continentsGraphics.lineTo 118.67377, 1563.9837 
      continentsGraphics.lineTo 104.67377, 1566.7756 
      continentsGraphics.lineTo 60.634328, 1577.7668 
      continentsGraphics.lineTo 60.34328, 1578.0629 


      continentsGraphics.endFill()

      continentsGraphics.scale = new PIXI.Point 1/21, 1/21
      continentsGraphics.position = new PIXI.Point -8,-84
      graphics.addChild continentsGraphics