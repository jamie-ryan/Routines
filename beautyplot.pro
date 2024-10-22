pro beautyplot
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Output Device: set to post script 
set_plot,'ps'

xaxis = findgen(10)
xrange = findgen(10)
nxticks = n_elements(xrange)
yaxis1 = findgen(10)*0.1
yrange1 = findgen(10)*0.12
yaxis2 = findgen(10)*0.101
yrange2 = findgen(10)*0.12
nyticks = n_elements(yrange1)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Font: Use TrueType fonts rather than ugly default IDL font
!p.font = 1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Line Thickness: IDL lines a too thin, so increase thickness
!p.thick = 2
!x.thick = 2
!y.thick = 2
!z.thick = 2

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Layout: Plots of equal size with an aspect ratio equal to the golden_ratio = 2d / (1 + sqrt(5)) = 1.61803398875. The width of the figure is 8.8cm because it exactly fits a column in most journals 
golden_ratio =  (1 + sqrt(5)) / 2d
xsize = 8.8

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Margins: 
;-Make margins the same left and bottom. Trial and error has rendered 12% of an 8.8cm plot
margin = 0.12

;-fix distance at top and right of plot
wall = 0.03

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Figure and Plot Size:

;-width of plot in units normalized to an 8.8cm wide figure
a = xsize/xsize - (margin + wall)
;-using the golden ratio, calculate height of plot
b = a / golden_ratio 

;-vertical size of figure
ysize = (margin + b + wall) * xsize

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Plot Positions: compute the corners of the plots in order to instruct IDL to place them exactly where I want them. So far I've worked with units normalized to an 8.8-centimeter wide figure, but IDL can't do that. Therefore calculate the horizontal and vertical coordinates in units normalized to the figure width and height, respectively:
;-as a sanity check, xc and yc should now equal ~1
x1 = margin*8.8/xsize
x2 = x1 + a*8.8/xsize
xc = x2 + wall*8.8/xsize
y1 = margin*8.8/ysize
y2 = y1 + b*8.8/ysize
y3 = y2 + wall*8.8/ysize
y4 = y3 + b*8.8/ysize
yc = y4 + wall*8.8/ysize

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Tick Marks: Set horizontal and vertical tick marks of the plots to have equal length. 
;-The manual is rather cryptic, but it turns out IDL scales the length of a vertical tick mark to the height of the plot, and the horizontal to the width. I keep my ticks the same length, irrespective of the size of the figure:
ticklen = 0.01
xticklen = ticklen/b
yticklen = ticklen/a

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Plotting Data: 
;-open output file, postscript output of specific size, TrueType fonts, font size = 10
;-bits_per_pixel=8 If plotting an image, to enable a sufficient number of shades of gray 
;-/color to enable colors.
device, filename='output.eps', /encapsulated, xsize=xsize, ysize=ysize, $
/tt_font, set_font='Times', font_size=10

;-next create the frame for the first plot using the position keyword to control where it will end up
plot, xrange, yrange1, /nodata, /noerase, position=[x1,y1,x2,y2], $
xtitle='xtitle', ytitle='ytitle', $
xminor=1, yminor=1, xticklen=xticklen, yticklen=yticklen, $
xticks=nxticks, xtickv=xtickvalues, yticks=nyticks, ytickv=ytickvalues

;-now plot the data. 
oplot, xaxis, yaxis1

;-next create the frame for the second plot. In this case we don't want annotations on the x-axis
plot, xrange, yrange2, /nodata, /noerase, position=[x1,y3,x2,y4], $
ytitle='ytitle', $
xminor=1, yminor=1, xticklen=xticklen, yticklen=yticklen, $
xticks=nxticks, xtickv=xtickvalues, yticks=nyticks, ytickv=ytickvalues, $
xtickname=replicate(' ',nxticks+1)

;-The only way to suppress the tick names is by setting them to spaces with the {x|y|z}tickname keyword. It's also possible, but perhaps less elegant, to use xtickname=replicate(' ',60). It appears that 60 is the maximum number of tick marks, so this should suppress tick labels in all cases. 

;-Now plot the data:
oplot, xaxis, yaxis2

;Finishing up: Close the output file and set the device back to screen
device, /close
set_plot, 'x'
end
