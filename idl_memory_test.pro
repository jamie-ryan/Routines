;IDL>  HELP,/MEMORY
;heap memory used:    2732834, max:    3110916, gets:  1789557, frees:  1788688

directory = '/unsafe/jsr2/project2/20140329/HMI/ic/'
files = findfile(directory+'hmi.*')
aia_prep, temporary(files) ,-1, out_ind, out_dat, /despike

;IDL>  HELP,/MEMORY
;heap memory used: 1816631737, max: 2085114988, gets: 26019120, frees: 26007710


index2map, temporary(out_ind), temporary(out_dat), map
;IDL>  HELP,/MEMORY
;heap memory used: 1816859734, max: 5507844854, gets: 26400639, frees: 26390435

submap_range = [519.2,260.0]
sub_map, temporary(map), xr=[submap_range[0] - 50.,submap_range[0] + 50.], yr=[submap_range[1] - 50.,submap_range[1] + 50.], mp 
;IDL>  HELP,/MEMORY
;heap memory used:    7735754, max: 2423665051, gets: 26322295, frees: 26312292

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;IDL> help, /memory                                                                     
;heap memory used:    2732455, max:    3110917, gets:  1789557, frees:  1788688
dir ='/unsafe/jsr2/test/'                                                                       
hmi_process_filter_universal, /process, dir, submap_range = [519., 262.], /difffilt, /phys_units

;IDL> help, /memory
;heap memory used:    4821466, max: 5507843834, gets: 34655382, frees: 34645353





