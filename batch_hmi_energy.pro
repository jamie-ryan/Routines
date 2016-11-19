;./Scripts/bsidl.sh Routines/batch_hmi_energy.pro batch_hmi_energy.log &

;;;this processes and converts to flux, energy and power, each hmi ic data set contained within the eventdir for project 2 

;;;hmi_process_filter_universal is set to take a directory as a location for fits files to be processed. 
;It will also put the sav file in the same place. 
;Using /phys_units, it runs the processed data through hmi_radiometric_calibration to 
;produce an array called hmifep = fltarr(3, n_elements(mp[0].data[*,0]), n_elements(mp[0].data[*,0]), n_elements(mp)).
;hmifep contains the entire hmidiff.data arrays converted into flux, energy and power.
;hmifep[0,*,*,*] = flux
;hmifep[0,*,*,*] = energy
;hmifep[0,*,*,*] = power

;;;Already done
maindir = '/unsafe/jsr2/project2/'
eventdir = '20110215/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [205.,-222.], /difffilt, /phys_units

.reset_session ;restarts session... effectively refreshing memory allocation :D


maindir = '/unsafe/jsr2/project2/'
eventdir = '20110730/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-526., 170.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20110926/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-519., 116.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20120309/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [0., 389.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20120510/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-364., 259.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20120704/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [289., -343.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '201207050325/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [417., -338.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '201207051134/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [495., -332.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20120706/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [585., -322.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20121023/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-795., -272.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20130217/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-338., 307.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20130708/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [75., -217.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20131106/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-549., -267.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '201311070339/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-450., -272.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '201311071428/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-363., -263.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20140107/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-228., -168.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20140202/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-300., 314.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20140207/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [764., 270.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20140329/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [519., 262.], /difffilt, /phys_units

.reset_session


maindir = '/unsafe/jsr2/project2/'
eventdir = '20150311/HMI/ic/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-350, -200], /difffilt, /phys_units
