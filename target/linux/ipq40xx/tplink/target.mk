BOARDNAME := TP-Link Devices
FEATURES += minor tplink low_mem

DEFAULT_PACKAGES += kmod-crypto-hw-qce kmod-crypto-aes-arm-bs kmod-cryptodev \
										kmod-crypto-sha1-arm-neon kmod-crypto-sha256-arm \
										dropbear logd urng-entropy urandom-seed irqbalance kmod-zram \
										zram-swap kmod-lib-lz4 kmod-lib-zstd netifd ip-full ethtool \
										odhcp6c odhcpd-ipv6only ppp ppp-mod-pppoe kmod-pppoe \
										kmod-pppox fw4 kmod-nft-core kmod-nft-nat kmod-nft-offload \
										nftables-json kmod-ebtables kmod-ebtables-filter kmod-nf-flow \
										kmod-bridge kmod-br-netfilter luci-proto-ipv6 kmod-macvlan bridge-utils \
										ip-bridge kmod-8021q ath10k-board-qca4019 \
										ath10k-firmware-qca4019 kmod-ath10k wireless-regdb hostapd \
										hostapd-common hostapd-utils iw-full iwinfo wpa-cli  kmod-sched-cake \
										kmod-ifb sqm-scripts tc kmod-sched-fq-codel iperf3 tcpdump-mini curl \
										wget-ssl kmod-dsa kmod-dsa-core kmod-dsa-qca8k kmod-dsa-tag-qca \
										kmod-phy-qca807x dawn luci-theme-bootstrap luci-mod-admin-full \
										luci-ssl luci-mod-network luci-mod-status luci-mod-system kmod-ipt-nat6 \
										luci-app-firewall luci-app-sqm luci-app-irqbalance luci-app-dawn \
										luci-app-advanced-reboot luci-app-attendedsysupgrade luci-app-opkg \
										luci-app-statistics btop luci-app-vnstat2 luci-app-nlbwmon luci-proto-ppp \
										luci-i18n-base-en ip6tables kmod-ip6-vti bind-dig luci-app-commands \
										vlandev kmod-bonding

# DEFAULT_PACKAGES += -kmod-slhc -wpad-basic-mbedtls -dnsmasq -ath10k-firmware-qca4019-ct \
# 										-kmod-ath10k-ct -swconfig, -kmod-swconfig


DEFAULT_PACKAGES += -kmod-slhc -kmod-usb-core -kmod-usb2 -kmod-usb3 -kmod-usb-dwc3 \
										-kmod-usb-dwc3-qcom -kmod-usb-ohci -kmod-usb-ehci -kmod-usb-xhci-hcd \
										-usb-utils -wpad-basic-mbedtls -dnsmasq -ath10k-firmware-qca4019-ct \
										-kmod-ath10k-ct -swconfig, -kmod-swconfig
