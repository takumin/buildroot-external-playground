#!/bin/bash

START_QEMU_SCRIPT="${BINARIES_DIR}/start-qemu.sh"

declare -ar QEMU_CMD_LINE=(
"qemu-system-aarch64"
"-nographic"
"-M" "virt"
"-cpu" "cortex-a53"
"-smp" "1"
"-kernel" "Image"
"-append" "'rootwait root=/dev/vda console=ttyAMA0'"
"-netdev" "user,id=eth0"
"-device" "virtio-net-device,netdev=eth0"
"-drive" "file=rootfs.ext4,if=none,format=raw,id=hd0"
"-device" "virtio-blk-device,drive=hd0"
)

cat <<-_EOF_ > "${START_QEMU_SCRIPT}"
	#!/bin/sh
	(
	BINARIES_DIR="\${0%/*}/"
	cd "\${BINARIES_DIR}"
	export PATH="${HOST_DIR}/bin:\${PATH}"
	exec ${QEMU_CMD_LINE[@]}
	)
_EOF_

chmod +x "${START_QEMU_SCRIPT}"
