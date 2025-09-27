SUBTARGET := tplink
BOARDNAME := TP-Link Devices
FEATURES += minor tplink small_flash

# Essential packages only for mesh functionality
DEFAULT_PACKAGES += kmod-crypto-hw-qce dropbear netifd logd \
					kmod-zram urng-entropy irqbalance \
					ath10k-board-qca4019 ath10k-firmware-qca4019 kmod-ath10k \
					wireless-regdb hostapd wpad-mesh-openssl \
					fw4 kmod-nft-core kmod-nft-nat kmod-nft-offload \
					kmod-dsa kmod-dsa-core kmod-bridge ip-full ethtool \
					mesh11sd kmod-mac80211-mesh kmod-dsa-qca8k
					 
# luci-base luci-app-firewall luci-mod-admin-full \
# 					luci-theme-bootstrap
DEFAULT_PACKAGES += kmod-br-netfilter kmod-crypto-authenc \
					kmod-cryptodev kmod-fs-squashfs kmod-i2c-core \
					kmod-input-core kmod-input-leds kmod-ipt-core \
					kmod-leds-lp55xx-common kmod-ledtrig-activity \
					kmod-ledtrig-gpio kmod-lib-lz4 kmod-lib-lz4-decompress \
					kmod-lib-xxhash kmod-lib-zstd kmod-mux-core kmod-mux-gpio \
					kmod-nf-ipt kmod-spi-dw kmod-spi-dw-mmio kmod-ubootenv-nvram \
					libbpf libelf libopenssl-legacy libuclient fit-check-sign \
					hostapd-basic-mbedtls hostapd-mbedtls ip-tiny libatomic \
					libcap libiwinfo libiwinfo-data libncurses libopenssl \
					libopenssl-conf libopenssl-devcrypto libpthread librt rpcd \
					rpcd-mod-file rpcd-mod-ucode terminfo ucode-mod-log \
					ucode-mod-math wireless-tools wpa-supplicant-mbedtls \
					wpa-supplicant-mesh-mbedtls wpad-basic-mbedtls \
					wpad-mesh-mbedtls

# Remove heavy packages
DEFAULT_PACKAGES += -luci -luci-ssl -luci-theme-bootstrap \
					-luci-mod-admin-full -luci-mod-network -luci-mod-status \
					-luci-mod-system -luci-app-firewall -luci-app-sqm \
					-luci-app-irqbalance -luci-app-dawn -luci-app-advanced-reboot \
					-luci-app-attendedsysupgrade -luci-app-opkg -luci-app-statistics \
					-btop -luci-app-vnstat2 -luci-app-nlbwmon -luci-app-commands \
					-dawn -kmod-usb-core -kmod-usb2 -kmod-usb3 -kmod-usb-dwc3 \
					-kmod-usb-dwc3-qcom -wpad-basic-mbedtls -dnsmasq \
					-ath10k-firmware-qca4019-ct -kmod-ath10k-ct -ppp -ppp-mod-pppoe \
					-kmod-pppoe -kmod-pppox -odhcp6c -odhcpd-ipv6only -curl \
					-wget-ssl -tcpdump-mini -iperf3 -sqm-scripts -kmod-sched-cake \
					-kmod-ifb -tc -kmod-sched-fq-codel -opkg -iptables -luci-base \
					-luci-app-firewall -luci-mod-admin-full -luci-theme-bootstrap \
					-uhttpd -uhttpd-mod-ubus -libiwinfo-lua -wpad-mesh-openssl \
					-uclient-fetch -hostapd -apk-mbedtls -ip-full


# Essential packages only for mesh functionality
# DEFAULT_PACKAGES += kmod-crypto-hw-qce dropbear netifd logd \
# 					kmod-zram zram-swap urng-entropy irqbalance \
# 					ath10k-board-qca4019 ath10k-firmware-qca4019 kmod-ath10k \
# 					wireless-regdb hostapd wpad-mesh-openssl \
# 					fw4 kmod-nft-core kmod-nft-nat kmod-nft-offload \
# 					kmod-dsa kmod-dsa-core kmod-dsa-tag-qca \
# 					kmod-bridge ip-full ethtool \
# 					mesh11sd kmod-mac80211-mesh kmod-dsa-qca8k

# DEFAULT_PACKAGES += kmod-crypto-hw-qce kmod-crypto-aes-arm-bs kmod-cryptodev \
# 										kmod-crypto-sha1-arm-neon kmod-crypto-sha256-arm \
# 										dropbear logd urng-entropy urandom-seed irqbalance kmod-zram \
# 										zram-swap kmod-lib-lz4 kmod-lib-zstd netifd ip-full ethtool \
# 										odhcp6c odhcpd-ipv6only ppp ppp-mod-pppoe kmod-pppoe \
# 										kmod-pppox fw4 kmod-nft-core kmod-nft-nat kmod-nft-offload \
# 										nftables-json kmod-ebtables kmod-ebtables-filter kmod-nf-flow \
# 										kmod-bridge kmod-br-netfilter  kmod-macvlan bridge-utils \
# 										ip-bridge kmod-8021q ath10k-board-qca4019 \
# 										ath10k-firmware-qca4019 kmod-ath10k wireless-regdb hostapd \
# 										hostapd-common hostapd-utils iw-full iwinfo wpa-cli  kmod-sched-cake \
# 										kmod-ifb sqm-scripts tc kmod-sched-fq-codel iperf3 tcpdump-mini curl \
# 										wget-ssl kmod-dsa kmod-dsa-core kmod-dsa-qca8k kmod-dsa-tag-qca \
# 										kmod-phy-qca807x dawn kmod-ipt-nat6 ip6tables kmod-ip6-vti vlandev kmod-bonding 

