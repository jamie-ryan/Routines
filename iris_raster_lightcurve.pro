pro iris_raster_lightcurve

restore, '/unsafe/jsr2/Mar18-2016/balm_data-Mar18-2016.sav'

balmercoords = 0
common_x_pix = 0
iris_y_pix = 0
ncoords = 0
balmdat = 0
balmerdata = 0
;times = 0
;texp = 0
balmwidth = 0
fout = 0
eout = 0
f_err = 0
e_err = 0

;print, iris_x_pos
;      508.393      510.438      512.432      514.429      516.470      518.468      520.461      522.507
;      508.542      510.587      512.580      514.636      516.625      518.611      520.660      522.655
;      508.739      510.735      512.729      514.774      516.774      518.819      520.811      522.859
;      508.887      510.877      512.927      514.924      516.921      518.968      521.012      523.007
;      509.041      511.087      513.080      515.073      517.114      519.115      521.109      523.154
;      509.237      511.230      513.224      515.272      517.271      519.266      521.311      523.359
;      509.386      511.383      513.424      515.422      517.414      519.464      521.463      523.508
;      509.539      511.581      513.576      515.572      517.618      519.616      521.611      523.655
;      509.692      511.736      513.731      515.725      517.767      519.769      521.759      523.804
;      509.887      511.883      513.879      515.922      517.917      519.914      521.959      524.002
;      510.030      512.033      514.078      516.073      518.068      520.115      522.112      524.107
;      510.188      512.232      514.225      516.221      518.267      520.263      522.260      524.307
;      510.386      512.380      514.378      516.427      518.420      520.413      522.456      524.451
;      510.533      512.532      514.527      516.570      518.569      520.616      522.608      524.604
;      510.689      512.683      514.732      516.723      518.718      520.762      522.753      524.800
;      510.833      512.880      514.877      516.874      518.919      520.911      522.909      524.954
;      511.032      513.026      515.026      517.076      519.070      521.059      523.107      525.153
;      511.184      513.179      515.225      517.220      519.216      521.267      523.261      525.248
;      511.335      513.381      515.372      517.372      519.416      521.413      523.409      525.454
;      511.485      513.531      515.527      517.571      519.564      521.560      523.607      525.599
;      511.678      513.684      515.677      517.721      519.716      521.759      523.755      525.752
;      511.835      513.831      515.875      517.869      519.865      521.912      523.908      525.903
;      511.986      514.032      516.023      518.024      520.066      522.063      524.057      526.100
;      512.183      514.179      516.174      518.219      520.215      522.212      524.256      526.252
;      512.290      514.328      516.374      518.363      520.361      522.409      524.410      526.404
;      512.485      514.531      516.524      518.517      520.564      522.562      524.560      526.602
;      512.634      514.675      516.674      518.667      520.714      522.707      524.706      526.751
;      512.784      514.830      516.822      518.866      520.862      522.860      524.905      526.902
;      512.931      514.978      517.023      519.019      521.014      523.059      525.054      527.048
;      513.131      515.178      517.173      519.165      521.210      523.209      525.203      527.252

;balmercoordsfinal.txt
;518.50        264.00
;519.00        262.00
;519.70        263.20
;520.81        264.91
;523.39        265.13
;511.00        272.10


dataset = ['balmer']
for k = 0, n_elements(dataset)-1 do begin
    flnm = dataset[k]+'coordsfinal.txt' ;eg, flnm=hmicoords1.txt
    openr, lun, flnm, /get_lun
    nlin =  file_lines(flnm)
    tmp = fltarr(2, nlin)
    readf, lun, tmp
    com = dataset[k]+'coords = tmp' ;readf,lun,hmg
    exe = execute(com)
    free_lun, lun
endfor

;common pix will contain the pixel locations of the x coords in balmercoords.txt
;common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos)
common_x_pix = find_iris_slit_pos_new(balmercoords[0,*], iris_x_pos[*,23])
iris_y_pix = find_iris_slit_pos_new(balmercoords[1, *], iris_y_pos[*,23])

ncoords = n_elements(balmercoords[0,*])
balmdat = fltarr(ncoords, nfiles)
balmerdata = fltarr(4, ncoords, nfiles)

for i = 0, n_elements(balmerdata[0,0,*]) - 1 do begin 
balmerdata[0, *, i] = common_x_pix[*] ;think this will give a constant x y pix? check
balmerdata[1, *, i] = iris_y_pix[*]
endfor


;;;;;;;;;;;;;;;;;single pix;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;if keyword_set(single_pixel) then begin
for j = 0,  ncoords - 1 do begin 
    for i = 0, nfiles -1 do begin
;	    times[j,i] =  t_x_pos[common_x_pix[i], i]
	    times[j,i] =  times_corrected[common_x_pix[j], i]
        texp[j,i]  = exp1[common_x_pix[j], i]

        ;fill array with intensity summed over an area equal to sunquake area
        balmdat[j, i] = dat_bk_subtract_exp_weighted[common_x_pix[j], iris_y_pix[j] ,i]
        ;balmdat[j, i] = sumarea(dat_bk_subtract_exp_weighted[*,*,i], j, iris_y_pix[j, i], iradius, /sg)
    endfor
endfor
;endif
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




savf = '/unsafe/jsr2/Mar18-2016/balm-dat-final-coords.sav'
save, /variables, filename = savf

end
