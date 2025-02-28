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

`timescale 1 ns / 1 ps

module scoreboard_tb;
	reg clock;
	reg RSTB;
	reg CSB;
	reg power1, power2;
	reg power3, power4;
	
	reg team1_inc; // New input for team 1 increment
    	reg team2_inc; // New input for team 2 increment

	reg team1_dec; // New input for team 1 increment
    	reg team2_dec; // New input for team 2 increment

	wire gpio;
	wire [37:0] mprj_io;
	wire [10:0] mprj_io_0;

	assign mprj_io_0 = mprj_io[33:23];
	// assign mprj_io_0 = {mprj_io[8:4],mprj_io[2:0]};
	
	    // Assign team increment inputs to specific mprj_io pins
    	assign mprj_io[37] = team1_inc; // Example pin assignment for team1_inc
    	assign mprj_io[36] = team2_inc; // Example pin assignment for team2_inc
    	
    	assign mprj_io[35] = team1_dec; // Example pin assignment for team1_dec
    	assign mprj_io[34] = team2_dec; // Example pin assignment for team2_dec

	assign mprj_io[3] = (CSB == 1'b1) ? 1'b1 : 1'bz;
	// assign mprj_io[3] = 1'b1;

	// External clock is used by default.  Make this artificially fast for the
	// simulation.  Normally this would be a slow clock and the digital PLL
	// would be the fast clock.

	always #12.5 clock <= (clock === 1'b0);

	initial begin
		clock = 0;
	end


	`ifdef ENABLE_SDF
		initial begin
			$sdf_annotate("../../../sdf/user_proj_example.sdf", uut.mprj) ;
			$sdf_annotate("../../../sdf/user_project_wrapper.sdf", uut.mprj.mprj) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/DFFRAM.sdf", uut.soc.DFFRAM_0) ;
			$sdf_annotate("../../../mgmt_core_wrapper/sdf/mgmt_core.sdf", uut.soc.core) ;
			$sdf_annotate("../../../caravel/sdf/housekeeping.sdf", uut.housekeeping) ;
			$sdf_annotate("../../../caravel/sdf/chip_io.sdf", uut.padframe) ;
			$sdf_annotate("../../../caravel/sdf/mprj_logic_high.sdf", uut.mgmt_buffers.mprj_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mprj2_logic_high.sdf", uut.mgmt_buffers.mprj2_logic_high_inst) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect_hv.sdf", uut.mgmt_buffers.powergood_check) ;
			$sdf_annotate("../../../caravel/sdf/mgmt_protect.sdf", uut.mgmt_buffers) ;
			$sdf_annotate("../../../caravel/sdf/caravel_clocking.sdf", uut.clocking) ;
			$sdf_annotate("../../../caravel/sdf/digital_pll.sdf", uut.pll) ;
			$sdf_annotate("../../../caravel/sdf/xres_buf.sdf", uut.rstb_level) ;
			$sdf_annotate("../../../caravel/sdf/user_id_programming.sdf", uut.user_id_value) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_bidir_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_1a[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[3] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[4] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[5] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[6] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[7] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[8] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[9] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[10] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[11] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[12] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[13] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[14] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_control_block.sdf", uut.\gpio_control_in_2[15] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_0[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[0] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[1] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.\gpio_defaults_block_2[2] ) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_5) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_6) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_7) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_8) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_9) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_10) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_11) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_12) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_13) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_14) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_15) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_16) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_17) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_18) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_19) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_20) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_21) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_22) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_23) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_24) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_25) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_26) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_27) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_28) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_29) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_30) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_31) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_32) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_33) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_34) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_35) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_36) ;
			$sdf_annotate("../../../caravel/sdf/gpio_defaults_block.sdf", uut.gpio_defaults_block_37) ;
		end
	`endif 

	initial begin
		$dumpfile("scoreboard.vcd");
		$dumpvars(0, scoreboard_tb);
	
	
	// Specify the variables to dump
	//	$dumpvars(0, scoreboard_pin_limited_tb.mprj_io_0, scoreboard_pin_limited_tb.team1_inc, scoreboard_pin_limited_tb.team2_inc);

		// Repeat cycles of 1000 clock edges as needed to complete testbench
		repeat (250) begin
			repeat (1000) @(posedge clock);
			// $display("+1000 cycles");
		end
		$display("%c[1;31m",27);
		`ifdef GL
			$display ("Monitor: Timeout, Test Mega-Project IO Ports (GL) Failed");
		`else
			$display ("Monitor: Timeout, Test Mega-Project IO Ports (RTL) Failed");
		`endif
		$display("%c[0m",27);
	
		$finish;
	end

	initial begin
	    // Observe Output pins [7:0]
	    
	    	team1_inc <= 0;
        	team2_inc <= 0; 
        	team1_dec <= 0; 
        	team2_dec <= 0; 
        	
        	
        	wait(mprj_io_0 == 11'h01D);     //during the initial reset, Segment output is 0 0 0 0
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h01E);
		wait(mprj_io_0 == 11'h01D);
       	
       // 	#433750			// The large delay is given to aovid error in the gatelevel simulation.IC may take some time for initialization and the same is considered here.
         	
         	team1_inc <=1;		//incremnt to 01,  Segment output is 0 0 0 1	
        	#100
        	team1_inc <=0;   
        	
		wait(mprj_io_0 == 11'h01D); 
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h4FE);
		wait(mprj_io_0 == 11'h01D);
/*		
 	    	team1_inc <=1;		//incremnt to 02, Segment output is 0 0 0 2
        	#100
        	team1_inc <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h12E);
		wait(mprj_io_0 == 11'h01D);        	
 
  	    	team1_dec <=1;		//decremnt to 01, Segment output is 0 0 0 1
        	#100
        	team1_dec <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h4FE);
		wait(mprj_io_0 == 11'h01D); 
 
   	    	team1_dec <=1;		//decremnt to 00, Segment output is 0 0 0 0
        	#100
        	team1_dec <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h01E);
		wait(mprj_io_0 == 11'h01D); 
        			
   	    	team1_dec <=1;		//decremnt to 00, Segment output is 0 0 0 0
        	#100
        	team1_dec <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h01E);
		wait(mprj_io_0 == 11'h01D); 
*/

   	    	team1_dec <=1;		//decremnt to 00, Segment output is 0 0 0 0
        	#100
        	team1_dec <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h01E);
		wait(mprj_io_0 == 11'h01D); 
/*		
   	    	team1_inc <=1;		//increment to 01, Segment output is 0 0 0 1
        	#100
        	team1_inc <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h4FE);
		wait(mprj_io_0 == 11'h01D); 		

   	    	team1_inc <=1;		//increment to 02, Segment output is 0 0 0 2
        	#100
        	team1_inc <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h01B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h12E);
		wait(mprj_io_0 == 11'h01D); 	
				
*/				
		`ifdef GL
	    	$display("Monitor: Test 1 Score board IO (GL) Passed");
		`else
		    $display("Monitor: Test 1 Score board IO (RTL) Passed");
		`endif
/*	
		
        	team2_inc <=1;		//incremnt to 01, Segment output is 0 1 0 2
        	#100
        	team2_inc <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h4FB);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h12E);
		wait(mprj_io_0 == 11'h01D);    
		     	
        	team2_inc <=1;		//incremnt to 02,  Segment output is 0 2 0 2
        	#100
        	team2_inc <=0;
        	
		wait(mprj_io_0 == 11'h01D);
		wait(mprj_io_0 == 11'h12B);
		wait(mprj_io_0 == 11'h017);
		wait(mprj_io_0 == 11'h12E);
		wait(mprj_io_0 == 11'h01D);  	
		
			
		`ifdef GL
	    	$display("Monitor: Test 2 Score board IO (GL) Passed");
		`else
		    $display("Monitor: Test 2 Score board IO (RTL) Passed");
		`endif		
*/		
	    $finish;
	end

	initial begin
		RSTB <= 1'b0;
		CSB  <= 1'b1;		// Force CSB high
		#2000;
		RSTB <= 1'b1;	    	// Release reset
		#3_00_000;
		CSB = 1'b0;		// CSB can be released
	end

	initial begin		// Power-up sequence
		power1 <= 1'b0;
		power2 <= 1'b0;
		power3 <= 1'b0;
		power4 <= 1'b0;
		#100;
		power1 <= 1'b1;
		#100;
		power2 <= 1'b1;
		#100;
		power3 <= 1'b1;
		#100;
		power4 <= 1'b1;
	end
		
	always @(mprj_io) begin
		#1 $display("MPRJ-IO state = %b ", mprj_io[34:24]);
	end

	wire flash_csb;
	wire flash_clk;
	wire flash_io0;
	wire flash_io1;

	wire VDD3V3;
	wire VDD1V8;
	wire VSS;
	
	assign VDD3V3 = power1;
	assign VDD1V8 = power2;
	assign VSS = 1'b0;

	caravel uut (
		.vddio	  (VDD3V3),
		.vddio_2  (VDD3V3),
		.vssio	  (VSS),
		.vssio_2  (VSS),
		.vdda	  (VDD3V3),
		.vssa	  (VSS),
		.vccd	  (VDD1V8),
		.vssd	  (VSS),
		.vdda1    (VDD3V3),
		.vdda1_2  (VDD3V3),
		.vdda2    (VDD3V3),
		.vssa1	  (VSS),
		.vssa1_2  (VSS),
		.vssa2	  (VSS),
		.vccd1	  (VDD1V8),
		.vccd2	  (VDD1V8),
		.vssd1	  (VSS),
		.vssd2	  (VSS),
		.clock    (clock),
		.gpio     (gpio),
		.mprj_io  (mprj_io),
		.flash_csb(flash_csb),
		.flash_clk(flash_clk),
		.flash_io0(flash_io0),
		.flash_io1(flash_io1),
		.resetb	  (RSTB)
	);

	spiflash #(
		.FILENAME("scoreboard.hex")
	) spiflash (
		.csb(flash_csb),
		.clk(flash_clk),
		.io0(flash_io0),
		.io1(flash_io1),
		.io2(),			// not used
		.io3()			// not used
	);

endmodule
`default_nettype wire
