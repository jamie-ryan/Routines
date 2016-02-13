pro read_iris_l2_cp, l2files, index, data, _extra=_extra, keep_null=keep_null, append=append, silent=silent, $
   wave=wave,remove_bad=remove_bad, rows=rows, imagen=imagen, $
   adata=adata, aindex=aindex, eindex=eindex, timerange=timerange
;
;+
;   Name: read_iris_l2
;
;   Purpose: iris level2 files -> index,data (usually called by read_iris)
;
;   Input Parameters:
;      l2files - local full path of One IRIS level 2 SJI or vector of one or more RASTER files (one OBSID)
;
;   Output Parameters:
;      index - L2 meta data ~ssw standard
;      data  - data
;
;   Keyword Parameters:
;      WAVE - optional/desired wave in conjunction with raster input (->iris_l2_wave2extension) ; float or string; def='C II'
;     keep_null (switch) - if set , retain NULL images - default returns only non-null index,data
;     rows -or- imagen (synonyms) - optional subset of rows/image/spectra numbers to read - vector of subscripts
;     timerange - optional timerange to read - assume temporal subset of entire obs (maps -> ROWS and uses rows logic)
;
;   Calling Examples:
;      IDL> read_iris_l2,sjifile,index,data ; contents of SJI L2 file -> "index,data" e.g. 2Dx2DxNFRAMES
;      IDL> read_iris_l2,rastfile,index,data [,WAVE=WAVE] ; default C II
;      IDL> read_iris_l2,<file>,index,data,imagen=indgen(200) ; only 1st 200 images/spectra in <file> (sji or raster)
;      IDL> read_iris_l2,sjifile, TIMERANGE=[t0,t1] ; temporal sub-range (via -> ROWS logic)
;
;   Restrictions:
;      prototype routine... - nothing rigorous abou
;
;   History:
;      Circa Sept 1 - S.L.Freeland - sji
;      28-sep-2013 - raster support (prototype!)
;      30-sep-2013 - add WAVE input/selection for raster file input
;       3-sep-2013 - include total(total(data,2),1) > 0 
;      26-oct-2013 - bdp/slf - keep_nulls->keep_null ; add /fscale->mrdfits call
;      18-nov-2013 - Slf - adjust null logic - use ABS(stuff) 
;      20-jan-2014 - Slf - optional ROWS -> mrdfits - synonym=imagen
;                          adjust 'index' if rows/imagen supplied
;      21-jan-2014 - slf - repair a small issue with Yesterdays 'adjust index' mod
;       5-feb-2014 - slf - Major: for vector/non-sit&stare, times relative to obsstart, not file date_obs
;      20-feb-2014 - slf - date_obs -> startobs
;      10-mar-2014 - slf - generalize the sji bit (extension 1/per-image stuff added since original version; this should auto-track)
;       2-apr-2014 - slf - oops, hard coded 20 -> n_elements(tnames) to complete 10-mar-2014 generalization...
;       6-may-2014 - slf - xcen/ycen/exptime SJI
;       5-sep-2014 - slf - use insertion for sji null image removal
;       9-sep-2014 - slf - fix ROWS/IMAGEN option for SJI, allow index-only (avoid data read) - faster data reads 
;                          add TIMERANGE optional keyword (sji only for now) maps t0,t1 -> ROWs logic
;                          Alpha version (external name NE internal name)
;      20-oct-2014 - slf - add some index:eindex typing protection
;      13-mar-2015 - slf - fix null removal logic for SJI
;      15-mar-2015 - slf - fix 13-mar fix(!)
;       3-jun-2015 - slf - naxis -> 2 (SJI only for now) + PC matrix updates per J.P.Wuelser
;-

loud=1-keyword_set(silent)
nf=n_elements(l2files)

fex=where(file_exist(l2files),ecnt)

if nf eq 0 or ecnt eq 0 then begin 
   box_message,'at least one file not found, bailing..
   return
endif

f2=l2files[fex]

mreadfits_header,f2,index, only_tags='tsr1,ter1,tsc1,tec1,date_obs,datamean'
info=get_infox(index,'tsr1,ter1,tsc1,tec1')

