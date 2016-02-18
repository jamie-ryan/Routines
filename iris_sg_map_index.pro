;build an index for iris sg map

;plot_map looks for:
;index[i].time
;index[i].

;get_map_prop looks for:
;index.NX
;index.NY
;index.DR
;index.XP
;index.YP
;index.XR
;index.YR
;-- spacings
;index.SPA
;index.DX
;index.DY
;-- center
;index.CEN
;index.XC
;index.YC
;-- check for roll parameters
;index.ROLL_C ;roll centre
;index.ROLL ;roll angle















;help, hmidiff, /str
;   DATA            FLOAT     Array[310, 304]
;   XC              DOUBLE           497.40002
;   YC              DOUBLE           280.80001
;   DX              DOUBLE          0.60000002
;   DY              DOUBLE          0.60000002
;   TIME            STRING    '29-Mar-2014 17:46:16.600'
;   ID              STRING    'SDO HMI_FRONT2 6173'
;   DUR             FLOAT           0.00000
;   XUNITS          STRING    'arcsecs'
;   YUNITS          STRING    'arcsecs'
;   ROLL_ANGLE      DOUBLE           0.0000000
;   ROLL_CENTER     DOUBLE    Array[2]
;   SOHO            BYTE         0
;   L0              DOUBLE           0.0000000
;   B0              DOUBLE          -6.6729843
;   RSUN            DOUBLE           960.38319
;   RTIME           STRING    '29-Mar-2014 17:46:16.600'
;   DIFFERENCE      STRING    '29-Mar-2014 17:46:16.600 - 29-Mar-2014'...


restore, '/unsafe/jsr2/sp2826-Feb8-2016.sav'
XC = sp2826.tag0176.xcen
YC = sp2826.tag0176.xcen
DX              DOUBLE          0.16700002
DY              DOUBLE          0.16700002
TIME =  = sp2826.tag0176.time_ccsds[3] ;map needs a single string, take middle value?
ID              STRING    'IRIS SG 2825.7 - 2825.8'
;DUR             FLOAT           0.00000
   XUNITS          STRING    'arcsecs'
   YUNITS          STRING    'arcsecs'
   ROLL_ANGLE      DOUBLE           0.0000000
   ROLL_CENTER     DOUBLE    Array[2]
;   SOHO            BYTE         0
;   L0              DOUBLE           0.0000000
;   B0              DOUBLE          -6.6729843
;   RSUN            DOUBLE           960.38319
;   RTIME           STRING    '29-Mar-2014 17:46:16.600'
;   DIFFERENCE      STRING    '29-Mar-2014 17:46:16.600 - 29-Mar-2014'...
 
