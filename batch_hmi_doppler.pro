maindir = '/unsafe/jsr2/project2/'

;processes hmi dopplergrams


eventdir = '20110215/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [205.,-222.], /difffilt, /dopp

eventdir = '20110730/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-526., 170.], /difffilt, /dopp

eventdir = '20110926/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-519., 116.], /difffilt, /dopp

eventdir = '20120509/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [0., 389.], /difffilt, /dopp

eventdir = '20120510/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-364., 259.], /difffilt, /dopp

eventdir = '20120704/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [289., -343.], /difffilt, /dopp

eventdir = '201207050325/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [417., -338.], /difffilt, /dopp

eventdir = '201207051134/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [495., -332.], /difffilt, /dopp

eventdir = '20120706/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [585., -322.], /difffilt, /dopp

eventdir = '20121023/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-795., -272.], /difffilt, /dopp

eventdir = '20130213/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-338., 307.], /difffilt, /dopp

eventdir = '20130708/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [75., -217.], /difffilt, /dopp

eventdir = '20131106/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-549., -267.], /difffilt, /dopp

eventdir = '201311070339/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-450., -272.], /difffilt, /dopp

eventdir = '201311071428/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-363., -263.], /difffilt, /dopp

eventdir = '20140107/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-228., -168.], /difffilt, /dopp

eventdir = '20140202/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-300., 314.], /difffilt, /dopp

eventdir = '20140207/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [764., 270.], /difffilt, /dopp

eventdir = '20140329/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [519., 262.], /difffilt, /dopp

eventdir = '20150311/HMI/v/'
dir = maindir+eventdir
hmi_process_filter_universal, /process, dir, submap_range = [-350, -200], /difffilt, /dopp
