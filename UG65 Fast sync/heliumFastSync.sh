echo requested file is : $1
echo milesight helium height is: &&
docker exec miner miner info height &&
echo '****************** Pausing syncinig ******************'
docker exec miner miner repair sync_pause &&
echo '****************** Canceling syncinig ******************'
docker exec miner miner repair sync_cancel &&
echo '****************** Loading snapshot... CAUTION : if it failed, there is no need to worry, proccess is going back here ******************'
docker exec miner miner snapshot load /var/data/snap/snap-$1
echo '****************** Please WAIT... , loadig the snapshot is in progress. wait for: ******************' &&
secs=$((10 * 60))                             
while [ $secs -gt 0 ]; do             
   echo -ne "$((secs/60)):$((secs%60))\033[0K\r"                                            
   sleep 1                    
   : $((secs--))               
done
if docker exec miner miner repair sync_state == 'sync pause' ( echo ssalxxam)
echo '****************** Resuming syncinig ******************'
docker exec miner miner repair sync_resume 
echo '****************** Milesight helium height is: ******************'
docker exec miner miner info height
echo '****************** Congrats! your milesight helium miner is syncing normally ******************'
echo '******************************************'
echo '****************** DONE ******************'
echo '******************************************'
exit 0