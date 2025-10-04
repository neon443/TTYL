TARGET := iphone:clang:latest:12.0
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TTYL2

TTYL2_FILES = Tweak.x
TTYL2_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += TTYLPrefs
include $(THEOS_MAKE_PATH)/aggregate.mk
