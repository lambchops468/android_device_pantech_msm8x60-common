#!/system/bin/sh

target=`getprop ro.board.platform`
platformid=`cat /sys/devices/system/soc/soc0/id`
#
# Function to start sensors for DSPS enabled platforms
#
start_sensors()
{
    if [ -c /dev/msm_dsps -o -c /dev/sensors ]; then
        mkdir -p /data/system/sensors
        touch /data/system/sensors/settings
        chmod 775 /data/system/sensors
        chmod 664 /data/system/sensors/settings
        chown system /data/system/sensors/settings

        mkdir -p /data/misc/sensors
        chmod 775 /data/misc/sensors

        if [ ! -s /data/system/sensors/settings ]; then
            # If the settings file is empty, enable sensors HAL
            # Otherwise leave the file with it's current contents
            echo 1 > /data/system/sensors/settings
        fi
        start sensors
    fi
}

start_battery_monitor()
{
	chown root.system /sys/module/pm8921_bms/parameters/*
	chmod 0660 /sys/module/pm8921_bms/parameters/*
	mkdir -p /data/bms
	chown root.system /data/bms
	chmod 0770 /data/bms
	start battery_monitor
}

baseband=`getprop ro.baseband`
izat_premium_enablement=`getprop ro.qc.sdk.izat.premium_enabled`

#
# Suppress default route installation during RA for IPV6; user space will take
# care of this
# exception default ifc
for file in /proc/sys/net/ipv6/conf/*
do
  echo 0 > $file/accept_ra_defrtr
done
echo 1 > /proc/sys/net/ipv6/conf/default/accept_ra_defrtr

#
# Start gpsone_daemon for SVLTE Type I & II devices
#
case "$target" in
        "msm7630_fusion")
        start gpsone_daemon
esac
case "$baseband" in
        "svlte2a")
        start gpsone_daemon
        start bridgemgrd
        ;;
        "sglte" | "sglte2")
        start gpsone_daemon
        ;;
esac
case "$target" in
        "msm7630_surf" | "msm8660" | "msm8960" | "msm8974")
        start quipc_igsn
esac
case "$target" in
        "msm7630_surf" | "msm8660" | "msm8960" | "msm8974")
        start quipc_main
esac

case "$target" in
        "msm8960" | "msm8974")
        start location_mq
        start lowi-server
        if [ "$izat_premium_enablement" -eq 1 ]; then
            start xtwifi_inet
            start xtwifi_client
        fi
esac

start_sensors

case "$target" in
    "msm7630_surf" | "msm7630_1x" | "msm7630_fusion")
        value=`cat /sys/devices/system/soc/soc0/hw_platform`
        case "$value" in
            "Fluid")
             start profiler_daemon;;
        esac
        ;;
    "msm8660" )
        platformvalue=`cat /sys/devices/system/soc/soc0/hw_platform`
        case "$platformvalue" in
            "Fluid")
                start profiler_daemon;;
        esac
        ;;
    "msm8960")
        case "$baseband" in
            "msm")
                start_battery_monitor;;
        esac

        platformvalue=`cat /sys/devices/system/soc/soc0/hw_platform`
        case "$platformvalue" in
             "Fluid")
                 start profiler_daemon;;
             "Liquid")
                 start profiler_daemon;;
        esac
        ;;
esac
