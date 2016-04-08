;Function to make .png images from maps. 
;
;
;INPUT:
;file_string = a string identifying the data set to be used in the output png file name
;map = map structure to be converted to png
;colour = loadct color table number
;oplt = over plot contours i.e, plot_map, /over, levels = lvls
;omap = the map to be overplot
;n0 = the starting element in omap
;element_range = an array containing two value, the start and end elements for the plot_map, omap, /over contours
;increment = the increment for omap, i.e., if you want to plot only elements that are a multiple of two then increment = 2
;ocolour = conout colours for overplot
;lvls = array containing levels in relative units, i.e, lvls = [0.8] is 80% contour
;thresh = an array conaining dmin and dmax values for plot_map
;log = include /log for plot_map, /log 
;
;OUTPUT:
;png images named from 1 to x. 
;Stored in /unsafe/jsr2/png/"date"
;
;TO RUN:
;eg, map2png, 'HMI_Cont', shmi, 3, thresh = [0,5000]
pro map2png, file_string, map, colour, oplt = oplt, omap, n0, element_range, increment ,ocolour, lvls, thresh = thresh, log = log

d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
date = d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/png/'+date


loadct, colour
for i = 0, n_elements(map) - 1 do begin

    if (i + 1 lt 10) then filename = '/unsafe/jsr2/png/'+date+'/'+file_string+'_0' else $
    filename = '/unsafe/jsr2/png/'+date+'/'+file_string+'_'

    if (n_elements(thresh) eq 0) then begin
        set_plot,'z'
            fileplot = strcompress(filename + string(i + 1, format ='(I2)' ) + '.png', /remove_all)
            plot_map, map[i]
            ;plot_map, /over
            if keyword_set(oplt) then begin
                ;align map elements
                if (n_elements(element_range) eq 0) then begin
                loadct, ocolour
                plot_map, omap, /over, /drot, levels = [lvls], /percent
                endif 
                if (n_elements(element_range) gt 0) then begin
                    if (i ge element_range[0]) && (i le max(element_range[0]) then begin
                    loadct, ocolour
                    plot_map, omap[n0 + increment*(i-element_range[0])], /over, /drot, levels = [lvls], /percent
                    endif
                endif
            endif            image = tvread(TRUE=3)
            image = transpose(image, [2,0,1])
            write_png, fileplot, image
            ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
        set_plot,'x'
    endif

    if (n_elements(thresh) gt 1) then begin
        set_plot,'z'
            fileplot = strcompress(filename + string(i + 1, format ='(I2)' ) + '.png', /remove_all)
            plot_map, map[i], dmin = thresh[0] , dmax = thresh[1]
            if keyword_set(oplt) then begin
                ;align map elements
                if (n_elements(element_range) eq 0) then begin
                loadct, ocolour
                plot_map, omap, /over, /drot, levels = [lvls], /percent
                endif 
                if (n_elements(element_range) gt 0) then begin
                    if (i ge element_range[0]) && (i le max(element_range[0]) then begin
                    loadct, ocolour
                    plot_map, omap[n0 + increment*(i-element_range[0])], /over, /drot, levels = [lvls], /percent
                    endif
                endif
            endif
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
            if keyword_set(oplt) then begin
                ;align map elements
                if (n_elements(element_range) eq 0) then begin
                loadct, ocolour
                plot_map, omap, /over, /drot, levels = [lvls], /percent
                endif 
                if (n_elements(element_range) gt 0) then begin
                    if (i ge element_range[0]) && (i le max(element_range[0]) then begin
                    loadct, ocolour
                    plot_map, omap[n0 + increment*(i-element_range[0])], /over, /drot, levels = [lvls], /percent
                    endif
                endif
            endif            image = tvread(TRUE=3)
            image = transpose(image, [2,0,1])
            write_png, fileplot, image
            ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
        set_plot,'x'
    endif
endfor
loadct, 0


end
