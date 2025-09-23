BOARDNAME := TP-Link Devices
FEATURES += minor
# FEATURES += squashfs fpu ramdisk nand usb usbgadget TODO: check again


# Core IPQ4019 hardware support
DEFAULT_PACKAGES += kmod-leds-gpio kmod-gpio-button-hotplug
# IPQ4019 QCE hardware crypto acceleration
DEFAULT_PACKAGES += kmod-crypto-hw-qce kmod-crypto-aes-arm-bs \
										kmod-crypto-sha1-arm-neon kmod-crypto-sha256-arm \
										kmod-cryptodev
# QCA4019 WiFi with 802.11s mesh support - Non-CT for better mesh
DEFAULT_PACKAGES += ath10k-board-qca4019 ath10k-firmware-qca4019 \
										kmod-ath10k kmod-mac80211 kmod-mac80211-mesh \
										kmod-cfg80211 wireless-regdb
# QCA8072 DSA managed switch support
DEFAULT_PACKAGES += kmod-dsa kmod-dsa-qca8k kmod-dsa-core kmod-dsa-tag-qca kmod-phy-qca807x
# fw4/nftables with hardware flow offloading  
DEFAULT_PACKAGES +=  kmod-nft-core kmod-nft-nat kmod-nft-offload \
										 kmod-nf-flow nftables-json fw4
# CAKE QoS for bufferbloat elimination
DEFAULT_PACKAGES += kmod-sched-cake kmod-sched-fq-codel kmod-ifb \
										tc-tiny luci-app-sqm
# VLAN Support for Mesh Networking
DEFAULT_PACKAGES += kmod-br-netfilter kmod-macvlan kmod-vlan8021q kmod-bridge
# TP-Link firmware handling and MTD splitting
DEFAULT_PACKAGES += kmod-mtd kmod-mtd-cmdline-parts kmod-mtd-split \
										kmod-mtd-split-firmware
# Essential networking infrastructure  
DEFAULT_PACKAGES += netifd ip-full ethtool iw-full iwinfo irqbalance \
										luci-app-irqbalance
# Compression libraries for performance
DEFAULT_PACKAGES += kmod-lib-lz4 kmod-lib-zstd
# Remove packages not needed for mesh router use case
DEFAULT_PACKAGES += -ppp -ppp-mod-pppoe -kmod-pppoe -kmod-pppox -kmod-slhc \
										-kmod-usb-core -kmod-usb2 -kmod-usb3 -kmod-usb-dwc3 \
										-kmod-usb-dwc3-qcom -kmod-usb-ohci -kmod-usb-ehci \
										-kmod-usb-xhci-hcd -usb-utils -wpad-basic-mbedtls \
										-wpad-basic-wolfssl -ath10k-firmware-qca4019-ct \
										-kmod-ath10k-ct -swconfig -kmod-swconfig -dnsmasq \
										-odhcpd -wpad-mesh-mbedtls

# Essential system packages TODO: check again
# DEFAULT_PACKAGES += luci-ssl-nginx luci-mod-admin-full luci-theme-bootstrap \
#                    luci-app-firewall luci-app-opkg
# Space-optimized core packages
# DEFAULT_PACKAGES += dropbear logd urng-entropy urandom-seed

# TODO : check if needed , if config-default says lto
define Package/lto-flags
  TARGET_CFLAGS += -flto=auto
  TARGET_LDFLAGS += -flto=auto
endef

