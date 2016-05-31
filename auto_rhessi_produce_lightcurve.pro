



dir = '/unsafe/jsr2/rhessi-spectra-May27-2016/energy-20-to-60/increments-3keV/timg-20sec/PIXON/'
mstr = 'hmap20to23'
cf = '/unsafe/jsr2/balmercoords.txt'

rhessi_produce_lightcurves, indir = dir, mapstr = mstr, coords_file = cf

dir = 0
mstr = 0
cf = 0

dir = '/unsafe/jsr2/rhessi-spectra-May27-2016/energy-60-to-100/increments-5keV/timg-20sec/PIXON/'
mstr = 'hmap60to65'
cf = '/unsafe/jsr2/balmercoords.txt'

rhessi_produce_lightcurves, indir = dir, mapstr = mstr, coords_file = cf

