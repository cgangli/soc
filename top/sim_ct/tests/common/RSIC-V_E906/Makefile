#/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.
#*/
#*/
#*/
# the compiler toolset setting
#E906_CC      = ${TOOL_EXTENSION}/riscv64-unknown-elf-gcc
#E906_AS      = ${TOOL_EXTENSION}/riscv64-unknown-elf-as
#E906_LINK    = ${TOOL_EXTENSION}/riscv64-unknown-elf-ld
#E906_OBJDUMP = ${TOOL_EXTENSION}/riscv64-unknown-elf-objdump
#E906_OBJCOPY = ${TOOL_EXTENSION}/riscv64-unknown-elf-objcopy
E906_CC      = riscv64-unknown-elf-gcc
E906_AS      = riscv64-unknown-elf-as
E906_LINK    = riscv64-unknown-elf-ld
E906_OBJDUMP = riscv64-unknown-elf-objdump
E906_OBJCOPY = riscv64-unknown-elf-objcopy
CONVERT =./Srec2vmem

SSRC = $(wildcard *.S)
sSRC = $(wildcard *.s)
CSRC = $(wildcard *.c)

OBJECTS = $(SSRC:%.S=%.o) $(sSRC:%.s=%.o) $(CSRC:%.c=%.o)


FLAG_ABI = 
FLAG_MARCH = -mtune=e906 
#CPU_ARCH_FLAG_0 => CPU Arch: e906, e906f, e906d
#CPU_ARCH_FLAG_1 => DSP: dsp, nodsp 
ifeq (${CPU_ARCH_FLAG_1}, nodsp)
  ifeq (${CPU_ARCH_FLAG_0}, e906f)
    FLAG_MARCH += -march=rv32imafc
    FLAG_ABI   = -mabi=ilp32f
  else
    ifeq (${CPU_ARCH_FLAG_0}, e906d)
      FLAG_MARCH += -march=rv32imafdc
      FLAG_ABI   = -mabi=ilp32d
    else
      FLAG_MARCH += -march=rv32imac
      FLAG_ABI   = -mabi=ilp32
    endif
  endif
else 
  ifeq (${CPU_ARCH_FLAG_0}, e906f)
    FLAG_MARCH += -march=rv32imafcpzp64
    FLAG_ABI   = -mabi=ilp32f
  else
    ifeq (${CPU_ARCH_FLAG_0}, e906d)
      FLAG_MARCH += -march=rv32imafdcpzp64
      FLAG_ABI   = -mabi=ilp32d
    else
      FLAG_MARCH += -march=rv32imacpzp64
      FLAG_ABI   = -mabi=ilp32
    endif
  endif
endif
CFLAGS = ${FLAG_MARCH} ${FLAG_ABI} 

ifeq (${CASENAME}, coremark)
  CFLAGS +=-c -v -O3 -funroll-all-loops -fgcse-sm -finline-limit=500 -fno-schedule-insns --param max-rtl-if-conversion-unpredictable-cost=100 -msignedness-cmpiv -fno-code-hoisting -mno-thread-jumps1 -mno-iv-adjust-addr-cost -mno-expand-split-imm -fno-tree-loop-distribution
else
  CFLAGS += -c -v -O2
  # CFLAGS= -march=rv32imafc -mabi=ilp32f -c -v -O2
endif

ifeq (${CASENAME}, csr_rw)
  ifeq (${CPU_ARCH_FLAG_0}, e906)
    CFLAGS +=-DE906 -Wa,--defsym=E906=1 
  endif

  ifeq (${CPU_ARCH_FLAG_0}, e906f)
    CFLAGS +=-DE906F -Wa,--defsym=E906F=1 
  endif

  ifeq (${CPU_ARCH_FLAG_0}, e906d)
    CFLAGS +=-DE906FD -Wa,--defsym=E906FD=1 
  endif
