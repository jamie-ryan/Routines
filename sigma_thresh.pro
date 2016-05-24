;returns pixel coordinates containing values
;above the standard deviation threshold set by the user
function sigma_thresh, $
array, $
sigma_thresh, $
;ptf = ptf, $
outfile = outfile

sigma = stddev(array)

;calculte max possible sigma_thresh
stmax = max(array)/sigma

;check user input
if (sigma_thresh gt stmax) then begin
ust = string(sigma_thresh, format = '(I0)') 
stm = string(stmax, format = '(I0)')
message, 'Your sigma threshold value of '+ust+' is too large, maximum signal is '+stm+' times the standard deviation.'
endif

thresh = where(array gt sigma_thresh*sigma, tmp)
flagged_pixel_locations = array_indices(array, thresh)

;print to file
;if keyword_set(pft)
openw, lun, outfile, /get_lun
printf, lun, flagged_pixel_locations
free_lun, lun
;endif

return, flagged_pixel_locations
end
