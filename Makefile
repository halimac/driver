# Comment/uncomment the following line to disable/enable debugging
#DEBUG = y

# Add your debugging flag (or not) to CFLAGS
ifeq ($(DEBUG),y)
  DEBFLAGS = -O -g # "-O" is needed to expand inlines
else
  DEBFLAGS = -O2
endif

EXTRA_CFLAGS += $(DEBFLAGS) -I$(LDDINCDIR)

ifneq ($(KERNELRELEASE),)
# call from kernel build system

obj-m	:= hello.o

else

KERNELDIR := /lib/modules/$(shell uname -r)/build
PWD       := $(shell pwd)

default:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) LDDINCDIR=/home/wangjy/Desktop/linux-5.7.8 modules

all:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) LDDINCDIR=/home/wangjy/Desktop/linux-5.7.8 modules

endif



clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions

depend .depend dep:
	$(CC) $(CFLAGS) -M *.c > .depend


ifeq (.depend,$(wildcard .depend))
include .depend
endif
