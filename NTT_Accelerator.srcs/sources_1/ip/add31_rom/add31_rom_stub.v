// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Jun 11 12:32:49 2025
// Host        : b107_win7_64_PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top add31_rom -prefix
//               add31_rom_ add31_rom_stub.v
// Design      : add31_rom
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010iclg225-1L
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *)
module add31_rom(clka, addra, douta, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,addra[9:0],douta[4:0],clkb,addrb[9:0],doutb[4:0]" */;
  input clka;
  input [9:0]addra;
  output [4:0]douta;
  input clkb;
  input [9:0]addrb;
  output [4:0]doutb;
endmodule
