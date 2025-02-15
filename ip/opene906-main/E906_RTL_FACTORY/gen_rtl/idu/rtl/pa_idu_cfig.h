/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

//==========================================================
//     Define the operation type and function
//==========================================================
// following defines data width of decoded information
`define SEL_WIDTH  6
`define FUNC_WIDTH 20

//--------------------ISA Sel define----------------
`define FUNC_RV32IM 5'b00001
`define FUNC_RV32C  5'b00010
`define FUNC_RV32X  5'b00100
`define FUNC_RV32P  5'b01000
`define FUNC_RV32FD 5'b10000

//--------------------ISA OP define----------------
`define OP_EXT 7'b0001011
`define OP_DSP 7'b1110111

//--------------------Inst Unit define--------------
`define SEL_ALU 6'b000001
`define SEL_MUL 6'b000010
`define SEL_DIV 6'b000100
`define SEL_BJU 6'b001000
`define SEL_LSU 6'b010000
`define SEL_CP0 6'b100000

//--------------------ALU FUNC define Begin---------
`ifdef DSP
//--------------------ADDER FUNC define---------
`define FUNC_ADDSL  20'b0000_1100_1000_0000_0001
`define FUNC_ADD    20'b0000_1100_1000_0000_0000
`define FUNC_SUB    20'b0000_1100_1001_1100_0000
`define FUNC_SLT    20'b0000_1100_1001_1100_0101
`define FUNC_LTU    20'b0000_1100_0001_1100_0101
`define FUNC_MIN    20'b0000_1101_1001_1100_0010
`define FUNC_MINU   20'b0000_1101_0001_1100_0010
`define FUNC_MAX    20'b0000_1100_1001_1100_0011
`define FUNC_MAXU   20'b0000_1100_0001_1100_0011
//--------------------SHIFT FUNC define---------
`define FUNC_SLL    20'b0001_0000_0010_1000_0000
`define FUNC_SRL    20'b0001_0000_1010_0000_0000
`define FUNC_SRA    20'b0001_0000_1010_0100_0000
`define FUNC_SRRI   20'b0001_0000_1010_0000_0100
`define FUNC_EXT    20'b0001_0000_1010_0100_0001
`define FUNC_EXTU   20'b0001_0000_1010_0000_0001
//--------------------LOGIC FUNC define---------
`define FUNC_AND    20'b1000_0000_0000_0000_0001
`define FUNC_OR     20'b1000_0000_0000_0000_0010
`define FUNC_XOR    20'b1000_0000_0000_0000_0100
`define FUNC_ANDN   20'b1000_0000_0000_0000_1001
`define FUNC_ORN    20'b1000_0000_0000_0000_1010
`define FUNC_XORN   20'b1000_0000_0000_0000_1100
//--------------------PACK FUNC define----------
`define FUNC_PACKL  20'b0010_0000_0000_0001_0100
`define FUNC_PACKH  20'b0010_0000_0000_1101_0100
`define FUNC_PACKHL 20'b0010_0000_0000_0011_0100
`define FUNC_MVEQZ  20'b0010_0000_0000_0100_0010
`define FUNC_MVNEZ  20'b0010_0000_0000_1000_0010
//--------------------BITOP FUNC define---------
`define FUNC_FF1    20'b0100_0000_0000_1001_0001
`define FUNC_FF0    20'b0100_0000_0000_1000_1001
`define FUNC_TST    20'b0100_0000_0000_1001_0010
`define FUNC_TSTNBZ 20'b0100_0000_0000_1000_1010
`define FUNC_REV    20'b0100_0000_0000_1000_0100
`else
//--------------------ADDER FUNC define---------
`define FUNC_ADDSL  20'b00001_10001
`define FUNC_ADD    20'b00001_00001
`define FUNC_SUB    20'b00001_00000
`define FUNC_SLT    20'b00001_10010
`define FUNC_LTU    20'b00001_00010
`define FUNC_MIN    20'b00001_10110
`define FUNC_MINU   20'b00001_00110
`define FUNC_MAX    20'b00001_11110
`define FUNC_MAXU   20'b00001_01110
//--------------------SHIFT FUNC define---------
`define FUNC_SLL    20'b00010_00001
`define FUNC_SRL    20'b00010_00010
`define FUNC_SRA    20'b00010_00100
`define FUNC_SRRI   20'b00010_01000
`define FUNC_EXT    20'b00010_10001
`define FUNC_EXTU   20'b00010_10000
//--------------------LOGIC FUNC define---------
`define FUNC_AND    20'b00100_00001
`define FUNC_OR     20'b00100_00010
`define FUNC_XOR    20'b00100_00100
`define FUNC_ANDN   20'b00100_01001
`define FUNC_ORN    20'b00100_01010
`define FUNC_XORN   20'b00100_01100
//--------------------PACK FUNC define----------
`define FUNC_PACKL  20'b01000_00001
`define FUNC_PACKH  20'b01000_00010
`define FUNC_PACKHL 20'b01000_00100
`define FUNC_MVEQZ  20'b01000_01000
`define FUNC_MVNEZ  20'b01000_10000
//--------------------BITOP FUNC define---------
`define FUNC_FF0    20'b10000_10001
`define FUNC_FF1    20'b10000_10000
`define FUNC_TST    20'b10000_00100
`define FUNC_TSTNBZ 20'b10000_01000
`define FUNC_REV    20'b10000_00010
`endif
//--------------------ALU FUNC define End-----------