# DEFAULT_PACKAGES += kmod-crypto-hw-qce kmod-crypto-aes-arm-bs kmod-cryptodev \
# 			kmod-crypto-sha1-arm-neon kmod-crypto-sha256-arm kmod-phy-qca807x dropbear \
# 			logd urng-entropy urandom-seed irqbalance kmod-zram zram-swap kmod-lib-lz4 \
# 			kmod-lib-zstd netifd ip-full ethtool odhcp6c odhcpd-ipv6only ppp ppp-mod-pppoe \
# 			kmod-pppoe dawn kmod-pppox fw4 kmod-nft-core kmod-nft-nat kmod-nft-offload \
# 			nftables-json kmod-ebtables kmod-ebtables-filter kmod-nf-flow kmod-bridge \
# 			kmod-br-netfilter  kmod-macvlan bridge-utils kmod-ip6-vti ip-bridge kmod-8021q \
# 			ath10k-board-qca4019 btop ip6tables vlandev ath10k-firmware-qca4019 kmod-ath10k \
# 			wireless-regdb hostapd kmod-bonding hostapd-common hostapd-utils iw-full iwinfo \
# 			wpa-cli  kmod-sched-cake kmod-ifb sqm-scripts tc kmod-sched-fq-codel iperf3 curl \
# 			tcpdump-mini  wget-ssl kmod-dsa kmod-dsa-core kmod-dsa-qca8k kmod-dsa-tag-qca \
# 			kmod-mtd kmod-mtd-cmdline-parts kmod-mtd-split kmod-mtd-split-firmware \
# 			kmod-mac80211-mesh mesh11sd kmod-batman-adv batctl-full wpad-mesh-openssl \
# 			kmod-cfg80211 kmod-mac80211 kmod-leds-lp5521 uhttpd uhttpd-mod-ubus luci-base \
# 			luci-mod-admin-full luci-lib-ip luci-lib-jsonc luci-theme-bootstrap



#
# DEFAULT_PACKAGES += -kmod-slhc -wpad-basic-mbedtls -dnsmasq -ath10k-firmware-qca4019-ct \
# 										-kmod-ath10k-ct -swconfig, -kmod-swconfig


# DEFAULT_PACKAGES += -kmod-slhc -kmod-usb-core -kmod-usb2 -kmod-usb3 -kmod-usb-dwc3 \
# 										-kmod-usb-dwc3-qcom -kmod-usb-ohci -kmod-usb-ehci -kmod-usb-xhci-hcd \
# 										-usb-utils -wpad-basic-mbedtls -dnsmasq -ath10k-firmware-qca4019-ct \
# 										-kmod-ath10k-ct -swconfig, -kmod-swconfig


# CORE MESH NETWORKING (Non-negotiable requirements)
# DEFAULT_PACKAGES += netifd dropbear logd \
# 					kmod-crypto-hw-qce \
# 					ath10k-board-qca4019 ath10k-firmware-qca4019 kmod-ath10k \
# 					wireless-regdb hostapd wpad-mesh-openssl \
# 					kmod-mac80211-mesh mesh11sd \
# 					kmod-batman-adv batctl-minimal \
# 					fw4 kmod-nft-core kmod-nft-nat kmod-nft-offload nftables-json \
# 					kmod-dsa kmod-dsa-core kmod-dsa-tag-qca \
# 					kmod-bridge kmod-br-netfilter bridge-utils \
# 					ip-full ethtool kmod-8021q \
# 					kmod-zram zram-swap
#
# # PERFORMANCE OPTIMIZATION (Hardware accel requirements)
# DEFAULT_PACKAGES += irqbalance kmod-sched-cake kmod-ifb sqm-scripts \
# 					kmod-crypto-aes-arm-bs kmod-crypto-sha1-arm-neon \
# 					kmod-lib-lz4 kmod-lib-zstd

# # IPv6 SUPPORT (Requirement 7)
# DEFAULT_PACKAGES += odhcp6c odhcpd-ipv6only kmod-ip6tables ip6tables
#
# # SIZE REDUCTION - Remove unused packages from parent
# DEFAULT_PACKAGES += -dnsmasq -wpad-basic-mbedtls -ath10k-firmware-qca4019-ct \
					-kmod-ath10k-ct -ppp -ppp-mod-pppoe -kmod-pppoe -kmod-pppox \
					-kmod-usb-core -kmod-usb2 -kmod-usb3 -kmod-usb-dwc3 \
					-kmod-usb-dwc3-qcom -uboot-envtools

# # REMOVE LUCI (Last resort for size)
# DEFAULT_PACKAGES += -luci -luci-ssl -luci-theme-bootstrap \
# 					-luci-mod-admin-full -luci-mod-network -luci-mod-status \
# 					-luci-mod-system -luci-app-firewall -luci-app-opkg \
# 					-luci-lib-base -luci-lib-ip -luci-lib-nixio \
# 					-luci-lib-jsonc -rpcd -uhttpd -uhttpd-mod-ubus
# DEFAULT_PACKAGES += luci-theme-bootstrap luci-mod-admin-full luci-ssl luci-mod-network \
#  										luci-mod-status luci-mod-system kmod-ipt-nat6 \
#  										luci-app-firewall luci-app-sqm luci-app-irqbalance luci-app-dawn \
#  										luci-app-advanced-reboot luci-app-attendedsysupgrade luci-app-opkg \
#  										luci-app-statistics luci-proto-ipv6 luci-app-vnstat2 luci-app-nlbwmon luci-proto-ppp \
#  										luci-i18n-base-en luci luci-app-commands
#
