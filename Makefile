unexport CPATH
unexport C_INCLUDE_PATH
unexport CPLUS_INCLUDE_PATH
unexport LD_LIBRARY_PATH
unexport LD_RUN_PATH
unexport UNZIP

BUILD_DIR    = /tmp/qemu-aarch64-virt
EXTERNAL_DIR = $(CURDIR)/external

.PHONY: default
default: clean build

defconfig:
ifeq ("$(wildcard $(BUILD_DIR)/.config)","")
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) qemu_aarch64_virt_playground_defconfig
endif

menuconfig: defconfig
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) menuconfig

linux-menuconfig: defconfig
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) linux-menuconfig

busybox-menuconfig: defconfig
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) busybox-menuconfig

barebox-menuconfig: defconfig
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) barebox-menuconfig

uboot-menuconfig: defconfig
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) uboot-menuconfig

build: defconfig
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR)

clean:
ifneq ("$(wildcard $(BUILD_DIR)/.config)","")
	@$(MAKE) -C buildroot O=$(BUILD_DIR) BR2_EXTERNAL=$(EXTERNAL_DIR) clean
endif

distclean:
	@rm -fr $(BUILD_DIR)
