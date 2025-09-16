DEVICE_VARS += TPLINK_BOARD_ID

define Device/FitImage
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef


define Device/tplink_deco-m4r-v3
  $(call Device/FitImage)
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := Deco M4R
  DEVICE_VARIANT := v3
  BOARD_NAME := deco-m4r-v3
  SOC := qcom-ipq4019
  
  BLOCKSIZE := 64k
  PAGESIZE := 2048
  
  IMAGE_SIZE := 16000k
  
  DEVICE_DTS := qcom-ipq4019-tplink-deco-m4r-v3
  DEVICE_DTS_CONFIG := config@ap.dk04.1-c1 
  
  TPLINK_BOARD_ID := DECO-M4R-V3
  
  # Core mesh networking packages
  DEVICE_PACKAGES := \
    ath10k-board-qca4019 ipq-wifi-tplink_deco-m4r-v3 ath10k-firmware-qca4019 \
    hostapd-full wpad-mesh-mbedtls iw-full iwinfo wireless-regdb batctl-default \
    kmod-batman-adv bridge-utils vlan kmod-8021q kmod-bridge kmod-br-netfilter \
    kmod-vlan irqbalance tc-tiny ethtool kmod-sched-fq-codel kmod-nf-flow \
    kmod-crypto-hw-qce kmod-crypto-aes-arm-bs kmod-crypto-sha1-neon luci \
    luci-base luci-mod-admin-full luci-proto-batman-adv luci-app-batman-adv \
    luci-app-advanced-reboot ip-full curl wget-ssl ca-certificates uci netifd \
    kmod-ath10k kmod-mac80211-mesh dnsmasq-dhcpv6 kmod-mac80211 kmod-leds-gpio \
    kmod-gpio-button-hotplug kmod-dsa kmod-dsa-qca8k kmod-leds-lp55xx-common lua \
    luci-mod-dashboard
    
  # Remove unnecessary packages to save space and avoid conflicts
  DEVICE_PACKAGES += \
     -wpad-basic-mbedtls -ppp -ppp-mod-pppoe -kmod-pppoe \
	  -kmod-pppox -kmod-slhc
  
  IMAGES := factory.bin sysupgrade.bin
  IMAGE/factory.bin := append-rootfs | tplink-safeloader factory | check-size
  IMAGE/sysupgrade.bin := append-rootfs | tplink-safeloader sysupgrade | append-metadata | check-size
  

	KERNEL_PATCHVER := 6.12

  SUPPORTED_DEVICES += deco-m4r-v3

  
endef

TARGET_DEVICES += tplink_deco-m4r-v3

