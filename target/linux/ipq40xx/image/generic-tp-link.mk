DEVICE_VARS += TPLINK_BOARD_ID

define Device/tplink-deco-m4r-v3-common
  DEVICE_VENDOR := TP-Link
  SOC := ipq4019
  DEVICE_MODEL := Deco M4R
  BOARD_NAME := deco-m4r-v3
  TPLINK_BOARD_ID := DECO-M4R-V3
  BLOCKSIZE := 64k
  PAGESIZE := 2048
  IMAGE_SIZE := 16000k
  DEVICE_DTS := qcom-ipq4019-tplink-deco-m4r-v3
  DEVICE_DTS_CONFIG := config@ap.dk04.1-c1 
  DEVICE_PACKAGES := ath10k-board-qca4019 ipq-wifi-tplink_deco-m4r-v3 \
    ath10k-firmware-qca4019 kmod-crypto-hw-qce kmod-crypto-aes-arm-bs \
    kmod-crypto-sha1-neon lua luci luci-base luci-mod-admin-full \
		luci-mod-dashboard kmod-8021q kmod-bridge kmod-br-netfilter \
		vlan kmod-vlan irqbalance ip-full curl wget-ssl ca-certificates uci \
		kmod-ath10k kmod-mac80211-mesh dnsmasq-dhcpv6 kmod-mac80211 \
		kmod-leds-gpio kmod-dsa kmod-dsa-qca8k bridge-utils hostapd-full \
		wpad-mesh-mbedtls iw-full iwinfo wireless-regdb netifd
  DEVICE_PACKAGES += \
    -wpad-basic-mbedtls -ppp -ppp-mod-pppoe -kmod-pppoe \
	  -kmod-pppox -kmod-slhc -ath10k-firmware-qca4019-ct -kmod-ath10k-ct \
	  -kmod-usb-dwc3-qcom -kmod-usb3 kmod-usb-dwc3 -kmod-usb3 -kmod-usb2 \
	  -kmod-usb-ohci -kmod-usb-ehci -usb-utils

  IMAGES := factory.bin sysupgrade.bin
  IMAGE/factory.bin := append-rootfs | tplink-safeloader factory | check-size
  IMAGE/sysupgrade.bin := append-rootfs | tplink-safeloader sysupgrade | append-metadata | check-size
endef


define Device/tplink_deco-m4r-v3
  $(call Device/FitImage)
	$(call Device/tplink-deco-m4r-v3-common)
  DEVICE_VARIANT := v3
  DEVICE_PACKAGES := \
     batctl-default kmod-batman-adv luci-proto-batman-adv \
		 luci-app-batman-adv tc-tiny ethtool kmod-sched-fq-codel \
		 kmod-nf-flow kmod-gpio-button-hotplug kmod-leds-lp55xx-common
endef

TARGET_DEVICES += tplink_deco-m4r-v3

define Device/tplink_deco-m4r-v3-gateway
  $(call Device/FitImage)
	$(call Device/tplink-deco-m4r-v3-common)
  DEVICE_VARIANT := Gateway
  DEVICE_PACKAGES += hostapd-openssl wpad-basic-openssl mesh11sd batman-adv
endef
TARGET_DEVICES += tplink_deco-m4r-v3-gateway

define Device/tplink_deco-m4r-v3-node
  $(call Device/FitImage)
  $(call Device/tplink-deco-m4r-v3-common)
  DEVICE_VARIANT := Node
  DEVICE_PACKAGES += wpad-basic-openssl mesh11sd batman-adv
endef

TARGET_DEVICES += tplink_deco-m4r-v3-node

