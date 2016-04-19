;make black to r, g or blue colour table
pro rgbct, r=r, g=g, b=b

steps = 255.5
scaleFactor = FINDGEN(steps) / (steps - 1)

if keyword_set(r) then begin
;red goes from 0 to 255
beginNum = 0
endNum = 255
redVector = beginNum + (endNum - beginNum) * scaleFactor
;rest 0 to 0
beginNum = 0
endNum = 0
greenVector = beginNum + (endNum - beginNum) * scaleFactor
blueVector = beginNum + (endNum - beginNum) * scaleFactor  
endif

if keyword_set(g) then begin
;green 0 to 255
beginNum = 0
endNum = 255
greenVector = beginNum + (endNum - beginNum) * scaleFactor 
;rest 0 to 0 
beginNum = 0
endNum = 0
redVector = beginNum + (endNum - beginNum) * scaleFactor  
blueVector = beginNum + (endNum - beginNum) * scaleFactor  
endif

if keyword_set(b) then begin
;blue 0 to 255
beginNum = 0
endNum = 255
blueVector = beginNum + (endNum - beginNum) * scaleFactor
;rest 0 to 0
beginNum = 0
endNum = 0
redVector = beginNum + (endNum - beginNum) * scaleFactor
greenVector = beginNum + (endNum - beginNum) * scaleFactor
blueVector = REPLICATE(blue, steps)
endif

TVLCT, redVector, greenVector, blueVector

end
