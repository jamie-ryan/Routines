

;+
; NAME
;
;     WRITE_MOVIE_MAP_MP4
;
; EXPLANATION
;
;     This routine takes a map array and writes out the frames out to
;     a mp4 file.
;
;     1. The OPLOT can be used to plot a cross at a particular
;        location on each image. Note that the position of the cross
;        is not corrected for differential rotation.
;
;     2. FILE_OPLOT this is used for complex overplotting of symbols
;        and text. Differential rotation is applied, and the
;        symbols/text can be over-plotted only on certain frames.
;
;     3. XMAP is used to specify another map array that is plotted in
;        a second window (!p.multi=[0,2,1]).
;
;     4. CONTOUR_MAP is used to over-plot another map array as a
;        contour on top of MAP.
;
; INPUTS
;
;     MAP     An array of maps that will be written as a set of
;             individual images.
;
; OPTIONAL INPUTS
;
;     OPLOT   2 element array that gives the position of cross to
;             overplot on the movie frames.
;
;     FILE_OPLOT This allows more complex over-plotting of text on the
;                movie images. FILE_OPLOT is the name of a text file,
;                and the file should have the format
;                (2i5,i3,3a20). The first two integers give the X and
;                Y coordintes. The second integer gives the plot
;                symbol (standard IDL format; a -1 indicates to symbol
;                should be used). The first two strings give the start
;                and end time for the period over which the
;                symbol/text should be plotted. Empty strings indicate
;                that the symbol/text is plotted for the whole time
;                range. The final string gives the text that should be
;                plotted. 
;
;     XMAP    This is the name of another map array, and a 2 panel
;             plot will be created with MAP in the left-hand plot and
;             XMAP in the right-hand plot.
;
;     XMAP_DMAX  Sets DMAX for the XMAP plots.
;
;     CONTOUR_MAP  A map array that is used to over-plot contours onto
;                  MAP. The routine automatically finds the nearest
;                  image within CONTOUR_MAP to over-plot.
;
;     CONTOUR_LEVEL The routine automatically calculates contour
;                   levels for CONTOUR_MAP, but this keyword allows
;                   them to be manually specified.
;
; HISTORY
;
;     Beta 1, 22-Aug-2013, Peter Young
;        This had been modified from write_map_movie_png, but the full
;        functionality has not been implemented yet.
;
; $Revision: $:
; $Author: $:
; $Date: $:
;-


;----------------
function wm_make_image, map, log=log, dmax=dmax, dmin=dmin, reverse=reverse, $
                        title=title

map2=map

img=float(map.data)
img=img<dmax
img=img>dmin

ddmax=dmax
ddmin=dmin

IF keyword_set(log) THEN BEGIN
  img=alog10(img)
 ;
  ddmax=alog10(dmax)
  ddmin=alog10(dmin)
ENDIF 

IF keyword_set(reverse) THEN BEGIN
  img=ddmax-img
  ddmax=ddmax-ddmin
  ddmin=0
ENDIF 

img=bytscl(img,max=ddmax,min=ddmin)

time=anytim2utc(/ccsds,map.time,/trunc,/time)
date=anytim2utc(/ccsds,map.time,/date)
etime_str='t_exp='+trim(string(format='(f10.1)',map.dur))+' s'
title=date+' '+time+', '+etime_str

return,img

END



;----------------------
PRO write_movie_map_mp4, map, xsize=xsize, ysize=ysize, filename=filename, $
                         dmax=dmax, log=log, reverse=reverse, dmin=dmin, $
                         outdir=outdir, $
                         oplot=oplot, diff=diff, file_oplot=file_oplot, $
                         extra_map=xmap, xmap_dmax=xmap_dmax, xmap_dmin=xmap_dmin, $
                         contour_map=contour_map, contour_levels=contour_levels, $
                         mag=mag, $
                         outfile=outfile

IF n_elements(outfile) EQ 0 THEN BEGIN
  IF NOT keyword_set(quiet) THEN BEGIN
    print,'%WRITE_MOVIE_MAP_MP4: OUTFILE not specified. Movie will be written to movie.mp4.'
  ENDIF 
  outfile='movie.mp4'
ENDIF ELSE BEGIN
  outfile=expand_path(outfile)
ENDELSE 

IF n_elements(frame_rate) EQ 0 THEN frame_rate=15

IF NOT keyword_set(quiet) THEN BEGIN
  print,'Max of data array is: ',max(map.data)
  print,'Min of data array is: ',min(map.data)
  print,'  (use dmin= and dmax= to change these values)'
ENDIF 

s=size(map.data,/dim)
nx=s[0]
ny=s[1]
n=s[2]

;
; Specifies the default size of the output image frames.
;
IF n_elements(xsize) EQ 0 THEN xsize=500
IF n_elements(ysize) EQ 0 THEN ysize=500


CASE 1 OF
  keyword_set(diff): BEGIN
    loadct,0
    IF n_elements(dmax) EQ 0 THEN dmax=max(abs(map.data))
    dmin=-dmax
;    IF n_elements(filename) EQ 0 THEN filename='diff_image_'
  END
 ;
  keyword_set(mag): BEGIN
    loadct,0
    IF n_elements(dmax) EQ 0 THEN dmax=max(abs(map.data))
    dmin=-dmax
;    IF n_elements(filename) EQ 0 THEN filename='mag_image_'
  END
 ;
  ELSE: BEGIN
    loadct,3
    IF n_elements(dmax) EQ 0 THEN dmax=max(map.data)
    IF n_elements(dmin) EQ 0 THEN dmin=min(map.data)
;    IF N_elements(filename) EQ 0 THEN filename='image_'
  END
ENDCASE

;
; Frames per second (fps) for the movie
;
IF n_elements(fps) EQ 0 THEN fps=15

;
; Compute the default bit rate for the movie. Using a factor 4 seems
; to give an almost loss-less movie.
;
IF n_elements(bit_rate) EQ 0 THEN bit_rate=float(xsize)*float(ysize)*float(fps)*float(2)

;
; Print information about movie
;
IF NOT keyword_set(quiet) THEN BEGIN 
  print,'Movie parameters:'
  print,'    X-size: ',trim(xsize),'                 [xsize= ]'
  print,'    Y-size: ',trim(ysize),'                 [ysize= ]'
  print,'    Frames-per-second: ',trim(fps),'       [fps= ]'
  print,'    Bit rate (Mbitps): ',trim(string(format='(f10.2)',bit_rate/1024.^2)),'    [bit_rate= ]'
ENDIF


;
; Create the video object
;
ovid=idlffvideowrite(outfile)
vidstream=ovid.addvideostream(xsize,ysize,fps,bit_rate=bit_rate)


;
; Work out scale factor
;
xfactor=xsize*0.75/nx
yfactor=ysize*0.75/ny
scale_factor=min([xfactor,yfactor])

;
; Write the individual movie frames.
;
FOR i=0,n-1 DO BEGIN
  x=(findgen(nx)-float(nx)/2.)*map[i].dx+map[i].xc
  y=(findgen(ny)-float(ny)/2.)*map[i].dy+map[i].yc
 ;
  img=wm_make_image(map[i], log=log, dmax=dmax, dmin=dmin, $
                    reverse=reverse, title=title)

  p=image(img,x,y, $
          axis_style=2,dim=[xsize,ysize],/buffer,rgb_table=3, $
          title=title)
  p.scale,scale_factor,scale_factor
  time=ovid.put(vidstream,p.copywindow())
  p.close
ENDFOR

ovid.cleanup


END

