BOARDNAME:=Generic
FEATURES+=emmc nand
DEFAULT_PACKAGES += ath10k-board-qca4019


# Device-specific configuration loader
# Only applies special configurations to specific devices
define Device/LoadDeviceConfig
  $(if $(filter $(DEVICE_NAME),tplink_deco-m4r-v3),\
    $(eval include $(TOPDIR)/target/linux/ipq40xx/generic/tplink_deco-m4r-v3.mk))
endef

# Hook to load device-specific configurations during device definition
define Device/Template
  $(call Device/LoadDeviceConfig)
endef

# Standard build optimization (applies to all devices)
MAKE_FLAGS += \
  CCACHE_DIR="$(TOPDIR)/.ccache" \
  USE_CCACHE=1

# Parallel build for all devices
PARALLEL_BUILD ?= 1
ifeq ($(PARALLEL_BUILD),1)
  MAKE_FLAGS += -j$(shell nproc)
endif

# Build environment optimizations (global)
export CCACHE_SLOPPINESS := file_macro,locale,time_macros
export CCACHE_HASHDIR := 1
export CCACHE_BASEDIR := $(TOPDIR)

