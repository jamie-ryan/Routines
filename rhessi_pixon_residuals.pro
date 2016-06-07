
;+

function rhessi_pixon_residuals,image,dobj,ceobj,a2d,harmonics, $
                             modprofile=modprofile,sspatt=sspatt, $
                             noresidual=noresidual,setunits=setunits, $
                             nounits=nounits,background=bobj, $
                             cbe_ptr = cbe_ptr, $
                             map_ptr = map_ptr, $
                             time_unit = time_unit, $
;                             time_bin = time_bin,$
                             time_bin_sec = time_bin_sec,$
                             det_eff = det_eff

;NAME:
;     hsi_pixon_residuals
;PURPOSE:
;     compute the data residuals for an image
;CATEGORY:
;CALLING SEQUENCE:
;     residuals = hsi_pixon_residuals(image,dobj,ceobj,a2d,harmonics)
;INPUTS:
;     First five parameters have been extracted from IOBJ to reduce object overhead
;      cbe_ptr = calib_eventlist pointer array
;      map_ptr = modpat pointer array
;      time_unit = multiplier on time_bin, number of binary microseconds
;      time_bin =  - number of time_units for each bin for each detector, 9 element vector
;      det_eff = cbe_det_eff extracted from object
;     image = the image. fltarr(nx*ny)
;     dobj = pixon data object, array of pointers, [27,5]
;     ceobj = modulation pattern object
;     a2d = list of valid a2d's from hsi_pixon_get_data
;     harmonics = list of valid harmonics from hsi_pixon_get_data
;OPTIONAL INPUT PARAMETERS:
;KEYWORD PARAMETERS
;     modprofile = returns with the reconstructed data.
;                  residuals = data-modprofile.
;     sspatt = index array giving the image pixels used if an image subset is
;              being passed in.
;     /noresidual = return the modulation profile rather than the residual.
;                   this is slightly faster than using the modprofile keyword
;                   since the residual is never computed in this case.
;OUTPUTS:
;     residuals = vector of residuals, [nd]
;COMMON BLOCKS:
;SIDE EFFECTS:
;RESTRICTIONS:
;PROCEDURE:
;MODIFICATION HISTORY:
;     T. Metcalf 1999-Dec-09
;     19-jun-2002, ras, protect against division by 0 in computation of nunits
;     R Schwartz 2015-Jan-16- Extensively edited to pass cbe_ptr, map_ptr, det_eff, time_unit, time_bins
;       directly into hsi_annsec_bproj and not the object to bypass object overhead. Removed dead code bloat.
;       removed references to harmonics, they are used to compute profiles but all the info is in the mpat_ptr
;-

   common hsi_pixon_residuals_private,units,nunits

   setup = 1  ; flag to check if need to set up arrays
   setupunits = 1

   if n_elements(units) LE 0 then begin
      szdobj = size(dobj)
      
      units = ptrarr(szdobj[1])
   endif
   if n_elements(nunits) LE 0 then begin
      szdobj = size(dobj)
      nunits = ptrarr(szdobj[1])
   endif
   for i=0,n_elements(a2d)-1 do begin
      
      
         if NOT keyword_set(noresidual) then fobs = *dobj[a2d[i]]
         ; Next lines adjust units, but this should not be done here???
         ; I think these corrections should be applied to the modulation
         ; patterns when they are calculated.
         if keyword_set(setunits) OR $
           ((NOT ptr_valid(units[a2d[i]]))) OR $
           ((NOT ptr_valid(nunits[a2d[i]])))then begin
            if setupunits then begin
;               time_bin_sec = time_bin / 2.0^20
               cbe_ptr = max( ptr_valid( cbe_ptr )) ? cbe_ptr : ceobj->GetData(class_name='hsi_calib_eventlist')
               setupunits = 0
               message,/info,'Resetting units'
            endif
           qtrans = (*cbe_ptr[a2d[i]]).gridtran
            det_index_mask=ceobj->get(/det_index_mask)
            test = where( det_index_mask, ndet)
            ; Since hsi_annsec_profile applies some units we have to
            ; counteract this if /nounits is set.
            nunits[a2d[i]] = $
               ptr_new(f_div( 1.0,(time_bin_sec[a2d[i] MOD 9] * qtrans * $
                       (*cbe_ptr[a2d[i]]).livetime * $
                       ((*cbe_ptr[a2d[i]]).flux_var) * $
                        det_eff.rel[a2d[i] MOD 9])))

            units[a2d[i]] = ptr_new(1.)
         endif

         mtemp = hsi_annsec_profile(image, $
                                    ceobj, $
                                    this_det=a2d[i], $                                  
                                    map_ptr = map_ptr, $
                                    cbe_ptr = cbe_ptr, $
                                    time_unit = time_unit, $
                                    wnz = wnz, $
                                    det_eff = det_eff.rel, $
                                    time_bin = time_bin)
         if keyword_set(nounits) then begin
            mtemp = mtemp * (*nunits[a2d[i]])
         endif else begin
            mtemp = mtemp * (*units[a2d[i]])
         endelse
         ; Account for background
         if keyword_set(bobj) then begin
            if ptr_valid(bobj[a2d[i]]) then begin
               mtemp = mtemp + (*bobj[a2d[i]])
            endif
         endif
         if NOT keyword_set(noresidual) then begin
            rtemp = mtemp - fobs
            ;bad = where(fobs LE 0.1,nbad)   ; Fix the dropouts
            ;if nbad GT 0 then rtemp[bad] = 0.0
         endif
         if setup then begin
            modprofile = mtemp
            if NOT keyword_set(noresidual) then residuals = rtemp
            setup = 0
         endif else begin
            modprofile = [modprofile,mtemp]
            if NOT keyword_set(noresidual) then residuals = [residuals,rtemp]
         endelse
      
   endfor

   if keyword_set(noresidual) then return,modprofile

   return,residuals

end
