pro intimpulse
;integrate energy curve over duration of impulsive phase of flare


restore, '29-Mar-2014-bk-subtracted-iris-hmi-area-energies-Nov30-2015.sav'
cadence = [26., 19., 72., 75., 45. ] ;si, mg  , balmer  , mgw  , hmi 
time_frames = 2
nrb = 20
npt = 1 + (nrb/time_frames)
siint = fltarr(time_frames + 1,npt) ; siint[0, *]=e1, siint[1, *]=e2, siint[2, *]=timespan
mgint = fltarr(time_frames + 1,npt)
balmerint = fltarr(time_frames + 1,npt)
mgwint = fltarr(time_frames + 1,npt)
hmiint = fltarr(time_frames + 1,npt)


;;;;Si IV
simx = max(sidata, a) ;locate maximum
sib = array_indices(sidata,a) ;convert to arrayt indices, such that max is located at sidata[sib[0], 3, sib[2], sib[3] ]
av = median(sidata[sib[0],3,sib[2], 0:n_elements(tsi)/2])
rat = sidata[sib[0],3,sib[2], sib[3]]/av
sia = where(sidata[sib[0],3,sib[2], *]/av gt 0.9*rat) ;energy above the threshold...threshold is based on mx/av
nx = n_elements(sia)
xsi = fltarr(nx)
for i =  0, nx -1 do begin
xsi[i] = i*cadence[0] 
endfor

;;;;MG II
mgmx = max(mgdata, a) 
mgb = array_indices(mgdata,a)
av = median(mgdata[mgb[0],3,mgb[2], 0:n_elements(tmg)/2])
rat = mgdata[mgb[0],3,mgb[2], mgb[3]]/av
mga = where(mgdata[mgb[0],3,mgb[2], *]/av gt 0.9*rat)
nx = n_elements(mga)
xmg = fltarr(nx)
for i =  0, nx -1 do begin
xmg[i] = i*cadence[1] 
endfor

;;;;Balmer
balmermx = max(balmerdata, a) 
balmerb = array_indices(balmerdata,a)
av = median(balmerdata[balmerb[0],3,balmerb[2], 0:n_elements(tbalm[0,0,*])/2])
rat = balmerdata[balmerb[0],3,balmerb[2], balmerb[3]]/av
balmera = where(balmerdata[balmerb[0],3,balmerb[2], *]/av gt 0.9*rat)
nx = n_elements(balmera)
xbalm = fltarr(nx)
for i =  0, nx -1 do begin
xbalm[i] = i*cadence[2] 
endfor

;;;;Mg II wing
mgwmx = max(mgwdata, a) 
mgwb = array_indices(mgwdata,a)
av = median(mgwdata[mgwb[0],3,mgwb[2], 0:n_elements(tmgw)/2])
rat = mgwdata[mgwb[0],3,mgwb[2], mgwb[3]]/av
mgwa = where(mgwdata[mgwb[0],3,mgwb[2], *]/av gt 0.9*rat)
nx = n_elements(mgwa)
xmgw = fltarr(nx)
for i =  0, nx -1 do begin
xmgw[i] = i*cadence[3] 
endfor

;;;;HMI
hmimx = max(hmidata, a) 
hmib = array_indices(hmidata,a)
av = median(hmidata[hmib[0],3,hmib[2], 0:n_elements(thmi)/2])
rat = hmidata[hmib[0],3,hmib[2], hmib[3]]/av
hmia = where(hmidata[hmib[0],3,hmib[2], *]/av gt 0.9*rat)
nx = n_elements(hmia)
xhmi = fltarr(nx)
for i =  0, nx -1 do begin
xhmi[i] = i*cadence[4] 
endfor


;integrate energy over impulsive phase for each coordinate
i = 0
for j = 0, time_frames - 1 do begin
    for i = 0, npt - 1 do begin  
        siint[j,i] = int_tabulated(xsi, sidata[j,3,i, min(sia):max(sia)])
        siint[2, i] = max(xsi)
        mgint[j,i] = int_tabulated(xmg, mgdata[j,3,i, min(mga):max(mga)])
        mgint[2, i] = max(xmg)
        balmerint[j,i] = int_tabulated(xbalm, balmerdata[j,3,i, min(balmera):max(balmera)])
        balmerint[2, i] = max(xbalm)
        mgwint[j,i] = int_tabulated(xmgw, mgwdata[j,3,i, min(mgwa):max(mgwa)])
        mgwint[2, i] = max(xmgw)
        hmiint[j,i] = int_tabulated(xhmi, hmidata[j,3,i, min(hmia):max(hmia)])
        hmiint[2, i] = max(xhmi)
    endfor
endfor
end
