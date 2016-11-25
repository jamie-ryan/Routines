

;something wrong with files...redownload
maindir = '/unsafe/jsr2/project2/'
eventdir = '20150311/HMI/ic/pre-flare/'
dir = maindir+eventdir
files = findfile(dir+'hmi.*')
aia_prep, temporary(files),-1, out_ind, out_dat, /despike




maindir = '/unsafe/jsr2/project2/'
eventdir = '20140329/HMI/ic/pre-flare/'
dir = maindir+eventdir
files = findfile(dir+'hmi.*')
aia_prep, temporary(files),-1, out_ind, out_dat, /despike
submap_range = [519., 262.]
;514.28560       260.57132
restore, '/unsafe/jsr2/project2/'+directories[ddd]+'/HMI/ic/hmi_mp.sav'
