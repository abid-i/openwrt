# TP-Link Deco M4R v3 Device-Specific Configuration
# This file is only loaded when building for tplink_deco-m4r-v3

# Device-specific kernel configuration selection
DEVICE_KERNEL_CONFIG := memory-optimized-config

# Combined firmware partition support for this device only
define Device/tplink_deco-m4r-v3/CombinedFirmware
  # Enable MTD firmware splitting specifically for this device
  DEVICE_PACKAGES += kmod-mtd-split-firmware
  
  # Remove traditional kernel size limitations for combined approach
  undefine KERNEL_SIZE
  
  # Use slot 1 (larger partition) instead of slot 0
  # Verified from device logs: slot 1 gives 16.45MB vs slot 0's 13.125MB
  IMAGE_SIZE := 16704k  # 0xfe0000 bytes = 16.45MB
  
  # Configure MTD splitter for combined firmware approach  
  DEVICE_DTS_CONFIG := config@ap.dk04.1-c1
endef

# Memory optimization specific to 256MB RAM devices like deco-m4r-v3
define Device/tplink_deco-m4r-v3/MemoryOptimized
  # Aggressive size optimization flags
  TARGET_CFLAGS += -Os -ffunction-sections -fdata-sections
  TARGET_CFLAGS += -fomit-frame-pointer -fno-stack-protector
  TARGET_CFLAGS += -DCONFIG_ATH10K_SMALLBUFFERS=y
  TARGET_LDFLAGS += -Wl,--gc-sections -Wl,--as-needed
  
  # Link-Time Optimization for maximum size reduction
  TARGET_CFLAGS += -flto=thin
  TARGET_LDFLAGS += -flto=thin
  
  # Remove unnecessary USB support (not used on Deco M4R v3)
  DEVICE_PACKAGES += \
    -kmod-usb-dwc3-qcom \
    -kmod-usb3 \
    -kmod-usb-dwc3 \
    -kmod-usb2 \
    -kmod-usb-ohci \
    -kmod-usb-ehci \
    -uboot-envtools
endef

# WiFi optimization for mesh networking
define Device/tplink_deco-m4r-v3/MeshOptimizedWiFi
  # Use upstream ath10k for better mesh support and stability
  DEVICE_PACKAGES += \
    ath10k-firmware-qca4019 \
    -kmod-ath10k-ct \
    -ath10k-firmware-qca4019-ct
  
  # Essential mesh and crypto support
  DEVICE_PACKAGES += \
    wpad-basic-mbedtls \
    kmod-crypto-hw-qce \
    kmod-leds-gpio \
    kmod-gpio-button-hotplug
endef

# Device-specific kernel config application
define Device/tplink_deco-m4r-v3/ConfigureKernel
  # Apply memory-optimized kernel config during build
  define Kernel/Configure/tplink_deco-m4r-v3
    echo "Applying memory-optimized config for tplink_deco-m4r-v3"
    if [ -f "$(TOPDIR)/target/linux/ipq40xx/generic/config-memory-optimized-config" ]; then \
      cat "$(TOPDIR)/target/linux/ipq40xx/generic/config-memory-optimized-config" >> $(LINUX_DIR)/.config; \
      $(SCRIPT_DIR)/kconfig.pl merge $(LINUX_DIR)/.config \
        $(TOPDIR)/target/linux/ipq40xx/generic/config-memory-optimized-config > \
        $(LINUX_DIR)/.config.new; \
      mv $(LINUX_DIR)/.config.new $(LINUX_DIR)/.config; \
    fi
  endef
  
  Hooks/Kernel/Configure/Post += Kernel/Configure/tplink_deco-m4r-v3
endef

# Build-time verification for combined firmware
define Device/tplink_deco-m4r-v3/PostBuildVerification
  @echo "=== Deco M4R v3 Build Verification ==="
  @echo "Target: $(DEVICE_NAME)"
  @echo "Image size limit: $(IMAGE_SIZE)"
  @echo "Using slot 1 partitions (0x1020000-0x2000000)"
  @if [ -f "$(BIN_DIR)/$(IMG_PREFIX)-$(DEVICE_NAME)-squashfs-factory.bin" ]; then \
    SIZE=$$(stat -c%s "$(BIN_DIR)/$(IMG_PREFIX)-$(DEVICE_NAME)-squashfs-factory.bin"); \
    echo "Factory image: $$SIZE bytes ($$(echo "scale=2; $$SIZE/1024/1024" | bc) MB)"; \
    if [ $$SIZE -gt 17530880 ]; then \
      echo "WARNING: Image size exceeds slot 1 capacity!"; \
    fi \
  fi
  @if [ -f "$(BIN_DIR)/$(IMG_PREFIX)-$(DEVICE_NAME)-squashfs-sysupgrade.bin" ]; then \
    SIZE=$$(stat -c%s "$(BIN_DIR)/$(IMG_PREFIX)-$(DEVICE_NAME)-squashfs-sysupgrade.bin"); \
    echo "Sysupgrade image: $$SIZE bytes ($$(echo "scale=2; $$SIZE/1024/1024" | bc) MB)"; \
  fi
endef

# Apply all optimizations specifically to deco-m4r-v3
$(eval $(call Device/tplink_deco-m4r-v3/CombinedFirmware))
$(eval $(call Device/tplink_deco-m4r-v3/MemoryOptimized)) 
$(eval $(call Device/tplink_deco-m4r-v3/MeshOptimizedWiFi))
$(eval $(call Device/tplink_deco-m4r-v3/ConfigureKernel))

# Post-build hooks for this device only
DEVICE_BUILD_HOOKS += Device/tplink_deco-m4r-v3/PostBuildVerification

