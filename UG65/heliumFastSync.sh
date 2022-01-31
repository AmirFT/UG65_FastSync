echo '****************** Downloading the latest height file ******************' &&
cd /mnt/mmcblk0p1/miner_data/snap/ &&
rm snap-* || true &&
wget https://helium-snapshots.nebra.com/snap-`curl 'https://helium-snapshots.nebra.com/latest.json' | sed -e 's/[{}]/''/g' |  awk -v k="text" '{n=split($0,a,",");  print a[1]}' | awk -v k="text" '{n=split($0,b,":");  print b[2]}' | xargs` &&

echo milesight helium height is: &&
docker exec miner miner info height &&
echo '****************** Pausing syncing ********************'
docker exec miner miner repair sync_pause &&
echo '****************** Canceling syncing ******************'
docker exec miner miner repair sync_cancel &&
echo '****************** Loading snapshot... CAUTION : if it failed, there is no need to worry, proccess is going back here ******************'
docker exec miner miner snapshot load /var/data/snap/snap-`curl 'https://helium-snapshots.nebra.com/latest.json' |
    sed -e 's/[{}]/''/g' | 
    awk -v k="text" '{n=split($0,a,",");  print a[1]}' |
    awk -v k="text" '{n=split($0,b,":");  print b[2]}' | xargs`

echo '****************** Please WAIT... , loadig the snapshot is in progress. wait for 10 minutes' &&
secs=$((10 * 60))                             
while [ $secs -gt 0 ]; do             
   echo -ne "$((secs/60)):$((secs%60))\033[0K\r"                                            
   sleep 1                    
   : $((secs--))               
done

echo '****************** Resuming syncing ******************'
docker exec miner miner repair sync_resume 
echo '****************** Milesight helium height is: ******************'
docker exec miner miner info height
echo '****************** Congrats! your milesight helium miner is syncing normally ******************'
echo '******************************************'
echo '******************************************'
echo '******************************************'
echo '******************************************'
echo '****************** DONE ******************'
echo '******************************************'
exit 0