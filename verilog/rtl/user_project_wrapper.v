// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

    
    wire csb;
    wire [3:0] wmask;    
    wire [31:0] insMemDataM2P;
    wire [8:0] insMemAddrP2M;
        
    
SLRV SLRV_CORE (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    .wb_clk_i(wb_clk_i),
    .reset(la_data_in[0]),
    .la_data_in(la_data_in[2:1]),
    .insMemEn(la_data_in[3]),
    .insMemDataIn(insMemDataM2P),
    .insMemAddr(insMemAddrP2M),
    .gp(la_data_out[31:0]),
    .a7(la_data_out[63:32]),
    .pc_led(io_out[8]),
    .pc_led_oeb(io_oeb[8]),
    .csb(csb),
    .wmask(wmask)

);

sky130_sram_2kbyte_1rw1r_32x512_8 SLRV_IMEM (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    .clk0(wb_clk_i),
    .csb0(csb),
    .web0(la_data_in[3]),
    .wmask0(wmask),
    .addr0(la_data_in[12:4]),
    .din0(la_data_in[44:13]),
    
    .clk1(wb_clk_i),
    .csb1(csb),
    .addr1(insMemAddrP2M),
    .dout1(insMemDataM2P)
);

scoreboard_top scoreboard (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),
    
    .sb_la_data_out(la_data_out[122:112]),
    
    .sb_io_in (io_in[37:34]),
    .sb_io_out(io_out[33:23]),
    .sb_io_oeb(io_oeb[33:23])
);

s3chip s3chip (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),	// User area 1 1.8V power
    .vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i  (wb_clk_i),

    .la_data_in(la_data_in[58:45]),

    .io_out    (io_out[22:15]),
    .io_oeb    (io_out[22:15])
);

SLOPEDETECT SLOPEDETECT (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),  // User area 1 1.8V power
    .vssd1(vssd1),  // User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),

    .io_in (io_in[10:9]),
    .io_out(io_out[14:11]),
    .io_oeb(io_oeb[14:11])
);

macp_top macp_top (
`ifdef USE_POWER_PINS
    .vccd1(vccd1),  // User area 1 1.8V power
    .vssd1(vssd1),  // User area 1 digital ground
`endif

    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),

    // Logic Analyzer

    .la_data_in(la_data_in[79:64]),
    .la_data_out(la_data_out[111:96])
);

endmodule
`default_nettype wire
