DEVICE_VARS += TPLINK_BOARD_ID

define Device/FitGzipImage
  KERNEL_SUFFIX := -uImage.itb
  KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
  KERNEL_NAME := Image
endef

define Device/tplink_deco-m4r-v3
	$(call Device/FitGzipImage)
	SOC := qcom-ipq4019
	DEVICE_VENDOR := TP-Link
	DEVICE_MODEL := Deco M4R
	DEVICE_VARIANT := v3
	BOARDNAME := deco-m4r-v3
	TPLINK_BOARD_ID := DECO-M4R-V3

  DEVICE_DTS := qcom-ipq4019-deco-m4r-v3
	DEVICE_DTS_CONFIG := config@ap.dk04.1-c1

  DEVICE_PACKAGES += kmod-mtd kmod-mtd-cmdline-parts kmod-mtd-split \
  								 kmod-mtd-split-firmware kmod-mac80211-mesh mesh11sd \
  								 kmod-batman-adv batctl-full luci-proto-batman-adv \
  								 wpad-mesh-openssl kmod-cfg80211 kmod-mac80211 \
  								 kmod-leds-lp5521 kmod-usb3 kmod-usb-dwc3 \
									 kmod-usb-dwc3-qcom

  # ipq-wifi-tplink_deco-m4r-v3
	# Slot 1 firmware partition size (15.625MB - 256KB buffer)
  IMAGE_SIZE := 15616k
	KERNEL_SIZE := 4096k
	BLOCKSIZE := 64k
	PAGESIZE := 2048
	FILESYSTEMS := squashfs

	IMAGES := factory.bin sysupgrade.bin
	IMAGE/factory.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | pad-rootfs | \
		tplink-safeloader factory | check-size
	IMAGE/sysupgrade.bin := append-kernel | pad-to $$(KERNEL_SIZE) | append-rootfs | pad-rootfs | \
		tplink-safeloader sysupgrade | append-metadata | check-size
endef

TARGET_DEVICES += tplink_deco-m4r-v3
