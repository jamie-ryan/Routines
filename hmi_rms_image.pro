pro hmi_rms_image

;open and read in file containing data directories
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun


for ddd = 0, nlin - 1 do begin

pfdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/pre-flare/'
fdir = '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/v/'

restore, pfdir+'hmi-dopp.sav'
pfmp = temporary(hmidopp)

restore, fdir+'hmi-dopp.sav'
fmp =  temporary(hmidopp)

    xpix = n_elements(pfmp[0].data[*,0])
    ypix = n_elements(pfmp[0].data[0,*])
    nt = n_elements(pfmp)
    pfrms = fltarr(xpix,ypix)
    frms = fltarr(xpix,ypix)
    pfsd = fltarr(xpix,ypix)
    fsd = fltarr(xpix,ypix)
    pfvar = fltarr(xpix,ypix)
    fvar = fltarr(xpix,ypix)
    for i = 0, xpix - 1 do begin 
        for j = 0, ypix - 1 do begin
            pfrms[i,j] = sqrt(mean((pfmp[*].data[i,j])^2))
            frms[i,j] = sqrt(mean((fmp[*].data[i,j])^2))   
            pfsd[i,j] = stddev(pfmp[*].data[i,j])
            fsd[i,j] = stddev(fmp[*].data[i,j])   
            pfvar[i,j] = variance(pfmp[*].data[i,j])
            fvar[i,j] = variance(fmp[*].data[i,j])  
        endfor
    endfor


endfor
