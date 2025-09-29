DEVICE_VARS += TPLINK_BOARD_ID TPLINK_HWID TPLINK_HWREV

# # Enhanced safeloader with comprehensive TP-Link validation
define Build/tplink-safeloader
	$(STAGING_DIR_HOST)/bin/tplink-safeloader \
		$(if $(findstring factory,$(word 1,$(1))),-z $@) \
		$(if $(findstring sysupgrade,$(word 1,$(1))),-S) \
		-B $(TPLINK_BOARD_ID) \
		$(if $(TPLINK_HWID),-a $(TPLINK_HWID)) \
		$(if $(TPLINK_HWREV),-r $(TPLINK_HWREV)) \
		-s -o $@.new
	@mv $@.new $@
endef

# Size validation with detailed reporting  
define Build/check-size-verbose
	@imagesize=$$(stat -c%s $@); \
	limitsize=$$(( $(subst k,* 1024,$(subst m, * 1024k,$(1))) )); \
	echo "Image: $@ Size: $$imagesize bytes, Limit: $$limitsize bytes"; \
	if [ $$imagesize -gt $$limitsize ]; then \
		echo "❌ ERROR: Image size $$imagesize exceeds limit $$limitsize by $$(( $$imagesize - $$limitsize )) bytes"; \
		rm -f $@; exit 1; \
	else \
		echo "✅ OK: $$(( $$limitsize - $$imagesize )) bytes remaining"; \
	fi
endef

define Device/FitImage
	KERNEL_SUFFIX := -uImage.itb
	KERNEL = kernel-bin | gzip | fit gzip $$(KDIR)/image-$$(DEVICE_DTS).dtb
	KERNEL_NAME := Image
endef


define Device/tplink_deco-m4r-v3
  $(call Device/FitImage)
  SOC := qcom-ipq4019
  DEVICE_VENDOR := TP-Link
  DEVICE_MODEL := Deco M4R  
  DEVICE_VARIANT := v3
  TPLINK_BOARD_ID := DECO-M4R-V3
  TPLINK_HWID := 0x55530000
  TPLINK_HWREV := 1
  DEVICE_DTS := qcom-ipq4019-deco-m4r-v3
  DEVICE_DTS_CONFIG := config@ap.dk04.1-c1
  SUPPORTED_DEVICES += tplink,deco-m4r-v3
  
  # Memory layout optimized for 32MB flash
  KERNEL_LOADADDR := 0x80208000
  KERNEL_SIZE := 4096k
  IMAGE_SIZE := 14976k
  ROOTFS_BLOCKSIZE := 64k
  BLOCKSIZE := 64k
  PAGESIZE := 2048
  FILESYSTEMS := squashfs
  
  # Remove conflicting packages and enforce wolfSSL ecosystem
  DEVICE_PACKAGES := \
    -wpad-basic-mbedtls -libustream-mbedtls -libmbedtls \
    -ath10k-firmware-qca4019-ct -kmod-ath10k-ct \
    -kmod-usb3 -kmod-usb-dwc3-qcom -kmod-usb-dwc3-ipq40xx \
    -swconfig -odhcp6c -ppp -kmod-ppp \
    ath10k-firmware-qca4019 kmod-ath10k \
    kmod-crypto-hw-qce kmod-leds-lp55xx-common

  # Build variant support
  DEVICE_PACKAGES += \
    $(if $(filter router,$(BUILD_VARIANT)),$(ROUTER_PACKAGES)) \
    $(if $(filter mesh,$(BUILD_VARIANT)),$(MESH_PACKAGES)) \
    $(if $(filter full,$(BUILD_VARIANT)),$(FULL_PACKAGES))

  IMAGES += factory.bin sysupgrade.bin
  IMAGE/factory.bin := \
    append-kernel | pad-to $(KERNEL_SIZE) | \
    append-rootfs | pad-rootfs | \
    tplink-safeloader factory | \
    check-size-verbose $(IMAGE_SIZE)
  IMAGE/sysupgrade.bin := \
    append-kernel | pad-to $(KERNEL_SIZE) | \
    append-rootfs | pad-rootfs | \
    tplink-safeloader sysupgrade | \
    append-metadata | \
    check-size-verbose $(IMAGE_SIZE)
endef

TARGET_DEVICES += tplink_deco-m4r-v3