//--------------------MUL FUNC define Begin---------
`ifdef DSP
`define FUNC_MULT   20'b1001000000000010011
`define FUNC_MULH   20'b1001000001000010011
`define FUNC_MULHSU 20'b1001000001000010001
`define FUNC_MULHU  20'b1001000001000010000
//--------------------MULA FUNC define----------
`define FUNC_MULA   20'b1001000000001010011
`define FUNC_MULAH  20'b0111000000001010011
//--------------------MULS FUNC define----------
`define FUNC_MULS   20'b1001000000010010011
`define FUNC_MULSH  20'b0111000011010010011
`else
//--------------------MULT FUNC define----------
`define FUNC_MULT   20'b00000_00111
`define FUNC_MULH   20'b00000_00011
`define FUNC_MULHSU 20'b0000000001
`define FUNC_MULHU  20'b00000_00000
//--------------------MULA FUNC define----------
`define FUNC_MULA   20'b00001_00111
`define FUNC_MULAH  20'b00001_10111
//--------------------MULS FUNC define----------
`define FUNC_MULS   20'b00010_00111
`define FUNC_MULSH  20'b00010_10111
`endif
//--------------------MUL FUNC define End-----------

//--------------------DIV FUNC define Begin---------
`define FUNC_DIVS   20'b0000000001
`define FUNC_DIVU   20'b00000_00010
`define FUNC_REMS   20'b00000_00100
`define FUNC_REMU   20'b00000_01000
//--------------------DIV FUNC define End-----------

//--------------------BJU FUNC define Begin---------
//--------------------UCOND FUNC define---------
`define FUNC_JAL    20'b00001_00010
`define FUNC_JALR   20'b00001_00100
//--------------------COND FUNC define----------
`define FUNC_BEQ    20'b00010_00100
`define FUNC_BNE    20'b00010_01100
`define FUNC_BLT    20'b00010_10010
`define FUNC_BGE    20'b00010_11010
`define FUNC_BLTU   20'b00010_00010
`define FUNC_BGEU   20'b00010_01010
//--------------------AUIPC FUNC define---------
`define FUNC_AUIPC  20'b00100_00000
//--------------------BJU FUNC define End-----------

