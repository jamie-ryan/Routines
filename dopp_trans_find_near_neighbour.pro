pro dopp_trans_find, img

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
for i = 9, 0, -1 do begin
print, i
	thresh = maxi - i*sd
	findtrans = where(img gt thresh, ind)
	if (findtrans[0] gt -1) then begin 
		sweep[i] = 1.
		loc = array_indices(img, findtrans)
				
		tvcircle, 3., loc[0,*], loc[1,*], color = colors[i]   
	endif else begin 
	sweep[i] = 0. 
	endelse


endfor
end
