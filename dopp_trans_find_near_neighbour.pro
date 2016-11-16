pro dopp_trans_find, img, dopptrans

maxi = max(img)
mini = min(img)
sd = (maxi - (mini + ((maxi - mini)/2)))/9
;sd = stddev(img)
sweep = fltarr(10)
colors = strarr(10)
colors[0] = 'green'
colors[1] = 'lime green'
colors[2] = 'chartreuse'
colors[3] = 'green yellow'
colors[4] = 'yellow'
colors[5] = 'goldenrod'
colors[6] = 'orange'
colors[7] = 'orange red'
colors[8] = 'red'
colors[9] = 'dark red'

;;;ten sweeps
plot_image, img 
;for i = 9, 0, -1 do begin
;print, i
;	thresh = maxi - i*sd
;	findtrans = where(img gt thresh, ind)
;	if (findtrans[0] gt -1) then begin 
;		sweep[i] = 1.
;		loc = array_indices(img, findtrans)
				
;		tvcircle, 3., loc[0,*], loc[1,*], color = colors[i]   
;	endif else begin 
;	sweep[i] = 0. 
;	endelse
;endfor

;case select to setup number of sweeps

case 1 of
	(maxi - 9*sd lt mini) and (maxi - 8*sd gt mini): swp = 8
	(maxi - 8*sd lt mini) and (maxi - 7*sd gt mini): swp = 7
	(maxi - 7*sd lt mini) and (maxi - 6*sd gt mini): swp = 6
	(maxi - 6*sd lt mini) and (maxi - 5*sd gt mini): swp = 5
	(maxi - 5*sd lt mini) and (maxi - 4*sd gt mini): swp = 4
	(maxi - 4*sd lt mini) and (maxi - 3*sd gt mini): swp = 3
	(maxi - 3*sd lt mini) and (maxi - 2*sd gt mini): swp = 2
	(maxi - 2*sd lt mini) and (maxi - 1*sd gt mini): swp = 1
	(maxi - 1*sd lt mini) and (maxi - 0*sd gt mini): swp = 0
	else: swp = 9
endcase

for i = swp, 0, -1 do begin
	thresh = maxi - i*sd
	findtrans = where(img gt thresh, ind)
	if (findtrans[0] gt -1) then begin 
		sweep[i] = 1.
		loc = array_indices(img, findtrans)
		if (i eq swp) then dopptrans = loc else $
		dopptrans = [[dopptrans], [loc]]		
		tvcircle, 3., loc[0,*], loc[1,*], color = colors[i]   
	endif else begin 
	sweep[i] = 0. 
	endelse
endfor
end
