/*
 * insertion_sort.s
 *
 *  Created on: 10/08/2023
 *      Author: Ni Qingqing
 */
.syntax unified
.cpu cortex-m4
.fpu softvfp
.thumb

.global insertion_sort

@ Start of executable code
.section .text

@ EE2028 Assignment 1, Sem 1, AY 2023/24
@ (c) ECE NUS, 2023
@ Insertion sort arr in ascending order

@ Write Student 1’s Name here: Woo Wen Jun A0239038B
@ Write Student 2’s Name here: Irving de Boer A0238894J

insertion_sort:
	PUSH {LR}
	MOV R2, #0				@ int swaps = 0;		machine code: 0x3A02000
	MOV R3, #0				@ int i = 0;			machine code: 0x3A03000

outer_loop:
	CMP R3, R1				@ Compare i with n		machine code: 0x1530001
	BGE done				@ if (i >= n), loop ends	machine code: 0xA8800044

	LDR R4, [R0, R3, LSL #2]	@ int temp = key[i]
	MOV R5, R3				@ j = i					machine code: 0x1A05003

inner_loop:
	CMP R5, #0				@						machine code: 0x3550000
	BLE inner_done 			@ while (j > 0...)		machine code: 0xD8800028

	PUSH {R5}
	SUB R5, #1				@ load j -1 into R3		machine code: 0x2455001
	LDR R6, [R0, R5, LSL #2]	@ load arr[j-1] into R6
	POP {R5}

    CMP R4, R6
    BGE inner_done      @ while (temp < arr[j - 1])

    STR R6, [R0, R5, LSL #2]  @ Move arr[j-1] to arr[j]

	ADD R2, #1		@ swaps++;						machine code: 0x2822001
	SUB R5, #1		@ j--;
	B inner_loop	@

inner_done:
    STR R4, [R0, R5, LSL #2]  @arr[j] = temp		machine code: 0xE800004C
    ADD R3, #1      @ i++
    B outer_loop	@ continues outer loop

done:
	MOV R0, R2
	POP {PC}

