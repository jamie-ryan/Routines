pro hmi_ic_plot, time, array, dir, coords = coords, sdstr, flux = flux, energy = energy, power = power

;coords = [x,y]

if keyword_set(flux) then begin 
ang = STRING("305B)
angstrom = '!3' +ang+ '!x'
ytitl = 'Flux [erg s!E-1!N cm!E-2!N sr!E-1!N '+angstrom+'!E-1!N]'
titl = 'Flux'
endif
if keyword_set(energy) then begin
ytitl = 'Energy [erg]'
titl = 'Energy' 
endif
if keyword_set(power) then begin
ytitl = 'Power [erg s!E-1!N]'
titl = 'Power'
endif
;convert coords to strings
stcoords = string(coords, format = '(F0.2)')

;extract string from time 29-Mar-2014 17:38:46.600
t1 = time[0]
t2 = strcompress(strmid(time[-1],12), /remove_all)
t3 = t1+' - '+t2

!p.thick=2 ;data
!x.thick=2 ;x axis
!y.thick=2 ;y axis

;-------
;setup for postscript or eps output
;-------
flnm = dir+'IC_'+titl+'_'+sdstr+'sd_'+stcoords[0]+'_'+stcoords[1]+'.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1

utplot, time, array, title = t3+' '+titl+' Curve  ('+stcoords[0]+'", '+stcoords[1]+'")', ytitle = ytitl, charsize = 0.5

device,/close
set_plot,'x'
!p.font=-1 
end
