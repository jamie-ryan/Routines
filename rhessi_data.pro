pro rhessi_data

;steph sent me this code
search_network, /enable
tr ='29-Mar-14 '+['17:35:28','18:14:36']
obs = hsi_obs_summary(obs_time_interval = tr)
corrected_data = obs -> getdata(/corrected)
times = obs -> getdata(/time_array) ;or times = obs -> getaxis(/ut)
data = corrected_data.countrate
ntt = n_elements(times)
obs -> plot ;will plot all energy ranges

;to plot individually:
;data[0,*] = 3 - 6 keV
;data[1,*] = 6 - 12 keV
;data[2,*] = 12 - 25 keV
;data[3,*] = 25 - 50 keV
;data[4,*] = 50 - 100 keV
;data[5,*] = 100 - 300 keV
;data[6,*] = 300 - 800 keV
;data[7,*] = 800 - 7000 keV
;data[8,*] = 7000 - 20000 keV
s = 's!E-1!N'
det = 'detector!E-1!N'
ytitl = 'Count Rate ('+s+' '+det+')'
loadct, 
utplot, times-times[0], data[4,*], ytitle = ytitl, title = 'RHESSI 25 - 50 and 50 - 100 keV', /ylog 
oplot, times-times[0], data[3,*]
;or
utplot, atime(times), data[4,*], ytitle = ytitl, title = 'RHESSI 25 - 50 and 50 - 100 keV', /ylog 
oplot, atime(times), data[3,*]



;RHESSI IMAGING VIA GUI see rhessi_imaging_kontar_2009.pdf
search_network, /enable
hessi

;;RHESSI IMAGING VIA COMMAND LINE see rhessi_imaging_kontar_2009.pdf
search_network, /enable ;access to rhessi data
obj = hsi_image() ;define imaging object
obj-> set, det_index_mask= [0, 0, 1, 1, 1, 1, 1, 1, 0] ;detectors used 3 to 8
obj-> set, im_energy_binning= [50.0, 100.0] ;energy range
obj-> set, im_time_interval= ' 29-Mar-2014 '+['17:47:18', '17:47:22'] ;time range
obj-> set, image_algorithm= 'Back Projection' ;or 'Clean' or 'Pixon' etc
obj-> set, image_dim= [128, 128] ;image size in pixels
obj-> set, pixel_size= [32., 32.] ;pixel size in arcseconds
obj-> set, use_flare_xyoffset= 1 ;if set to 1 uses catalogue data, if set to 0 it doesn't
obj-> set, xyoffset= [0.0, 0.0] ;set image centre coordinates
data = obj-> getdata() ; retrieve the last image made





search_network, /enable
tr ='29-Mar-14 '+['17:35:28','18:14:36']
obs = hsi_obs_summary(obs_time_interval = tr)
data = obs -> getdata(/corrected)
times = obs -> getaxis(/ut)
utplot,anytim(times,/yoh),data.countrate[0]
;data.countrate[0] = 3 - 6 keV sxr
;data.countrate[1] = 6 - 12 keV sxr to hxr
;data.countrate[2] = 12 - 25 keV hxr
;data.countrate[3] = 25 - 50 keV hxr
;data.countrate[4] = 50 - 100 keV hxr
;data.countrate[5] = 100 - 300 keV hxr
;data.countrate[6] = 300 - 800 keV hxr
;data.countrate[7] = 800 - 7000 keV hxr
;data.countrate[8] = 7000 - 20000 keV hxr - gamma


;spectra and srm via command line
obj = hsi_spectrum()
obj -> set, decimation_correct = 1
obj -> set, obs_time_interval = tr
obj -> set, pileup_correct = 0
obj -> set, seg_index_mask = [1,0,1,1,0,1,0,1,1,0,0,0,0,0,0,0,0,0]
obj -> set, sp_data_unit = 'Flux'
obj -> set, sp_energy_binning = 22
obj -> set, sp_semi_calibrated = 0
obj -> set, sp_time_interval = 4
obj -> set, sum_flag = 1
obj -> set, use_flare_xyoffset = 1
obj -> filewrite, /fits, /buildsrm, all_simplify = 0, /create
;;;doesn't work???? try 

;DEFAULT ENERGY BINNING SCHEMES

;A number of energy binning schemes are defined for use in the spectrum 
;object and hessi_build_srm.  They are stored in the files 
;$SSWDB_HESSI/spec_resp/ct_edges.x where x is the scheme number.  You can 
;select one of these schemes by setting the sp_energy_binning control 
;parameter in the spectrum object to the scheme number.  If none of these 
;schemes fits your needs, you can define your own energy bins by setting 
;sp_energy_binning to an array of low/high energy edges ( fltarr(2,n) ).

