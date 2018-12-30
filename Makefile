THEOS_DEVICE_IP = 0
THEOS_DEVICE_PORT = 2222
TARGET = iphone:11.2:11.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = u0sileoPatches
u0sileoPatches_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

