set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { LED_out[0] }]; #IO_L18P_T2_A24_15 Sch=led[0]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { LED_out[1] }]; #IO_L24P_T3_RS1_15 Sch=led[1]
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { LED_out[2] }]; #IO_L17N_T2_A25_15 Sch=led[2]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { LED_out[3] }]; #IO_L8P_T1_D11_14 Sch=led[3]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { LED_out[4] }]; #IO_L7P_T1_D09_14 Sch=led[4]
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { LED_out[5] }]; #IO_L18N_T2_A11_D27_14 Sch=led[5]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { LED_out[6] }]; #IO_L17P_T2_A14_D30_14 Sch=led[6]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { LED_out[7] }]; #IO_L18P_T2_A12_D28_14 Sch=led[7]
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { LED_out[8] }]; #IO_L16N_T2_A15_D31_14 Sch=led[8]
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { LED_out[9] }]; #IO_L14N_T2_SRCC_14 Sch=led[9]
set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { LED_out[10] }]; #IO_L22P_T3_A05_D21_14 Sch=led[10]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { LED_out[11] }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14 Sch=led[11]
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { LED_out[12] }]; #IO_L16P_T2_CSI_B_14 Sch=led[12]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { LED_out[13] }]; #IO_L22N_T3_A04_D20_14 Sch=led[13]
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { LED_out[14] }]; #IO_L20N_T3_A07_D23_14 Sch=led[14]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { LED_out[15] }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=led[15]



#set_property package_pin H17 [get_ports LED_out[0]]
#set_property iostandard LVCMOS33 [get_ports LED_out[0]]

#set_property package_pin K15 [get_ports LED_out[1]]
#set_property iostandard LVCMOS33 [get_ports LED_out[1]]

#set_property package_pin J13 [get_ports LED_out[2]]
#set_property iostandard LVCMOS33 [get_ports LED_out[2]]

#set_property package_pin N14 [get_ports LED_out[3]]
#set_property iostandard LVCMOS33 [get_ports LED_out[3]]

#set_property package_pin R18 [get_ports LED_out[4]]
#set_property iostandard LVCMOS33 [get_ports LED_out[4]]

#set_property package_pin V17 [get_ports LED_out[5]]
#set_property iostandard LVCMOS33 [get_ports LED_out[5]]

#set_property package_pin U17 [get_ports LED_out[6]]
#set_property iostandard LVCMOS33 [get_ports LED_out[6]]

#set_property package_pin U16 [get_ports LED_out[7]]
#set_property iostandard LVCMOS33 [get_ports LED_out[7]]

#set_property package_pin V16 [get_ports LED_out[8]]
#set_property iostandard LVCMOS33 [get_ports LED_out[8]]

#set_property package_pin T15 [get_ports LED_out[9]]
#set_property iostandard LVCMOS33 [get_ports LED_out[9]]

#set_property package_pin U14 [get_ports LED_out[10]]
#set_property iostandard LVCMOS33 [get_ports LED_out[10]]

#set_property package_pin T16 [get_ports LED_out[11]]
#set_property iostandard LVCMOS33 [get_ports LED_out[11]]

#set_property package_pin V15 [get_ports LED_out[12]]
#set_property iostandard LVCMOS33 [get_ports LED_out[12]]

#set_property package_pin V14 [get_ports LED_out[13]]
#set_property iostandard LVCMOS33 [get_ports LED_out[13]]

#set_property package_pin V12 [get_ports LED_out[14]]
#set_property iostandard LVCMOS33 [get_ports LED_out[14]]

#set_property package_pin V11 [get_ports LED_out[15]]
#set_property iostandard LVCMOS33 [get_ports LED_out[15]]




#set_property package_pin J15 [get_ports LEDSel[0]]
#set_property iostandard LVCMOS33 [get_ports LEDSel[0]]

#set_property package_pin L16 [get_ports LEDSel[1]]
#set_property iostandard LVCMOS33 [get_ports LEDSel[1]]


