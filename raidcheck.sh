#!/bin/sh

# Some Variables
servername='testserver'
datastore=$(pwd)
tmpfile='/tmp/sn.raidstatus'

#Update Datastore File
updateds='true'

#Upload via SSH
updatessh='true'

#Upload raidinfo to yourwebserver
sshserver='sshwwwuser@demoserver:/var/www/sshuploadtmp/'
sshuploadfile='.raid-status.txt'
sshconnection=$sshserver$servername$sshuploadfile
sshport='12345'

#Controller
ctrladaptec='true'
ctrllsi='false' 

#Debug
debug='true'

if $debug 
  then echo ESXi Raidcheck  
  echo Debug - $debug
  echo UpdateDS - $updateds
  echo SSH to - $sshconnection
fi


#Check Raid with megacli, perccli or arcconf

#megacli for LSI Controller 
if $ctrllsi 
 then 
  cd /opt/sn/raidcheck/lsi
  /opt/sn/raidcheck/lsi/megacli -PdList -aALL| awk -f /opt/sn/raidcheck/analysis.awk >$tmpfile
 
  if grep -qv 'Online' $tmpfile
    then
    echo 'BROKEN RAID' >>$tmpfile
    if $updateds
      then
      cp -a $tmpfile $datastore/raid_broken.txt
    fi
  fi
fi


#PercCli
#/opt/sn/raidcheck/perc/perccli /c0 show all |grep Onln | awk '{gsub(/Onln/,"Online")}1' |grep 512 >$tmpfile

# Adaptec with arcconf
if $ctrladaptec 
  then
  /opt/sn/raidcheck/adaptec/arcconf GETCONFIG 1 LD | grep Opti >$tmpfile
  /opt/sn/raidcheck/adaptec/arcconf GETCONFIG 1 LD | grep Present >>$tmpfile
fi


echo '^^^^^^^^^^^^^-----------------------------------' >>$tmpfile

echo $servername  `date` >>$tmpfile

if $ctrladaptec 
  then
    sed -i "s|$|<br>|" $tmpfile
fi

if $updateds
  then
#  echo Updating Data Store
   /bin/cp -a $tmpfile $datastore/raid.status.txt
#  echo Datastore - $datastore
#  ls -la $datastore
  fi

if $updatessh
  then
# copy file to the ssh server
 /bin/scp -q -P 12122 $tmpfile $sshconnection
fi

if $debug 
  then 
    cat $tmpfile 
  fi
  rm -rf $tmpfile
exit 0
