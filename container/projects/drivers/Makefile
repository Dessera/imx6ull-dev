
KERNEL_DIR = ../linux-imx/
MODULE_DIR = $(PWD)

obj-m = led.o gt9147.o gt115X.o

all:
	make -C $(KERNEL_DIR) M=$(MODULE_DIR) modules

clean:
	make -C $(KERNEL_DIR) M=$(MODULE_DIR) clean