//--------------------LSU FUNC define Begin---------
//--------------------UBYTE FUNC define---------
`define FUNC_LBU    20'b00000_00000
//--------------------UHALT FUNC define---------
`define FUNC_LHU    20'b00001_00000
//--------------------BYTE  FUNC define---------
`define FUNC_LB     20'b00100_00000
`define FUNC_SB     20'b00100_00001
//--------------------HALF  FUNC define---------
`define FUNC_LH     20'b00101_00000
`define FUNC_SH     20'b00101_00001
//--------------------WORD  FUNC define---------
`define FUNC_LW     20'b00110_00000
`define FUNC_SW     20'b00110_00001
//--------------------UBYTEB FUNC define--------
`define FUNC_LBUIB  20'b01000_00000
//--------------------UBYTEA FUNC define--------
`define FUNC_LBUIA  20'b11000_00000
//--------------------UHALFB FUNC define--------
`define FUNC_LHUIB  20'b01001_00000
//--------------------UHALFA FUNC define--------
`define FUNC_LHUIA  20'b11001_00000
//--------------------BYTEB FUNC define---------
`define FUNC_LBIB   20'b01100_00000
`define FUNC_SBIB   20'b01100_00001
//--------------------BYTEA FUNC define---------
`define FUNC_LBIA   20'b11100_00000
`define FUNC_SBIA   20'b11100_00001
//--------------------HALFB FUNC define---------
`define FUNC_LHIB   20'b01101_00000
`define FUNC_SHIB   20'b01101_00001
//--------------------HALFA FUNC define---------
`define FUNC_LHIA   20'b11101_00000
`define FUNC_SHIA   20'b11101_00001
//--------------------WORDB FUNC define---------
`define FUNC_LWIB   20'b01110_00000
`define FUNC_SWIB   20'b01110_00001
//--------------------WORDA FUNC define---------
`define FUNC_LWIA   20'b11110_00000
`define FUNC_SWIA   20'b11110_00001
//--------------------DBWD FUNC define----------
`define FUNC_FLD    20'b00111_00000
`define FUNC_FSD    20'b00111_00001
//--------------------ATOM FUNC define----------
`define FUNC_LR     20'b00110_10010
`define FUNC_SC     20'b00110_10011
`define FUNC_AMO    20'b00110_10100
//--------------------DCAOPS FUNC define--------
`define FUNC_DIPA   20'b00000_01001
`define FUNC_DCPA   20'b00000_01010
`define FUNC_DCIPA  20'b00000_01011
//--------------------LSU FUNC define End-----------

//--------------------CP0 FUNC define Begin---------
//--------------------CSR FUNC define-----------
`define FUNC_CSRRW  20'b0000100001
`define FUNC_CSRRS  20'b0000100010
`define FUNC_CSRRC  20'b0000100100
`define FUNC_CSRR   20'b0000101000
//--------------------FNC FUNC define-------
`define FUNC_FENCE  20'b0001000001
`define FUNC_FENCI  20'b0001000010
`define FUNC_SYNC   20'b0001000100
`define FUNC_SYNCI  20'b0001001000
//--------------------SYS FUNC define-------
`define FUNC_ECALL  20'b0010000001
`define FUNC_EBREAK 20'b0010000010
`define FUNC_MRET   20'b0010000100
`define FUNC_DRET   20'b1000000010
`define FUNC_WFI    20'b0010001000
`define FUNC_CAOPS  20'b0010010000
//--------------------CP0 FUNC define End-----------

