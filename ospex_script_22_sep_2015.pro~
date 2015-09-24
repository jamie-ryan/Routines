; OSPEX script created Tue Sep 22 16:21:07 2015 by OSPEX writescript method.                
;                                                                                           
;  Call this script with the keyword argument, obj=obj to return the                        
;  OSPEX object reference for use at the command line as well as in the GUI.                
;  For example:                                                                             
;     ospex_script_22_sep_2015, obj=obj                                                     
;                                                                                           
;  Note that this script simply sets parameters in the OSPEX object as they                 
;  were when you wrote the script, and optionally restores fit results.                     
;  To make OSPEX do anything in this script, you need to add some action commands.          
;  For instance, the command                                                                
;     obj -> dofit, /all                                                                    
;  would tell OSPEX to do fits in all your fit time intervals.                              
;  See the OSPEX methods section in the OSPEX documentation at                              
;  http://hesperia.gsfc.nasa.gov/ssw/packages/spex/doc/ospex_explanation.htm                
;  for a complete list of methods and their arguments.                                      
;                                                                                           
pro ospex_script_22_sep_2015, obj=obj                                                       
if not is_class(obj,'SPEX',/quiet) then obj = ospex()                                       
obj-> set, spex_specfile= '/disk/solar3/jsr2/Data/SDO/hsi_spectrum_20140329_172528.fits'    
obj-> set, spex_drmfile= '/disk/solar3/jsr2/Data/SDO/hsi_srm_20140329_172528.fits'          
obj-> set, spex_source_angle= 36.7633                                                       
obj-> set, spex_source_xy= [511.494, 261.736]                                               
obj-> set, spex_fit_manual= 2                                                               
obj-> set, spex_erange= [3.0000000D, 100.00000D]                                            
obj-> set, spex_fit_time_interval= [['29-Mar-2014 17:34:08.000', $                          
 '29-Mar-2014 17:44:24.000'], ['29-Mar-2014 17:44:36.000', '29-Mar-2014 17:45:52.000'], $   
 ['29-Mar-2014 17:46:04.000', '29-Mar-2014 17:49:56.000'], ['29-Mar-2014 17:50:04.000', $   
 '29-Mar-2014 18:02:12.000'], ['29-Mar-2014 18:02:20.000', '29-Mar-2014 18:02:40.000'], $   
 ['29-Mar-2014 18:02:44.000', '29-Mar-2014 18:06:40.000'], ['29-Mar-2014 18:06:48.000', $   
 '29-Mar-2014 18:17:00.000']]                                                               
obj-> set, spex_bk_time_interval=['29-Mar-2014 18:14:52.000', '29-Mar-2014 18:18:28.000']   
obj-> set, fit_function= 'vth+thick2'                                                       
obj-> set, fit_comp_params= [0.0144422, 1.02806, 1.00000, 0.000164458, 7.45997, 4.05432, $  
 15.1858, 51.9255, 32000.0]                                                                 
obj-> set, fit_comp_minima= [1.00000e-20, 0.500000, 0.0100000, 1.00000e-10, 1.10000, $      
 1.00000, 1.10000, 1.00000, 100.000]                                                        
obj-> set, fit_comp_maxima= [1.00000e+20, 8.00000, 10.0000, 1.00000e+10, 20.0000, 100000., $
 20.0000, 1000.00, 1.00000e+07]                                                             
obj-> set, fit_comp_free_mask= [1, 1, 0, 1, 1, 1, 1, 1, 0]                                  
obj-> set, fit_comp_spectrum= ['full', '']                                                  
obj-> set, fit_comp_model= ['chianti', '']                                                  
obj-> set, spex_autoplot_photons= 1                                                         
obj-> set, spex_autoplot_units= 'Flux'                                                      
obj-> set, spex_fitcomp_plot_photons= 1                                                     
obj-> set, spex_eband= [[3.00000, 6.00000], [6.00000, 12.0000], [12.0000, 25.0000], $       
 [25.0000, 50.0000], [50.0000, 100.000], [100.000, 300.000]]                                
obj-> set, spex_tband= [['29-Mar-2014 17:25:28.000', '29-Mar-2014 17:40:15.000'], $         
 ['29-Mar-2014 17:40:15.000', '29-Mar-2014 17:55:02.000'], ['29-Mar-2014 17:55:02.000', $   
 '29-Mar-2014 18:09:49.000'], ['29-Mar-2014 18:09:49.000', '29-Mar-2014 18:24:36.000']]     
obj -> restorefit, file='/disk/solar3/jsr2/Data/SDO/ospex_results_22_sep_2015.fits'         
end                                                                                         
