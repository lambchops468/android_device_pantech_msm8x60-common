#!/system/bin/sh
#
# start ril-daemon only for targets on which radio is present
#
baseband=`getprop ro.baseband`
multirild=`getprop ro.multi.rild`
dsds=`getprop persist.dsds.enabled`
netmgr=`getprop ro.use_data_netmgrd`

case "$baseband" in
    "apq")
    setprop ro.radio.noril yes
    stop ril-daemon
esac

case "$baseband" in
    "msm" | "csfb" | "svlte2a" | "mdm" | "sglte" | "sglte2" | "dsda2" | "unknown")
    start qmuxd
    case "$baseband" in
        "svlte2a" | "csfb" | "sglte" | "sglte2")
        start qmiproxy
        ;;
        "dsda2")
          setprop ro.multi.rild true
          setprop persist.multisim.config dsda
          stop ril-daemon
          start ril-daemon
          start ril-daemon1
    esac
    case "$multirild" in
        "true")
         case "$dsds" in
             "true")
             start ril-daemon1
         esac
    esac
    case "$netmgr" in
        "true")
        start netmgrd
    esac
esac
