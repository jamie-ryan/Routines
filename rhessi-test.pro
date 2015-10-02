;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;rhessi spectrum fitting process without gui

if not is_class(obj,'SPEX',/quiet) then obj = ospex()                                              
obj-> set, spex_specfile= 'hsi_spectrum_20140329_172528.fits'           
obj-> set, spex_drmfile= 'hsi_srm_20140329_172528.fits'                 
obj-> set, spex_source_angle= 36.7633                                                              
obj-> set, spex_source_xy= [511.494, 261.736]                                                      
obj-> set, spex_fit_manual= 2                                                                      
obj-> set, spex_erange= [10.000000D, 100.00000D]                                                   
obj-> set, spex_fit_time_interval= [['29-Mar-2014 17:34:08.000', $                                 
 '29-Mar-2014 17:44:24.000'], ['29-Mar-2014 17:44:36.000', '29-Mar-2014 17:45:52.000'], $          
 ['29-Mar-2014 17:46:04.000', '29-Mar-2014 17:49:56.000'], ['29-Mar-2014 17:50:04.000', $          
 '29-Mar-2014 18:02:12.000'], ['29-Mar-2014 18:02:20.000', '29-Mar-2014 18:02:40.000'], $          
 ['29-Mar-2014 18:02:44.000', '29-Mar-2014 18:06:40.000'], ['29-Mar-2014 18:06:48.000', $          
 '29-Mar-2014 18:17:00.000']]                                                                      
obj-> set, spex_bk_time_interval=['29-Mar-2014 18:15:32.000', '29-Mar-2014 18:17:36.000']          
obj-> set, fit_function= 'vth+thick2'                                                              
obj-> set, fit_comp_params= [0.00272447, 1.17151, 2.20388, 0.000871992, 8.74030, 42.2049, $        
 10.2575, 37.2830, 136.169]                                                                        
obj-> set, fit_comp_minima= [1.00000e-20, 0.500000, 0.0100000, 1.00000e-10, 1.10000, $             
 1.00000, 1.10000, 1.00000, 100.000]                                                               
obj-> set, fit_comp_maxima= [1.00000e+20, 8.00000, 10.0000, 1.00000e+10, 20.0000, 100000., $       
 20.0000, 1000.00, 1.00000e+07]                                                                    
obj-> set, fit_comp_free_mask= [1B, 1B, 1B, 1B, 1B, 1B, 1B, 1B, 1B]                                
obj-> set, fit_comp_spectrum= ['full', '']                                                         
obj-> set, fit_comp_model= ['chianti', '']                                                         
obj-> set, spex_autoplot_photons= 1                                                                
obj-> set, spex_autoplot_units= 'Flux'                                                             
obj-> set, spex_fitcomp_plot_bk= 1                                                                 
obj-> set, spex_fitcomp_plot_photons= 1                                                            
obj-> set, spex_fitcomp_plot_resid= 0                                                              
obj-> set, spex_eband= [[3.00000, 6.00000], [6.00000, 12.0000], [12.0000, 25.0000], $              
 [25.0000, 50.0000], [50.0000, 100.000], [100.000, 300.000]]                                       
obj-> set, spex_tband= [['29-Mar-2014 17:25:28.000', '29-Mar-2014 17:40:15.000'], $                
 ['29-Mar-2014 17:40:15.000', '29-Mar-2014 17:55:02.000'], ['29-Mar-2014 17:55:02.000', $          
 '29-Mar-2014 18:09:49.000'], ['29-Mar-2014 18:09:49.000', '29-Mar-2014 18:24:36.000']]            

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;data manipulation and plotting;;;;;;;;;;;;;;;;;;;;;;;;
obj -> restorefit, file='ospex_results_1_oct_2015-with-bk.fits'

;grab spex parameters from fits file
s = obj -> get(/spex_summ) ;or s = spex_read_fit_results('ospex_results_1_oct_2015-with-bk.fits')

