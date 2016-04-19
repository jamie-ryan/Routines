pro rgbct, r=r, g=g, b=b

if keyword_set(r) then begin
red = 255 
green = 0
blue = 0
endif
if keyword_set(g) then begin
red = 0
green = 255
blue = 0
endif
if keyword_set(b) then begin
red = 0
green = 0 
blue = 255
endif


vector = beginNum + (endNum - beginNum) * scaleFactor
beginNum = 10.0
endNum = 20.0
steps = 5
scaleFactor = FINDGEN(steps) / (steps - 1)

steps = 200

redVector = REPLICATE(red, steps)
blueVector = REPLICATE(blue, steps)

scaleFactor = FINDGEN(steps) / (steps - 1)
beginNum = green
endNum = 0
greenVector = beginNum + (endNum - beginNum) * scaleFactor  
TVLCT, redVector, greenVector, blueVector

end
