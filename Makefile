unexport CPATH
unexport C_INCLUDE_PATH
unexport CPLUS_INCLUDE_PATH
unexport LD_LIBRARY_PATH
unexport LD_RUN_PATH
unexport UNZIP

.PHONY: default
default: qemu-aarch64-virt

qemu-aarch64-virt: qemu-aarch64-virt-clean qemu-aarch64-virt-defconfig qemu-aarch64-virt-build

qemu-aarch64-virt-defconfig:
	@$(MAKE) -C buildroot O=/tmp/qemu-aarch64-virt BR2_EXTERNAL=../external qemu_aarch64_virt_playground_defconfig

qemu-aarch64-virt-menuconfig:
ifeq ("$(wildcard /tmp/qemu-aarch64-virt/.config)","")
	@$(MAKE) -C buildroot O=/tmp/qemu-aarch64-virt BR2_EXTERNAL=../external qemu_aarch64_virt_playground_defconfig
endif
	@$(MAKE) -C buildroot O=/tmp/qemu-aarch64-virt BR2_EXTERNAL=../external menuconfig

qemu-aarch64-virt-clean:
	@$(MAKE) -C buildroot O=/tmp/qemu-aarch64-virt BR2_EXTERNAL=../external clean

qemu-aarch64-virt-build:
ifeq ("$(wildcard /tmp/qemu-aarch64-virt/.config)","")
	@$(MAKE) -C buildroot O=/tmp/qemu-aarch64-virt BR2_EXTERNAL=../external qemu_aarch64_virt_playground_defconfig
endif
	@$(MAKE) -C buildroot O=/tmp/qemu-aarch64-virt BR2_EXTERNAL=../external
