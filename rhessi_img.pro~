pro rhessi_img, $
energy_range =  energy_range, $
increment, $
hrstart, $ 
minstart, $
secst, $
hrend, $
minend, $
secend, $ 
nt, $
algorithm
;INPUT:
;energy_range = either a single number, or a 2 element array. eg energy_range = [10.0D, 100.0D]
;increments = spectrum x-axis energy increment, in keV. eg increment = 1 is 1 kev  
;hrstart = starting hour of observation. In number format eg 17 
;minstart = starting minute. eg, 44
;secst = starting second. eg, 0
;hrend = ending hour. eg, 17
;minend = ending minute. eg, 52
;secend = ending second. eg, 30
;nt = number of time intervals. eg 7  
;algorithm = image construction algorithm. eg  'CLEAN'       
        ;'Back Projection'
        ;'CLEAN' 
        ;'PIXON' 
        ;'MEM_NJIT' 
        ;'FORWARDFIT'
        ;'VIS_FWDFIT' 


;OUTPUT:
 
;syntax
;rhessi_img_spectra, energy_range = [10.,100.], 10., 17, 40, 0, 17, 54, 0, 7, 'Back Projection'
                              
;hsi image object                                                                                         
; For a complete list of control parameters look at the tables in                         
; http://hesperia.gsfc.nasa.gov/ssw/hessi/doc/hsi_params_all.htm                          
;                                                                                         
                                                                                    
; Once you have run the script (via one of those 3 methods), you will have an             
; hsi_image object called obj that is set up as it was when you wrote the script.         
; You can proceed using obj from the command line or the hessi GUI.  To use               
; it in the GUI, type                                                                     
;   hessi,obj    
tic                                                                         
search_network, /enable   
d1 = strcompress(strmid(systime(),4,7),/remove_all)
d2 = strcompress(strmid(systime(),20),/remove_all)
datstr = 'rhessi-spectra-'+d1+'-'+d2
spawn, 'mkdir /unsafe/jsr2/'+datstr

if (n_elements(energy_range) eq 1) then e1 = string(energy_range, format = '(I0)') else $
e1 = string(energy_range[0], format = '(I0)')
e2 = string(energy_range[1], format = '(I0)')
estr = 'energy-'+e1+'-to-'+e2
algo = strcompress(algorithm, /remove_all)
spawn, 'mkdir /unsafe/jsr2/'+datstr+'/'+estr+'/'+algo
outdir = '/unsafe/jsr2/'+datstr+'/'+estr+'/'+algo+'/'

;number of energy bands
nenergy = max(energy_range)/increment
time_intervals = rhessi_time_string_iterator(nt, hrstart, hrend, minstart, minend, secst, secend)

;energy increment loop
for i = 0, nenergy - 1 do begin   
         
    iflt = i*1.0D                                           
    obj = hsi_image()                    
    ;obj-> set, im_energy_binning= [10.000000D, 100.00000D]                                    
    obj-> set, im_energy_binning = [iflt*increment, iflt*increment + increment]
    
    er1 = string(iflt*increment, format = '(I0)')
    er2 = string(iflt*increment + increment, format = '(I0)')
    ;loop through each time interval
    for t = 0, nt-1 do begin
        print, 'energy loop = ',i   
        print, 'time loop = ',t
        ;choose time interval
        obj-> set, im_time_interval= [ [time_intervals[0, t]], [time_intervals[1, t]] ]

        ;;;set image construction algorithm
        obj-> set, image_algorithm= algorithm
        ;obj-> set, image_algorithm= 'Back Projection'
        ;obj-> set, image_algorithm= 'CLEAN' 
        ;obj-> set, image_algorithm= 'PIXON' 
        ;obj-> set, image_algorithm= 'MEM_NJIT' 
        ;obj-> set, image_algorithm= 'FORWARDFIT'
        ;obj-> set, image_algorithm= 'VIS_FWDFIT'              

        obj-> set, time_bin_def= [1.00000, 2.00000, 4.00000, 4.00000, 8.00000, 16.0000, 32.0000, $
         64.0000, 64.0000]                                                                        
        obj-> set, time_bin_min= 512L                                                             


        ii = string(i, format = '(I0)')
        tt = string(t, format = '(I0)')

        ind =  obj->get( /summary_info) ; retrieve index                                                                     
        data = obj-> getdata()    ; retrieve the last image made                                 
        ;data = obj-> getdata(use_single=0)  ; retrieve all images in cube        

        if (t eq 0) then rhessiindex =  obj->get( /summary_info) else $
        if (t gt 0) then rhessiindex = str_concat(rhessiindex, ind)

        if (i eq 0) and (t eq 0) then begin
        datdim = size(data)

        ;PRINT, SIZE(FINDGEN(10, 20))
        ;IDL prints:
        ;   2   10   20   4   200
        ;This IDL output indicates the array has 2 dimensions, equal to 10 and 20, 
        ;a type code of 4, and 200 elements total. Similarly, to print only the 
        ;number of dimensions of the same array:

        ;rhessidata[e,xpix,ypix,t]
        rhessidata = fltarr(nenergy, datdim[1],datdim[2],n_elements(time_intervals[0,*]))
        endif

        rhessidata[i,*,*,t] = data    

        ;;;create map structures for each energy increment
        ;;;then save 
        ;im2fits
;        ffit= outdir+'rhessi_img_ne_'+ii+'nt_'+tt+'_time_'+time_intervals[0,t]+'.fits'
        ffit = outdir+'tmp.fit'
        obj-> set, im_out_fits_filename = ffit
        obj->fitswrite
        ;;;fits files to maps section
        ;fits2map, ffit
        obj-> set, im_input_fits = ffit
        hsi_fits2map, ffit, rhessimap
        if (t eq 0) then rhessimap0 = rhessimap else $
        if (t gt 0) then rhessimap0 = str_concat(rhessimap0, rhessimap)
        if (t eq nt - 1) then begin
;        if (t eq 1) then begin
        mapstr = 'hmap'+er1+'to'+er2
        com = mapstr+' = rhessimap0'
        exe = execute(com)
        fff = outdir+mapstr+'.sav'
        com = 'save, '+mapstr+', filename = fff'
        exe = execute(com)
        endif                                                                                       
    endfor
endfor
fil = outdir+'rhessidata.sav'
save, time_intervals, rhessiindex, rhessidata, filename = fil                         
toc
spawn, 'rm '+outdir+'tmp.fit'
end
