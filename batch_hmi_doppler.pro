;./Scripts/bsidl.sh Routines/batch_hmi_doppler.pro batch_hmi_doppler.log &

maindir = '/unsafe/jsr2/project2/'

;processes hmi dopplergrams


eventdir = '20110215/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [205.,-222.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20110730/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-526., 170.],  /dopp


.reset_session


maindir = '/unsafe/jsr2/project2/'


eventdir = '20110926/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-519., 116.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20120509/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [0., 389.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20120510/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-364., 259.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20120704/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [289., -343.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '201207050325/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [417., -338.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '201207051134/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [495., -332.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20120706/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [585., -322.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20121023/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-795., -272.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20130213/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-338., 307.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20130708/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [75., -217.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20131106/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-549., -267.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '201311070339/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-450., -272.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '201311071428/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-363., -263.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20140107/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-228., -168.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20140202/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-300., 314.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20140207/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [764., 270.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20140329/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [519., 262.],  /dopp

.reset_session


maindir = '/unsafe/jsr2/project2/'

eventdir = '20150311/HMI/v/'
print, eventdir
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-350, -200],  /dopp
