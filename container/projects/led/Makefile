
KERNEL_DIR = ../linux-imx/
MODULE_DIR = $(PWD)

CROSS_COMPILE :=
CC_USER = $(CROSS_COMPILE)gcc

obj-m = led.o

ifeq ($(KERNEL_DIR),)
$(error "KERNEL_DIR is not set")
endif

all:
	make -C $(KERNEL_DIR) M=$(MODULE_DIR) modules
	$(CC_USER) ledctrl.c -o ledctrl

clean:
	make -C $(KERNEL_DIR) M=$(MODULE_DIR) clean
	rm -f ledctrl
