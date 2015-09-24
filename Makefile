include theos/makefiles/common.mk

LIBRARY_NAME = libfireball
libfireball_FILES = libfireball.m
libfireball_FRAMEWORKS = UIKit Social

include $(THEOS_MAKE_PATH)/library.mk
