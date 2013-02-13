ifeq ($(BOARD_VENDOR),pantech)

ifeq ($(call is-board-platform-in-list,msm8660 msm8960),true)
include $(call all-makefiles-under,$(LOCAL_PATH))
endif
endif
