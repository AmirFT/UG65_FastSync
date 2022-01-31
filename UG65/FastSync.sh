echo '**********************************************************************' &&
echo '**********************************************************************' &&
echo '**********************************************************************' &&
echo '**********************************************************************' &&
echo '****************** Welcome to UG65 Fast Sync script ******************' &&
echo '**********************************************************************' &&
echo '************************ Version: 1.0.1 ******************************' &&
echo '**********************************************************************' &&
echo '**********************************************************************' &&
echo '**********************************************************************' &&
echo 'Always use the latest version of this Script'
echo '**********************************************************************' &&
echo '**********************************************************************' &&

echo '****************** Enter the ssh password of milesight to login ******************' &&

if [ -z "$1" ]; then
    echo "IP not supplied."
    exit 0
fi

if [ -z "$2" ]; then
    ssh root@$1 < heliumFastSync.sh
else
    ssh root@$1 -p $2 < heliumFastSync.sh
fi

