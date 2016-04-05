;Function to make .png images from maps. 
;
;
;INPUT:
;file_string = a string identifying the data set to be used in the output png file name
;map = map structure to be converted to png
;colour = loadct color table number
;thresh = an array conaining dmin and dmax values for plot_map
;log = include /log for plot_map, /log 
;
;OUTPUT:
;png images named from 1 to x. 
;Stored in /unsafe/jsr2/png/"date"
pro map2png, file_string, map, colour, thresh = thresh, log = log

d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2


loadct, colour
for i = 0, n_elements(map) - 1 do begin

    if (i + 1 lt 10) then filename = '/unsafe/jsr2/png/'+date+'/'+file_string+'_0' else $
    filename = '/unsafe/jsr2/png/'+date+'/'+file_string+'_'

    if (n_elements(thresh) eq 0) then begin
        set_plot,'z'
            fileplot = strcompress(filename + string(i + 1, format ='(I2)' ) + '.png', /remove_all)
            plot_map, map[i]
            image = tvread(TRUE=3)
            image = transpose(image, [2,0,1])
            write_png, fileplot, image
            ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
        set_plot,'x'
    endif

    if (n_elements(thresh) gt 1) then begin
        set_plot,'z'
            fileplot = strcompress(filename + string(i + 1, format ='(I2)' ) + '.png', /remove_all)
            plot_map, map[i], dmin = thresh[0] , dmax = thresh[1]
            image = tvread(TRUE=3)
            image = transpose(image, [2,0,1])
            write_png, fileplot, image
            ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
        set_plot,'x'
    endif

    if keyword_set(log) then begin
        set_plot,'z'
            fileplot = strcompress(filename + string(i + 1, format ='(I2)' ) + '.png', /remove_all)
            plot_map, map[i], /log
            image = tvread(TRUE=3)
            image = transpose(image, [2,0,1])
            write_png, fileplot, image
            ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
        set_plot,'x'
    endif
endfor
loadct, 0


end