;Energy Binning Schemes:

;0   3 bins    Three energy bands, 10 keV wide, starting from 20 keV.  
;                 Used mostly for quick software checks, but it 
;                 could be useful for some hard x-ray work.

;1   97 bins   1-keV bands, covering 3 to 100 keV.  Possibly good for
;                 high-resolution hard-x-ray work (fitting thermal and 
;                 nonthermal emission, etc.)

;2   5 bins    The three bands from "0" plus 50-100 and 100-200 keV bands; we 
;                 will probably use this binning for a lot of non-solar work 
;                 with the rear segments.

;3   7 bins    A broad band from 20 to 200 keV followed by 6 narrow bands (4-keV
;                 wide) to 224 keV.  Used in software debugging.

;4   1000 bins 1-keV bands from 3 to 1003 keV.  Mostly useful for generating
;                 finely-detailed response matrices for debugging and display 
;                 purposes.

;5   563 bins  1-keV each from 3 to 100 keV, then 5-keV bands to 1820 keV,
;                 and 10-keV to 2500.  In addition, there are sections of fine 
;                 binning around the 511 keV and 2.2 MeV lines.  This is a 
;                 good choice for first-look spectroscopy of gamma-ray flares.

;6   197 bins  1-keV bands covering 3 to 100 keV, then 5-keV bands to 600 keV.
;                 A more complete binning than "1" for studying hard x-ray 
;                 continuum spectra out to higher energies.

;7   19 bins   10-keV bands from 10 to 100 keV, then 50-keV bands to 600
;                 keV.  Good for survey work to select spectra for closer 
;                 analysis with "6".

;8   77 bins   3-keV bands from 4 to 118 keV, then 15-keV bands up to
;                 703 keV.  Intermediate between "6" and "7" in memory use 
;                 for hard x-ray work.

;9   4 bins    12-keV bands from 200 to 248 keV.  Another debugging mode.

;10  9 bins    Pseudo-logarithmic binning covering the entire HESSI
;                 energy range.  The bin edges are at [3, 6, 12, 25, 50, 100, 
;                 300, 1000, 2500, 20000] keV.  These spectra should contain 
;                 all the events in the HESSI data stream (minus any rejected 
;                 by event selection criteria like segment choices or coincidence 
;                 rejection).  Potentially useful for quick screening to separate 
;                 x-ray from gamma-ray flares, etc.

;11  791 bins  Detailed binning for fine analysis of large gamma-ray line flares.
;                 1-keV channels from 3 to 100 keV, then 5-keV channels to 1820 
;                 kev, interrupted by 0.5-keV channels across the 511 keV line 
;                 (500-520), then 10-keV channels to 2.5 MeV, interrupted by 
;                 1-keV channels across the 2223 keV neutron capture line, then 
;                 25 keV channels to 6.4 MeV, and then 50 keV channels to 10 MeV.

;12  517 bins  Somewhat more "economical" binning for gamma flares. 1 keV binning 
;                 from 3 to 60 keV, 2 keV to 120 keV, 5 keV to 250 keV, 10 keV to
;                 2250 keV (interruptions at 511 for 0.5 keV binning and 2223 for 
;                 1 keV binning as in "11"), 50 keV binning to 7.2 MeV, 200 keV 
;                 binning to 17.0 MeV.

;13  129 bins  Coarse, full-energy-range (3 keV to 16 MeV) binning for weak to 
;                 moderate gamma flares in which the only individual lines visible 
;                 are 511 keV and 2223 keV. Resolution is high at low energies 
;                 (3 keV up to 60 keV), then rapidly gets coarser until the bins 
;                 are 2 MeV broad above 10 MeV. There is a single narrowish bin 
;                 to contain each of the two lines.

;14   77 bins  For hard x-ray flares; empirically designed after looking at
;                 some real events.  1-keV bins from 3 to 40 keV, 3-keV bins
;                 up to 100 keV, 5-keV bins up to 150 keV, 10 keV bins to 250 keV.

;15 4500 bins  For long-term background accumulations; from 3 keV to 9453 keV
;                 in 4500 bins of 2.1 keV width.

;16  797 bins  Similar to 11, for fine analysis of large gamma-ray line flares.
;                 The only difference from 11 is finer (2 keV) bins around 
;                 847 keV.

