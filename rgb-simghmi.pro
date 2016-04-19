pro rgb-simghmi
restore, '/unsafe/jsr2/iris-16-03-15.sav'
restore, '/unsafe/jsr2/hmi-submaps-for-movies.sav'

red_image = map1400[498].data
green_image = map2832[166].data
blue_image = shmidf[28].data

rgbimage, red_image, green_image, blue_image
end
