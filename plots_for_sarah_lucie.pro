

restore, '/unsafe/jsr2/Oct7-2016/balm_simple_Oct7-2016_raw_variables.sav'

bk = 170.0

!p.font=0			;use postscript fonts
set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename= '/unsafe/jsr2/Oct7-2016/balm_rawdata.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
utplot, obs_times[3,*], rawdat[*, 43, 447, 3], title = 'Raw data', ytitle = 'DN', charsize = 0.5
device,/close
set_plot,'x'



a = fltarr(nfiles, nwav, ypix, xpix)
for i = 0, nfiles - 1 do begin
for j = 0, xpix - 1 do begin

endfor
endfor

!p.font=0			;use postscript fonts
set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename= '/unsafe/jsr2/Oct7-2016/balm_rawdata_expnorm.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
utplot, obs_times[3,*], a[*, 43, 447, 3], title = 'Raw data exposure normalised', ytitle = 'DN/s', charsize = 0.5
device,/close
set_plot,'x'





!p.font=0			;use postscript fonts
set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename= '/unsafe/jsr2/Oct7-2016/balm_corrwave.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
utplot, obs_times[3,*], corrdat[*, 43, 447, 3], title = 'Corrected wavelength shifts', ytitle = 'DN', charsize = 0.5
device,/close
set_plot,'x'




!p.font=0			;use postscript fonts
set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename= '/unsafe/jsr2/Oct7-2016/balm_corrwave_wavesum.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
utplot, obs_times[3,*], alldat[3, 447, *], title = 'Corrected wavelength shifts. Summed over Balmer range', ytitle = 'DN', charsize = 0.5
device,/close
set_plot,'x'


!p.font=0			;use postscript fonts
set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename= '/unsafe/jsr2/Oct7-2016/balm_corrwave_wavesum_expnorm.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
utplot, obs_times[3,*], alldat_exp_weighted[3, 447, *], title = 'Corrected wavelength shifts. Summed over Balmer range. Exposure normalised', ytitle = 'DN/s', charsize = 0.5
device,/close
set_plot,'x'


!p.font=0			;use postscript fonts
set_plot, 'ps'
;    @symbols_ps_kc		;load string symbols and greek letters for Postscript
device, filename= '/unsafe/jsr2/Oct7-2016/balm_corrwave_wavesum_expnorm_bksub.eps', encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
utplot, obs_times[3,*], alldat_exp_weighted[3, 447, *] - bk, title = 'Corrected wavelength shifts. Summed over Balmer range. Exposure normalised. Background subtracted.', ytitle = 'DN', charsize = 0.5
device,/close
set_plot,'x'




