function manyplots, n_plots

;x axis range = 0.15 to 0.9...constant
;y axis range = 0.15 to 0.9


yplotlength = (0.90 - 0.15) / n_plots ;calculates yplot position increments based on number of plots 

;xplotpos = [0.15, 0.9] ;contains position coordiuntaes [x0,x1]
yplotpos = fltarr(2,n_plots) ;contains position coordinates in the form [y0,y1]


for i = 0, n_plots - 1 do begin ;loop to fill yplotpos

	yplotpos[0,i] = 0.15 + i*yplotlength ; y0
	yplotpos[1,i] = 0.15 + yplotlength + i*yplotlength ; y1

endfor

;TESTED LOOP RESULTS...
;IDL> print, yplotpos[0,*]               
;     0.150000
;     0.525000....should be 0.500000 therefore may need to subtract 0.025 from y0's after the first value
;IDL> print, yplotpos[1,*]
;     0.525000
;     0.900000

return, yplotpos

end
