pro rhessi_array2spectra, outdir

outdir = '/unsafe/jsr2/rhessi-spectra-May18-2016/energy-10-to-100/PIXON/'
restore, outdir+'rhessidata.sav'
;rhessidata = [e,x,y,t]


for i = 0, n_elements(rhessidata[*,0,0,0]) - 1  do begin
    for j = 2, 4 do begin

        ii = string(i ,format = '(I0)')
        jj = string(j ,format = '(I0)')

        tmp = 0
        psd = stddev(rhessidata[i, *, *, j])
        tmp = where(rhessidata[i, *, *, j] gt 2*psd, pid)
        pind = array_indices(rhessidata[i, *, *, j], tmp)

        fil = 'hxrpix-coords-e-'+ii+'-t-'+jj+'.txt'
        openw, lun, fil, /get_lun
        printf, lun, pind        
        free_lun, lun

    endfor
endfor



spectra = fltarr(n_elements(rhessidata[*,0,0,0]), n_elements(rhessidata[0,*,0,0]), n_elements(rhessidata[0,0,*,0]))
spectra = max(rhessidata[])
lightcurve = fltarr(n_elements(rhessidata[0,0,0,*]))


        spectrum[i] = 
        lightcurve[j] = 



end
