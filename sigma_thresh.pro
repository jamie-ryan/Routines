;returns pixel coordinates containing values
;above the standard deviation threshold set by the user
function sigma_thresh, $
array, $
sigma_thresh, $
;ptf = ptf, $
outfile = outfile

sigma = stddev(array)
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