modes=all_vals(info)
nmodes=n_elements(modes)


raster=strpos(f2[0],'_raster_') ne -1  
sji=1-raster

case 1 of 
   raster and n_elements(timerange) eq 2 and n_elements(f2) gt 1: begin 
      box_message,'raster file timerange subselect
      epoch=ssw_time2epoch(index.date_obs,timerange[0],timerange[1])
      sse=where(epoch eq 0, ecnt)
      if ecnt eq 0 then begin 
         box_message,'No raster files in your TIMERANGE, bailing...'
         return ; EARLY EXIT on bum TIMERANGE
      endif
      f2=f2[sse]
   endcase
   sji: begin 
      if n_elements(imagen) ne 0 then rows=imagen ; imagen=<image#s> synonym for rows=<row#s> ; e.g. subset of images
      if n_elements(timerange) eq 2 and n_elements(rows) eq 0 then begin  ; map timerange -> ROWS for temporal sub-range reads
         ftimes=iris_l2_file2times(f2[0])
         epoch=ssw_time2epoch(ftimes,timerange[0],timerange[1])
         rows=where(epoch eq 0,rcnt)
         if rcnt eq 0 then begin
            box_message,'No images in your TIMERANGE(??), bailing...)
            return ; EARLY EXIT on bum TIMERANGE
         endif
      endif  
   endcase
   raster and n_elements(timerange) eq 2: begin
      box_message,'sit and stare + TIMERANGE'
      stop
   endcase
   else: 
endcase   

if nmodes gt 1 then begin
   box_message,'Cannot mix & match FOVS... separate, and get back to me...'
   return
end
ndata=n_params() gt 2 

if raster then begin ; raster piece

   if not keyword_set(append) then delvarx,index,data 
   r0=f2[0]
   nextend=get_fits_nextend(r0) ; assume consistent
   mreadfits_header,r0,h0template 
   startobs=h0template.startobs
   tnames=tag_names(h0template)
   for f=0,n_elements(f2)-1 do begin 
      rx=f2[f]
      if loud then box_message,rx
      mreadfits_header,rx,head0 ; primary header
      rinfo=mrdfits(rx,nextend-1,silent=silent,/fscale) ; per-image info
      rinfohead=fitshead2struct(headfits(rx,ext=nextend-1))
      wavename=strarr(nextend)
      wavelnth=dblarr(nextend)
      wavemin=dblarr(nextend)
      wavemax=dblarr(nextend)
      wext=iris_l2_wave2extension(head0, wave)
      if wext eq -1 then begin 
         box_message,'Requested WAVE does not exist in this file >> ' +wave
         return ; EARLY EXIT ON No-such-wave
      endif
      for e=wext,wext do begin
         if ndata then begin 
            data=mrdfits(rx,e,silent=silent,/fscale,rows=rows)
            if n_elements(data) eq 1 then begin 
               box_message,'data prob - trying alternate...
               if n_elements(iobj) eq 0 then iobj=iris_load(rx)
               data=iobj->getvar(e-1,/load)
            endif
         endif
         rindex=fitshead2struct(headfits(rx,ext=e))
         nimg=rindex.naxis3
         l2temp=iris_l2_strtemplate()
         eindex=join_struct(head0,l2temp)
         eindex=join_struct(eindex,rindex)
         eindex=replicate(eindex,nimg)
         temptn=tag_names(l2temp)
         for t=0,n_elements(temptn)-1 do begin 
            eindex.(tag_index(eindex,temptn[t]))=reform(rinfo[t,*])
         endfor
         eindex.date_obs=anytim(anytim(startobs) + eindex.time,/ccsds) ; slf, 5-feb-2014
         eindex=add_tag(eindex,gt_tagval(eindex,'twave'+strtrim(e,2)),'wavelnth')
         eindex=add_tag(eindex,gt_tagval(eindex,'tdesc'+strtrim(e,2)),'wavename')
         eindex=add_tag(eindex,gt_tagval(eindex,'twmin'+strtrim(e,2)),'wavemin')
         eindex=add_tag(eindex,gt_tagval(eindex,'twmax'+strtrim(e,2)),'wavemax')
         if n_elements(f2) gt 1 then eindex=rem_tag(eindex,'history')
         if n_elements(index) eq 0 then index=replicate(eindex[0],n_elements(f2)*nimg)
         tempx=replicate(index[0],n_elements(eindex))
         tempx=str_copy_tags(tempx,eindex) ; force typing of eindex -> index
         index[f*nimg]=tempx  ; slf, 20-oct-2014 - eindex -> tempx
         if n_elements(f2) gt 1 and ndata then begin 
            if f eq 0 then begin 
               if loud then box_message,'Reading ' + strtrim(n_elements(f2),2) +' raster files...'
               odata=make_array(data_chk(data,/nx),data_chk(data,/ny),data_chk(data,/nimage),n_elements(f2))
            endif
            odata(0,0,0,f)=data
         endif
         if n_elements(rows) gt 0 then index=index[rows]
      endfor
   endfor ; end of raster file processing
   delvarx,iobj