`ifdef DSP
//--------------------DSP ALU FUNC define Begin-----
`define FUNC_ADD8      20'b0000_1000_1000_0000_0000
`define FUNC_ADD16     20'b0000_1010_1000_0000_0000
`define FUNC_ADD32     20'b0000_1100_1000_0000_0000
`define FUNC_ADD64     20'b0000_1110_1000_0000_0000
`define FUNC_RADD8     20'b0000_1001_1000_0000_0000
`define FUNC_RADD16    20'b0000_1011_1000_0000_0000
`define FUNC_RADDW     20'b0000_1101_1000_0000_0000
`define FUNC_RADD64    20'b0000_1111_1000_0000_0000
`define FUNC_AVE       20'b0010_1101_1000_0001_0000
`define FUNC_URADD8    20'b0000_1001_0000_0000_0000
`define FUNC_URADD16   20'b0000_1011_0000_0000_0000
`define FUNC_URADDW    20'b0000_1101_0000_0000_0000
`define FUNC_URADD64   20'b0000_1111_0000_0000_0000
`define FUNC_KADD8     20'b0000_1000_1100_0000_0000
`define FUNC_KADD16    20'b0000_1010_1100_0000_0000
`define FUNC_KADDH     20'b0000_1100_1110_0000_0000
`define FUNC_KADDW     20'b0000_1100_1100_0000_0000
`define FUNC_KADD64    20'b0000_1110_1100_0000_0000
`define FUNC_UKADD8    20'b0000_1000_0100_0000_0000
`define FUNC_UKADD16   20'b0000_1010_0100_0000_0000
`define FUNC_UKADDH    20'b0000_1100_0110_0000_0000
`define FUNC_UKADDW    20'b0000_1100_0100_0000_0000
`define FUNC_UKADD64   20'b0000_1110_0100_0000_0000
`define FUNC_SUB8      20'b0000_1000_1001_1100_0000
`define FUNC_SUB16     20'b0000_1010_1001_1100_0000
`define FUNC_SUB32     20'b0000_1100_1001_1100_0000
`define FUNC_SUB64     20'b0000_1110_1001_1100_0000
`define FUNC_RSUB8     20'b0000_1001_1001_1100_0000
`define FUNC_RSUB16    20'b0000_1011_1001_1100_0000
`define FUNC_RSUBW     20'b0000_1101_1001_1100_0000
`define FUNC_RSUB64    20'b0000_1111_1001_1100_0000
`define FUNC_URSUB8    20'b0000_1001_0001_1100_0000
`define FUNC_URSUB16   20'b0000_1011_0001_1100_0000
`define FUNC_URSUBW    20'b0000_1101_0001_1100_0000
`define FUNC_URSUB64   20'b0000_1111_0001_1100_0000
`define FUNC_KSUB8     20'b0000_1000_1101_1100_0000
`define FUNC_KSUB16    20'b0000_1010_1101_1100_0000
`define FUNC_KSUBH     20'b0000_1100_1111_1100_0000
`define FUNC_KSUBW     20'b0000_1100_1101_1100_0000
`define FUNC_KSUB64    20'b0000_1110_1101_1100_0000
`define FUNC_UKSUB8    20'b0000_1000_0101_1100_0000
`define FUNC_UKSUB16   20'b0000_1010_0101_1100_0000
`define FUNC_UKSUBH    20'b0000_1100_0111_1100_0000
`define FUNC_UKSUBW    20'b0000_1100_0101_1100_0000
`define FUNC_UKSUB64   20'b0000_1110_0101_1100_0000
`define FUNC_CRAS16    20'b0000_1010_1000_1010_0000
`define FUNC_RCRAS16   20'b0000_1011_1000_1010_0000
`define FUNC_URCRAS16  20'b0000_1011_0000_1010_0000
`define FUNC_KCRAS16   20'b0000_1010_1100_1010_0000
`define FUNC_UKCRAS16  20'b0000_1010_0100_1010_0000
`define FUNC_CRSA16    20'b0000_1010_1001_0110_0000
`define FUNC_RCRSA16   20'b0000_1011_1001_0110_0000
`define FUNC_URCRSA16  20'b0000_1011_0001_0110_0000
`define FUNC_KCRSA16   20'b0000_1010_1101_0110_0000
`define FUNC_UKCRSA16  20'b0000_1010_0101_0110_0000
`define FUNC_STAS16    20'b0000_1010_1000_0100_0000
`define FUNC_RSTAS16   20'b0000_1011_1000_0100_0000
`define FUNC_URSTAS16  20'b0000_1011_0000_0100_0000
`define FUNC_KSTAS16   20'b0000_1010_1100_0100_0000
`define FUNC_UKSTAS16  20'b0000_1010_0100_0100_0000
`define FUNC_STSA16    20'b0000_1010_1000_1000_0000
`define FUNC_RSTSA16   20'b0000_1011_1000_1000_0000
`define FUNC_URSTSA16  20'b0000_1011_0000_1000_0000
`define FUNC_KSTSA16   20'b0000_1010_1100_1000_0000
`define FUNC_UKSTSA16  20'b0000_1010_0100_1000_0000
`define FUNC_CMPEQ8    20'b0000_1000_1101_1100_0100
`define FUNC_CMPEQ16   20'b0000_1010_1101_1100_0100
`define FUNC_SCMPLT8   20'b0000_1000_1001_1100_0100
`define FUNC_SCMPLT16  20'b0000_1010_1001_1100_0100
`define FUNC_SLT32     20'b0000_1100_1001_1100_0101
`define FUNC_SCMPLE8   20'b0000_1000_1011_1100_0100
`define FUNC_SCMPLE16  20'b0000_1010_1011_1100_0100
`define FUNC_UCMPLT8   20'b0000_1000_0001_1100_0100
`define FUNC_UCMPLT16  20'b0000_1010_0001_1100_0100
`define FUNC_SLTU32    20'b0000_1100_0001_1100_0101
`define FUNC_UCMPLE8   20'b0000_1000_0011_1100_0100
`define FUNC_UCMPLE16  20'b0000_1010_0011_1100_0100
`define FUNC_SMIN8     20'b0000_1001_1001_1100_0010
`define FUNC_SMIN16    20'b0000_1011_1001_1100_0010
`define FUNC_MINW      20'b0000_1101_1001_1100_0010
`define FUNC_UMIN8     20'b0000_1001_0001_1100_0010
`define FUNC_UMIN16    20'b0000_1011_0001_1100_0010
`define FUNC_SMAX8     20'b0000_1000_1001_1100_0011
`define FUNC_SMAX16    20'b0000_1010_1001_1100_0011
`define FUNC_MAXW      20'b0000_1100_1001_1100_0011
`define FUNC_UMAX8     20'b0000_1000_0001_1100_0011
`define FUNC_UMAX16    20'b0000_1010_0001_1100_0011
`define FUNC_KABS8     20'b0000_1000_1101_1100_1000
`define FUNC_KABS16    20'b0000_1010_1101_1100_1000
`define FUNC_KABSW     20'b0000_1100_1101_1100_1000
`define FUNC_PBSAD     20'b0000_1100_0001_1110_0001
`define FUNC_PBSADA    20'b0000_1100_0001_1111_0001
`define FUNC_ADDSL     20'b0000_1100_1000_0000_0001

