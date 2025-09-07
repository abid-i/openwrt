# TP-Link subtarget configuration for IPQ4019-based devices
# Optimized for mesh networking and hardware acceleration

BOARDNAME:=TP-Link
# FEATURES+=fpu vfpv4 neon gpio squashfs ramdisk nand
FEATURES+=emmc nand
DEFAULT_PACKAGES += ath10k-board-qca4019 

