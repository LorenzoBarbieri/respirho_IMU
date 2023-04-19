	.cpu cortex-m4
	.arch armv7e-m
	.fpu fpv4-sp-d16
	.eabi_attribute 27, 1
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 1
	.eabi_attribute 30, 4
	.eabi_attribute 34, 1
	.eabi_attribute 38, 1
	.eabi_attribute 18, 4
	.file	"system_nrf52.c"
	.text
.Ltext0:
	.section	.text.nrf52_errata_12,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf52_errata_12, %function
nrf52_errata_12:
.LFB232:
	.file 1 "C:\\Users\\loren\\Desktop\\nRF5_SDK_17.1.0_ddde560\\modules\\nrfx\\mdk\\nrf52_erratas.h"
	.loc 1 671 1 view -0
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 677 13 view .LVU1
	.loc 1 678 13 view .LVU2
	.loc 1 680 13 view .LVU3
	.loc 1 680 17 is_stmt 0 view .LVU4
	mov	r3, #268435456
	ldr	r0, [r3, #304]
	.loc 1 680 16 view .LVU5
	adds	r2, r0, #1
	.loc 1 682 17 is_stmt 1 view .LVU6
	.loc 1 682 26 is_stmt 0 view .LVU7
	itt	eq
	moveq	r3, #-268435456
	.loc 1 682 22 view .LVU8
	ldrbeq	r0, [r3, #4064]	@ zero_extendqisi2
.LVL0:
	.loc 1 683 17 is_stmt 1 view .LVU9
	.loc 1 693 13 view .LVU10
	.loc 1 714 1 is_stmt 0 view .LVU11
	subs	r3, r0, #6
	rsbs	r0, r3, #0
.LVL1:
	.loc 1 714 1 view .LVU12
	adcs	r0, r0, r3
	bx	lr
.LFE232:
	.size	nrf52_errata_12, .-nrf52_errata_12
	.thumb_set nrf52_errata_136,nrf52_errata_12
	.thumb_set nrf52_errata_108,nrf52_errata_12
	.thumb_set nrf52_errata_36,nrf52_errata_12
	.thumb_set nrf52_errata_31,nrf52_errata_12
	.section	.text.nrf52_errata_16,"ax",%progbits
	.align	1
	.syntax unified
	.thumb
	.thumb_func
	.type	nrf52_errata_16, %function
nrf52_errata_16:
.LFB234:
	.loc 1 857 1 is_stmt 1 view -0
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 1 863 13 view .LVU14
.LVL2:
	.loc 1 864 13 view .LVU15
	.loc 1 868 13 view .LVU16
	.loc 1 863 31 is_stmt 0 view .LVU17
	mov	r3, #-268435456
	.loc 1 863 22 view .LVU18
	ldrb	r2, [r3, #4064]	@ zero_extendqisi2
	.loc 1 868 16 view .LVU19
	cmp	r2, #6
	bne	.L6
	.loc 1 870 17 is_stmt 1 view .LVU20
	.loc 1 864 74 is_stmt 0 view .LVU21
	ldr	r3, [r3, #4072]
	.loc 1 864 22 view .LVU22
	ubfx	r3, r3, #4, #4
	subs	r3, r3, #3
	cmp	r3, #4
	bhi	.L6
	ldr	r2, .L7
	ldrb	r0, [r2, r3]	@ zero_extendqisi2
	bx	lr
.L6:
	.loc 1 887 16 view .LVU23
	movs	r0, #0
	.loc 1 889 1 view .LVU24
	bx	lr
.L8:
	.align	2
.L7:
	.word	.LANCHOR0
.LFE234:
	.size	nrf52_errata_16, .-nrf52_errata_16
	.thumb_set nrf52_errata_57,nrf52_errata_16
	.thumb_set nrf52_errata_37,nrf52_errata_16
	.thumb_set nrf52_errata_32,nrf52_errata_16
	.section	.text.nvmc_wait,"ax",%progbits
	.align	1
	.global	nvmc_wait
	.syntax unified
	.thumb
	.thumb_func
	.type	nvmc_wait, %function
nvmc_wait:
.LFB527:
	.file 2 "C:\\Users\\loren\\Desktop\\nRF5_SDK_17.1.0_ddde560\\modules\\nrfx\\mdk\\system_nrf52.c"
	.loc 2 73 1 is_stmt 1 view -0
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 2 74 5 view .LVU26
	.loc 2 74 20 is_stmt 0 view .LVU27
	ldr	r2, .L13
.L10:
	.loc 2 74 54 is_stmt 1 discriminator 1 view .LVU28
	.loc 2 74 28 discriminator 1 view .LVU29
	.loc 2 74 20 is_stmt 0 discriminator 1 view .LVU30
	ldr	r3, [r2, #1024]
	.loc 2 74 28 discriminator 1 view .LVU31
	cmp	r3, #0
	beq	.L10
	.loc 2 75 1 view .LVU32
	bx	lr
.L14:
	.align	2
.L13:
	.word	1073864704
.LFE527:
	.size	nvmc_wait, .-nvmc_wait
	.section	.text.nvmc_config,"ax",%progbits
	.align	1
	.global	nvmc_config
	.syntax unified
	.thumb
	.thumb_func
	.type	nvmc_config, %function
nvmc_config:
.LVL3:
.LFB528:
	.loc 2 80 1 is_stmt 1 view -0
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	.loc 2 81 5 view .LVU34
	.loc 2 81 22 is_stmt 0 view .LVU35
	ldr	r3, .L16
	str	r0, [r3, #1284]
	.loc 2 82 5 is_stmt 1 view .LVU36
	b	nvmc_wait
.LVL4:
.L17:
	.align	2
.L16:
	.word	1073864704
.LFE528:
	.size	nvmc_config, .-nvmc_config
	.section	.text.SystemCoreClockUpdate,"ax",%progbits
	.align	1
	.glob