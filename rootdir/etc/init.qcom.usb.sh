#!/system/bin/sh

# Update USB serial number from persist storage if present, if not update
# with value passed from kernel command line, if none of these values are
# set then use the default value. This order is needed as for devices which
# do not have unique serial number.
# User needs to set unique usb serial number to persist.usb.serialno
#
serialno=`getprop persist.usb.serialno`
case "$serialno" in
    "")
    serialnum=`getprop ro.serialno`
    case "$serialnum" in
        "");; #Do nothing, use default serial number
        *)
        echo "$serialnum" > /sys/class/android_usb/android0/iSerial
    esac
    ;;
    *)
    echo "$serialno" > /sys/class/android_usb/android0/iSerial
esac

chown root.system /sys/devices/platform/msm_hsusb/gadget/wakeup
chmod 220 /sys/devices/platform/msm_hsusb/gadget/wakeup

#
# Allow persistent usb charging disabling
# User needs to set usb charging disabled in persist.usb.chgdisabled
#
usbchgdisabled=`getprop persist.usb.chgdisabled`
case "$usbchgdisabled" in
    "") ;; #Do nothing here
    * )
# TODO(AZL): change to /sys/module/pmic8058_charger_presto/parameters/disabled
        echo "$usbchgdisabled" > /sys/module/pmic8058_charger/parameters/disabled
	;;
esac

#
# Allow USB enumeration with default PID/VID
#
usb_config=`getprop persist.sys.usb.config`
case "$usb_config" in
    "" | "adb") #USB persist config not set, select default configuration
            setprop persist.sys.usb.config diag,diag_mdm,serial_sdio,serial_tty,rmnet_sdio,mass_storage,adb
    ;;
    * ) ;; #USB persist config exists, do nothing
esac