help, s                                                                                                          
** Structure <3168a68>, 31 tags, length=18424, data length=18411, refs=1:                                             
   SPEX_SUMM_FIT_FUNCTION                                                                                             
                   STRING    'vth+thick2'                                                                             
   SPEX_SUMM_AREA  FLOAT           277.130                                                                            
   SPEX_SUMM_ENERGY                                                                                                   
                   FLOAT     Array[2, 77]                                                                             
   SPEX_SUMM_TIME_INTERVAL                                                                                            
                   DOUBLE    Array[2, 7]                                                                              
   SPEX_SUMM_FILTER                                                                                                   
                   INT       Array[7]                                                                                 
   SPEX_SUMM_FIT_DONE                                                                                                 
                   BYTE      Array[7]                                                                                 
   SPEX_SUMM_EMASK BYTE      Array[77, 7]                                                                             
   SPEX_SUMM_CT_RATE                                                                                                  
                   FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_CT_ERROR                                                                                                 
                   FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_BK_RATE                                                                                                  
                   FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_BK_ERROR                                                                                                 
                   FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_PH_MODEL                                                                                                 
                   FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_CONV  FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_RESID FLOAT     Array[77, 7]                                                                             
   SPEX_SUMM_STARTING_PARAMS                                                                                          
                   FLOAT     Array[9, 7]                                                                              
   SPEX_SUMM_PARAMS                                                                                                   
                   FLOAT     Array[9, 7]                                                                              
   SPEX_SUMM_SIGMAS                                                                                                   
                   FLOAT     Array[9, 7]                                                                              
   SPEX_SUMM_MINIMA                                                                                                   
                   FLOAT     Array[9, 7]                                                                              
   SPEX_SUMM_MAXIMA                                                                                                   
                   FLOAT     Array[9, 7]                                                                              
   SPEX_SUMM_FREE_MASK                                                                                                
                   BYTE      Array[9, 7]                                                                              
   SPEX_SUMM_FUNC_SPECTRUM
                   STRING    Array[2, 7]
   SPEX_SUMM_FUNC_MODEL
                   STRING    Array[2, 7]
   SPEX_SUMM_CHIANTI_VERSION
                   STRING    '7.1.3'
   SPEX_SUMM_ABUN_TABLE
                   STRING    'sun_coronal'
   SPEX_SUMM_SOURCE_XY
                   FLOAT     Array[2]
   SPEX_SUMM_SOURCE_ANGLE
                   FLOAT           36.7633
   SPEX_SUMM_MAXITER
                   INT       Array[7]
   SPEX_SUMM_UNCERT
                   FLOAT     Array[7]
   SPEX_SUMM_CHISQ FLOAT     Array[7]
   SPEX_SUMM_STOP_MSG
                   STRING    Array[7]
   SPEX_SUMM_NITER INT       Array[7]




conv_fact = s.spex_summ_conv
area = s.spex_summ_area
ewidth = get_edges(s.spex_summ_energy,/width)
ct_flux = s.spex_summ_ct_rate  / area / rebin(ewidth, size(s.spex_summ_ct_rate, /dim))
ph_flux = ct_flux / conv_fact


times = get_edges(s.spex_summ_time_interval, /mean)
utplot, anytim(times, /ex), alldat



time0 = s.spex_summ_time_interval[0:1,0]


;;;make an array with each interval back to back
s = obj -> get(/spex_summ)
nint = n_elements(s.spex_summ_time_interval[0,*])
d = obj->getdata(class='spex_fitint')
ndat = n_elements(d.data[*,0])
alldat = fltarr(1, ndat*nint)
for i = 0, nint-1  do begin
conv  = obj -> get_drm_eff (this_interval=[i], /use_fitted)
data = d.data[*,i]
spex_apply_eff, data, conv
alldat[(ndat-1)*i:(i+1)*(ndat-1)] = data 
endfor


a = anytim2utc(time)

a = anytim(time1,/ex)
a = atime(time)