//shift
`define FUNC_SRA8      20'b0001_0000_1000_0100_0000
`define FUNC_SRA16     20'b0001_0000_1001_0100_0000
`define FUNC_SRAW      20'b0001_0000_1010_0100_0000
`define FUNC_SRAU      20'b0001_0000_1010_0110_0000
`define FUNC_SRAI8     20'b0001_0000_1000_0100_0000
`define FUNC_SRAI16    20'b0001_0000_1001_0100_0000
`define FUNC_SRAIU     20'b0001_0000_1010_0110_0000
`define FUNC_SRA8U     20'b0001_0000_1000_0110_0000
`define FUNC_SRAI8U    20'b0001_0000_1000_0110_0000
`define FUNC_SRA16U    20'b0001_0000_1001_0110_0000
`define FUNC_SRAI16U   20'b0001_0000_1001_0110_0000
`define FUNC_SRL8      20'b0001_0000_1000_0000_0000
`define FUNC_SRL16     20'b0001_0000_1001_0000_0000
`define FUNC_SRLIW     20'b0001_0000_1010_0000_0000
`define FUNC_SRLI8     20'b0001_0000_1000_0000_0000
`define FUNC_SRLI16    20'b0001_0000_1001_0000_0000
`define FUNC_SRLIIW    20'b0001_0000_1010_0000_0000
`define FUNC_SRL8U     20'b0001_0000_1000_0010_0000
`define FUNC_SRLI8U    20'b0001_0000_1000_0010_0000
`define FUNC_SRL16U    20'b0001_0000_1001_0010_0000
`define FUNC_SRLI16U   20'b0001_0000_1001_0010_0000
`define FUNC_SLL8      20'b0001_0000_0000_1000_0000
`define FUNC_SLL16     20'b0001_0000_0001_1000_0000
`define FUNC_SLLIW     20'b0001_0000_0010_1000_0000
`define FUNC_SLLI8     20'b0001_0000_0000_1000_0000
`define FUNC_SLLI16    20'b0001_0000_0001_1000_0000
`define FUNC_SLLIIW    20'b0001_0000_0010_1000_0000
`define FUNC_KSLL8     20'b0001_0000_0000_1001_0000
`define FUNC_KSLL16    20'b0001_0000_0001_1001_0000
`define FUNC_KSLLW     20'b0001_0000_0010_1001_0000
`define FUNC_KSLLI8    20'b0001_0000_0000_1001_0000
`define FUNC_KSLLI16   20'b0001_0000_0001_1001_0000
`define FUNC_KSLLIW    20'b0001_0000_0010_1001_0000
`define FUNC_KSLRA8    20'b0001_0000_0000_1001_1000
`define FUNC_KSLRA16   20'b0001_0000_0001_1001_1000
`define FUNC_KSLRAW    20'b0001_0000_0010_1001_1000
`define FUNC_KSLRA8U   20'b0001_0000_0000_1011_1000
`define FUNC_KSLRA16U  20'b0001_0000_0001_1011_1000
`define FUNC_KSLRAWU   20'b0001_0000_0010_1011_1000
`define FUNC_WEXT      20'b0001_0000_1110_0000_0000
`define FUNC_WEXTI     20'b0001_0000_1110_0000_0000
`define FUNC_BITREV    20'b0001_0000_0010_0000_0010
`define FUNC_BITREVI   20'b0001_0000_0010_0000_0010
`define FUNC_SRRI      20'b0001_0000_1010_0000_0100
`define FUNC_SCLIP8    20'b0001_0000_0000_0110_0001
`define FUNC_SCLIP16   20'b0001_0000_0001_0110_0001
`define FUNC_SCLIP32   20'b0001_0000_0010_0110_0001
`define FUNC_UCLIP8    20'b0001_0000_0000_0010_0001
`define FUNC_UCLIP16   20'b0001_0000_0001_0010_0001
`define FUNC_UCLIP32   20'b0001_0000_0010_0010_0001
// pack
`define FUNC_PACKL     20'b0010_0000_0000_0001_0100
`define FUNC_PKBB16    20'b0010_0000_0000_0000_0100
`define FUNC_PKBT16    20'b0010_0000_0000_0100_0100
`define FUNC_PKTB16    20'b0010_0000_0000_1000_0100
`define FUNC_PKTT16    20'b0010_0000_0000_1100_0100
`define FUNC_SUNPKD810 20'b0010_0000_0000_0101_1000
`define FUNC_SUNPKD820 20'b0010_0000_0000_1001_1000
`define FUNC_SUNPKD830 20'b0010_0000_0000_1101_1000
`define FUNC_SUNPKD831 20'b0010_0000_0000_0111_1000
`define FUNC_SUNPKD832 20'b0010_0000_0000_1011_1000
`define FUNC_ZUNPKD810 20'b0010_0000_0000_0100_1000
`define FUNC_ZUNPKD820 20'b0010_0000_0000_1000_1000
`define FUNC_ZUNPKD830 20'b0010_0000_0000_1100_1000
`define FUNC_ZUNPKD831 20'b0010_0000_0000_0110_1000
`define FUNC_ZUNPKD832 20'b0010_0000_0000_1010_1000
`define FUNC_BPICK     20'b0010_0000_0000_0010_0010
`define FUNC_INSB      20'b0010_0000_0000_0010_0001
`define FUNC_SWAP8     20'b0010_0000_0000_0100_0001
`define FUNC_SWAP16    20'b0010_0000_0000_1000_0001
//bit ins
`define FUNC_CLRS8     20'b0100_0000_0000_0010_0001
`define FUNC_CLRS16    20'b0100_0000_0000_0110_0001
`define FUNC_CLRS32    20'b0100_0000_0000_1010_0001
`define FUNC_CLZ8      20'b0100_0000_0000_0001_0001
`define FUNC_CLZ16     20'b0100_0000_0000_0101_0001
`define FUNC_CLZ32     20'b0100_0000_0000_1001_0001
`define FUNC_CLO8      20'b0100_0000_0000_0000_1001
`define FUNC_CLO16     20'b0100_0000_0000_0100_1001
`define FUNC_CLO32     20'b0100_0000_0000_1000_1001
//--------------------DSP ALU FUNC define End-------

