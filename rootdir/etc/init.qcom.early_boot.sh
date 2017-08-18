#!/system/bin/sh
export PATH=/system/bin

# Set platform variables
soc_hwplatform=`cat /sys/devices/system/soc/soc0/hw_platform` 2> /dev/null
soc_hwid=`cat /sys/devices/system/soc/soc0/id` 2> /dev/null
soc_hwver=`cat /sys/devices/system/soc/soc0/platform_version` 2> /dev/null

log -t BOOT -p i "MSM target '$1', SoC '$soc_hwplatform', HwID '$soc_hwid', SoC ver '$soc_hwver'"

# Set date to a time after 2008
# This is a workaround for Zygote to preload time related classes properly
if [[ `date "+%Y"` < 2009 ]]; then
	date -s 20090102.130000
fi
