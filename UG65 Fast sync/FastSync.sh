echo Instlling requirments
sh ./requirments.sh
echo '****************** Installation finished ******************' &&
curl https://helium-snapshots.nebra.com/latest.json -o milesightHeight.txt &&
echo '****************** Downloading the latest height file ******************' &&
rm snap-* &&
wget https://helium-snapshots.nebra.com/snap-`cat milesightHeight.txt | jq '.height'` &&
echo '****************** Enter the ssh password of milesight to copy last snapshot ******************' &&
scp snap-`cat milesightHeight.txt | jq '.height'` root@$1:/mnt/mmcblk0p1/miner_data/snap/ &&
echo '****************** Enter the ssh password of milesight to login ******************' &&
ssh root@$1 `cat milesightHeight.txt | jq '.height'` < heliumFastSync.sh