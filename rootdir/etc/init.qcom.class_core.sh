#!/system/bin/sh

# Set platform variables
target=`getprop ro.board.platform`

dserial=`getprop ro.debuggable`
case "$dserial" in
    "1")
        start console
        ;;
esac
