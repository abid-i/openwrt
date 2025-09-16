SUBTARGET:=tplink
BOARDNAME:=TP-Link
FEATURES:=

include $(INCLUDE_DIR)/target.mk

DEFAULT_PACKAGES += -ath10k-firmware-qca4019-ct -kmod-ath10k-ct \
	-kmod-usb-dwc3-qcom -kmod-usb3 kmod-usb-dwc3 -kmod-usb3 -kmod-usb2 \
	-kmod-usb-ohci -kmod-usb-ehci -usb-utils

define Target/Description
	Build firmware images for TP-Link devices based on IPQ40xx
endef


ifeq ($(CONFIG_TARGET_ipq40xx_tplink_DEVICE_tplink_deco-m4r-v3-gateway),y)
  DEFAULT_PACKAGES += kmod-batman-adv kmod-lib-crc16
endif

ifeq ($(CONFIG_TARGET_ipq40xx_tplink_DEVICE_tplink_deco-m4r-v3-node),y)
  DEFAULT_PACKAGES += kmod-batman-adv
endif

