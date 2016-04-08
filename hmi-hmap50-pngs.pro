restore, 'hmi-submaps-for-movies.sav'
restore, '/disk/solar3/jsr2/Data/SDO/hmap50.sav'
;IDL> help, hmap50, shminf
;HMAP50          STRUCT    = -> <Anonymous> Array[24]
;SHMINF          STRUCT    = -> <Anonymous> Array[45]

;help, hmap50[1] renders 17:45:38
;help, hmap50[23] renders 17:52:58
;help, shminf[27] renders 17:45:31

;hmap50 has a cadence of 20 seconds
;shminf has cadence of 45 seconds  


;IDL> print, n_elements(shminf) - 27
;          18
;but hmap50 is 24 elements...check times manually and make a new map structure 18 elements long based on rhessi data with exact hmi times


;IDL> print, shminf[27:37].time
;29-Mar-2014 17:45:31.600 29-Mar-2014 17:46:16.600 29-Mar-2014 17:47:01.600 29-Mar-2014 17:47:46.600 29-Mar-2014 17:48:31.600
;29-Mar-2014 17:49:16.600 29-Mar-2014 17:50:01.600 29-Mar-2014 17:50:46.600 29-Mar-2014 17:51:31.600 29-Mar-2014 17:52:16.600
;29-Mar-2014 17:53:01.600
;IDL> help, shminf[27:37]      
;<Expression>    STRUCT    = -> <Anonymous> Array[11]


;IDL> print, hmap50[1:*].time        
;29-Mar-2014 17:45:38.000 29-Mar-2014 17:45:58.000 29-Mar-2014 17:46:18.000 29-Mar-2014 17:46:38.000 29-Mar-2014 17:46:58.000
;29-Mar-2014 17:47:18.000 29-Mar-2014 17:47:38.000 29-Mar-2014 17:47:58.000 29-Mar-2014 17:48:18.000 29-Mar-2014 17:48:38.000
;29-Mar-2014 17:48:58.000 29-Mar-2014 17:49:18.000 29-Mar-2014 17:49:38.000 29-Mar-2014 17:49:58.000 29-Mar-2014 17:50:18.000
;29-Mar-2014 17:50:38.000 29-Mar-2014 17:50:58.000 29-Mar-2014 17:51:18.000 29-Mar-2014 17:51:38.000 29-Mar-2014 17:51:58.000
;29-Mar-2014 17:52:18.000 29-Mar-2014 17:52:38.000 29-Mar-2014 17:52:58.000
;IDL> help, hmap50[1:*]      
;<Expression>    STRUCT    = -> <Anonymous> Array[23]

;so if n0 is the starting element (n0 = 1) for hmap50 then to align temporally with hmi.time we need hmap50[n0 + i*2].time
n0 = 1
for i = 0, n_elements() - 1 do begin

hmap50[n0 + 1*2]



map2png, file_string, map, colour, oplt = oplt, omap, ocolour, lvls, thresh = thresh, log = log
;z stands for zoom
map2png, 'HMI_Cont_z', shminf, 3, /oplt, hmap50, 0, lvls = [0.8, 90, 92, 94, 96, 98]
map2png, 'HMI_Cont_Diff_z', shmidf, 3
