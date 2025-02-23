;try out some hmi dopp data

dir = '/unsafe/jsr2/project2/20150311/HMI/v/'                                     
                                                        
files = findfile(dir+'*')
aia_prep, files,-1, out_ind, out_dat, /despike
index2map, out_ind, out_dat, map

;Event epicenter
x = -350.	
y = -200.

x0 = -300
xf = -400
y0 = -150
yf = -250

sub_map, map, xr=[x0,xf], yr=[y0,yf], mp
map2index, mp, mp_ind, mp_dat

plot_image, mp_dat[*,*,6]
cursor, x, y & plot, mp[*].data[x,y]

;clicking on white pixels gave a positive value..... white  = blue shift = towards observer
;clicking on black pixels gave a negative value..... black  = red shift = towards sun


