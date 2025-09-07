
define Device/tplink_deco-m4r-v3
  $(call Device/FitImage)
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := Deco M4R
  DEVICE_VARIANT := v3
  BOARD_NAME := deco-m4r-v3
  SOC := qcom-ipq4019
  BLOCKSIZE := 64k
  PAGESIZE := 2048
  # Combined firmware partition approach (15.375MB total space)
  IMAGE_SIZE := 15744k
  DEVICE_DTS := qcom-ipq4019-tplink-deco-m4r-v3
  DEVICE_DTS_CONFIG := config@ap.dk04.1-c1
  TPLINK_BOARD_ID := DECO-M4R-V3

  DEVICE_PACKAGES := \
		kmod-leds-gpio \
		kmod-gpio-button-hotplug \
		kmod-crypto-hw-qce \
		ath10k-board-qca4019 \
		ipq-wifi-tplink_deco-m4r-v3 \
		ath10k-firmware-qca4019 \
		kmod-ath10k \
		kmod-batman-adv \
		batctl-full \
		mesh11sd \
		hostapd-full \
		wpad-mesh-mbedtls \
		bridge-utils \
		vlan \
		kmod-8021q \
		kmod-br-netfilter \
		kmod-nft-offload \
		irqbalance \
		tc-tiny \
		ethtool \
		iwinfo \
		iw-full \
		wireless-regdb \
		kmod-mac80211 \
		uci \
		netifd \
		firewall4 \
		luci \
		luci-base \
		luci-mod-admin-full \
		luci-theme-bootstrap \
		luci-app-firewall \
		luci-proto-batman-adv \
		luci-app-batman-adv \
		luci-app-advanced-reboot \
		ip-full \
		curl \
		wget-ssl \
		ca-certificates \
		openssl-util \
		libopenssl-devcrypto \
		-ppp-mod-pppoe \
		-ppp \
		-odhcp6c \
		-odhcpd-ipv6only \
		-kmod-usb-dwc3-qcom \
		-kmod-usb3 \
		-ath10k-firmware-qca4019-ct \
		-kmod-ath10k-ct \
		-kmod-usb-dwc3 \
		-kmod-usb2 \
		-kmod-usb-ohci \
		-kmod-usb-ehci \
		-uboot-envtools \
		-kmod-ppp \
		-kmod-pppoe \
		-dnsmasq \
		-odhcpd-ipv6only \
		-dropbear \
		-wpad-basic-mbedtls

  # Image generation with combined firmware partition
  IMAGES := factory.bin sysupgrade.bin
  IMAGE/factory.bin := tplink-safeloader
  IMAGE/sysupgrade.bin := sysupgrade-tar | append-metadata
  
  # Performance optimization compiler flags
  TARGET_CFLAGS += -O3 -ffunction-sections -fdata-sections \
                   -fomit-frame-pointer -funroll-loops \
                   -mcpu=cortex-a7 -mfpu=neon-vfpv4 \
                   -mfloat-abi=hard
  
  TARGET_LDFLAGS += -Wl,--gc-sections -Wl,--as-needed -Wl,-O1

  # IPQ4019 specific hardware optimizations
  TARGET_CPPFLAGS += -DCONFIG_IPQ4019_EDMA_OPTIMIZATION \
                     -DCONFIG_BATMAN_ADV_BATMAN_V \
                     -DCONFIG_ATH10K_SPECTRAL \
                     -DCONFIG_ATH10K_DFS_CERTIFIED \
                     -DCONFIG_MAC80211_MESH \
                     -DCONFIG_HOSTAPD_WPS \
                     -DCONFIG_IEEE80211R \
                     -DCONFIG_IEEE80211W \
                     -DCONFIG_HS20 \
                     -DCONFIG_WNM \
                     -DCONFIG_MBO \
                     -DCONFIG_SAE
  
  SUPPORTED_DEVICES += deco-m4r-v3
endef
TARGET_DEVICES += tplink_deco-m4r-v3

