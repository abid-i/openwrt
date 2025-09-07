
define Device/tplink_deco-m4r-v3
  $(call Device/FitImage)
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := Deco M4R
  DEVICE_VARIANT := v3
  BOARD_NAME := deco-m4r-v3
  SOC := qcom-ipq4019
  BLOCKSIZE := 64k
  PAGESIZE := 2048
  IMAGE_SIZE := 15744k
  DEVICE_DTS := qcom-ipq4019-tplink-deco-m4r-v3
  DEVICE_DTS_CONFIG := config@ap.dk04.1-c1
  TPLINK_BOARD_ID := DECO-M4R-V3

  DEVICE_PACKAGES := \
		kmod-leds-gpio \
		kmod-gpio-button-hotplug \
		kmod-crypto-hw-qce \
		hostapd-common \
		wpad-basic-mbedtls \
		iwinfo \
		iw-full \
		wireless-regdb \
		kmod-mac80211 \
		uci \
		netifd \
		firewall4 \
		kmod-nft-offload \
		bridge-utils \
		kmod-sched-cake \
		irqbalance \
		tc-tiny \
		luci \
		luci-base \
		luci-mod-admin-full \
		luci-theme-bootstrap \
		luci-proto-ipv6 \
		luci-app-firewall \
		ip-full \
		ipset \
		curl \
		wget-ssl \
		ca-certificates \
		openssl-util \
		openssh-sftp-server \
		kmod-tcp-bbr \
		ethtool \
		-ppp-mod-pppoe \
		-ppp \
		-odhcp6c \
		-kmod-usb-dwc3-qcom \
		-kmod-usb3 \
		-kmod-usb-dwc3 \
		-kmod-usb2 \
		-kmod-usb-ohci \
		-kmod-usb-ehci \
		-uboot-envtools \
		-kmod-ppp \
		-kmod-pppoe \
		-dnsmasq \
		-odhcpd-ipv6only \
		-dropbear

  # Image generation with automatic MTD splitting
  IMAGES := factory.bin sysupgrade.bin
  IMAGE/factory.bin := tplink-safeloader
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  
  TARGET_CFLAGS += -O3 -ffunction-sections -fdata-sections \
                   -fomit-frame-pointer -funroll-loops
  
  TARGET_LDFLAGS += -Wl,--gc-sections -Wl,--as-needed -Wl,-O1

  # # IPQ4019 specific hardware optimizations 
  # TARGET_CPPFLAGS += -DCONFIG_IPQ4019_EDMA_OPTIMIZATION \
  #                    -DCONFIG_BATMAN_ADV_BATMAN_V \
  #                    -DCONFIG_ATH10K_SPECTRAL \
  #                    -DCONFIG_ATH10K_DFS_CERTIFIED \
  #                    -DCONFIG_MAC80211_MESH \
  #                    -DCONFIG_HOSTAPD_WPS \
  #                    -DCONFIG_IEEE80211R \
  #                    -DCONFIG_IEEE80211W \
  #                    -DCONFIG_HS20 \
  #                    -DCONFIG_WNM \
  #                    -DCONFIG_FST \
  #                    -DCONFIG_MBO \
  #                    -DCONFIG_OCV \
  #                    -DCONFIG_SAE \
  #                    -DCONFIG_EAP_SERVER=0 \
  #                    -DCONFIG_RADIUS_CLIENT=1
  
  SUPPORTED_DEVICES += deco-m4r-v3
endef
TARGET_DEVICES += tplink_deco-m4r-v3
