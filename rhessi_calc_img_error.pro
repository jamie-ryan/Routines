
;+

;function hsi_calc_image_error,imagein,iobjin, $
function rhessi_calc_img_error,imagein,iobjin, $
                              alg_used=alg_used,algunit=algunit, $
                              pixonmap=pixonmap,pixon_sizes=pixon_sizes, $
                              use_annsec2xy=use_annsec2xy,verbose=verbose, timg

;NAME:
;     HSI_CALC_IMAGE_ERROR
;PURPOSE:
;     Calculates the one sigma errors for a RHESSI image
;CATEGORY:
;CALLING SEQUENCE:
;     error = hsi_calc_image_error(image,iboj)
;INPUTS:
;     image = 2D array containing the image
;     iobj = image object for the image
;OPTIONAL INPUT PARAMETERS:
;KEYWORD PARAMETERS
;     /verbose = Plot residuals, etc.
;OUTPUTS:
;     error = 1 sigma error for each image pixel
;COMMON BLOCKS:
;SIDE EFFECTS:
;RESTRICTIONS:
;     The errors represent only the statistical errors for the
;     particular image reconstruction provided to this code.  There
;     are systematic errors due to selection of the particular
;     reconstruction that are not a priori known.  They could be
;     estimated by comparing reconstructions using alternate
;     algorithms, but are not included here.
;PROCEDURE:
;MODIFICATION HISTORY:
;     T. Metcalf  2002-Nov-12
;     T. Metcalf  2002-Nov-18 Fixed units problem.
;     T. Metcalf  2003-Dec-19 Require image to be passed in.
;     T. Metcalf  2004-Jan-05 Added /verbose keyword.
;     T. Metcalf  2004-Jan-06 Added MEMVIS kludge.
;     T. Metcalf  2004-May-12 Clone iobj to protect it from change.
;-

   if n_params() LT 2 then $
      message,'Sorry, but the calling sequence for hsi_calc_image_error '+$
              'has changed : err = hsi_calc_image_error(image,object)'

   iobj = clone_var(iobjin)  ; protect from change
   image = imagein ; protect from change

   ; copied annsec logic from hsi_image__define::getdata()
   if NOT keyword_set(alg_used) then alg_used = iobj->get(/algorithm_used) 
   annsecalg=['HSI_BPROJ','HSI_CLEAN','HSI_PIXON','HSI_MEM_SATO','HSI_FORWARDFIT']
   if n_elements(use_annsec2xy) LE 0 then  $
      use_annsec2xy = grep(alg_used[0], annsecalg) eq alg_used[0]
   if use_annsec2xy then image = hsi_xy2annsec(image,iobj)

   ; Get relevant units.  The input to hsi_image error must be in 
   ; the units used by the pixon algorithm, but the final output
   ; should be in the final image units.
   pixonalgunit = hessi_constant(/detector_area) * $
                (iobj->get(/info, /cbe_det_eff)).avg   ; Pixon alg unit
   ;if NOT keyword_set(algunit) then algunit = iobj->get(/alg_unit)
   ; Back projection is a special case since it has funny units
   if alg_used[0] EQ 'HSI_BPROJ' then dirty_norm = hsi_dirty_norm(iobj,/polar) $
   else dirty_norm = 1.0

   ; The Pixon algorithm is a special case since adjacent pixels are not
   ; necessarily independent.
   if alg_used[0] EQ 'HSI_PIXON' then begin
      if NOT keyword_set(pixonmap) then pixonmap = iobj->get(/pixonmap)
      if NOT keyword_set(pixon_sizes) then pixon_sizes = iobj->get(/pixon_sizes)
   endif

   if alg_used[0] EQ 'HSI_MEMVIS' then begin
      ; The MEMVIS algorithm will cause the code to crash so we
      ; have to trick it into thinking we are using back projection
      ; and, in particular, annular sectors.
      iobj->set,image_algorithm='back'
      iobj->set,algorithm_used='HSI_BPROJ'
      iobj->setnoupdate
      image = hsi_xy2annsec(image,iobj)
   endif

;   ierror = hsi_image_error(iobj,image*pixonalgunit/dirty_norm, $
   ierror = rhessi_img_error(iobj,image*pixonalgunit/dirty_norm, $
                          pixonmap=pixonmap,/poisson, $
                          pixon_sizes=pixon_sizes,verbose=verbose, $
                          algunit=pixonalgunit, alg_used=alg_used[0])*dirty_norm, timg

   if alg_used[0] EQ 'HSI_MEMVIS' then begin
      ; Now clean up the MEMVIS kludge.
      ierror = HSI_Annsec2XY( ierror, iobj )
      iobj->set,image_algorithm='memvis'
      iobj->set,algorithm_used='HSI_MEMVIS'
      iobj->setnoupdate
   endif

   return,ierror


end
