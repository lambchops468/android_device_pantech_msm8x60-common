#!/system/bin/sr

netmgr=`getprop ro.use_data_netmgrd`

start qmuxd
start qmiproxy
case "$netmgr" in
    "true")
    start netmgrd
esac
