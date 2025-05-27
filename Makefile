TARGET = iphone:latest:8.0

export THEOS_DEVICE_IP = localhost
export THEOS_DEVICE_PORT = 2222
export ARCHS = arm64
export GO_EASY_ON_ME = 1
export DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = zzclassdump
ADDITIONAL_CFLAGS += -I$(THEOS_PROJECT_DIR)/ClassDump # 假设 ClassDump 是你的模块根目录

zzclassdump_FILES = $(wildcard ./*.xm)
zzclassdump_FILES += $(wildcard ./ClassDump/*.m)


#开启自动内存管理模式 
ADDITIONAL_OBJCFLAGS =-fobjc-arc 
#Tweak.xm_CFLAGS = -fobjc-arc #单文件开启自动内存管理模式 

#链接库文件
zzclassdump_FRAMEWORKS = UIKit Foundation 
# zzclassdump_PRIVATE_FRAMEWORKS  = 
# ADDITIONAL_CFLAGS = -I$(THEOS_PROJECT_DIR)


# HikariObfuscator 设置
# TARGET_CC = ~/HikariObfuscator/Build/bin/clang 
# TARGET_CXX =  ~/HikariObfuscator/Build/bin/clang++

#单个文件加密
# Tweak.xm_CFLAGS += -mllvm -enable-allobf
# Tweak.xm_CXXFLAGS += -mllvm -enable-allobf

#所有文件加密
# zzclassdump_CFLAGS += -mllvm -enable-allobf
# zzclassdump_CXXFLAGS += -mllvm -enable-allobf

#链接库文件
#theos 采用GUN Linker来链接Mach-O对象，包括.dylib/.a/.o,例如，要链接libsqlite3.0.dylib 、libz.dylib 和dylib1.o
#example_LDFLAGS = -lz -lsqlite3.0 -dylib1.o 

#zzclassdump_LDFLAGS = 

#LOCAL_INSTALL_PATH = /System/Library/Frameworks/SurikPlugin.framework/ #安装路径

#zzclassdump_CODESIGN_FLAGS = -Sentitlements.xml #签名信息

#SUBPROJECTS += project #子项目

include $(THEOS_MAKE_PATH)/tweak.mk
	
after-install::
	install.exec "killall -9 Aweme"

# before-package::
# 	cp postinst $(THEOS_STAGING_DIR)/DEBIAN/


