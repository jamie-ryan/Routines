restore, '/disk/solar3/jsr2/Data/SDO/iris-16-03-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/sp2826-Apr28-2015.sav'
;restore, '/disk/solar3/jsr2/Data/SDO/hmi-12-05-15.sav'
restore, '/disk/solar3/jsr2/Data/SDO/HMI-diff-15-Oct-15.sav'


sav = find_file('29-Mar-2014-energies-*-single-pixel-Oct19-2015.sav')


for i = 0, n_elements(sav) -1 do begin
    restore, sav[i]
endfor


plot_map, map1400[495], /log
oplot_ribbon_coords, sicoords, 4., /frame1

plot_map, submg[661]
oplot_ribbon_coords, mgcoords, 4., /frame1

plot_map, map2832[166]
oplot_ribbon_coords, mgwcoords, 4., /frame1

plot_map, diff[62]
oplot_ribbon_coords, hmicoords, 4., /frame1

plot_map, map1400[498], /log
oplot_ribbon_coords, sicoords, 4., /frame2

plot_map, submg[664]

plot_map, map2832[167]

plot_map, diff[63]
