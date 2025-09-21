DEVICE_VARS += TPLINK_BOARD_ID

# Define FIT image support for modern U-Boot
define Device/FitImage
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef

# Common configuration for all Deco M4 V3 variants
define Device/tplink-deco-m4r-v3-common
	DEVICE_VENDOR := TP-Link
	SOC := qcom-ipq4019
	DEVICE_MODEL := Deco M4R V3
	BOARDNAME := deco-m4r-v3
	TPLINK_BOARD_ID := DECO-M4R-V3
	BLOCKSIZE := 64k
	PAGESIZE := 2048

	# Optimized for 15.625MB firmware partition with MTD splitting
	IMAGE_SIZE := 15616k
	DEVICE_DTS := qcom-ipq4019-tplink-deco-m4r-v3
	DEVICE_DTS_CONFIG := config@ap.dk04.1-c1

	# Essential WiFi calibration data - REQUIRED
	DEVICE_PACKAGES := ipq-wifi-tplink_deco-m4r-v3

	# Optimized image generation with maximum compression
	IMAGES := factory.bin sysupgrade.bin
	IMAGE/factory.bin := append-rootfs | tplink-safeloader factory | check-size
	IMAGE/sysupgrade.bin := append-rootfs | tplink-safeloader sysupgrade | append-metadata | check-size

	# Maximum compression for U-Boot 2012.07 compatibility
	KERNEL := kernel-bin | append-dtb | lzma | uImage lzma
	FILESYSTEMS := squashfs
endef

# Profile 1: Basic Mesh - Stock firmware feature parity
define Device/tplink_deco-m4r-v3-basic
	$(call Device/FitImage)
	$(call Device/tplink-deco-m4r-v3-common)
	DEVICE_VARIANT := Basic-Mesh
	
	# === BASIC WIFI MANAGEMENT ===
	# Stock firmware feature parity with mesh support
	DEVICE_PACKAGES += \
		hostapd \
		wpad-mesh-openssl \
		dnsmasq-full \
		odhcpd-ipv6only \
		luci-ssl \
		luci-mod-admin-full \
		luci-mod-network \
		luci-mod-status \
		luci-mod-system \
		luci-app-firewall \
		luci-theme-bootstrap \
		tcpdump-mini \
		wget-ssl
endef
TARGET_DEVICES += tplink_deco-m4r-v3-basic

# Profile 2: Enhanced Mesh - Advanced mesh + VLAN switching + monitoring
define Device/tplink_deco-m4r-v3-enhanced  
	$(call Device/FitImage)
	$(call Device/tplink-deco-m4r-v3-common)
	DEVICE_VARIANT := Enhanced-Mesh
	
	# === BASIC WIFI MANAGEMENT ===
	# Foundation wireless and management
	DEVICE_PACKAGES += \
		hostapd \
		wpad-mesh-openssl \
		dnsmasq-full \
		odhcpd-ipv6only \
		luci-ssl \
		luci-mod-admin-full \
		luci-mod-network \
		luci-mod-status \
		luci-mod-system \
		luci-app-firewall \
		luci-theme-bootstrap \
		tcpdump-mini \
		wget-ssl

	# === ADVANCED MESH NETWORKING ===
	# batman-adv Layer 2 mesh protocol + 802.11s
	DEVICE_PACKAGES += \
		kmod-batman-adv \
		batctl-full \
		mesh11sd \
		luci-proto-batman-adv

	# === VLAN & BRIDGING SUPPORT ===
	# Managed VLAN switch functionality
	DEVICE_PACKAGES += \
		kmod-br-netfilter \
		kmod-macvlan

	# === ENHANCED MANAGEMENT ===
	# Advanced system administration tools
	DEVICE_PACKAGES += \
		luci-app-opkg \
		luci-app-advanced-reboot \
		luci-app-attendedsysupgrade \
		ip-bridge \
		iperf3 \
		curl \
		wpa-cli \
		hostapd-utils

	# === SYSTEM MONITORING ===
	# Prometheus-based performance monitoring
	DEVICE_PACKAGES += \
		prometheus-node-exporter-lua \
		prometheus-node-exporter-lua-openwrt \
		prometheus-node-exporter-lua-wifi \
		prometheus-node-exporter-lua-wifi_stations \
		luci-app-statistics

endef
TARGET_DEVICES += tplink_deco-m4r-v3-enhanced

