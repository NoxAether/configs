#!/usr/bin/env sh

function vm {
    qemu-system-x86_64 \
        -enable-kvm \
        -m 12G \
        -cpu host \
        -smp 8 \
        -drive file=/home/nox/Tools/Disks/LowLin.qcow2,format=qcow2 \
        -boot c \
        -device qxl-vga \
        -device virtio-mouse-pci \
        -device virtio-keyboard-pci \
        -device virtio-tablet-pci \
        -net nic -net user \
        -device virtio-gpu
}
