#
# Copyright (C) 2012 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := pantech

#----------------------------------------------------------------------

# Architecture
TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_ABI  := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
ARCH_ARM_HAVE_TLS_REGISTER := true

# Audio
BOARD_USES_AUDIO_LEGACY  := false
TARGET_PROVIDES_LIBAUDIO := false

# Board info
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USES_MMCUTILS := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true

# Bootloader
TARGET_NO_BOOTLOADER := true

# Charging mode
BOARD_BATTERY_DEVICE_NAME := "battery"
BOARD_CHARGER_RES := device/pantech/qcom-common/charger/res/images/charger

# Flags
COMMON_GLOBAL_CFLAGS += -DQCOM_HARDWARE

# Graphics
BOARD_EGL_CFG := device/pantech/qcom-common/prebuilt/system/lib/egl/egl.cfg
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true

# Kernel
TARGET_NO_KERNEL := false

# Postrecovery
PRODUCT_COPY_FILES += \
    device/pantech/qcom-common/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh \
    device/pantech/qcom-common/recovery/postrecoveryboot.sh:recovery/system/bin/postrecoveryboot.sh

# QCOM hardware
BOARD_USES_QCOM_HARDWARE := true

# Recovery
TARGET_RECOVERY_UI_LIB := librecovery_ui_qcom

# Target info
TARGET_USERIMAGES_USE_EXT4 := true

# Webkit
ENABLE_WEBGL := true
TARGET_FORCE_CPU_UPLOAD := true
