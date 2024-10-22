pro iris-sji-2-png
loadct, 0
restore, 'SJI_1400-17-Jul-2015.sav'

index2map, SJI_1400_hdr[473:516], SJI_1400_dat[*,*, 473:516], map1400


loadct, 1
for i = 0, n_elements(map1400) - 1 do begin
    if (i lt 10) then filename = '/unsafe/jsr2/png/SJI_1400_0' else filename = '/unsafe/jsr2/png/SJI_1400_'
    set_plot,'z'
        fileplot = strcompress(filename + string(i, format ='(I2)' ) + '.png', /remove_all)
        plot_map, map1400[i], /log
        image = tvread(TRUE=3)
        image = transpose(image, [2,0,1])
        write_png, fileplot, image
        ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
    set_plot,'x'
endfor
loadct, 0
restore, 'SJI_2796-17-Jul-2015.sav'

index2map, SJI_2796_hdr[630:687], SJI_2796_dat[*,*, 630:687], map2796


loadct,3
for i = 0, n_elements(map2796) - 1 do begin
    if (i lt 10) then filename = '/unsafe/jsr2/png/SJI_2796_0' else filename = '/unsafe/jsr2/png/SJI_2796_'
    set_plot,'z'
        fileplot = strcompress(filename + string(i, format ='(I2)' ) + '.png', /remove_all)
        plot_map, map2796[i], /log
        image = tvread(TRUE=3)
        image = transpose(image, [2,0,1])
        write_png, fileplot, image
        ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
    set_plot,'x'
endfor
loadct, 0
restore, 'SJI_2832-17-Jul-2015.sav'

index2map, SJI_2832_hdr[158:*], SJI_2832_dat[*,*, 158:*], map2832


loadct,8
for i = 0, n_elements(map2832) - 1 do begin
    if (i lt 10) then filename = '/unsafe/jsr2/png/SJI_2832_0' else filename = '/unsafe/jsr2/png/SJI_2832_'
    set_plot,'z'
        fileplot = strcompress(filename + string(i, format ='(I2)' ) + '.png', /remove_all)
        plot_map, map2832[i], dmin = 0, dmax =1500
        image = tvread(TRUE=3)
        image = transpose(image, [2,0,1])
        write_png, fileplot, image
        ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
    set_plot,'x'
endfor
loadct, 0

end
