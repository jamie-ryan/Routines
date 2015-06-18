function energy_func, Fluxarray, wave

nnn = n_elements(Fluxarray)


if (wave eq 1400) then lambda = 1.4e-7 else $

if (wave eq 2796) then lambda = 2.796e-7 else lambda = 2.832e-7 





;spatial pixel in radians
pixxy = 0.16635000*(!pi/(180.*3600.*6. )) 

;spectral scale pixel in angstroms....nuv = 2796, 2832.....fuv = 1330, 1400
pixfuv = 12.8e-3
pixnuv = 25.6e-3
if (wave eq 1400) then pixlambda = pixfuv else pixlambda = pixnuv


;slit width
Wslit = !pi/(180.*3600.*3.)

;exposure time
texp = 8.0000496

;energy in erg.cm^2
E = Fluxarray*(pixxy*pixlambda*texp*wslit)


return, E
end

