#
# Copyright (c) 2026, PenNameLuXun
#
# SPDX-License-Identifier: BSD-3-Clause
#

PLAT_JXL_PATH		:=	plat/jxl
PLAT_QEMU_PATH		:=	${PLAT_JXL_PATH}
PLAT_QEMU_COMMON_PATH	:=	plat/qemu/common

SEPARATE_CODE_AND_RODATA := 1
ENABLE_STACK_PROTECTOR	 := 0

# Reuse the QEMU common Armv8 code paths, but drive them with the JXL memory
# map and keep the real GICv3 configuration.
$(eval $(call add_define,PLAT_qemu))
QEMU_USE_GIC_DRIVER	:= QEMU_GICV3

include plat/qemu/common/common.mk
include drivers/arm/gic/v3/gicv3.mk

BL31_SOURCES		+=	${GICV3_SOURCES}			\
				plat/common/plat_gicv3.c		\
				${PLAT_QEMU_COMMON_PATH}/qemu_gicv3.c

BL31_SOURCES		+=	drivers/arm/pl061/pl061_gpio.c		\
				drivers/gpio/gpio.c			\
				plat/common/plat_hold_pen.c		\
				${PLAT_QEMU_COMMON_PATH}/qemu_pm.c	\
				${PLAT_QEMU_COMMON_PATH}/topology.c
