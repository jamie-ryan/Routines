pro intimpulse
;integrate energy curve over duration of impulsive phase of flare

;sidata = fltarr(time_frames, columns, npt, n_elements(tsi))
;mgdata = fltarr(time_frames, columns, npt, n_elements(tmg))
;balmerdata = fltarr(time_frames, columns, npt, n_elements(tagarr))
;mgwdata = fltarr(time_frames, columns, npt, n_elements(tmgw))
;hmidata = fltarr(time_frames, columns, npt, n_elements(thmi))

restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Nov25-2015.sav'
cadence = [26., 19., 72., 75., 45. ] ;si, mg  , balmer  , mgw  , hmi 
time_frames = 2
nrb = 20
npt = 1 + (nrb/time_frames)
siimp = fltarr(time_frames,npt,n_elements(tsi))
mgimp = fltarr(time_frames,npt,n_elements(tmg))
balmerimp = fltarr(time_frames,npt,n_elements(tbalm[0,0,*]))
mgwimp = fltarr(time_frames,npt,n_elements(tmgw))
hmiimp = fltarr(time_frames,npt,n_elements(thmi))


;define location in array of maximum
simx = max(sidata, a) ;locate maximum
sib = array_indices(sidata,a) ;convert to arrayt indices, such that max is located at sidata[sib[0], 3, sib[2], sib[3] ]
av = avg(sidata[sib[0],3,sib[2], 0:n_elements(tsi)/2])
sia = where(sidata[sib[0],3,sib[2], *]/av gt 1000) ;which energy values are above the threshold...threshold is based on mx/av

mgmx = max(mgdata, a)
mgb = array_indices(mgdata,a)
av = avg(mgdata[mgb[0],3,mgb[2], 0:n_elements(tmg)/2])
mga = where(mgdata[mgb[0],3,mgb[2], *]/av gt 1000)

balmermx = max(balmerdata, a)
balmerb = array_indices(balmerdata,a)
av = avg(balmerdata[balmerb[0],3,balmerb[2], 0:n_elements(tbalm[0,0,*])/2])
balmera = where(balmerdata[balmerb[0],3,balmerb[2], *]/av gt 1000)

mgwmx = max(mgwdata, a)
mgwb = array_indices(mgwdata,a)
av = avg(mgwdata[mgwb[0],3,mgwb[2], 0:n_elements(tmgw)])
mgwa = where(mgwdata[mgwb[0],3,mgwb[2], *]/av gt 1000)

hmimx = max(hmidata, a)
hmib = array_indices(hmidata,a)
av = avg(hmidata[hmib[0],3,hmib[2], n_elements(thmi)])
hmia = where(hmidata[hmib[0],3,hmib[2], *]/av gt 1000)


result = INT_TABULATED(, )

end
