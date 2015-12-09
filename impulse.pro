pro impulse, fdate, plot = plot, table = table
restore, '/unsafe/jsr2/'+fdate+'-2015/29-Mar-2014-bk-subtracted-iris-hmi-area-energies-'+fdate+'-2015.sav'

dir = '/unsafe/jsr2/'+fdate+'-2015/'
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


eimprhessi = 1.0e29 ;temp value

;d1 = strcompress(strmid(systime(),4,7),/remove_all)
;d2 = strcompress(strmid(systime(),20),/remove_all)
;date = d1+'-'+d2
save, t_av, eimprhessi, $
si, timpsi, eimpsi, timpsi_av, eimpsi_av, $
mg, timpmg, eimpmg, timpmg_av, eimpmg_av, $
balm, timpbalm, eimpbalm, timpbalm_av, eimpbalm_av, $
mgw, timpmgw, eimpmgw, timpmgw_av, eimpmgw_av, $
hmi, timphmi, eimphmi, timphmi_av, eimphmi_av, $
filename = '/unsafe/jsr2/'+fdate+'-2015/29-Mar-14-impulsive-phase-'+fdate+'.sav'

if keyword_set(plot) then begin
time_frames = 2 
npt = 1 + (nrb/time_frames) ; number of ribbon coords per time_frame + 1 qk coord

dataset = ['si', 'mg', 'balmer', 'mgw', 'hmi']
for i = 1,2 do begin
    ii = string(i, format = '(I0)')
    for k = 0, n_elements(dataset)-1 do begin
        flnm = dataset[k]+'coords'+ii+'.txt' ;eg, flnm=hmicoords1.txt
        openr, lun, flnm, /get_lun
        nlin =  file_lines(flnm)
        tmp = fltarr(2, nlin)
        readf, lun, tmp
        com = dataset[k]+'coords'+ii+ '= tmp' ;readf,lun,hmg
        exe = execute(com)
        free_lun, lun
    endfor
endfor
datasets = 6 ;rhessi, siiv, mgii, balm, mgiiw, hmi
for j = 0, time_frames - 1 do begin
    for i = 0, npt - 1 do begin

        e = fltarr(2, datasets) ;[0, *] = datatitle  [1, *] = eimp

        ;rhessi
        e[0, 0] = 0
        e[1, 0] = eimprhessi

        ;si
        e[0, 1] = 1
        e[1, 1] = eimpsi[j,i]

        ;mg
        e[0, 2] = 2
        e[1, 2] = eimpmg[j,i]

        ;balm
        e[0, 3] = 3
        e[1, 3] = eimpbalm[j,i]

        ;mgw
        e[0, 4] = 4
        e[1, 4] = eimpmgw[j,i]

        ;hmi
        e[0, 5] = 5
        e[1, 5] = eimphmi[j,i]

        ;plot
        if (j eq 0) then xx = string(hmicoords1[0,i], format = '(I0)') else $
        xx = string(hmicoords2[0,i], format = '(I0)')
        if (j eq 0) then yy = string(hmicoords1[1,i], format = '(I0)') else $
        yy = string(hmicoords2[1,i], format = '(I0)')

        ;used hmi coords as reference point
        fff = dir+'29-Mar-14-Ribbon-xyPosition-'+xx+'-'+yy+'-Frame-'+jj+'-Impulse-Energy.eps'
        jjj = string(j+1, format = '(I0)')
        titl = '29-Mar-14-Ribbon--Energy-hmicoords'+jjj+'-'+xx+'-'+yy
        mydevice=!d.name
        set_plot,'ps'
        ;device,filename=fff,/portrait,/encapsulated, decomposed=0,color = 1  , bits=8, bits = 8
        device,filename=fff,/portrait,/encapsulated, decomposed=0,color = 1, bits = 8
        plot, e[0,*], e[1,*], ytitle = 'Energy [erg]', xtitle = 'Dataset'
        device,/close
        set_plot,mydevice     
    endfor
endfor


endif
if keyword_set(table) then begin
;insert latex table here
endif

end