endif
LINKFLAGS = -Tlinker.lcf -nostartfiles ${FLAG_MARCH} ${FLAG_ABI}
# LINKFLAGS = -Tlinker.lcf -nostartfiles -march=rv32imafc -mabi=ilp32f
#
# LINKLIBS  = -L${TOOL_PATH}/lib/gcc/riscv64-unknown-elf/8.1.0/rv32imac
# LINKLIBS += -L${TOOL_PATH}/riscv64-unknown-elf/lib/rv32imac
# LINKLIBS += -L${TOOL_PATH}/riscv32-unknown-elf/lib

LINKLIBS = -lc -lgcc

OBJDUMPFLAGS = -S -Mnumeric

HEXFLAGS	= -O srec

%.o : %.c
	${E906_CC} -c ${CFLAGS} -o $@ $<
# ${TOOL_EXTENSION}/riscv64-unknown-elf-gcc -c -march=rv32imafc -mabi=ilp32f -c -v -O2 -o $@ $<

%.o : %.s
	${E906_CC} -c ${CFLAGS} -o $@ $<
# ${TOOL_EXTENSION}/riscv64-unknown-elf-gcc -c -march=rv32imafc -mabi=ilp32f -c -v -O2 -o $@ $<

%.o : %.S
	${E906_CC} -c ${CFLAGS} -o $@ $<
# ${TOOL_EXTENSION}/riscv64-unknown-elf-gcc -c -march=rv32imafc -mabi=ilp32f -c -v -O2 -o $@ $<

${FILE}.elf : ${OBJECTS} linker.lcf
	${E906_CC} ${LINKFLAGS} ${LINKLIBS} ${OBJECTS} -o $@ -lm 
# ${TOOL_EXTENSION}/riscv64-unknown-elf-gcc -Tlinker.lcf -nostartfiles -march=rv32imafc -mabi=ilp32f -lc -lgcc $(SSRC:%.S=%.o) $(sSRC:%.s=%.o) $(CSRC:%.c=%.o) -o $@ $<

${FILE}.obj : ${FILE}.elf
	${E906_OBJDUMP} ${OBJDUMPFLAGS} $< > $@
#${TOOL_EXTENSION}/riscv64-unknown-elf-objdump -S -Mnumeric $< > $@


INST_HEX = ${FILE}_inst.hex
DATA_HEX = ${FILE}_data.hex
FILE_HEX = ${FILE}.hex

${FILE}.hex : ${FILE}.elf
	${E906_OBJCOPY} ${HEXFLAGS} $< ${INST_HEX} -j .text*  -j .rodata* -j .eh_frame*
#${TOOL_EXTENSION}/riscv64-unknown-elf-objcopy -O srec $< ${FILE}_inst.hex -j .text*  -j .rodata* -j .eh_frame*
	${E906_OBJCOPY} ${HEXFLAGS} $< ${DATA_HEX} -j .data*  -j .bss -j .COMMON
#${TOOL_EXTENSION}/riscv64-unknown-elf-objcopy -O srec $< ${FILE}_data.hex -j .bss  -j .COMMON
	${E906_OBJCOPY} ${HEXFLAGS} $< $@ 
#${TOOL_EXTENSION}/riscv64-unknown-elf-objcopy -O srec $< $@

INST_PAT = inst.pat
DATA_PAT = data.pat
FILE_PAT = case.pat

%.pat	: %.hex
	rm -f *.pat
	${CONVERT} ${INST_HEX} ${INST_PAT}
	${CONVERT} ${DATA_HEX} ${DATA_PAT}
	${CONVERT} ${FILE_HEX} ${FILE_PAT}


#--------------------------------------------------------------------
# target setting
.PHONY :e906_all
e906_all : ${FILE}.pat ${FILE}.hex ${FILE}.elf ${FILE}.obj

#---------------------------------------------------------------------
# clean some medium code and .pat
#.PHONY :clean 
#clean:
#	rm -rf *.o *.pat  *.obj *.hex

