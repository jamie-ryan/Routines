pro rgbct, r=r, g=g, b=b

steps = 200

if keyword_set(r) then begin
red = 255 
scaleFactor = FINDGEN(steps) / (steps - 1)
beginNum = 0
endNum = 0
redVector = REPLICATE(red, steps)
greenVector = beginNum + (endNum - beginNum) * scaleFactor
blueVector = beginNum + (endNum - beginNum) * scaleFactor  
endif

if keyword_set(g) then begin
green = 255
scaleFactor = FINDGEN(steps) / (steps - 1)
beginNum = 0
endNum = 0
redVector = beginNum + (endNum - beginNum) * scaleFactor  
greenVector = REPLICATE(green, steps)
blueVector = beginNum + (endNum - beginNum) * scaleFactor  
endif

if keyword_set(b) then begin
blue = 255
scaleFactor = FINDGEN(steps) / (steps - 1)
beginNum = 0
endNum = 0
redVector = beginNum + (endNum - beginNum) * scaleFactor
greenVector = beginNum + (endNum - beginNum) * scaleFactor
blueVector = REPLICATE(blue, steps)
endif

TVLCT, redVector, greenVector, blueVector

end