//--------------------DSP MUL FUNC define Begin-----
// 16-bit SIMD MUL
`define FUNC_SMUL16   20'b0111100000000010011
`define FUNC_SMULX16  20'b0111100000000010111
`define FUNC_UMUL16   20'b0111100000000010000
`define FUNC_UMULX16  20'b0111100000000010100
`define FUNC_KHM16    20'b0101110100000010011
`define FUNC_KHMX16   20'b0101110100000010111
// 8-bit SIMD MUL
`define FUNC_SMUL8    20'b0111100000000001011
`define FUNC_SMULX8   20'b0111100000000001111
`define FUNC_UMUL8    20'b0111100000000001000
`define FUNC_UMULX8   20'b0111100000000001100
`define FUNC_KHM8     20'b0101110100000001011
`define FUNC_KHMX8    20'b0101110100000001111
// MSW 32p32 MULA
`define FUNC_SMMUL    20'b1001000001000010011
`define FUNC_SMMULU   20'b1001000011000010011
`define FUNC_KMMAC    20'b1001010001001010011
`define FUNC_KMMACU   20'b1001010011001010011
`define FUNC_KMMSB    20'b1001010001010010011
`define FUNC_KMMSBU   20'b1001010011010010011
`define FUNC_KWMMUL   20'b1001010100000010011
`define FUNC_KWMMULU  20'b1001010110000010011
// MSW 32p16 MULA
`define FUNC_SMMWB    20'b1001000001000001011
`define FUNC_SMMWBU   20'b1001000011000001011
`define FUNC_SMMWT    20'b1001000001000001111
`define FUNC_SMMWTU   20'b1001000011000001111
`define FUNC_KMMAWB   20'b1001010001001001011
`define FUNC_KMMAWBU  20'b1001010011001001011
`define FUNC_KMMAWT   20'b1001010001001001111
`define FUNC_KMMAWTU  20'b1001010011001001111
`define FUNC_KMMWB2   20'b1001010100000001011
`define FUNC_KMMWB2U  20'b1001010110000001011
`define FUNC_KMMWT2   20'b1001010100000001111
`define FUNC_KMMWT2U  20'b1001010110000001111
`define FUNC_KMMAWB2  20'b1001010100001001011
`define FUNC_KMMAWB2U 20'b1001010110001001011
`define FUNC_KMMAWT2  20'b1001010100001001111
`define FUNC_KMMAWT2U 20'b1001010110001001111
// S16b MULA/MULS
`define FUNC_SMBB16   20'b0111000000000010011
`define FUNC_SMBT16   20'b0111000000000010111
`define FUNC_SMTT16   20'b0110100000000010011
`define FUNC_KMDA     20'b0111010000100010011
`define FUNC_KMXDA    20'b0111010000100010111
`define FUNC_SMDS     20'b0111000001100010011
`define FUNC_SMDRS    20'b0111000010100010011
`define FUNC_SMXDS    20'b0111000001100010111
`define FUNC_KMABB    20'b0111010000001010011
`define FUNC_KMABT    20'b0111010000001010111
`define FUNC_KMATT    20'b0110110000001010011
`define FUNC_KMADA    20'b0111010000101010011
`define FUNC_KMAXDA   20'b0111010000101010111
`define FUNC_KMADS    20'b0111010001101010011
`define FUNC_KMADRS   20'b0111010010101010011
`define FUNC_KMAXDS   20'b0111010001101010111
`define FUNC_KMSDA    20'b0111010011101010011
`define FUNC_KMSXDA   20'b0111010011101010111
// 8b MULA
`define FUNC_SMAQA    20'b0111100000101001011
`define FUNC_UMAQA    20'b0111100000101001000
`define FUNC_SMAQASU  20'b0111100000101001001
// Q15 MUL
`define FUNC_KHMBB    20'b0101010100000010011
`define FUNC_KHMBT    20'b0101010100000010111
`define FUNC_KHMTT    20'b0100110100000010011
// Q31 MUL
`define FUNC_KDMBB    20'b0111011000000010011
`define FUNC_KDMBT    20'b0111011000000010111
`define FUNC_KDMTT    20'b0110111000000010011
`define FUNC_KDMABB   20'b0111011000001010011
`define FUNC_KDMABT   20'b0111011000001010111
`define FUNC_KDMATT   20'b0110111000001010011
// Misc
`define FUNC_MADDR32  20'b1001000000001010011
`define FUNC_MSUBR32  20'b1001000000010010011
// Zp64 MUL
`define FUNC_SMAL     20'b0101000000001110111
`define FUNC_SMAR64   20'b1001100000001010011
`define FUNC_SMSR64   20'b1001100000010010011
`define FUNC_UMAR64   20'b1001100000001010000
`define FUNC_UMSR64   20'b1001100000010010000
`define FUNC_KMAR64   20'b1001110000001010011
`define FUNC_KMSR64   20'b1001110000010010011
`define FUNC_UKMAR64  20'b1001110000001010000
`define FUNC_UKMSR64  20'b1001110000010010000
`define FUNC_SMALBB   20'b0111000000001110011
`define FUNC_SMALBT   20'b0111000000001110111
`define FUNC_SMALTT   20'b0110100000001110011
`define FUNC_SMALDA   20'b0111000000101110011
`define FUNC_SMALXDA  20'b0111000000101110111
`define FUNC_SMALDS   20'b0111000001101110011
`define FUNC_SMALDRS  20'b0111000010101110011
`define FUNC_SMALXDS  20'b0111000001101110111
`define FUNC_SMSLDA   20'b0111000011101110011
`define FUNC_SMSLXDA  20'b0111000011101110111
`define FUNC_MULR64   20'b1001100000000010000
`define FUNC_MULSR64  20'b1001100000000010011
//--------------------DSP MUL FUNC define End-------
`endif