;17  936 bins  A further elaboration beyond 11 and 16, for large gamma-ray line 
;                 flares.  Starting from the binning of 11, it adds 2 keV binning
;                 around lines at 339, 450, 847, 937, 1369, 1238, 1634, and 
;                1778 keV, and broadens the region of fine binning around 511 keV.
                                                             
;18  908 bins  Improved binning for large flares spanning 250 to 10000 keV. 
;              
;19  916 bins  Gamma-ray line flare code like 17, but with 1 keV bins around 511.

;20  888 bins  Gamma-ray line flare code like 18, but with 1 keV bins around 511.

;21  497 bins  Gamma-ray line flare code like 12, but with 1 keV bins around 511.

;22  101 bins  .3 keV binning from 3 to 15 keV, 1 keV to 50 keV, 5 keV to
;                 100 keV, and 10 keV to 300 keV.  Good for fine energy
;                 resolution analysis of the Iron line. 

;23  630 bins  Gamma-ray line flare code.  Same as 21, but extended to 150 MeV with 133 
;                additional 1 Mev wide bins. (Note: photon bins will extend to the 
;                top of the range, but count bins will not exceed 20 MeV.)
                                                             
;24  958 bins  
			  
;25  1141 bins Gamma-ray line flare code for moderate resolution. (Note: photon bins will 
;                extend to the top of the range, but count bins will not exceed 20 MeV.)
;              5 keV up to 1.5 MeV, 
;              10 keV from 1.5 to 3 MeV
;              15 keV from 3 MeV to 8 MeV, 
;              20 keV from 8 MeV to 12 MeV,
;              200 keV bins to 17.0 MeV,
;              1 MeV to 150 MeV.

;26  990 bins   Gamma-ray line code.  (Note: photon bins will extend to the 
;                  top of the range, but count bins will not exceed 20 MeV.)
;               5 keV bins 5-500 keV
;               1 keV bins 500-520 keV
;               5 keV bins 520-1800 keV
;               10 keV bins 1800-2210 keV
;               1 keV bins 2210-2230 keV
;               10 keV bins 2230-2500 keV                     
;               15 keV bins 2500-8500 keV
;               50 keV bins  8500-10000 keV
;               200 keV bins 10000-16000 keV
;               2000 keV bins 16000-150000 keV

;27  2452 bins  1 keV bins 3-2300 keV
;               500 keV bins 2300-10000 keV
;               1000 keV bins 10000-150000 keV
               		   
;28  963 bins   5 keV bins 5-500 keV
;               2 keV bins 500-520 keV
;               5 keV bins 520-1800 keV
;               10 keV bins 1800-2500 keV
;               15 keV bins 2500-8500 keV
;               50 keV bins 8500-10000 keV
;               200 keV bins 10000-16000 keV
;               2000 keV bins 16000-150000 keV

;29  128 bins   .3 keV bins 3-10 keV,
;               increasing logarithmically to ~10 keV at 300 keV


;;;;rhessi image
search_network, /enable
o_img = hsi_image()           ; create an instance of the image class
                                ; of objects
o_img -> print                ; list object parameters

time_interval = '29-Mar-14 '+['17:35:28','18:14:36']
position = [519, 262]          ; x and y center, in heliographic coordinates
                               ; (arcsecs from sun center)
strtstp = [540, 780]           ; start, stop seconds from start of time_interval (integration time)
erng = [50.,100.]			   ;energy range to be integrated	

im = o_img -> getdata(obs_time=time_interval,   ; overall interval 
                    time_range= strtstp,        ; start, stop seconds from
                                                ; start of overall interval
                    xyoffset=position           ; center for reconstruction
                    image_algorithm='clean')    ; reconstruction algorithm,
                                                ; back-projection by default

im = o_img -> getdata(obs_time = time_interval, $
								 time_range = strtstp, $
								 xyoffset=position, $
								 im_energy_binning = erng, $
								 image_alrogithm='clean')
o_img -> plot                                   ; plot the image  


;% HSI_CALIB_EVENTLIST_RAW::PROCESS: !!!!!!!!Warning. Attenuator state changed during the observing interval29-Mar-2014
;                            17:40:27.990 - 29-Mar-2014 17:44:32.212 - 29-Mar-2014 17:44:32.590 - 29-Mar-2014 17:45:58.269 -
;                            29-Mar-2014 17:45:58.524 - 29-Mar-2014 17:50:00.214 - 29-Mar-2014 17:50:00.517 - 29-Mar-2014
;                            17:50:00.580 - 29-Mar-2014 17:50:00.642

hmap = o_img -> makemap() ;;doesnt work???

fits2map
end
