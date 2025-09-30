TARGET := iphone:clang:latest:12.2
INSTALL_TARGET_PROCESSES = SpringBoard


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TTYL

TTYL_FILES = $(shell find Sources/TTYL -name '*.swift') $(shell find Sources/TTYLC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
TTYL_SWIFTFLAGS = -ISources/TTYLC/include
TTYL_CFLAGS = -fobjc-arc -ISources/TTYLC/include

include $(THEOS_MAKE_PATH)/tweak.mk
