pro proj2_plotgoes
fdir = '/unsafe/jsr2/project2/'
flnm = '/unsafe/jsr2/project2/directories.txt'
openr, lun, flnm, /get_lun
nlin =  file_lines(flnm)
directories = strarr(nlin)
readf, lun, directories 
free_lun, lun

;flare
flnm = fdir+''+directories[0]+'/HMI/'+directories[0]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '11-mar-15 15:45', 2 ;20150311
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[0]+'/HMI/'+directories[0]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '11-mar-15 10:10', 1 ;20150311
device,/close
set_plot,'x'
!p.font=-1


;flare
flnm = fdir+''+directories[1]+'/HMI/'+directories[1]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '29-mar-14 17:30',1 ;20140329
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[1]+'/HMI/'+directories[1]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '29-mar-14 15:30',1 ;20140329
device,/close
set_plot,'x'
!p.font=-1 


;flare
flnm = fdir+''+directories[2]+'/HMI/'+directories[2]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-feb-14 10:00',1 ;20140207
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[2]+'/HMI/'+directories[2]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-feb-14 18:00',1 ;20140207
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[3]+'/HMI/'+directories[3]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '02-feb-14 06:00',1 ;20140202
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[3]+'/HMI/'+directories[3]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '02-feb-14 03:00',1 ;20140202
device,/close
set_plot,'x'
!p.font=-1


;flare
flnm = fdir+''+directories[4]+'/HMI/'+directories[4]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-jan-14 09:45',2 ;20140107
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[4]+'/HMI/'+directories[4]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-jan-14 00:00',0.5 ;20140107
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[5]+'/HMI/'+directories[5]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-nov-13 14:00',1 ;201311071428
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[5]+'/HMI/'+directories[5]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-nov-13 21:00',1
device,/close
set_plot,'x'
!p.font=-1 



;flare
flnm = fdir+''+directories[6]+'/HMI/'+directories[6]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-nov-13 03:00', 1 ;201311070339
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[6]+'/HMI/'+directories[6]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '07-nov-13 21:00',1 ;201311070339
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[7]+'/HMI/'+directories[7]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '06-nov-13 13:00',2 ;20131106
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[7]+'/HMI/'+directories[7]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '06-nov-13 11:10',0.5 ;20131106
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[8]+'/HMI/'+directories[8]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '08-jul-13 01:00',1 ;20130708
device,/close
set_plot,'x'
!p.font=-1 
;preflare
flnm = fdir+''+directories[8]+'/HMI/'+directories[8]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '08-jul-13 00:00', 0.5 ;20130708
device,/close
set_plot,'x'
!p.font=-1 



;flare
flnm = fdir+''+directories[9]+'/HMI/'+directories[9]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '17-feb-13 15:30',1 ;20130217
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[9]+'/HMI/'+directories[9]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '17-feb-13 11:35',0.5 ;20130217
device,/close
set_plot,'x'
!p.font=-1 


;flare
flnm = fdir+''+directories[10]+'/HMI/'+directories[10]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '23-oct-12 03:00',1 ;20121023
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[10]+'/HMI/'+directories[10]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '23-oct-12 02:00',1 ;20121023
device,/close
set_plot,'x'
!p.font=-1


;flare
flnm = fdir+''+directories[11]+'/HMI/'+directories[11]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '06-jul-12 01:00', 1 ;20120706
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[11]+'/HMI/'+directories[11]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '05-jul-12 23:00', 1 ;20120706
device,/close
set_plot,'x'
!p.font=-1

;flare
flnm = fdir+''+directories[12]+'/HMI/'+directories[12]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '05-jul-12 10:40',2 ;201207051134
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[12]+'/HMI/'+directories[12]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '05-jul-12 10:20',1 ;201207051134
device,/close
set_plot,'x'
!p.font=-1


;flare
flnm = fdir+''+directories[13]+'/HMI/'+directories[13]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '05-jul-12 02:30', 2 ;201207050325
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[13]+'/HMI/'+directories[13]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '05-jul-12 01:00',2 ;201207050325
device,/close
set_plot,'x'
!p.font=-1 


;flare
flnm = fdir+''+directories[14]+'/HMI/'+directories[14]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '04-jul-12 09:00',2 ;20120704
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[14]+'/HMI/'+directories[14]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '04-jul-12 05:00',1 ;20120704
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[15]+'/HMI/'+directories[15]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '10-may-12 03:00', 2 ;20120510
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[15]+'/HMI/'+directories[15]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '10-may-11 06:00', 1 ;20120510
device,/close
set_plot,'x'
!p.font=-1 



;flare
flnm = fdir+''+directories[16]+'/HMI/'+directories[16]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '09-mar-12 02:00', 2 ;20120309
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[16]+'/HMI/'+directories[16]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '09-mar-12', 1 ;20120309
device,/close
set_plot,'x'
!p.font=-1 


;flare
flnm = fdir+''+directories[17]+'/HMI/'+directories[17]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '26-sep-11 04:00', 2 ;20110926
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[17]+'/HMI/'+directories[17]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '25-sep-11 04:00', '25-sep-11 04:40' ;20110926
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[18]+'/HMI/'+directories[18]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '30-jul-11 02:00', 3 ;20110730
device,/close
set_plot,'x'
!p.font=-1 
;pre-flare
flnm = fdir+''+directories[18]+'/HMI/'+directories[18]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '30-jul-11 01:00', 1 ;20110730
device,/close
set_plot,'x'
!p.font=-1 

;flare
flnm = fdir+''+directories[19]+'/HMI/'+directories[19]+'goes.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '15-feb-11', 3 ;20110215
device,/close
set_plot,'x'
!p.font=-1
;preflare 
flnm = fdir+''+directories[19]+'/HMI/'+directories[19]+'goes-pf.eps'
!p.font=0			;use postscript fonts
set_plot, 'ps'
device, filename= flnm, encapsulated=eps, $
/helvetica,/isolatin1, landscape=0, color=1
plot_goes, '14-feb-11 01:00', 1 ;20110215
device,/close
set_plot,'x'
!p.font=-1 
end
