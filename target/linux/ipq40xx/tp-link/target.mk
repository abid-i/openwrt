BOARDNAME:=TP-Link
FEATURES+=nand

# Core mesh and wireless packages
DEFAULT_PACKAGES += \
	ath10k-board-qca4019 \
	ath10k-firmware-qca4019 \
	kmod-ath10k \
	kmod-crypto-hw-qce

# Batman-adv mesh networking
DEFAULT_PACKAGES += \
	kmod-batman-adv \
	batctl-full \
	mesh11sd

# RADIUS/hostapd for VLAN mapping
DEFAULT_PACKAGES += \
	hostapd-full \
	wpad-mesh-mbedtls

# VLAN and bridge support
DEFAULT_PACKAGES += \
	bridge-utils \
	vlan \
	kmod-8021q \
	kmod-br-netfilter \
	kmod-nft-offload

# Performance optimization packages
DEFAULT_PACKAGES += \
	irqbalance \
	tc-tiny \
	ethtool

# Network management
DEFAULT_PACKAGES += \
	iwinfo \
	iw-full \
	wireless-regdb \
	kmod-mac80211 \
	uci \
	netifd \
	firewall4

# Management interface
DEFAULT_PACKAGES += \
	luci-base \
	luci-mod-admin-full \
	luci-theme-bootstrap \
	luci-app-firewall \
	luci-proto-batman-adv \
	luci-app-batman-adv \
	luci-app-advanced-reboot

# Security and certificates
DEFAULT_PACKAGES += \
	ca-certificates \
	openssl-util \
	libopenssl-devcrypto

# Essential utilities (minimal)
DEFAULT_PACKAGES += \
	ip-full \
	curl \
	wget-ssl

# Remove unnecessary packages for space optimization
DEFAULT_PACKAGES := $(filter-out \
	ppp-mod-pppoe \
	ppp \
	odhcp6c \
	odhcpd-ipv6only \
	dropbear \
	dnsmasq \
	kmod-usb-dwc3-qcom \
	kmod-usb3 \
	kmod-usb-dwc3 \
	kmod-usb2 \
	kmod-usb-ohci \
	kmod-usb-ehci \
	uboot-envtools \
	kmod-ppp \
	kmod-pppoe \
	ath10k-firmware-qca4019-ct \
	kmod-ath10k-ct \
	wpad-basic-mbedtls, \
	$(DEFAULT_PACKAGES))

