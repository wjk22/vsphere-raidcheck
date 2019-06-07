# This is a little AWK program that interprets MegaCLI output

/Device Id/ { counter += 1; device[counter] = $3 }
/Firmware state/ { state_drive[counter] = $3 }
/Inquiry/ { name_drive[counter] = $3 " " $4 " " $5 " " $6 }
END {
for (i=1; i<=counter; i+=1) printf ( "Device %02d (%s) status is: %s <br>\n", device[i], name_drive[i], state_drive[i]); } 
