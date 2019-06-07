Vsphere Mini Adaptec/Dell/LSI/ESXi Monitoring Package   
Author W.Kalka <wojtek.kalka@gmail.com>
Date 2019/06/07

Working with VSphere 6.0 6.5 tested

Installation 
btw after every reboot you have to run the 1 2 3 4 scripts .. 

-1 get arcconf, perccli and megacli for your controller and put it in the correct dir
   not sure I am allowed to add them to this repository, 

0. Upload the package to your persistant datastore raid dir 
   /vmfs/........./tools/

1. Make sure you have proper ssh keys and known_hosts in ssh/

2. edit ssh2.xml and adjust your ssh upload port to your server
   in the file 12345

2. run script 1-
 
3. Check /.ssh is ok

4. run script 2-

   and check that ssh to your server works ssh testwwwuser@server

5. edit raidstatus.sh to your liking

6. run 3- to update cron

7. run 4- to restart cron
