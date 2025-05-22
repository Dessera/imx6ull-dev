DEVNAME := "imx6ull-dev"
DEVIMGNAME := DEVNAME + "-env"

SDCARD := "/dev/sda"
SDCARD_BOOT := SDCARD + "1"
SDCARD_ROOTFS := SDCARD + "2"

DIST := "./container/projects/dist"
DIST_BOOT := DIST + "/boot"
DIST_ROOTFS := DIST + "/rootfs"
DIST_UBOOT := DIST + "/u-boot-dtb.imx"

MOUNT_POINT := "/mnt"

SD_TEMPLATE := "./SD_TEMPLATE"

# list all tasks
help:
  @just --list

# build development container
mkdev-image:
  podman build -t {{DEVIMGNAME}} ./container

# remove development container
rmdev-image:
  podman rmi {{DEVIMGNAME}}

# run development container
mkdev-env:
  podman run -dit --privileged --name {{DEVNAME}}     \
              -v $(pwd)/container/projects:/projects  \
              {{DEVIMGNAME}}:latest

# remove development container
rmdev-env:
  podman rm -f {{DEVNAME}}

# start development container
develop:
  podman exec -it {{DEVNAME}} bash

# partition sdcard
mkpart:
  cat {{SD_TEMPLATE}} | sfdisk {{SDCARD}}
  mkfs.vfat {{SDCARD_BOOT}} -F 32 -n BOOT
  mkfs.ext4 {{SDCARD_ROOTFS}} -L ROOTFS

# flash boot to sdcard
mkboot:
  mount {{SDCARD_BOOT}} {{MOUNT_POINT}}
  cp {{DIST_BOOT}}/* {{MOUNT_POINT}}
  umount {{MOUNT_POINT}}

# flash rootfs to sdcard
mkrootfs:
  mount {{SDCARD_ROOTFS}} {{MOUNT_POINT}}
  cp -r {{DIST_ROOTFS}}/* {{MOUNT_POINT}}
  umount {{MOUNT_POINT}}

# flash u-boot to sdcard
mkuboot:
  dd if={{DIST_UBOOT}} of={{SDCARD}} bs=512 seek=2 iflag=dsync oflag=dsync
