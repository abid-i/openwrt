SUBTARGET := tplink
BOARDNAME := TP-Link Devices
FEATURES += minor tplink small_flash nand squashfs
# FEATURES += minor tplink small_flash fpu ramdisk squashfs gpio rtc nand  dsa
# FEATURES += small_flash nand squashfs dsa

# wolfSSL ecosystem enforcement - removes mbedTLS/OpenSSL variants
DEFAULT_PACKAGES += \
  libustream-wolfssl -libustream-mbedtls -libustream-ssl -libustream-openssl \
  libwolfssl -libmbedtls -libopenssl \
  wpad-basic-wolfssl -wpad-basic-mbedtls -wpad-mesh-mbedtls \
  hostapd-wolfssl -hostapd-mbedtls -hostapd-openssl \
  wpa-supplicant-wolfssl -wpa-supplicant-mbedtls \
  px5g-wolfssl -px5g-mbedtls -px5g-openssl \
  uclient-fetch-wolfssl -uclient-fetch-mbedtls \
  -ath10k-firmware-qca4019-ct -kmod-ath10k-ct \
  ath10k-board-qca4019 ath10k-firmware-qca4019 kmod-ath10k \
  kmod-crypto-hw-qce kmod-cryptodev \
  kmod-zram irqbalance urng-entropy dropbear-wolfssl \
  kmod-dsa-core kmod-bridge \
  ethtool uboot-envtools kmod-nft-core fw4 ip-full

# Hardware-specific packages for IPQ4019
DEFAULT_PACKAGES += \
  kmod-leds-lp55xx-common \
  kmod-crypto-authenc \
  kmod-lib-lz4 kmod-lib-lz4-decompress

# Remove USB packages (Deco M4 V3 has no USB ports)
DEFAULT_PACKAGES += \
  -kmod-usb-core -kmod-usb3 -kmod-usb-dwc3-qcom \
  -kmod-usb-dwc3-ipq40xx -kmod-usb-ohci -kmod-usb-uhci \
  -kmod-usb2 -usb-modeswitch

# Profile-specific packages
ROUTER_PACKAGES := \
  dnsmasq-full odhcpd-ipv6only \
  kmod-nft-nat kmod-nft-offload \
  kmod-pppoe ppp ppp-mod-pppoe

MESH_PACKAGES := \
  batman-adv-full mesh11sd \
  kmod-mac80211-mesh wpad-mesh-wolfssl \
  kmod-nft-bridge bridge-utils kmod-batman-adv

FULL_PACKAGES := \
  $(ROUTER_PACKAGES) $(MESH_PACKAGES) \
  luci luci-ssl-wolfssl luci-mod-network luci-mod-status \
  luci-app-firewall luci-app-batman-adv luci-theme-bootstrap \
  luci-app-statistics collectd-mod-cpu collectd-mod-memory \
  tcpdump-mini iperf3 htop

# Build variant selection
ifeq ($(BUILD_VARIANT),router)
  DEFAULT_PACKAGES += $(ROUTER_PACKAGES)
else ifeq ($(BUILD_VARIANT),mesh)  
  DEFAULT_PACKAGES += $(MESH_PACKAGES)
else ifeq ($(BUILD_VARIANT),full)
  DEFAULT_PACKAGES += $(FULL_PACKAGES)
else
  # Default to router profile
  DEFAULT_PACKAGES += $(ROUTER_PACKAGES)
endif

