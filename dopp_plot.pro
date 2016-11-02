pro dopp_plot, time, array, dir, coords = coords

;coords = [x,y]

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
flnm = '/unsafe/jsr2/project2/'+dir+'/HMI/v/Dopp_Trans_'+stcoords[0]+'_'+stcoords[1]+'.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1

utplot, time, array, title = t3+' Doppler Velocity ('+stcoords[0]+'", '+stcoords[1]+'")', ytitle = 'm/s', charsize = 0.5

device,/close
set_plot,'x'
!p.font=-1 
end
