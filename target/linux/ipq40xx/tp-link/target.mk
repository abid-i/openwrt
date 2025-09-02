# TP-Link subtarget configuration for IPQ4019-based devices
# Optimized for mesh networking and hardware acceleration

BOARDNAME:=TP-Link
FEATURES+=fpu vfpv4 neon gpio squashfs ramdisk nand
CPU_TYPE:=cortex-a7+neon-vfpv4
DEFAULT_PACKAGES += ath10k-board-qca4019 

# Essential kernel modules for crypto acceleration
DEFAULT_PACKAGES += kmod-crypto-hw-qce kmod-crypto-qce

# Network optimization packages
DEFAULT_PACKAGES += kmod-sched-cake irqbalance

# Remove unnecessary packages to save space
DEFAULT_PACKAGES := $(filter-out ppp-mod-pppoe ppp odhcp6c,$(DEFAULT_PACKAGES))
