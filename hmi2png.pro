pro hmi-unfiltered
restore, '/unsafe/jsr2/Feb12-2016/hmifullfilt-Feb12-2016.sav'
files = findfile('/disk/solar4/sz2/SDO/20140329/Ic/hmi.Ic_45s.20140329_17*')
 f = files[47:71] ;17:35 - 1753
aia_prep, f,-1, hmiindex, hmidata, /despike
index2map, hmiindex, hmidata, hmimp
sub_map, hmimp, xr=[405,590], yr=[190,372], shmi
save, /variables, filename = '/unsafe/jsr2/hmifullfilt-all-arrays-'+date_today+'.sav'

loadct, 3
for i = 0, n_elements(shmi) - 1 do begin
    if (i + 1 lt 10) then filename = '/unsafe/jsr2/png/HMI_Cont_0' else filename = '/unsafe/jsr2/png/HMI_Cont_'
    set_plot,'z'
        fileplot = strcompress(filename + string(i + 1, format ='(I2)' ) + '.png', /remove_all)
        plot_map, shmi[i], dmin = , dmax = 
        image = tvread(TRUE=3)
        image = transpose(image, [2,0,1])
        write_png, fileplot, image
        ;		print, qkspectra[0,(inc)*i:inc*(i+1)-1], qkspectra[1,(inc)*i:inc*(i+1)-1]
    set_plot,'x'
endfor
loadct, 0


end
