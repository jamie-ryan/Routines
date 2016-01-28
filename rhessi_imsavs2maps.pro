pro rhessi_imsavs2maps

f = [ 'rhessi_image_0.sav', $
'rhessi_image_1.sav', $
'rhessi_image_2.sav', $
'rhessi_image_3.sav', $
'rhessi_image_4.sav', $
'rhessi_image_5.sav', $
'rhessi_image_6.sav' ]

;img0
restore, f[0]
obj->plotman
img0 = data
obj0 = obj

data = 0
obj = 0

;img1
restore, f[1]
obj->plotman
img1 = data
obj1 = obj
   
data = 0
obj = 0


;img2
restore, f[2]
obj->plotman
img2 = data
obj2 = obj

data = 0
obj = 0

;img3
restore, f[3]
obj->plotman
img3 = data
obj3 = obj
   
data = 0
obj = 0


;img4
restore, f[4]
obj->plotman
img4 = data
obj4 = obj

data = 0
obj = 0


;img5
restore, f[5]
obj->plotman
img5 = data 
obj5 = obj 

data = 0
obj = 0 

;img6
restore, f[6]
obj->plotman
img6 = data
obj6 = obj

data = 0
obj = 0
end
