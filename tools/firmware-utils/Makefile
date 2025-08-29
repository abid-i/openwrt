#
# Copyright (C) 2006-2020 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk

PKG_NAME:=firmware-utils
PKG_RELEASE:=1


PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL=https://github.com/abid-i/firmware-utils.git
PKG_SOURCE_DATE:=2025-08-29
PKG_SOURCE_VERSION:=e621b61ef6377352a26f1cfd60687152fc92944c
PKG_MIRROR_HASH:=d58b81ae91782f7b1c3e8a1994adb0f0f2290706339d6eb006c13f207e5046b9

include $(INCLUDE_DIR)/host-build.mk
include $(INCLUDE_DIR)/cmake.mk

$(eval $(call HostBuild))
