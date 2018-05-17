Verium Miner ODROID XU4 Patch
=============================
Here is the patch that I'm using for my ODROID XU4 Verium miners. The patch
includes compiler flags and a makefile for link-time optimization (LTO).
Unfortunately, LTO does not apply to the modules. I was too lazy to try and
include them; perhaps I'll include them in the future. The makefile was found
[here](https://github.com/andikleen/linux-misc/blob/lto/scripts/Makefile.lto).
The compiler flags were used from the [second part of birty's guide](https://steemit.com/verium/@birty/cpu-mining-is-back-a-complete-how-to-guide-and-profit-analysis-for-verium-mining-on-a-farm-of-single-board-computers-part-2b)
to compile the `cpuminer`.

Kernel config is for [Hardkernel's odroidxu4-4.14.y linux branch](https://github.com/hardkernel/linux/tree/odroidxu4-4.14.y), version 4.14.37

#### Appling the patch
To apply the patch, clone a copy of Hardkernel's linux kernel and apply the
patch with git:
```bash 
#! Clone the repo
git clone --depth 1 https://github.com/hardkernel/linux -b odroidxu4-4.14.y

#! Install the LTO makefile rules
cd linux/scripts
wget https://github.com/andikleen/linux-misc/blob/lto/scripts/Makefile.lto

#! Apply this patch
cd ..
git apply <path-to-this-patch-file>
```

#### Install Config and Build Kernel
One thing to note, to build the kernel, you will need to stop `cpuminer`,
disable hugepages, and restart the machine prior to building. Then, you can
install and build:
```bash
#! Copy this kernel config
cp <path-to-this-kernel-config-file> .config

#! Build the kernel
make oldconfig
make -j8 all

#! Install the kernel
sudo make modules_install                                                       
sudo cp -f arch/arm/boot/zImage /media/boot                                     
sudo cp -f arch/arm/boot/dts/exynos5422-odroidxu3.dtb /media/boot               
sudo cp -f arch/arm/boot/dts/exynos5422-odroidxu4.dtb /media/boot               
sudo cp -f arch/arm/boot/dts/exynos5422-odroidxu3-lite.dtb /media/boot          
sleep 1                                                                         
sync

#! Update boot config and initramfs
sudo cp .config /boot/config-`make kernelrelease`                               
sudo update-initramfs -c -k `make kernelrelease`                                
sudo mkimage -A arm -O linux -T ramdisk -C none -a 0 -e 0 -n uInitrd -d /boot/initrd.img-`make kernelrelease` /boot/uInitrd-`make kernelrelease`
sudo cp /boot/uInitrd-`make kernelrelease` /media/boot/uInitrd                  
```

When finished, reboot the machine
```bash
sudo systemctl reboot
```
