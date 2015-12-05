pro impulse, fdate
restore, '/unsafe/jsr2/'+fdate+'-2015/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+fdate+'-2015.sav'


intimpulse3, sidata, si, timpsi, eimpsi, timpsi_av, eimpsi_av
;INPUT:
;   sidata = [time_frames,column, npt, t]
;OUTPUT:
;   si = data structure 
;   timpsi = [time_frames, npt] = impulsive phase time for each coord 
;   eimpsi = [time_frames, npt] = impulsive phase integrated energy for each coord
;   timpsi_av = average impulsive phase time
;   eimpsi_av = average impulsive phase integrated energy
intimpulse3, mgdata, mg, timpmg, eimpmg, timpmg_av, eimpmg_av
intimpulse3, balmerdata, balm, timpbalm, eimpbalm, timpbalm_av, eimpbalm_av
intimpulse3, mgwdata, mgw, timpmgw, eimpmgw, timpmgw_av, eimpmgw_av
intimpulse3, hmidata, hmi, timphmi, eimphmi, timphmi_av, eimphmi_av


t_av = (timpsi_av + timpmg_av + timpbalm_av + timpmgw_av + timphmi_av)/5.

earry = [eimpsi_av, eimpmg_av, eimpbalm_av, eimpmgw_av, eimphmi_av]

;d1 = strcompress(strmid(systime(),4,7),/remove_all)
;d2 = strcompress(strmid(systime(),20),/remove_all)
;date = d1+'-'+d2
save, t_av, $
si, timpsi, eimpsi, timpsi_av, eimpsi_av, $
mg, timpmg, eimpmg, timpmg_av, eimpmg_av, $
balm, timpbalm, eimpbalm, timpbalm_av, eimpbalm_av, $
mgw, timpmgw, eimpmgw, timpmgw_av, eimpmgw_av, $
hmi, timphmi, eimphmi, timphmi_av, eimphmi_av, $
filename = '/unsafe/jsr2/'+fdate+'-2015/29-Mar-14-impulsive-phase-'+fdate+'.sav'
end
