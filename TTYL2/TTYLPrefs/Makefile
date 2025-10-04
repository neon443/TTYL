TARGET := iphone:clang:latest:12.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = TTYLPrefs

TTYLPrefs_FILES = $(shell find Sources/TTYLPrefs -name '*.swift') $(shell find Sources/TTYLPrefsC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
TTYLPrefs_SWIFTFLAGS = -ISources/TTYLPrefsC/include
TTYLPrefs_INSTALL_PATH = /Library/PreferenceBundles
TTYLPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
