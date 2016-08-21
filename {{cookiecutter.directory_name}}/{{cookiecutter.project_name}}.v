
// `define DDR3A
// `define DDR3B
// `define USB
// `define FM
// `define ETHERNET
// `define HSMA
// `define HSMB
// `define LCD
`define USER
// `define PCIE
// `define SDIA
// `define SEC

module {{cookiecutter.project_name}}
(

//GPLL-CLK-----------------------------//8 pins  //------------------------
    input          clkin_50,            //1.8V    //50 MHz.
    input          clkintop_p,          //LVDS    //clkintop
    input          clkinbot_p,          //LVDS    //clkinbot
    input          clkin_r_p,           //LVDS    //100 MHz prog osc
    input          clk_125m_p,          //LVDS    //125 MHz GPLL-req's External Term.
    output         sma_clkout,          //V       // sma_clkout.

`ifdef DDR3A
//DDR3-Devices-x40-hmc ----------------// pins   //--------------------------
    output  [13:0] ddr3a_a,             //SSTL15  //Address
    output  [2:0]  ddr3a_ba,            //SSTL15  //Bank Address
    output         ddr3a_casn,          //SSTL15  //Column Address Strobe
    output         ddr3a_clk_n,         //SSTL15  //Diff Clock - Neg
    output         ddr3a_clk_p,         //SSTL15  //Diff Clock - Pos
    output         ddr3a_cke,           //SSTL15  //Clock Enable
    output         ddr3a_csn,           //SSTL15  //Chip Select
    output  [4:0]  ddr3a_dm,            //SSTL15  //Data Write Mask
    inout   [39:0] ddr3a_dq,            //SSTL15  //Data Bus
    inout   [4:0]  ddr3a_dqs_n,         //SSTL15  //Diff Data Strobe - Neg
    inout   [4:0]  ddr3a_dqs_p,         //SSTL15  //Diff Data Strobe - Pos
    output         ddr3a_odt,           //SSTL15  //On-Die Termination Enable
    output         ddr3a_rasn,          //SSTL15  //Row Address Strobe
    output         ddr3a_resetn,        //SSTL15  //Reset
    output         ddr3a_wen,           //SSTL15  //Write Enable
    output [16:0]  ddr3a_hmc_gnd,       //HMC required GND connections.
`endif

    input          rzqin_1_5v,          //OCT Pin in Bank 4A

`ifdef DDR3B
//DDR3B Devices-x64-smc --------------------// pins   //--------------------------
    output  [13:0] ddr3b_a,             //SSTL15  //Address
    output  [2:0]  ddr3b_ba,            //SSTL15  //Bank Address
    output         ddr3b_casn,          //SSTL15  //Column Address Strobe
    output         ddr3b_clk_n,         //SSTL15  //Diff Clock - Neg
    output         ddr3b_clk_p,         //SSTL15  //Diff Clock - Pos
    output         ddr3b_cke,           //SSTL15  //Clock Enable
    output         ddr3b_csn,           //SSTL15  //Chip Select
    output  [7:0]  ddr3b_dm,            //SSTL15  //Data Write Mask
    inout   [63:0] ddr3b_dq,            //SSTL15  //Data Bus
    inout   [7:0]  ddr3b_dqs_n,         //SSTL15  //Diff Data Strobe - Neg
    inout   [7:0]  ddr3b_dqs_p,         //SSTL15  //Diff Data Strobe - Pos
    output         ddr3b_odt,           //SSTL15  //On-Die Termination Enable
    output         ddr3b_rasn,          //SSTL15  //Row Address Strobe
    output         ddr3b_resetn,        //SSTL15  //Reset
    output         ddr3b_wen,           //SSTL15  //Write Enable
`endif

`ifdef USB
    inout  [7:0]   usb_data,            //1.5V from MAXII
    //USB Blaster II ----------------------//19 pins //--------------------------
    inout  [1:0]   usb_addr,            //1.5V from MAXII
    inout          usb_clk,             //3.3V from Cypress USB
    output         usb_full,            //1.5V from MAXII
    output         usb_empty,           //1.5V from MAXII
    input          usb_scl,             //1.5V from MAXII
    inout          usb_sda,             //1.5V from MAXII
    input          usb_oen,             //1.5V from MAXII
    input          usb_rdn,             //1.5V from MAXII
    input          usb_wrn,             //1.5V from MAXII
    input          usb_resetn,          //1.5V from MAXII
`endif

`ifdef FM
    //FM-Shared-Bus---(Flash/Max)----------//49 pins //--------------------------
    output  [26:1] fm_a,                //1.8V    //Address
    inout   [15:0] fm_d,                //1.8V    //Data
    output         flash_advn,          //1.8V    //Flash Address Valid
    output         flash_cen,           //1.8V    //Flash Chip Enable
    output         flash_clk,           //1.8V    //Flash Clock
    output         flash_oen,           //1.8V    //Flash Output Enable
    input          flash_rdybsyn,       //1.8V    //Flash Ready/Busy
    output         flash_resetn,        //1.8V    //Flash Reset
    output         flash_wen,           //1.8V    //Flash Write Enable

    inout          max_clk,             //1.5V    //Max II Clk
    output         max_csn,             //1.5V    //Max II Chip Select
    output         max_oen,             //1.5V    //Max II Output Enable
    output         max_wen,             //1.5V    //Max II Write Enable
`endif

`ifdef ETHERNET
    //Ethernet-10/100/1000-RGMII-----------//16 pins //--------------------------
    input          enet_intn,           //2.5V     //MDIO Interrupt (TR=0)
    output         enet_mdc,            //2.5V     //MDIO Clock (TR=0)
    inout          enet_mdio,           //2.5V     //MDIO Data (TR=0)
    output         enet_resetn,         //2.5V     //Device Reset (TR=0)
    output         enet_gtx_clk,        //2.5V
    input          enet_rx_clk,         //2.5V
    output         enet_tx_en, 	        //2.5V
    output [3:0]   enet_tx_d,           //2.5V
    input          enet_rx_dv,          //2.5V
    input  [3:0]   enet_rx_d,           //2.5V
 `endif

`ifdef HSMB
    //HSMC-Port-B --------------------------------------------------
    //input  [3:0] hsmb_rx_p,           //PCML15  //HSMB Receive Data-req's OCT
    //output [3:0] hsmb_tx_p,           //PCML15  //HSMB Transmit Data
    //Enable below for CMOS HSMC
    //inout  [79:0]  hsma_d,            //1.5V    //HSMA CMOS Data Bus
    //Enable below for LVDS HSMC
    input          hsmb_clk_in0,        //1.5Var  //Primary single-ended CLKIN
    input          hsmb_clk_in_p1,      //1.5Var  //Secondary diff. CLKIN p
    input          hsmb_clk_in_n1,      //1.5Var  //Secondary diff. CLKIN n
    input          hsmb_clk_in_p2,      //LVDS    //Primary Source-Sync CLKIN
    output         hsmb_clk_out0,       //1.5Var  //Primary single-ended CLKOUT
    output         hsmb_clk_out_p1,     //1.5Var  //Secondary diff. CLKOUT p
    output         hsmb_clk_out_n1,     //1.5Var  //Secondary diff. CLKOUT n
    output         hsmb_clk_out_p2,     //1.5Var  //Primary Source-Sync CLKOUT p
    output         hsmb_clk_out_n2,     //1.5Var  //Primary Source-Sync CLKOUT n
    inout  [15:0]  hsmb_a,              //1.5Var  //Address
    inout          hsmb_addr_cmd,       //1.5Var  //Additional Addres/Command pins
    inout  [3:0]   hsmb_ba,             //1.5Var  //Bank Address
    inout          hsmb_casn,           //1.5Var  //Column Address Strobe
    inout          hsmb_rasn,           //1.5Var  //Row Address Strobe
    inout          hsmb_wen,            //1.5Var  //Write Enable
    inout          hsmb_cke,            //1.5Var  //Clock Enable
    inout          hsmb_csn,            //1.5Var  //Chip Select
    inout          hsmb_odt,            //1.5Var  //ODT
    inout [3:0]    hsmb_dm,             //1.5Var  //Data Write Mask
    inout [31:0]   hsmb_dq,             //1.5Var  //Data
    inout [3:0]    hsmb_dqs_p,          //1.5Var  //Data Strobe positive
    inout [3:0]    hsmb_dqs_n,          //1.5Var  //Data Strobe negative
    input          hsmb_prsntn,         //1.5Var  //HSMC Presence Detect Input
    output         hsmb_rx_led,         //1.5Var  //User LED - Labeled RX
    output         hsmb_scl,            //1.5Var  //SMBus Clock
    inout          hsmb_sda,            //1.5Var  //SMBus Data
    output         hsmb_tx_led,         //1.5Var  //User LED - Labeled TX
    input          rzqin_hsmb_var,      //1.5Var  //
`endif

`ifdef HSMA
    //HSMC-Port-A--------------------------//107pins //--------------------------
    //input  [3:0]   hsma_rx_p,         //PCML15  //HSMA Receive Data-req's OCT
    //output [3:0]   hsma_tx_p,         //PCML15  //HSMA Transmit Data
    //Enable below for CMOS HSMC
    //inout  [79:0]  hsma_d,            //2.5V    //HSMA CMOS Data Bus
    //Enable below for LVDS HSMC
    input          hsma_clk_in0,        //2.5V    //Primary single-ended CLKIN
    input          hsma_clk_in_p1,      //LVDS    //Secondary diff. CLKIN
    input          hsma_clk_in_p2,      //LVDS    //Primary Source-Sync CLKIN
    output         hsma_clk_out0,       //2.5V    //Primary single-ended CLKOUT
    output         hsma_clk_out_p1,     //LVDS    //Secondary diff. CLKOUT
    output         hsma_clk_out_p2,     //LVDS    //Primary Source-Sync CLKOUT
    inout    [3:0] hsma_d,              //2.5V    //Dedicated CMOS IO
    input          hsma_prsntn,         //2.5V    //HSMC Presence Detect Input
    input   [16:0] hsma_rx_d_p,         //LVDS    //LVDS Sounce-Sync Input
    output  [16:0] hsma_tx_d_p,         //LVDS    //LVDS Sounce-Sync Output
    output         hsma_rx_led,         //2.5V    //User LED - Labeled RX
    output         hsma_scl,            //2.5V    //SMBus Clock
    inout          hsma_sda,            //2.5V    //SMBus Data
    output         hsma_tx_led,         //2.5V    //User LED - Labeled TX
`endif

`ifdef LCD
    //Character-LCD------------------------//2 pins //--------------------------
    output         disp_i2c_scl,        //2.5V    //LCD
    inout    	   disp_i2c_sda,        //2.5V    //LCD Data for I2C LCD (Populate R1 on LCD)
    output    	   disp_spiss,          //2.5V    //LCD Control for SPI LCD (Populate R2 on LCD)
`endif

`ifdef PCIE
    //PCI-Express--------------------------//32 pins //--------------------------
    //input  [3:0]   pcie_rx_p,         //PCML14  //PCIe Receive Data-req's OCT
    //output [3:0]   pcie_tx_p,         //PCML14  //PCIe Transmit Data
    //input          pcie_refclk_p,     //HCSL    //PCIe Clock- Terminate on MB
    output         pcie_led_g2,         //2.5V    //User LED - Labeled Gen2
    output         pcie_led_x1,         //2.5V    //User LED - Labeled x1
    output         pcie_led_x4,         //2.5V    //User LED - Labeled x4
    input          pcie_perstn,         //2.5V    //PCIe Reset
    input          pcie_smbclk,         //2.5V    //SMBus Clock (TR=0)
    inout          pcie_smbdat,         //2.5V    //SMBus Data (TR=0)
    output         pcie_waken,          //2.5V    //PCIe Wake-Up (TR=0)
`endif

`ifdef SDIA
    //GPLL-CLK-----------------------------//6 pins  //------------------------
    //input          sdi_a_rx_p,        //PCML14  //SDI Video Input-req's OCT
    //output         sdi_a_tx_p,        //PCML14  //SDI Video Output
    //input          refclk0_b_qr0_p    //LVDS    //Programmable VCXO
    output         sdi_clk148_dn,       //1.5V    //VCXO Frequency Down
    output         sdi_clk148_up,       //1.5V    //VCXO Frequency Up
    output         sdi_a_tx_sd_hdn,     //1.5V    //HD Mode Enable
    output		   sdi_a_tx_en,         //1.5V  //Transmit Enable
    output		   sdi_a_rx_en,         //1.5V  //Receive Enable - Tri-state
    output		   sdi_a_rx_bypass,     //1.5V  //Receive Bypass
`endif

`ifdef SEC
    //Security-CPLD------------------------//8 pins  //------------------------
    input          sec_dataout,         //1.5V    //
    output         sec_random_in,       //1.5V    //
    output         sec_clk,             //1.5V    //
    output         sec_sys_reset,       //1.5V    //
    input          sec_shift_en,        //1.5V    //
    inout          sec_test1,           //1.5V    //
    input          sec_test2,           //1.5V    //
    output         sec_run_in,          //1.5V    //
`endif

`ifdef USER
    //User-IO------------------------------//28 pins //--------------------------
    input    [7:0] user_dipsw,          //2.5V   //User DIP Switches (TR=0)
    output   [7:0] user_led,            //2.5V	 //Green User LEDs
    input    [2:0] user_pb,             //2.5V   //User Pushbuttons (TR=0)
    input          cpu_resetn           //2.5V   //CPU Reset Pushbutton (TR=0)
`endif

);

endmodule
