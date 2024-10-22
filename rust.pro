;+
; NAME:  
;             RUST
; PURPOSE:
;             read and unpack data and pixel coordinate arrays for image 
;             saved in a structure variable created by RDFIS
; CATEGORY:  
;             utility
; CALLING SEQUENCE: 
;             rust,img,data,xp,yp
; INPUTS:    
;             img = image structure
; OUTPUTS:     
;             data = 2d image array
;             xp   = cartesian coordinates of image pixels in x-direction (+ W)
;             yp   = cartesian coordinates of image pixels in y-direction (+ N)
; OPTIONAL OUTPUTS:
;             dx,dy = mean spacing between pixels
;             xc,yc = mean center of image
; PROCEDURE:                         
;             simple
; MODIFICATION HISTORY:                           
;             written DMZ (ARC) Aug'91
;-

pro rust,img,data,xp,yp,dx,dy,xc,yc

sc=size(img) 
if sc(n_elements(sc)-2) ne 8 then begin
 print,'* input image not a valid structure' & return
endif
sz=size(img.data) & mbuf=sz(1) & nx=sz[1] & ny=sz[2] 
if nx*ny gt mbuf then begin
 print,'* image size exceeds buffer size' & return
endif
if sz(n_elements(sz)-2) eq 1 then data=bytarr(nx,ny) else $
 data=fltarr(nx,ny) 
xp=float(data) & yp=float(data)
data(0)=img.data(0:nx*ny-1)
xp(0)=img.xp(0:nx*ny-1) & yp(0)=img.yp(0:nx*ny-1)

if (nx eq 1) then begin                  ;take care of strip rasters
 if sz(n_elements(sz)-2) eq 1 then buff=bytarr(ny,2) else $
  buff=fltarr(ny,2)
 buff(0)=data(*) & data=transpose(buff) & nx=2 & img.nx=2
 dx=(max(yp)-min(yp))/(ny-1)
 xp=[xp,xp+dx] &  yp=[yp,yp] 
 img.xp=xp(*) & img.yp=yp(*) & img.data=data
endif

;-- compute size, center, and pixel spacings for image
;-- (warning: these concepts are meaningless if image has been warped)

 min_x=min(xp) & max_x=max(xp)
 min_y=min(yp) & max_y=max(yp)
 xb = [min_x,max_x,max_x,min_x,min_x]
 yb = [min_y,min_y,max_y,max_y,min_y]
 xc=(min_x+max_x)/2. &  yc=(min_y+max_y)/2.
 xside=abs(max_x-min_x) & yside=abs(max_y-min_y)
 dx=xside/(nx-1.) & dy=yside/(ny-1.)

 return & end


