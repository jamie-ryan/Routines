rhessi_master

;;;;;;;rhessi_img
;;;pre create auto_rhessi_img.pro... see existing
;spawn, 'bsidl.sh auto_rhessi_img.pro auto_rhessi_img.log'
;or run from csh: bsidl.sh auto_rhessi_img.pro auto_rhessi_img.log

;probably needto check input sav files in rhessi_produce*
rhessi_produce_spectra
rhessi_produce_lightcurves
end
