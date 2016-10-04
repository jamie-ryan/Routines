pro leg_end, labels = labels, coords = coords, linestylee = linestylee, box_colour = box_colour, line_colour = line_colour, text_colour = text_colour, char_size = char_size

;a manual legend drawing procedure based on legend.pro but resizable fo ladder plots
;legend, ['518.50, 264.00', '519.00, 262.00','519.70, 263.20','520.81, 264.91','523.39, 265.13', '511.00, 269.00'],linestyle = 0,color = [0,2,4,6,8, 10]

;labels = an array containing strings for labelling the lgened contents, i.e, labels = ['a', 'b', 'c'] 
;baset = base time for outplot
;coords = an array containing plot coords for legend box corners, i.e., coords = [x0, xf, y0, yf]
;linestylee = an array containing linestyle numbers
;box_colour = an array containing color numbers for the legend box (using linecolors)
;line_colour = an array containing color numbers for the lines inside the legend box (using linecolors)
;text_colour = an array containing color numbers for the text inside the legend box (using linecolors)
linecolors

;number of labels
nlb = n_elements(labels)

;legend box height
boxheight = coords[3] - coords[2]

;legend box width
boxwidth = coords[1] - coords[0]

;divide box height into number of labels
linespace = boxheight/nlb

;character size for xyouts, based on space available in box
chsz = linespace*0.8

;relative starting position of lines inside legend 
startline_relpos = 0.1

;relative end posuition of lines inside legend box
endline_relpos = 0.3


;draw black legend box '29-Mar-14 '+['17:30:00','17:53:00']
outplot, [coords[0], coords[1] + 240.], [coords[3] + 0.05*coords[3],  coords[3] + 0.05*coords[3]], linestyle = 0, color = box_colour ;top
outplot, [coords[0], coords[1] + 240.], [coords[2],  coords[2]], linestyle = 0, color = box_colour ;bottom
outplot, [coords[0], coords[0]], [coords[2],  coords[3]+ 0.05*coords[3]], linestyle = 0, color = box_colour ;left
outplot, [coords[1] + 240., coords[1] + 240.], [coords[2],  coords[3]+ 0.05*coords[3]], linestyle = 0, color = box_colour ;right

;loop through and oplot lines and labels inside legend box
for i = 0, nlb - 1 do begin
xyouts, coords[1] - 210.,[coords[3] - i*linespace - linespace/2., coords[3] - i*linespace - linespace/2.] , charsize = char_size ,labels[i]
;xyouts, (coords[1] - 0.15*coords[1]), coords[3] - (i+1)*linespace/2, charsize = 0.5,labels[i], /norm
;xyouts, (coords[1] - endline_relpos*coords[1])/2., coords[3] - (i+1)*linespace/2.,labels[i], charsize = chsz, color = text_colour[i], /norm
;[coords[3] - (i+1)*linespace/2., coords[3] - (i+1)*linespace/2.]
outplot, [coords[0] + 10., coords[1] - 240.], [coords[3] - i*linespace - linespace/2., coords[3] - i*linespace - linespace/2.], linestyle = linestylee[i], color = line_colour[i]
endfor

end