##Switches

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { SSDSel[0] }]; #IO_L24N_T3_RS0_15 Sch=sw[0]
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { SSDSel[1] }]; #IO_L3N_T0_DQS_EMCCLK_14 Sch=sw[1]
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { SSDSel[2] }]; #IO_L6N_T0_D08_VREF_14 Sch=sw[2]
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { SSDSel[3] }]; #IO_L13N_T2_MRCC_14 Sch=sw[3]
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { LEDSel[0] }]; #IO_L12N_T1_MRCC_14 Sch=sw[4]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { LEDSel[1] }]; #IO_L7N_T1_D10_14 Sch=sw[5]

set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { display[6] }]; #IO_L24N_T3_A00_D16_14 Sch=ca
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { display[5] }]; #IO_25_14 Sch=cb
set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { display[4] }]; #IO_25_15 Sch=cc
set_property -dict { PACKAGE_PIN K13   IOSTANDARD LVCMOS33 } [get_ports { display[3] }]; #IO_L17P_T2_A26_15 Sch=cd
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { display[2] }]; #IO_L13P_T2_MRCC_14 Sch=ce
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { display[1] }]; #IO_L19P_T3_A10_D26_14 Sch=cf
set_property -dict { PACKAGE_PIN L18   IOSTANDARD LVCMOS33 } [get_ports { display[0] }]; #IO_L4P_T0_D04_14 Sch=cg

#set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { DP }]; #IO_L19N_T3_A21_VREF_15 Sch=dp

set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { Anode[0] }]; #IO_L23P_T3_FOE_B_15 Sch=an[0]
set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { Anode[1] }]; #IO_L23N_T3_FWE_B_15 Sch=an[1]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { Anode[2] }]; #IO_L24P_T3_A01_D17_14 Sch=an[2]
set_property -dict { PACKAGE_PIN J14   IOSTANDARD LVCMOS33 } [get_ports { Anode[3] }]; #IO_L19P_T3_A22_15 Sch=an[3]


#set_property package_pin L18 [get_ports display[0]]
#set_property iostandard LVCMOS33 [get_ports display[0]]

#set_property package_pin T11 [get_ports display[1]]
#set_property iostandard LVCMOS33 [get_ports display[1]]

#set_property package_pin P15 [get_ports display[2]]
#set_property iostandard LVCMOS33 [get_ports display[2]]

#set_property package_pin K13 [get_ports display[3]]
#set_property iostandard LVCMOS33 [get_ports display[3]]

#set_property package_pin K16 [get_ports display[4]]
#set_property iostandard LVCMOS33 [get_ports display[4]]

#set_property package_pin R10 [get_ports display[5]]
#set_property iostandard LVCMOS33 [get_ports display[5]]

#set_property package_pin T10 [get_ports display[6]]
#set_property iostandard LVCMOS33 [get_ports display[6]]






#set_property package_pin H6 [get_ports SSDSel[0]]
#set_property iostandard LVCMOS33 [get_ports SSDSel[0]]

#set_property package_pin U12 [get_ports SSDSel[1]]
#set_property iostandard LVCMOS33 [get_ports SSDSel[1]]

#set_property package_pin U11 [get_ports SSDSel[2]]
#set_property iostandard LVCMOS33 [get_ports SSDSel[2]]

#set_property package_pin V10 [get_ports SSDSel[3]]
#set_property iostandard LVCMOS33 [get_ports SSDSel[3]]





#set_property package_pin J17 [get_ports Anode[0]]
#set_property iostandard LVCMOS33 [get_ports Anode[0]]

#set_property package_pin J18 [get_ports Anode[1]]
#set_property iostandard LVCMOS33 [get_ports Anode[1]]

#set_property package_pin T9 [get_ports Anode[2]]
#set_property iostandard LVCMOS33 [get_ports Anode[2]]

#set_property package_pin J14 [get_ports Anode[3]]
#set_property iostandard LVCMOS33 [get_ports Anode[3]]





set_property package_pin N17 [get_ports clk]
set_property iostandard LVCMOS33 [get_ports clk]

set_property package_pin M18 [get_ports rst]
set_property iostandard LVCMOS33 [get_ports rst]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk] 

set_property package_pin E3 [get_ports SSD_clk]
set_property iostandard LVCMOS33 [get_ports SSD_clk]
