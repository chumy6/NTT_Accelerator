// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
// Date        : Wed Jun 11 12:34:51 2025
// Host        : b107_win7_64_PC running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top reconstruct_rom -prefix
//               reconstruct_rom_ reconstruct_rom_sim_netlist.v
// Design      : reconstruct_rom
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010iclg225-1L
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "reconstruct_rom,blk_mem_gen_v8_4_2,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_2,Vivado 2018.3" *) 
(* NotValidForBitStream *)
module reconstruct_rom
   (clka,
    addra,
    douta,
    clkb,
    addrb,
    doutb);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [12:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [11:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE OTHER, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [12:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [11:0]doutb;

  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [11:0]douta;
  wire [11:0]doutb;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_rsta_busy_UNCONNECTED;
  wire NLW_U0_rstb_busy_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [12:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [12:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [11:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "13" *) 
  (* C_ADDRB_WIDTH = "13" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "9" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "3" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "0" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "0" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.791205 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "0" *) 
  (* C_HAS_ENB = "0" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "1" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "0" *) 
  (* C_HAS_RSTB = "0" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "reconstruct_rom.mem" *) 
  (* C_INIT_FILE_NAME = "reconstruct_rom.mif" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "1" *) 
  (* C_MEM_TYPE = "4" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "7168" *) 
  (* C_READ_DEPTH_B = "7168" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "12" *) 
  (* C_READ_WIDTH_B = "12" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "0" *) 
  (* C_USE_BYTE_WEA = "0" *) 
  (* C_USE_BYTE_WEB = "0" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "1" *) 
  (* C_WEB_WIDTH = "1" *) 
  (* C_WRITE_DEPTH_A = "7168" *) 
  (* C_WRITE_DEPTH_B = "7168" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "12" *) 
  (* C_WRITE_WIDTH_B = "12" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  reconstruct_rom_blk_mem_gen_v8_4_2 U0
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dinb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(1'b0),
        .enb(1'b0),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[12:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(1'b0),
        .rsta_busy(NLW_U0_rsta_busy_UNCONNECTED),
        .rstb(1'b0),
        .rstb_busy(NLW_U0_rstb_busy_UNCONNECTED),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[12:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[11:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb(1'b0),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(1'b0),
        .web(1'b0));
endmodule

module reconstruct_rom_blk_mem_gen_generic_cstr
   (douta,
    doutb,
    clka,
    clkb,
    addra,
    addrb);
  output [11:0]douta;
  output [11:0]doutb;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [11:0]douta;
  wire [11:0]doutb;
  wire \ramloop[1].ram.r_n_0 ;
  wire \ramloop[1].ram.r_n_1 ;
  wire \ramloop[1].ram.r_n_10 ;
  wire \ramloop[1].ram.r_n_11 ;
  wire \ramloop[1].ram.r_n_12 ;
  wire \ramloop[1].ram.r_n_13 ;
  wire \ramloop[1].ram.r_n_14 ;
  wire \ramloop[1].ram.r_n_15 ;
  wire \ramloop[1].ram.r_n_2 ;
  wire \ramloop[1].ram.r_n_3 ;
  wire \ramloop[1].ram.r_n_4 ;
  wire \ramloop[1].ram.r_n_5 ;
  wire \ramloop[1].ram.r_n_6 ;
  wire \ramloop[1].ram.r_n_7 ;
  wire \ramloop[1].ram.r_n_8 ;
  wire \ramloop[1].ram.r_n_9 ;
  wire \ramloop[2].ram.r_n_0 ;
  wire \ramloop[2].ram.r_n_1 ;
  wire \ramloop[2].ram.r_n_10 ;
  wire \ramloop[2].ram.r_n_11 ;
  wire \ramloop[2].ram.r_n_12 ;
  wire \ramloop[2].ram.r_n_13 ;
  wire \ramloop[2].ram.r_n_14 ;
  wire \ramloop[2].ram.r_n_15 ;
  wire \ramloop[2].ram.r_n_2 ;
  wire \ramloop[2].ram.r_n_3 ;
  wire \ramloop[2].ram.r_n_4 ;
  wire \ramloop[2].ram.r_n_5 ;
  wire \ramloop[2].ram.r_n_6 ;
  wire \ramloop[2].ram.r_n_7 ;
  wire \ramloop[2].ram.r_n_8 ;
  wire \ramloop[2].ram.r_n_9 ;

  reconstruct_rom_blk_mem_gen_mux \has_mux_a.A 
       (.DOADO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 ,\ramloop[2].ram.r_n_4 ,\ramloop[2].ram.r_n_5 ,\ramloop[2].ram.r_n_6 ,\ramloop[2].ram.r_n_7 }),
        .addra(addra[12]),
        .clka(clka),
        .douta(douta[11:4]),
        .\douta[11] ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }));
  reconstruct_rom_blk_mem_gen_mux__parameterized0 \has_mux_b.B 
       (.DOBDO({\ramloop[2].ram.r_n_8 ,\ramloop[2].ram.r_n_9 ,\ramloop[2].ram.r_n_10 ,\ramloop[2].ram.r_n_11 ,\ramloop[2].ram.r_n_12 ,\ramloop[2].ram.r_n_13 ,\ramloop[2].ram.r_n_14 ,\ramloop[2].ram.r_n_15 }),
        .addrb(addrb[12]),
        .clkb(clkb),
        .doutb(doutb[11:4]),
        .\doutb[11] ({\ramloop[1].ram.r_n_8 ,\ramloop[1].ram.r_n_9 ,\ramloop[1].ram.r_n_10 ,\ramloop[1].ram.r_n_11 ,\ramloop[1].ram.r_n_12 ,\ramloop[1].ram.r_n_13 ,\ramloop[1].ram.r_n_14 ,\ramloop[1].ram.r_n_15 }));
  reconstruct_rom_blk_mem_gen_prim_width \ramloop[0].ram.r 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .douta(douta[3:0]),
        .doutb(doutb[3:0]));
  reconstruct_rom_blk_mem_gen_prim_width__parameterized0 \ramloop[1].ram.r 
       (.\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram ({\ramloop[1].ram.r_n_0 ,\ramloop[1].ram.r_n_1 ,\ramloop[1].ram.r_n_2 ,\ramloop[1].ram.r_n_3 ,\ramloop[1].ram.r_n_4 ,\ramloop[1].ram.r_n_5 ,\ramloop[1].ram.r_n_6 ,\ramloop[1].ram.r_n_7 }),
        .\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ({\ramloop[1].ram.r_n_8 ,\ramloop[1].ram.r_n_9 ,\ramloop[1].ram.r_n_10 ,\ramloop[1].ram.r_n_11 ,\ramloop[1].ram.r_n_12 ,\ramloop[1].ram.r_n_13 ,\ramloop[1].ram.r_n_14 ,\ramloop[1].ram.r_n_15 }),
        .addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb));
  reconstruct_rom_blk_mem_gen_prim_width__parameterized1 \ramloop[2].ram.r 
       (.DOADO({\ramloop[2].ram.r_n_0 ,\ramloop[2].ram.r_n_1 ,\ramloop[2].ram.r_n_2 ,\ramloop[2].ram.r_n_3 ,\ramloop[2].ram.r_n_4 ,\ramloop[2].ram.r_n_5 ,\ramloop[2].ram.r_n_6 ,\ramloop[2].ram.r_n_7 }),
        .DOBDO({\ramloop[2].ram.r_n_8 ,\ramloop[2].ram.r_n_9 ,\ramloop[2].ram.r_n_10 ,\ramloop[2].ram.r_n_11 ,\ramloop[2].ram.r_n_12 ,\ramloop[2].ram.r_n_13 ,\ramloop[2].ram.r_n_14 ,\ramloop[2].ram.r_n_15 }),
        .addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb));
endmodule

module reconstruct_rom_blk_mem_gen_mux
   (douta,
    addra,
    clka,
    DOADO,
    \douta[11] );
  output [7:0]douta;
  input [0:0]addra;
  input clka;
  input [7:0]DOADO;
  input [7:0]\douta[11] ;

  wire [7:0]DOADO;
  wire [0:0]addra;
  wire clka;
  wire [7:0]douta;
  wire [7:0]\douta[11] ;
  wire sel_pipe;
  wire sel_pipe_d1;

  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[10]_INST_0 
       (.I0(DOADO[6]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [6]),
        .O(douta[6]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[11]_INST_0 
       (.I0(DOADO[7]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [7]),
        .O(douta[7]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[4]_INST_0 
       (.I0(DOADO[0]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [0]),
        .O(douta[0]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[5]_INST_0 
       (.I0(DOADO[1]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [1]),
        .O(douta[1]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[6]_INST_0 
       (.I0(DOADO[2]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [2]),
        .O(douta[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[7]_INST_0 
       (.I0(DOADO[3]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [3]),
        .O(douta[3]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[8]_INST_0 
       (.I0(DOADO[4]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [4]),
        .O(douta[4]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \douta[9]_INST_0 
       (.I0(DOADO[5]),
        .I1(sel_pipe_d1),
        .I2(\douta[11] [5]),
        .O(douta[5]));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(sel_pipe),
        .Q(sel_pipe_d1),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[0] 
       (.C(clka),
        .CE(1'b1),
        .D(addra),
        .Q(sel_pipe),
        .R(1'b0));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_mux" *) 
module reconstruct_rom_blk_mem_gen_mux__parameterized0
   (doutb,
    addrb,
    clkb,
    DOBDO,
    \doutb[11] );
  output [7:0]doutb;
  input [0:0]addrb;
  input clkb;
  input [7:0]DOBDO;
  input [7:0]\doutb[11] ;

  wire [7:0]DOBDO;
  wire [0:0]addrb;
  wire clkb;
  wire [7:0]doutb;
  wire [7:0]\doutb[11] ;
  wire \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ;
  wire \no_softecc_sel_reg.ce_pri.sel_pipe_reg_n_0_[0] ;

  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[10]_INST_0 
       (.I0(DOBDO[6]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [6]),
        .O(doutb[6]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[11]_INST_0 
       (.I0(DOBDO[7]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [7]),
        .O(doutb[7]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[4]_INST_0 
       (.I0(DOBDO[0]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [0]),
        .O(doutb[0]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[5]_INST_0 
       (.I0(DOBDO[1]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [1]),
        .O(doutb[1]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[6]_INST_0 
       (.I0(DOBDO[2]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [2]),
        .O(doutb[2]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[7]_INST_0 
       (.I0(DOBDO[3]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [3]),
        .O(doutb[3]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[8]_INST_0 
       (.I0(DOBDO[4]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [4]),
        .O(doutb[4]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \doutb[9]_INST_0 
       (.I0(DOBDO[5]),
        .I1(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .I2(\doutb[11] [5]),
        .O(doutb[5]));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg[0] 
       (.C(clkb),
        .CE(1'b1),
        .D(\no_softecc_sel_reg.ce_pri.sel_pipe_reg_n_0_[0] ),
        .Q(\no_softecc_norm_sel2.has_mem_regs.WITHOUT_ECC_PIPE.ce_pri.sel_pipe_d1_reg_n_0_[0] ),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \no_softecc_sel_reg.ce_pri.sel_pipe_reg[0] 
       (.C(clkb),
        .CE(1'b1),
        .D(addrb),
        .Q(\no_softecc_sel_reg.ce_pri.sel_pipe_reg_n_0_[0] ),
        .R(1'b0));
endmodule

module reconstruct_rom_blk_mem_gen_prim_width
   (douta,
    doutb,
    clka,
    clkb,
    addra,
    addrb);
  output [3:0]douta;
  output [3:0]doutb;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [3:0]douta;
  wire [3:0]doutb;

  reconstruct_rom_blk_mem_gen_prim_wrapper_init \prim_init.ram 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .douta(douta),
        .doutb(doutb));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module reconstruct_rom_blk_mem_gen_prim_width__parameterized0
   (\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram ,
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ,
    clka,
    clkb,
    addra,
    addrb);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram ;
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram ;
  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ;
  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;

  reconstruct_rom_blk_mem_gen_prim_wrapper_init__parameterized0 \prim_init.ram 
       (.\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 (\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram ),
        .\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_1 (\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ),
        .addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_width" *) 
module reconstruct_rom_blk_mem_gen_prim_width__parameterized1
   (DOADO,
    DOBDO,
    clka,
    clkb,
    addra,
    addrb);
  output [7:0]DOADO;
  output [7:0]DOBDO;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [7:0]DOADO;
  wire [7:0]DOBDO;
  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;

  reconstruct_rom_blk_mem_gen_prim_wrapper_init__parameterized1 \prim_init.ram 
       (.DOADO(DOADO),
        .DOBDO(DOBDO),
        .addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb));
endmodule

module reconstruct_rom_blk_mem_gen_prim_wrapper_init
   (douta,
    doutb,
    clka,
    clkb,
    addra,
    addrb);
  output [3:0]douta;
  output [3:0]doutb;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [3:0]douta;
  wire [3:0]doutb;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:4]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:4]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h0CA426703C25B554B8E796FC263254A10E9701CB2C64A14036708F8FF98CA3F1),
    .INIT_01(256'h062CFB2982754A87194A6A493147512C0D0E90B28B8418C76DDCF9589EA4E5BA),
    .INIT_02(256'h0DAD7CF79D22B175E3695F69A7DCBE15077D4847E0D571B417958596844623BE),
    .INIT_03(256'h09A18F6F70BC76A62D426A39B9355DD60940BF944B8F193A92274E0888B4A72F),
    .INIT_04(256'h032C5EE341F0EB09231A9C5E7ED1F7D000D5B7A6F12D104E265DD5A727F32991),
    .INIT_05(256'h0AA0027F8609CA4B36B3638519F94B7905BBD4718F1711AEC9FD77D96DCECAA8),
    .INIT_06(256'h0DC0401936E8D5908C3899D26FFB02D405DB3B88A42720919D0989C4881F6524),
    .INIT_07(256'h0E1B273B5492422473BDF973959A65FC00F30EE2F895D2B1ED27837C8320F6CD),
    .INIT_08(256'h03C381028D9139C4EE632F31973FD28808D29D1C37BA6395C1053FC07207D299),
    .INIT_09(256'h03AEC14DB8611A94AD1ED2A3482E9B6B0A0A2C0C8C865CEDA807DB096E1682D9),
    .INIT_0A(256'h04C152525A5A9A231FEB9E068DC1C3A80E4BFFF05B4DFD2706D7875FE1C64234),
    .INIT_0B(256'h0427ABDB81DDAF6679BC57CE0C5F19610AA94D3CE53222B9A6D4C724A2F8F3C9),
    .INIT_0C(256'h05B90A11D2D6D233F73DD0C0B84866CB0ADE91CA707440A5C98D20E8D223C81D),
    .INIT_0D(256'h0051A9CDE6F47798F70216BBFA21008602F138FF1DC148A95590F384DB011190),
    .INIT_0E(256'h0AE2E62324BAD85264D5588147430D650DFED8F54FDB7EFE5FCBEEF2A9401C94),
    .INIT_0F(256'h050E622D579300689F2F30A015277CFB056D70D4DEA4110B31A176A64C529C10),
    .INIT_10(256'h095F321422CC3CE813F7B8DCB73C8B3800A2455D3B9E017BB5B9FD02D5544B0D),
    .INIT_11(256'h0FA90F56F8A37340554BAD899CA9FFC60EA513E935D0DFA06A5A0C24076DCE34),
    .INIT_12(256'h036A8A3805F511C33BF8EB18AB268FA4054D04A754EAC633ACD2CBA93C4D1432),
    .INIT_13(256'h0B00BBCBF6C2B8EB465B8E667FCE34CB0D742D4B655035E880AFC29E3631A1E6),
    .INIT_14(256'h06E03D1D3673EC842D77DC343D75AB3E0C16D1B500432D147C61C7B0B7FF750B),
    .INIT_15(256'h0015B328C1333DA3BB6445A07282EE8F063D8A8A2D090EA581EA2E83851B47E9),
    .INIT_16(256'h05F7186CB5440929509694C662B1F5CE0CEE43B720A3EC09118187F29BAB03AC),
    .INIT_17(256'h0D8FA86D6BF56F195647833875EB025E03EA03A90876F9084889A651BD1E55A5),
    .INIT_18(256'h054A712841E28BE310E9B2036E576997030547FEC95B65C3916CB59AFAE0FB39),
    .INIT_19(256'h0FC52046470E486C6045F0A1921866AE04763E587917B3AA9074D92B37B65789),
    .INIT_1A(256'h0A0BBCEDFC5D755006385DB8330C57CA0D832B506122CBAE72A75C9A75ABF0F8),
    .INIT_1B(256'h0EAA6849E94561BC06A235CD5C8B839D022D6F5EEDDAE671BA1BAF0754327D8B),
    .INIT_1C(256'h078A33E4F4BCFEF2A66408666693616C044C0506157DB2159F4F429F2FB3B02B),
    .INIT_1D(256'h0C298CC3622A7C9DEAFB76A71F231AF601AEE3264606478C3866E3F16B80221F),
    .INIT_1E(256'h0DA66BEAB6049C9FD4089B6D9CE12AC70D3C92592CA4396C4F532FFDC51F080F),
    .INIT_1F(256'h0153F5B5AEB11E183E230C1C3F6B220D085A1494C0D56D60A7EE772A5C9052FC),
    .INIT_20(256'h0C6CFD69FA8E25F0EFAD7057DEBA1E5F0D7DD1EEA1329268967E2138C1056F51),
    .INIT_21(256'h0CD19AB8D7E7DDE0DDC045BF526289BA0DC953B4442829837D3167413846F969),
    .INIT_22(256'h0B60AE3EC8C2087E45630C974A52A74F0CA0DD0C8C958BEDDBFE67AA4D9DD31C),
    .INIT_23(256'h05A67BF2DFF7E868ECC44B87292E2A1602D8E76FFCD313991D7AF28E1608DDB9),
    .INIT_24(256'h011610FE0A8553A3402441EF5CC3EE02000103FB144F7AFA2E088014C2A7C20F),
    .INIT_25(256'h0857E6E56EBE9CE828D6A777F1FA39B10A097378248A47B4535739C964DD0980),
    .INIT_26(256'h09AC8155ED884FB216184D4B1D008E3303F1868418985D9002BCFDF4676997DF),
    .INIT_27(256'h09DF9DAE642BAE8C87AC2E3063AEFCD80C416031FABEA59EF92BB412413CF29E),
    .INIT_28(256'h00EA5D93BEF2E38A124FF9EBE90BF9A807CE82501CE2C1AF1A468874F8105EA6),
    .INIT_29(256'h05078D74A34F7EDBF3C6B607300D479B0BC5347A1A4618730A9F4F71AF51A95D),
    .INIT_2A(256'h0786FE0236431C945E5E49D5ECFCFC7704E4FA1B4F9A6230FBDCED3A62621C9D),
    .INIT_2B(256'h0472BDA865CA0311C20EB04FA76468040FFF287B4D53FD0F296E51778E4E43CE),
    .INIT_2C(256'h0B4FEE22E45151F9DBBB5BC6B17004FA0DD17CB89AF1304F2E59F47F38067A6A),
    .INIT_2D(256'h0D8A852A1F0B5627701A9B1007E543B207D978CCB12D9D4E10B0810209922045),
    .INIT_2E(256'h07496FB64CC8902ADE94BB73F3BF7FD606A8238256D32B78DC052D42C491CD24),
    .INIT_2F(256'h0EE1B9C2F6E1700C3AA556CE3BFF4C480D0018E010AB4BD7CF8A017B4A14D237),
    .INIT_30(256'h0555398E2969426A259619842EF0DF250A10A36C0824FF48CDDF1497FDCC4C68),
    .INIT_31(256'h04AE71CCA674988478125B278B2CB297014C71BDC795FDEABE53ED3790E38EC4),
    .INIT_32(256'h0C075E3629F60A76FB925DEB79779122071BE175485668E5640BEFCD4147A0D3),
    .INIT_33(256'h076932DB26939BA353ED56A11F6560B501ECA9927250838BE070394ADF4D4BCF),
    .INIT_34(256'h0E309DF1AAC5EDE4AF76E3B35E434EB00E040D65BD5A626A32AC1655B4A6C12D),
    .INIT_35(256'h0EA47366B6DC51AF9F3792A0C67F960E0113EC90D7FD9E9C06AA38BE44798F41),
    .INIT_36(256'h0D1808C38B8D5BFF602C5DC2409B36C80E3918D0909A2886761E455B3DE8AF27),
    .INIT_37(256'h0C22083BDF9EE9ACA61FC34B273B4B920D281ED9787BC062036C7CF37EE7889A),
    .INIT_38(256'h03964E0138631EB3CA2883CD710F8D0306B95E80B5FC87273D2698E19DAC358A),
    .INIT_39(256'h03D9B5D1DC21748FE9BBB32ECF1DBD610ACE7A81AD4896E16BCD980ABE0C9C80),
    .INIT_3A(256'h09ACC11BB9C069EC153A57C162534A5C0F5673AD7AC5871C74212E49FF6C5B0D),
    .INIT_3B(256'h0CB6651B7F7C50C5919E1437AB9B838D072BA0670C724ACD8FAC96F94B3C3334),
    .INIT_3C(256'h05232F7BDD190BB48EBCB5B97E13D2D6046F5C82D2DE82226E81FADD51C170CA),
    .INIT_3D(256'h07A58430266B7AA2F007205FA955EBF40BDA9559BF3E2DB611FF020133EFBDC1),
    .INIT_3E(256'h0D85864D1586148530F65A42BB2376B107E8E5D2BEFF245402C912FE58FC8F57),
    .INIT_3F(256'h000389E2FE1A0552B6CF150CE2C657360CB0B11A336AF4C589CF059C70D4D514),
    .INIT_40(256'h03FC813F74ADCA7367B3C95B524B227C0F87B95BA3D0ED5014B2D04A440D370E),
    .INIT_41(256'h0A3431545ADC69CF9F986759087694A30DF896A4A0BA40E6DB23B8A58CE6D5DF),
    .INIT_42(256'h011933DC8E118AD2CFFAD26B1A3E05950C93344D23BA77C4814E05570441595A),
    .INIT_43(256'h0A3EB9655DE697F8F3F7BBC7BA6BF4C20E5E8804AC2FE30B194E68F4934B2554),
    .INIT_44(256'h0ECE72D17DD042C75E331FE0BD12367902A747F6199B0D7F7A5F1C11D1E200D3),
    .INIT_45(256'h038A39F64B5AAA202EE8609CB3B8CB3307EA6D1EC2E858BDB418917D8A8A9F09),
    .INIT_46(256'h0992650B09D46604119CEEF7596CC5490EC4911F152F2DBAB83A4CE203B92098),
    .INIT_47(256'h0673959475F3E15E70254D84A8476BD503708388F66D0BD0E52F535A0B190276),
    .INIT_48(256'h0FBE970FDB2836387629791A7C28E6E206507907CB99AD2E01B37B0537FC1953),
    .INIT_49(256'h04A3C62E5B6A1A21146A8FC1A04A47ED0B0AAE178292A072C57894653ED87077),
    .INIT_4A(256'h0E058D63C3D84335C525AAABB23DFE5D07BFE7264534A7BABF0F8483D2506128),
    .INIT_4B(256'h061E005F236CD278BD391DAAF84799C50E2412F1B3F0AA43D7DE52226F9AED4A),
    .INIT_4C(256'h00CF284666865660A61DC76D3334F3DC0021D2F3C42DF2E93BA2B74C0A069872),
    .INIT_4D(256'h06CBFEA1B78671123CDF6F2979CF72210484C306619F1FB88F21D1A48395460F),
    .INIT_4E(256'h0989F7408DB6AECE62A24DAD6B26BD540EF6A9F512F4DC5DF054FDBC9FE9FCA4),
    .INIT_4F(256'h00E113E770CBC3E6B2D0D93306B5F2B306D60A52E712A6D90D2FEA5114931017),
    .INIT_50(256'h085FBEFC87087DF3A145FCCCCE693F8B09228954E2038A2055F5B97011EB519F),
    .INIT_51(256'h0D890DAC0FCBFA26F59F8CD73A05D7B70C2837D3CE74E3813F939D0D5A044528),
    .INIT_52(256'h0B87AB5680C434A82A80FF50AC3EBFC208B93DBDE632A4D9DA714EA0630ACC9C),
    .INIT_53(256'h0E868ECE44C87002BCA16CAB8BF4DFB801999637A128D762DDD65203E78FFAF3),
    .INIT_54(256'h0C3A3D02AB1E65C3DED32136184E078507AFB2EF780B4C6D7B50F431D1FBC44C),
    .INIT_55(256'h09C072826A8F715FA28B1357D6EBBEB40483451577EC634DA892DA00735824AA),
    .INIT_56(256'h04CB22B1F5D45FD188EB39408195E96807D99B2B0FDCC6E49972FA3180841898),
    .INIT_57(256'h03E8787B025E06FAE6DD8FDFF1AE64280A51EF1EB5A12EA33A298C4F9034FA9A),
    .INIT_58(256'h0E03AE54F99E54901F9410E85D31BE92059AFAA4FB893F8405EC67BE8C3016E2),
    .INIT_59(256'h00ED92386B6EF352D469B0E78674044F018B30B6F4891765159591C534790A4D),
    .INIT_5A(256'h01B8450CE7CD50CFCEC7C7875E0036850C9305ADF0D3D622B1C6D42CFAEB4A7A),
    .INIT_5B(256'h05C15C208B0DEA76469E4452BBC86ACA0FD75292758B78D4E5ECEDFF677BAD5A),
    .INIT_5C(256'h05166D93B56C68A70E4F4B4FEE2A6440039FFFB59047448057A15DDB7C5994F1),
    .INIT_5D(256'h06A27F011AB1C078C4362DA789DA1FBB03D46B00281F20EE2264506978CC862E),
    .INIT_5E(256'h0B0D9DE14BC73F6BFEAD6049C9BD4CC902FD8D105804234925D2C6A393C45632),
    .INIT_5F(256'h0710CF6A526C15BF54CAEE11B983F23107BD5CF8501C84A14D4C7D5016007EAB),
    .INIT_60(256'h0456AEB96E98C6EFDDFFA5E2390E2AD901F4C1DD6141DFDDC4EA8320A68C6724),
    .INIT_61(256'h0588578285BA7819CB897E7EDECCD6740FD1AB463E637C9E3BEC424291B7D716),
    .INIT_62(256'h00976F59274EB697E31C8C008EE4293607AE5D40D3FCC41DDAC83758EED54F56),
    .INIT_63(256'h0BBA293E25665167562D5F7936DBCC93083E1E0803B9AD84D6FCCDEC3991D25F),
    .INIT_64(256'h0EDF4AC36E0B31640FEBA8353DF4AA440616A2AAC26500403C114EF70DA5B08A),
    .INIT_65(256'h077AF1F339218C6E6956EEE47E86BDDC09E9606D0380E497978418137B9037F3),
    .INIT_66(256'h05BB1600C5332AC9B55CD818F8C16B8402F46761E7D53FDE68F18E35180090CA),
    .INIT_67(256'h0E3AC3A1FC349D79D4B62CBA08CBDACE0406413CF7CEC7167819ABE819D9927B),
    .INIT_68(256'h09EBECABF8A8D7A0F9303F963801286F087473106EAE1CEA2558C6BC1E81B568),
    .INIT_69(256'h0707F00BB79250F1DBDA33D7B5BFDC610F7EAFBCA98DBBE3C9A10A6E7731A948),
    .INIT_6A(256'h099EEC5CF577166F3425C43CC91BE5C4087A6762129D9E46C1B0F95623AFBACE),
    .INIT_6B(256'h054F5964E80377B9DA385CB0351C7FEB017CDE4A436FF4B28334473FA0F706E2),
    .INIT_6C(256'h0BCBB1EB0B5AB7EE3D2E65132F9BBB19042F36E61F6AD51C1B8CAF6F0482E2DF),
    .INIT_6D(256'h07A00FE572B5F8A552BFF0A5643706A90202699FF0207D3E8BDB1BD995E1BB0E),
    .INIT_6E(256'h0B78530F7FA47BB6F7641D8982AD19460D45C021C124E582C8257D38B7D2C0F2),
    .INIT_6F(256'h005E3B6FF148CE1C6C236E0300E3AE150F7B581CF239C00D8E510CB4B17C33A0),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(4),
    .READ_WIDTH_B(4),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(4),
    .WRITE_WIDTH_B(4)) 
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:4],douta}),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:4],doutb}),
        .DOPADOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:0]),
        .DOPBDOP(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:0]),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(1'b1),
        .ENBWREN(1'b1),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b1),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module reconstruct_rom_blk_mem_gen_prim_wrapper_init__parameterized0
   (\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ,
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_1 ,
    clka,
    clkb,
    addra,
    addrb);
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ;
  output [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_1 ;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 ;
  wire [7:0]\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_1 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_71 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_75 ;
  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [0:0]ena_array;
  wire [0:0]enb_array;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h00BCCD2E640FAC15A4BA2F14B92541B64951C14A7BA035044F0A835F957BC000),
    .INIT_01(256'h001F0DC274888C8F00698993848D0CAD83C92B36758D52AAB2B09D13AF433D0A),
    .INIT_02(256'h00707140B2078B88CFAC16CE12486D68BBBFC52CC952A71AAD6398A688068EA3),
    .INIT_03(256'h003D4D292356CD45756A557CCBC6C0A93E580E8212B861803F3B157DBEB8C47F),
    .INIT_04(256'h00668D52A81097CFBF199F2839912E17059605102D46346412925C0D37599E20),
    .INIT_05(256'h006C5C10779F076B30478A575C341A8ABE55BF812B54328B41B94F482A02A55B),
    .INIT_06(256'h00298A0257901D1C78C8B7568A3B5F0533BF121B6B96CCCDA266B03D06C79788),
    .INIT_07(256'h0021CBCAB11F77B20A3D4938AD1D8849BB3205305E9BB203884196181A43AAC8),
    .INIT_08(256'h00CA754A5B944D570F2A04252B9806A1A642C031059DB79DA0982CA981622417),
    .INIT_09(256'h00122268C5B20D7FA07227364E80AE8A724BA93A679749ABBCA6A0BFBE783CB0),
    .INIT_0A(256'h000F690B8D56A6570049BCA3071E852D4925AA4B6958976CA91A8DAF9B281927),
    .INIT_0B(256'h00B0A2AD999AA49A502C3C6160360F670E5F388A7A5A6201749B8E606C5AAC59),
    .INIT_0C(256'h005EAEB4A53632B9AE46597BB438A669CBA626C190912D03A89D7E955B245A3F),
    .INIT_0D(256'h00CB63AAAB2C10701ACDC86B5345B83E0D10542BA984466B50B52504936399C4),
    .INIT_0E(256'h009426726B099F1536BF1526B100A9CB5C9D1E897378A55E28A34AC29B92A2B2),
    .INIT_0F(256'h006C1B4A5F8594906A268E5D7B14731BB41840484D37034256394A189C37C257),
    .INIT_10(256'h0059C3A57E0F8BC7617C410C2E77117E81950E4740CEC52DCC24910B002AAFBB),
    .INIT_11(256'h003524A1C231CF762A2AACA0B83A7A9A1A47ADCA8B1A044928C6BDB0827C611C),
    .INIT_12(256'h00205B8C69C8253DB81A6AB26D41CC4AA5C8215ECEAF326F5672525D2E0A5C7A),
    .INIT_13(256'h006E56A9644783A2469155597AB609B9211E6D0F06618F44AE47683444ADAAAE),
    .INIT_14(256'h00369C5DC7CA74CD91BB0DBE3141534404AF51A03820C19EAD4467BE0B67AE24),
    .INIT_15(256'h0060BC87940741835C30A887850A43C7C4923F1E26147A93718A3A3592A6650A),
    .INIT_16(256'h00630B6AB36A7016598232C5492E061B94B7589BAE9154084B565F0CB77C84B0),
    .INIT_17(256'h0075CF5F925FA87D92AEAD20798F247D01BA951B2E70A34F6C9D318B452B9682),
    .INIT_18(256'h009702B05F0975354B666751334F1E03CB4BAC7CAE0193B0760E3C3B5B93AD85),
    .INIT_19(256'h0044245DC50218674DC169B588B3917589BD647865A158783BC16D1ECF1CBE0E),
    .INIT_1A(256'h000350532106806A2C5BB650B47EBC8D997A7365A28D8CB2262B707D02C77D4C),
    .INIT_1B(256'h0057AD398DBCA09B4B0955C653B8C7C7838658711134CAC106A750A17C1B21A8),
    .INIT_1C(256'h004216247ABD8D7694B367547546574D1405136F9C6DAE2B4C93008DC6B96B3C),
    .INIT_1D(256'h00919B6F0684AD3D9531686EB5AF983695BE3A5851564C4DBA2628161E98301B),
    .INIT_1E(256'h00BB80CDBB5AC848B01601548FA7B32D7A2D1F46BFC2BA83195C1E232CA55A1C),
    .INIT_1F(256'h00C41F35089251BCAA8B3528C3396A4931B462CD1C55551670A075256435918A),
    .INIT_20(256'h005DA1191623965E02A078A8AB6F0C947E56C9542E304280408F705DA115D0AC),
    .INIT_21(256'h00C88B5B2D66414C908E3C8C6FC3810B24A40DA242A00E1F1FBA4F20A1A20096),
    .INIT_22(256'h0028A68CC9050C006DCB19BE072467BBBC83A390082860767137396DC9B81E5F),
    .INIT_23(256'h0082C2771502C8CE6543CA36097969929FB186BD27554F685B2952CA120B4A82),
    .INIT_24(256'h00177D6B34C700906E30A4C1B3A15CBA392AB7378953B1BDB13FA89A88ACAFB8),
    .INIT_25(256'h000828583125CE9F4B3F78AC138C450F23103088029D5D37164428A53B3B6263),
    .INIT_26(256'h004532963F17729107CE35469C4FCE9C2F9EB4812E9702C48C1F0A80084F4176),
    .INIT_27(256'h00CE063712585498B98634CEB24D109A9D36527124C3C8476371B713B625CA7C),
    .INIT_28(256'h00C2BE745F96781FB70DAA6858C90C91980F904B32760ACAC422484ECB60B964),
    .INIT_29(256'h00910E431D18362F7E0C718127124552C7A095113786384029865BB3576D45BD),
    .INIT_2A(256'h00666AAF7829AD408677A21CB269CF86115BAF66270B639554429D9C99B66F36),
    .INIT_2B(256'h006D2309325335010D944A155AC0890D7060136C3927755C50096F33794C762D),
    .INIT_2C(256'h0047662A2E4D302185B45452A32D672A4EAACE9F3E57038C320C517440653C71),
    .INIT_2D(256'h006C7D4FA4978C6B023BA27CA8536BC25472A4111489095938AA21426C3EBD4A),
    .INIT_2E(256'h005B5D618430814EC8BA722BCF89BA28322C825CBD04712181710E18592DACC3),
    .INIT_2F(256'h007486701D3F3FA49E407275005CC146395ACC8A98504C79490EA5331748781B),
    .INIT_30(256'h0051104DC01C116E720B47A13C89517D48C20A19A60AC633AB0F4935A5A83776),
    .INIT_31(256'h00AB4FAB2F01B753A5C5258B9534AAB51F2A05C0CCB187C56C1222027E6E923C),
    .INIT_32(256'h006E43A793CC927F80654088AFA02E500768BE01500C0B79B39772B8A454559F),
    .INIT_33(256'h0040056BBA6FB989506F7777C5C61050B9634BCC6E967E338826488B1E469F61),
    .INIT_34(256'h00335D5E05B9480414303B9E831C8B645C772F14530ECC6A06689ECD685F6B7A),
    .INIT_35(256'h003449B7C08EC61392279C95C529CD0C6E2541A961A33C69CC679B21656A6CA4),
    .INIT_36(256'h0096C51C15C3B9449158C6C01FC9B5AC18BF5C733E9D1A8400B09F1852601F50),
    .INIT_37(256'h00226F797080443DB696AF0B8A14521D863A316C142C1812324F2587A4BE715A),
    .INIT_38(256'h00CD4E174F5AA9176A69629C0F6DA8048F20538A814B1F73399303CF8223B68F),
    .INIT_39(256'h0008724E1B91A012616623991C5B09C31265A66A031B71942AB4B1431A67C126),
    .INIT_3A(256'h006E48AE07486519A36D80CA79138FCD985C9A61423A97B3A4775BCE559C2CCC),
    .INIT_3B(256'h0022296313B270844384207CAB95082B9E8A5E4807057674837FA706B5A81309),
    .INIT_3C(256'h0067AB08954233131C31B22A89B6B6BBC33783339DBFA414562043A351645934),
    .INIT_3D(256'h00446EA09809921C7B672E900437193C113B7F36796C81151A0006B28D72B4C8),
    .INIT_3E(256'h00337D14BD67B71F936A7B816E28A2209AB038233315178E7378425A2A915114),
    .INIT_3F(256'h00B1C9923DBA087244042C0D5578899E875E029EA78FBA4B465A6985513E5491),
    .INIT_40(256'h00BB16B98E1A86CD0E86272F9ACB3BC54C063A540F8E1302406CC123BA2B1573),
    .INIT_41(256'h00444B4269224C0641995A607D251DAC32BC2D8C92C6B0C20D80474341CF6646),
    .INIT_42(256'h0001438762C314100AB6067DABB5226C4C2947C8412C5F5F8F1D6244470023B9),
    .INIT_43(256'h005304BB0F260177C14D99176E669095BA4911187A509282A6AC79BD8A5A4D7A),
    .INIT_44(256'h00A7963F08B8CB61CABFA21C9B6B153D73C29876311E69427D27BF382310B7B8),
    .INIT_45(256'h00A7739CB501117A904EA47B44448EAC8087A5CD2B749873BF5830C8646D8845),
    .INIT_46(256'h0079399470CA3E10BD9A643904012D693292C9083847A643CE7850B2B3575918),
    .INIT_47(256'h009722BD47861416CA9F01341DCC358E397DB58C2507AE045E1EB0191DC59301),
    .INIT_48(256'h0012A5383A2E298DC39ECA7718322F37A326856DABB9065A85873B826FC0A6CB),
    .INIT_49(256'h009A8D4F229A5D84275E6838BD2413292F1111989320BDAD670A1CC2508A5EA8),
    .INIT_4A(256'h002CC9574AA28FAA2584B377380026B5422034A7C4A8C07BC442793679CF9914),
    .INIT_4B(256'h006E6F997C68C1C2974555756DCEC234416F6375235A1F2DC637352B837FA363),
    .INIT_4C(256'h00691B98299F04291C0E3F3EA2CC2782523A74AB759043211B7E999D16938976),
    .INIT_4D(256'h0064808A179264BF7B2D264B89647F1A5ECB3DBB360B049726248EC05FB58507),
    .INIT_4E(256'h00A91E4C26057308B146A4572A71A72C854D343DCB1D3CA95E65C676BA991074),
    .INIT_4F(256'h004954BB90B41BB78F8782CFCC8D799685B745980D8363B5852A4A3B8765A941),
    .INIT_50(256'h00C38258BEBE4E3BC2888F0146A303AB3FC4CF2920149C0C2A519B450898538E),
    .INIT_51(256'h003017A055357C88220544B5CB25A709A61F4D531EB39A632E0D9F5159A59323),
    .INIT_52(256'h001D628E03852A4FAF7101209E607F5D7E11A1C573C4AF75386607AB7B17B561),
    .INIT_53(256'h00CA5619C616AEB160C0C96E408B2116679B032225219D792688894C2D303E7A),
    .INIT_54(256'h0011718E7C8BCC207E9497AFB331228C5811C47C21AB99C97208025B033E55C2),
    .INIT_55(256'h00484A0F8C080C3D90B13ABB56025E45958E3D292CC56F13683BC86A4C739F9B),
    .INIT_56(256'h000A86A10CB43B18773421B07BC7247970C35C534BB66CC46530655F6F764D9D),
    .INIT_57(256'h00AF5640AB8BCE153AB4A15FBC80644A9E448BBB394EBD00703D4827525E2222),
    .INIT_58(256'h007E9C81B1CCB884236D21CF3C2859C1AF94743C844A38961F70C74D9A844068),
    .INIT_59(256'h001A471C3E5A466E6B57362F77580C0E622900B3115E8BAB1B0BCDB869820EC7),
    .INIT_5A(256'h00871B5113423655626B2D56431DA93760536E0952841D7F7D74C94F65A47419),
    .INIT_5B(256'h00096C17085F4C4978AFBF9B3A0EC928452F54C8AE27794D9742C92F3484C67A),
    .INIT_5C(256'h007B5A3A7882BCCABC60A5622119833CCF4C0A1610938DB9AF55127F593B1C68),
    .INIT_5D(256'h00611A20C6993A5495777ECB838393A9A7B999379F4E3E3460C94B225D3A9E67),
    .INIT_5E(256'h007B41291D1855A3668A100DA74CB635B1ACA39C76B4414F02147607877EB9CE),
    .INIT_5F(256'h00A73D9765865D1B6DA3B37B7A47602F71AA6B9A40450B899AC73D7E13253E9A),
    .INIT_60(256'h00B92561C34951794A7BA19F044F8F835F722EC00023CD2EB6B9AC3971BA2F57),
    .INIT_61(256'h00438D0C4EC4C92BC2758D2FC1B2B01513AF2E2D0A3907C274A2698F833F8993),
    .INIT_62(256'h0012C86D681513C52C3F52A76F59639896880617B170A729B207CAC3CF6204CE),
    .INIT_63(256'h00CBC656A93E301E8212A861806774157D05B8C4854D4D0D5856CD07016A8C05),
    .INIT_64(256'h000E912E730596A5182D467C64121E900D35489E2017B852649C97CF3F199F2B),
    .INIT_65(256'h0023BD1A8AC055BF9F4754327341B98BA72A94945B6CC7A7779EAA6B30858A57),
    .INIT_66(256'h008A33800533A0121B4EA1CCCD0B66B0C550C7818E298A9D3990B85D78C80156),
    .INIT_67(256'h00AD1D82BFBB3299305EAB0C03886C9618BC19AA0553CBCA991F777B373D499B),
    .INIT_68(256'h00679806C43E42C03F059D59C5A00BADA981046F176B0D4A5B704D57B0190425),
    .INIT_69(256'h004EA8AE8A7D08A93ABE9749978FA64974BE78628A123EC1C5B2B77FA051C336),
    .INIT_6A(256'h00071E662D49BE754B69A8976C3A7B8D33332819609969652056A6220049582E),
    .INIT_6B(256'h00BA360F460E5F6FBC7A96A801747FC6609C56AC59A2A2ADC69DA49ACE2C3C85),
    .INIT_6C(256'h007D2CA669A5A62601319178CCA89DC37E5B906A3F5E88B4A5A182B9AE4A597B),
    .INIT_6D(256'h0053287C3E0D7B542BBEBB46C676B525AE8E639112CB6352AB2C38431ACD946B),
    .INIT_6E(256'h00B10046165C9DA3897312CB5EAF4E4AC2B792A2230C26726E099F4E81BF155D),
    .INIT_6F(256'h005A14730F891875034D377F835686C1189CB9C257B45B4A5FB294902B318E5D),
    .INIT_70(256'h002E93117E52870EC5B6CEC5099C24C086002A27BB597EC07E0FB3C7615DC40C),
    .INIT_71(256'h00B83A9B9A1AB1A6CA0F0304490A63BDADCD7C613D3524802431CF182A2A0BAA),
    .INIT_72(256'h0047412FA1A5C86811CE7FC36F561C525D172B5C7A305B8C283C253D501A6A90),
    .INIT_73(256'h00580A09BF7F1E6D8403613A51AE47A93444B189AE6E8FA9641561A2467F5559),
    .INIT_74(256'h00314CB3446B7351A0BB7CC103654467310B677164369C72C7CA168791BBA0BE),
    .INIT_75(256'h00850AA602C462AA1E266E7A9366033A35AEA665632BBC8718074109BC30A833),
    .INIT_76(256'h000F2E061A24B71074AE9132084BCF1F0CB77D84B07F396AB3BA70168B3E3209),
    .INIT_77(256'h00C445247DB24A959E6370A3B76C9D80AA452B118275AD60925F4F7D92193920),
    .INIT_78(256'h0033C06203CB40AF7C454E93B05C0E3CCC0093AD19970281B80975274B66666D),
    .INIT_79(256'h0036B374C689BD6A7865CDB4783BA56D1E8CB5BE0EA9245D81B4182FBDC169AC),
    .INIT_7A(256'h000556BC40027A7335A28D9538262B587D027A334C03625321C8876AB62CB650),
    .INIT_7B(256'h0053243AC7A43158718734CA595BA750287C1B27BC57ADA68DBC1D5F4B8C4BC6),
    .INIT_7C(256'h007546194D140C986F9C32AE2BBB79008D2CB96B779B1624C7BD8D9CBCB39E1D),
    .INIT_7D(256'h003FAF98B695BE94515156634DBAB5CF161E42301B078B6F2F37AD3DB35468A2),
    .INIT_7E(256'h004E61B32DB02D1F97ACC2BAB8195C578D2CA53E1CBB9C52BB136848B03C6654),
    .INIT_7F(256'h00C37B5749314862CD3129551684A075664A35917CC41F063D9215C7AA8BCBA3),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb[11:0],1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_0 }),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_1 }),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_75 }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(ena_array),
        .ENBWREN(enb_array),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b1),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
  LUT1 #(
    .INIT(2'h1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_i_1 
       (.I0(addra[12]),
        .O(ena_array));
  LUT1 #(
    .INIT(2'h1)) 
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_i_2 
       (.I0(addrb[12]),
        .O(enb_array));
endmodule

(* ORIG_REF_NAME = "blk_mem_gen_prim_wrapper_init" *) 
module reconstruct_rom_blk_mem_gen_prim_wrapper_init__parameterized1
   (DOADO,
    DOBDO,
    clka,
    clkb,
    addra,
    addrb);
  output [7:0]DOADO;
  output [7:0]DOBDO;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_71 ;
  wire \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_75 ;
  wire [7:0]DOADO;
  wire [7:0]DOBDO;
  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ;
  wire \NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED ;
  wire [31:8]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED ;
  wire [3:1]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED ;
  wire [7:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED ;
  wire [8:0]\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED ;

  (* box_type = "PRIMITIVE" *) 
  RAMB36E1 #(
    .DOA_REG(1),
    .DOB_REG(1),
    .EN_ECC_READ("FALSE"),
    .EN_ECC_WRITE("FALSE"),
    .INITP_00(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_01(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_02(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_03(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_04(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_05(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_06(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_07(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_08(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_09(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INITP_0F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_00(256'h00A0350C940A56C9957B3042BC408F640FA115A4AC5D14B91641B65E02C14AA8),
    .INIT_01(256'h006F52AA0B249D0DA2433D0E1F0DBA4F888CA20069C88B848D66AD83908E368C),
    .INIT_02(256'h0007241AADBC83A690088EA3767140396D8B881EAC16A68C486D0CBBBFCB19C9),
    .INIT_03(256'h00B879693F3BB186BE27557F3D5B2923CA12457582557C7715C0A9CE580ECA36),
    .INIT_04(256'h00B3345CBA925CB7375953B1668D3FA81088ACBF1917283934C717056E0510C1),
    .INIT_05(256'h00138C8B0F234F488802A55D375C10289F073B62478A285C3425CEBE4B3F812B),
    .INIT_06(256'h00964FCEA22F9E3D062E9788C48C0257801D1C4176B756963B5F7291BFCE356B),
    .INIT_07(256'h009BB2109A4136521A43C3C8216371B11FB6B20A7CCE38AD12884998B90534CE),
    .INIT_08(256'h0058B79D91982C904B62240ACA752248944D600F2AC2BE2B5F96A1A6B70D3168),
    .INIT_09(256'h002712ABBCC7A0BF11373CB04022685BB30D7F4572270E43801836724B0C7167),
    .INIT_0A(256'h005869CFA91A5BAF9B270B270F540B8D9C99570036BCA3AF7885AD4025AAA21C),
    .INIT_0B(256'h005A62890D9B8E136C5A2775B0A209999A794C502C6D6160325367010D388A15),
    .INIT_0C(256'h00A32D032A4E7E959F245A038CAEB4513632653C464766B4384D30CB85B4C190),
    .INIT_0D(256'h0084536B50547204931499C45938AAAB421070BD4AC87D4F45B88C6B103BA2A9),
    .INIT_0E(256'h0078A5BA28A32C829B9204B29481716B09591536C35B266184A9CB4EC81E722B),
    .INIT_0F(256'h0000034246394ACC8A37C24C6C1B0EA58517486A2674867B1D3F1BB49E404875),
    .INIT_10(256'h003C892DCC48910B19A6AFBB33C3A549358BA8377C41104D771C1181950B4740),
    .INIT_11(256'h001A34AA28C62AB082CCB11C356CA1C2027E76923CACA0AB2F7AB75347AD258B),
    .INIT_12(256'h00AF322E507252BE2E0A0C0B205B9769C8A454B89F6EB26D93CC4A7F80215E88),
    .INIT_13(256'h00C58F4450B96834CCADAA7E335626484783469F9140057AB66FB921506F0F06),
    .INIT_14(256'h00201C9EAD5C77BE0B53AE246A065D9ECD74CD6B7A0D5D5E41534804AF303B38),
    .INIT_15(256'h00147ACD718A254192A6A30A60CC67942165835CA43487B7C043C713923F9C95),
    .INIT_16(256'h001F5408AC565F5C737C9D1A630BB09F6A5260598296C54915C31B9491589BC0),
    .INIT_17(256'h008A144F6C86318B6C14961812CF5F2587A8BE71AEAD6F798F804401BA961B2E),
    .INIT_18(256'h00016DA8760E203B5B814B857339B05FCF8235B68F6751174F1EA9174BAC62AE),
    .INIT_19(256'h00A15809C3C16DA6CF1C1B71442AB4C5021A674D2608B5881B91751261647899),
    .INIT_1A(256'h00798CB2CD98709A61C77D97B350775B06809C2C5B6E48B47E488D99A36D65A2),
    .INIT_1B(256'h003495C1069E8AA1480721A8748339A706A09B1309552963B8C7708386842011),
    .INIT_1C(256'h006DAEB64C933783C69DBF3C4256207AA35176943467540895574D130513B22A),
    .INIT_1D(256'h00044C193C26287F36986C81919B0006848D729531446EB5980936957B3A5890),
    .INIT_1E(256'h006E2883209A1E2323335A178E80CD425AC8915116017D8FA767B77A2D6A46BF),
    .INIT_1F(256'h0055788970875E2564A78F8A4B4635088551BC5491352892396A0872B4622C1C),
    .INIT_20(256'h009ACB80C54C705D540FD01302A119C123962B15A07816AB6F1A867E5686542E),
    .INIT_21(256'h00A0251D1F32BC20A192C696C20D5B2D43414C66463C8C42C3814C06A40D5A42),
    .INIT_22(256'h002860226C372947C9B82C5F288F1DC90547006DB901BE076267BB100AA3067D),
    .INIT_23(256'h006E4F6895BA5211180B4A9282C2AC7902C85A65435304097926929FC14DBD17),
    .INIT_24(256'h009B6BBDB173C29A7631AFB8427D6BBF380090B730A4963FA15CCB392ABFA289),
    .INIT_25(256'h009D448E164487A53B2B746308BF5831C8649F4B4578AC9CB5450F7A1030A47B),
    .INIT_26(256'h0004022D691F0AC9084F47A64532783F17B35707CE79469C70CA9C10BDB48139),
    .INIT_27(256'h001DCC478E39B7138C25CAAE040637B05854C593863422B24D86149DCA9F7124),
    .INIT_28(256'h0076322FC4A3264ECBABB9645A85745F82781FA6CBAA6838C90C298D0F9ECA32),
    .INIT_29(256'h0086381329861111576D20BD91670A1D18502F7EA89A814F2245528427956838),
    .INIT_2A(256'h00386395B5429D34A7B66FC0666A427929ADCF86772CC9B24AA2861125846677),
    .INIT_2B(256'h006DCE5C50416F337523762D2D2309352B3501A3944A6F99C068C17060455539),
    .INIT_2C(256'h0057CC27320C3A7440759071471B2A2E9D1621857654529829670429AACE3F3E),
    .INIT_2D(256'h0089097F1AAA213D6C3E0B046C7D24A4975FB50207647CA81792C2BF7BA4114B),
    .INIT_2E(256'h002A71212C850E183D2DAC3CA95D61C630819910BAA91ECF89057332B1465CBD),
    .INIT_2F(256'h00508D794985B733170D781BB585701D3B3FA4A9417254BB5CC11BB75A878298),
    .INIT_30(256'h000AC603AB0FC4CFA5A81476512A51C045086E728EC3A158BE517D3BC20A8F01),
    .INIT_31(256'h00CB87C50912224D536E929AAB4F0D9F0159A5A5C53017955535B51F2205C0B5),
    .INIT_32(256'h009E6079B37E72B8C573559F7543A707AB9217B56540628EA0852A0768710150),
    .INIT_33(256'h00968B2188269B8B1E25216140266BBA4C2D893E7A777719C610AEB1634BC96E),
    .INIT_34(256'h000ECC228C689EC4685FAB9933720805B9033E14C2119E837C8B64207E2F14AF),
    .INIT_35(256'h00563C6945959B21296A6C6F13493BC88EC6739F27484AC529080C6E90B1A961),
    .INIT_36(256'h009DC7840070C318524B1F50C4651C655FB9444D9DC686A1C9B53B18BF34213E),
    .INIT_37(256'h002C1864324F448BA4394E5A22703D7027523DB622AF0B40AB521D153A31A15F),
    .INIT_38(256'h003C1F73C19303743C234A38CD4E70C75A9A846A697E9C0FB1CC048F23538ACF),
    .INIT_39(256'h007758942A62B143B311C18BAB724ECDB8A0820E6623471C5B5A461265576A03),
    .INIT_3A(256'h003A1DA9A47753CE555284CC7F7DAE074F6519741980CA51138F36555C9A2D42),
    .INIT_3B(256'h000576C9287F2F54B5A8277922974213B23484437A097CAB08082B49785E489B),
    .INIT_3C(256'h0021A4143CCF430A1664598DB9AB551242333B1C317B5A89B682BBC3BC60339D),
    .INIT_3D(256'h006C83151AA7B9B2379FB4C83460A04B22921C9E672E1A2037193A113B777E79),
    .INIT_3E(256'h00154CB67378ACA32A76B414330214BD07871F93CE7B81291DA220A3B038100D),
    .INIT_3F(256'h007ABA602F5A696B9A3E450BB1C9C73DBA13254404A70D5565869E876D029E7B),
    .INIT_40(256'h008E4F8F406C722EBA002373BBB6B98E3971CD0E57272F61C33BC579063AA19F),
    .INIT_41(256'h00C1B0B01580472E2DCF3907444BA26922833F419943607D4EC4AC32C22D8C2F),
    .INIT_42(256'h006F595F9896624417B123A7294387CAC3146204B606C8ABB515134C293FC841),
    .INIT_43(256'h00506774A67D05BD8A854D7A0D58BB0F0701778C059917566690301E4912A87A),
    .INIT_44(256'h001E691E90273548231017B8A7649C08B83F61CA2B0E1C9B73153DA51898467C),
    .INIT_45(256'h007398738BA73094946D88C7A7739EAA011185904E23BD4444C0AC809F47CD32),
    .INIT_46(256'h00CD0B43CEC550B2818E59189D3994B85D3E10019A643380012DA032924EA138),
    .INIT_47(256'h0007886C5E1EBC191D0553019799BD477B3716CA9B013482BF3532997DB5AB0C),
    .INIT_48(256'h00C5060BAD873B046FC06B0D12A5703A2EB019C39E677718C43E37C03F856D59),
    .INIT_49(256'h00978FAD49741CC2628A5E3EC18D4FB79A5D51C35E68A8BD247D082F3ABE9893),
    .INIT_4A(256'h00A83A7BC4333336796099146520574A228FAA582EB31E660026BE752069A8C4),
    .INIT_4B(256'h005A1F7FC6379C56837FA2636EC69D7C68CEC29785BA750F46C2346FBC6396A8),
    .INIT_4C(256'h00CC4321C37E99906A938988691BA1829F044A1C0E7D2CA269A582520131AB78),
    .INIT_4D(256'h00C6769726AE8EC09112850752808A384364BF942D26287C640D7B5ECBBEBB36),
    .INIT_4E(256'h001DAF4E5E65B776BA230C74A96E4C264E8108155DA4574616A79DA34D3412CB),
    .INIT_4F(256'h00836386C12A4AB98765B45B4954B290B42B318F5D5ACFCC0F8996750345987F),
    .INIT_50(256'h00099C0CC0869B452798537EC08258B3BE4E5DC4882E9346A352873FC5B62920),
    .INIT_51(256'h00B30A632EADCD51593D93238024A0CF187C880BAA443A9B25A7B1A61F0F031E),
    .INIT_52(256'h00C4AF1C3866172B7B1730611D283C033D504FAF9047202FA17F5D6811A17FC3),
    .INIT_53(256'h00519D79A98889B189303E8FCA56156116467F60C0580A40BF7F16678403223A),
    .INIT_54(256'h000365C97231025B716455C272718E1687CCBBA094974CB3316B735811BB7C21),
    .INIT_55(256'h00C56603683BAE6A4C632B9B87180F8C09BC3DA8333ABBA6025E62AA8E3D6E2C),
    .INIT_56(256'h00B66CCF1F30657D6F767F390AB3BA0CB48B3E77090FB07B1A247910745C5332),
    .INIT_57(256'h00B7BD0080AA4827115E22AD60565F4F8BCE1939B4C445BC80B24A9E9E63BB39),
    .INIT_58(256'h004A5C961FCC004DAD19406881B8817527B884666D21C062285940AF94454E84),
    .INIT_59(256'h005E8BA51B0B8CB5690EA9C71A81B43E2FBD6E6BAC362F74C60C0E6A2900CDB4),
    .INIT_5A(256'h00381D7F5874C97A33A40362871BC88742B62C626B05564340023760356E0995),
    .INIT_5B(256'h00595B4D9728C92F27BCC6ADA66C171D5F4C8C4BAFBF243A0EA431452F87C8AE),
    .INIT_5C(256'h0093BB79AF8D2C7F59779B6824C73A789CBCCA9E1DA5621919830C984C0A3210),
    .INIT_5D(256'h004E3EB5CFC91E425D3A078B612F37C699B35495A23FCB83B693A99451993763),
    .INIT_5E(256'h00B8414F578D76A53E7EB99C5241136818553C668A4E61A74CB035B197AC9C76),
    .INIT_5F(256'h001684899A664A7E917C3E9A063D9715C75D1BCBA3B37B5747604871AA312940),
    .INIT_60(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_61(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_62(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_63(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_64(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_65(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_66(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_67(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_68(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_69(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_6F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_70(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_71(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_72(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_73(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_74(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_75(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_76(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_77(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_78(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_79(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7A(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7B(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7C(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7D(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7E(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_7F(256'h0000000000000000000000000000000000000000000000000000000000000000),
    .INIT_A(36'h000000000),
    .INIT_B(36'h000000000),
    .INIT_FILE("NONE"),
    .IS_CLKARDCLK_INVERTED(1'b0),
    .IS_CLKBWRCLK_INVERTED(1'b0),
    .IS_ENARDEN_INVERTED(1'b0),
    .IS_ENBWREN_INVERTED(1'b0),
    .IS_RSTRAMARSTRAM_INVERTED(1'b0),
    .IS_RSTRAMB_INVERTED(1'b0),
    .IS_RSTREGARSTREG_INVERTED(1'b0),
    .IS_RSTREGB_INVERTED(1'b0),
    .RAM_EXTENSION_A("NONE"),
    .RAM_EXTENSION_B("NONE"),
    .RAM_MODE("TDP"),
    .RDADDR_COLLISION_HWCONFIG("DELAYED_WRITE"),
    .READ_WIDTH_A(9),
    .READ_WIDTH_B(9),
    .RSTREG_PRIORITY_A("REGCE"),
    .RSTREG_PRIORITY_B("REGCE"),
    .SIM_COLLISION_CHECK("ALL"),
    .SIM_DEVICE("7SERIES"),
    .SRVAL_A(36'h000000000),
    .SRVAL_B(36'h000000000),
    .WRITE_MODE_A("WRITE_FIRST"),
    .WRITE_MODE_B("WRITE_FIRST"),
    .WRITE_WIDTH_A(9),
    .WRITE_WIDTH_B(9)) 
    \DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram 
       (.ADDRARDADDR({1'b1,addra[11:0],1'b1,1'b1,1'b1}),
        .ADDRBWRADDR({1'b1,addrb[11:0],1'b1,1'b1,1'b1}),
        .CASCADEINA(1'b0),
        .CASCADEINB(1'b0),
        .CASCADEOUTA(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTA_UNCONNECTED ),
        .CASCADEOUTB(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_CASCADEOUTB_UNCONNECTED ),
        .CLKARDCLK(clka),
        .CLKBWRCLK(clkb),
        .DBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DBITERR_UNCONNECTED ),
        .DIADI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIBDI({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .DIPADIP({1'b0,1'b0,1'b0,1'b0}),
        .DIPBDIP({1'b0,1'b0,1'b0,1'b0}),
        .DOADO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOADO_UNCONNECTED [31:8],DOADO}),
        .DOBDO({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOBDO_UNCONNECTED [31:8],DOBDO}),
        .DOPADOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPADOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_71 }),
        .DOPBDOP({\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_DOPBDOP_UNCONNECTED [3:1],\DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_n_75 }),
        .ECCPARITY(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_ECCPARITY_UNCONNECTED [7:0]),
        .ENARDEN(addra[12]),
        .ENBWREN(addrb[12]),
        .INJECTDBITERR(1'b0),
        .INJECTSBITERR(1'b0),
        .RDADDRECC(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_RDADDRECC_UNCONNECTED [8:0]),
        .REGCEAREGCE(1'b1),
        .REGCEB(1'b1),
        .RSTRAMARSTRAM(1'b0),
        .RSTRAMB(1'b0),
        .RSTREGARSTREG(1'b0),
        .RSTREGB(1'b0),
        .SBITERR(\NLW_DEVICE_7SERIES.NO_BMM_INFO.TRUE_DP.SIMPLE_PRIM36.ram_SBITERR_UNCONNECTED ),
        .WEA({1'b0,1'b0,1'b0,1'b0}),
        .WEBWE({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}));
endmodule

module reconstruct_rom_blk_mem_gen_top
   (douta,
    doutb,
    clka,
    clkb,
    addra,
    addrb);
  output [11:0]douta;
  output [11:0]doutb;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [11:0]douta;
  wire [11:0]doutb;

  reconstruct_rom_blk_mem_gen_generic_cstr \valid.cstr 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .douta(douta),
        .doutb(doutb));
endmodule

(* C_ADDRA_WIDTH = "13" *) (* C_ADDRB_WIDTH = "13" *) (* C_ALGORITHM = "1" *) 
(* C_AXI_ID_WIDTH = "4" *) (* C_AXI_SLAVE_TYPE = "0" *) (* C_AXI_TYPE = "1" *) 
(* C_BYTE_SIZE = "9" *) (* C_COMMON_CLK = "0" *) (* C_COUNT_18K_BRAM = "0" *) 
(* C_COUNT_36K_BRAM = "3" *) (* C_CTRL_ECC_ALGO = "NONE" *) (* C_DEFAULT_DATA = "0" *) 
(* C_DISABLE_WARN_BHV_COLL = "0" *) (* C_DISABLE_WARN_BHV_RANGE = "0" *) (* C_ELABORATION_DIR = "./" *) 
(* C_ENABLE_32BIT_ADDRESS = "0" *) (* C_EN_DEEPSLEEP_PIN = "0" *) (* C_EN_ECC_PIPE = "0" *) 
(* C_EN_RDADDRA_CHG = "0" *) (* C_EN_RDADDRB_CHG = "0" *) (* C_EN_SAFETY_CKT = "0" *) 
(* C_EN_SHUTDOWN_PIN = "0" *) (* C_EN_SLEEP_PIN = "0" *) (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     8.791205 mW" *) 
(* C_FAMILY = "zynq" *) (* C_HAS_AXI_ID = "0" *) (* C_HAS_ENA = "0" *) 
(* C_HAS_ENB = "0" *) (* C_HAS_INJECTERR = "0" *) (* C_HAS_MEM_OUTPUT_REGS_A = "1" *) 
(* C_HAS_MEM_OUTPUT_REGS_B = "1" *) (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
(* C_HAS_REGCEA = "0" *) (* C_HAS_REGCEB = "0" *) (* C_HAS_RSTA = "0" *) 
(* C_HAS_RSTB = "0" *) (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
(* C_INITA_VAL = "0" *) (* C_INITB_VAL = "0" *) (* C_INIT_FILE = "reconstruct_rom.mem" *) 
(* C_INIT_FILE_NAME = "reconstruct_rom.mif" *) (* C_INTERFACE_TYPE = "0" *) (* C_LOAD_INIT_FILE = "1" *) 
(* C_MEM_TYPE = "4" *) (* C_MUX_PIPELINE_STAGES = "0" *) (* C_PRIM_TYPE = "1" *) 
(* C_READ_DEPTH_A = "7168" *) (* C_READ_DEPTH_B = "7168" *) (* C_READ_LATENCY_A = "1" *) 
(* C_READ_LATENCY_B = "1" *) (* C_READ_WIDTH_A = "12" *) (* C_READ_WIDTH_B = "12" *) 
(* C_RSTRAM_A = "0" *) (* C_RSTRAM_B = "0" *) (* C_RST_PRIORITY_A = "CE" *) 
(* C_RST_PRIORITY_B = "CE" *) (* C_SIM_COLLISION_CHECK = "ALL" *) (* C_USE_BRAM_BLOCK = "0" *) 
(* C_USE_BYTE_WEA = "0" *) (* C_USE_BYTE_WEB = "0" *) (* C_USE_DEFAULT_DATA = "0" *) 
(* C_USE_ECC = "0" *) (* C_USE_SOFTECC = "0" *) (* C_USE_URAM = "0" *) 
(* C_WEA_WIDTH = "1" *) (* C_WEB_WIDTH = "1" *) (* C_WRITE_DEPTH_A = "7168" *) 
(* C_WRITE_DEPTH_B = "7168" *) (* C_WRITE_MODE_A = "WRITE_FIRST" *) (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
(* C_WRITE_WIDTH_A = "12" *) (* C_WRITE_WIDTH_B = "12" *) (* C_XDEVICEFAMILY = "zynq" *) 
(* downgradeipidentifiedwarnings = "yes" *) 
module reconstruct_rom_blk_mem_gen_v8_4_2
   (clka,
    rsta,
    ena,
    regcea,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    regceb,
    web,
    addrb,
    dinb,
    doutb,
    injectsbiterr,
    injectdbiterr,
    eccpipece,
    sbiterr,
    dbiterr,
    rdaddrecc,
    sleep,
    deepsleep,
    shutdown,
    rsta_busy,
    rstb_busy,
    s_aclk,
    s_aresetn,
    s_axi_awid,
    s_axi_awaddr,
    s_axi_awlen,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awvalid,
    s_axi_awready,
    s_axi_wdata,
    s_axi_wstrb,
    s_axi_wlast,
    s_axi_wvalid,
    s_axi_wready,
    s_axi_bid,
    s_axi_bresp,
    s_axi_bvalid,
    s_axi_bready,
    s_axi_arid,
    s_axi_araddr,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_arvalid,
    s_axi_arready,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    s_axi_rlast,
    s_axi_rvalid,
    s_axi_rready,
    s_axi_injectsbiterr,
    s_axi_injectdbiterr,
    s_axi_sbiterr,
    s_axi_dbiterr,
    s_axi_rdaddrecc);
  input clka;
  input rsta;
  input ena;
  input regcea;
  input [0:0]wea;
  input [12:0]addra;
  input [11:0]dina;
  output [11:0]douta;
  input clkb;
  input rstb;
  input enb;
  input regceb;
  input [0:0]web;
  input [12:0]addrb;
  input [11:0]dinb;
  output [11:0]doutb;
  input injectsbiterr;
  input injectdbiterr;
  input eccpipece;
  output sbiterr;
  output dbiterr;
  output [12:0]rdaddrecc;
  input sleep;
  input deepsleep;
  input shutdown;
  output rsta_busy;
  output rstb_busy;
  input s_aclk;
  input s_aresetn;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [11:0]s_axi_wdata;
  input [0:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [11:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input s_axi_injectsbiterr;
  input s_axi_injectdbiterr;
  output s_axi_sbiterr;
  output s_axi_dbiterr;
  output [12:0]s_axi_rdaddrecc;

  wire \<const0> ;
  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [11:0]douta;
  wire [11:0]doutb;

  assign dbiterr = \<const0> ;
  assign rdaddrecc[12] = \<const0> ;
  assign rdaddrecc[11] = \<const0> ;
  assign rdaddrecc[10] = \<const0> ;
  assign rdaddrecc[9] = \<const0> ;
  assign rdaddrecc[8] = \<const0> ;
  assign rdaddrecc[7] = \<const0> ;
  assign rdaddrecc[6] = \<const0> ;
  assign rdaddrecc[5] = \<const0> ;
  assign rdaddrecc[4] = \<const0> ;
  assign rdaddrecc[3] = \<const0> ;
  assign rdaddrecc[2] = \<const0> ;
  assign rdaddrecc[1] = \<const0> ;
  assign rdaddrecc[0] = \<const0> ;
  assign rsta_busy = \<const0> ;
  assign rstb_busy = \<const0> ;
  assign s_axi_arready = \<const0> ;
  assign s_axi_awready = \<const0> ;
  assign s_axi_bid[3] = \<const0> ;
  assign s_axi_bid[2] = \<const0> ;
  assign s_axi_bid[1] = \<const0> ;
  assign s_axi_bid[0] = \<const0> ;
  assign s_axi_bresp[1] = \<const0> ;
  assign s_axi_bresp[0] = \<const0> ;
  assign s_axi_bvalid = \<const0> ;
  assign s_axi_dbiterr = \<const0> ;
  assign s_axi_rdaddrecc[12] = \<const0> ;
  assign s_axi_rdaddrecc[11] = \<const0> ;
  assign s_axi_rdaddrecc[10] = \<const0> ;
  assign s_axi_rdaddrecc[9] = \<const0> ;
  assign s_axi_rdaddrecc[8] = \<const0> ;
  assign s_axi_rdaddrecc[7] = \<const0> ;
  assign s_axi_rdaddrecc[6] = \<const0> ;
  assign s_axi_rdaddrecc[5] = \<const0> ;
  assign s_axi_rdaddrecc[4] = \<const0> ;
  assign s_axi_rdaddrecc[3] = \<const0> ;
  assign s_axi_rdaddrecc[2] = \<const0> ;
  assign s_axi_rdaddrecc[1] = \<const0> ;
  assign s_axi_rdaddrecc[0] = \<const0> ;
  assign s_axi_rdata[11] = \<const0> ;
  assign s_axi_rdata[10] = \<const0> ;
  assign s_axi_rdata[9] = \<const0> ;
  assign s_axi_rdata[8] = \<const0> ;
  assign s_axi_rdata[7] = \<const0> ;
  assign s_axi_rdata[6] = \<const0> ;
  assign s_axi_rdata[5] = \<const0> ;
  assign s_axi_rdata[4] = \<const0> ;
  assign s_axi_rdata[3] = \<const0> ;
  assign s_axi_rdata[2] = \<const0> ;
  assign s_axi_rdata[1] = \<const0> ;
  assign s_axi_rdata[0] = \<const0> ;
  assign s_axi_rid[3] = \<const0> ;
  assign s_axi_rid[2] = \<const0> ;
  assign s_axi_rid[1] = \<const0> ;
  assign s_axi_rid[0] = \<const0> ;
  assign s_axi_rlast = \<const0> ;
  assign s_axi_rresp[1] = \<const0> ;
  assign s_axi_rresp[0] = \<const0> ;
  assign s_axi_rvalid = \<const0> ;
  assign s_axi_sbiterr = \<const0> ;
  assign s_axi_wready = \<const0> ;
  assign sbiterr = \<const0> ;
  GND GND
       (.G(\<const0> ));
  reconstruct_rom_blk_mem_gen_v8_4_2_synth inst_blk_mem_gen
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .douta(douta),
        .doutb(doutb));
endmodule

module reconstruct_rom_blk_mem_gen_v8_4_2_synth
   (douta,
    doutb,
    clka,
    clkb,
    addra,
    addrb);
  output [11:0]douta;
  output [11:0]doutb;
  input clka;
  input clkb;
  input [12:0]addra;
  input [12:0]addrb;

  wire [12:0]addra;
  wire [12:0]addrb;
  wire clka;
  wire clkb;
  wire [11:0]douta;
  wire [11:0]doutb;

  reconstruct_rom_blk_mem_gen_top \gnbram.gnativebmg.native_blk_mem_gen 
       (.addra(addra),
        .addrb(addrb),
        .clka(clka),
        .clkb(clkb),
        .douta(douta),
        .doutb(doutb));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