endif else begin ; assuming SJI...

;mreadfits,f2,index,data,_extra=_extra
mreadfits,f2,index,_extra=_extra


if n_elements(rows) gt 0 then index=index[rows]
if n_params() ge 3 then data=mrdfits(f2[0],rows=rows,/fscale,silent=silent) 

; define per-frame/image header structure - major rewrite 10-mar-2014
mreadfits_header,f2[0],/extension,pinfo
tnames=tag_names(pinfo)
tnames=tnames[where(tnames eq 'TIME'):where(tnames eq 'COMMENT')-1] ;
create_struct_temp,pinfostr,'',tnames,replicate('D',n_elements(tnames))
pinfo=replicate(pinfostr,n_elements(index))
index=join_struct(index,pinfo)
if not required_tags(index,/date_obs) then index=add_tag(index,'','DATE_OBS')
nf=n_elements(f2)
pnt=0
for f=0,nf-1 do begin 
   imginf=mrdfits(f2[f],1,header,silent=silent,/fscale,rows=rows)
   ndata=data_chk(imginf,/ny)
   lastd=pnt+ndata-1
   for t=0,n_tags(pinfostr)-1 do begin
      tind=tag_index(index,tnames[t])
      index[pnt:lastd].(tind)=reform(imginf[t,*]) 
   endfor
   index[pnt:lastd].date_obs=anytim( anytim(index[pnt:lastd].startobs) + reform(imginf[0,*]),/ccsds) ; slf, 20-feb-2014 date_obs->startobs
   pnt=pnt+ndata
endfor


okcnt=n_elements(index)
if n_elements(data) gt 0 then begin
   totdn=total(total(data>0,2),1) 
   index=add_tag(index,totdn,'totdn')
   tdd=totdn>0<1000
   ok=tdd gt 0
   okss=where(ok,okcnt)
if get_logenv('check_null') ne '' then stop,'okss,totdn
   if okcnt lt n_elements(index) and 1-keyword_set(keep_null) then begin 
      box_message,'removing null images; use /KEEP_NULL to avoid this default'
      index=index[okss]
      temp=make_array(data_chk(data,/nx),data_chk(data,/ny),okcnt,type=data_chk(data,/type),/nozero)
      for i=0,okcnt-1 do temp[0,0,i]=data[*,*,okss[i]]
      data=temporary(temp)
   endif
endif

; populate per-exposure from extension -> crval1/crval2/exptime
if required_tags(index,'crval1,xcen,exptime,xcenix') then begin 
   index.xcen=index.xcenix
   index.ycen=index.ycenix
   index.crval1=index.xcenix
   index.crval2=index.ycenix
   index.exptime=index.exptimes
   index.pc1_1=index.pc1_1ix
   index.pc1_2=index.pc1_2ix
   index.pc2_1=index.pc2_1ix
   index.pc2_2=index.pc2_2ix
   index.naxis=2 ; 3D -> 2D per "index,data" pair
endif



endelse ; end of SJI bit


if n_elements(odata) gt n_elements(data) then begin
   delvarx,data
   data=temporary(odata)
endif
      
return
end

