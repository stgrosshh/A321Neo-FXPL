-------------------------------------------------------------------------------
-- A32NX Freeware Project
-- Copyright (C) 2020
-------------------------------------------------------------------------------
-- LICENSE: GNU General Public License v3.0
--
--    This program is free software: you can redistribute it and/or modify
--    it under the terms of the GNU General Public License as published by
--    the Free Software Foundation, either version 3 of the License, or
--    (at your option) any later version.
--
--    Please check the LICENSE file in the root of the repository for further
--    details or check <https://www.gnu.org/licenses/>
-------------------------------------------------------------------------------
-- File: sasl_drawing_assets.lua
-- Short description: place to find all the texture loaded into sasl
-------------------------------------------------------------------------------

--EWD
EWD_slat_img =       sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/slat.png")
EWD_flap_img =       sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/flap.png")
EWD_slat_to_go_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/slattogo.png")
EWD_flap_to_go_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/flaptogo.png")
EWD_slat_tract_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/slat_tack.png")
EWD_flap_tract_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/flaps_track.png")
EWD_wing_indic_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/wing_indication.png")
EWD_req_thrust_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EWD/ndl_trst.png")

--ECAM
--backgrounds
--ENG--
ECAM_ENG_valve_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/ENG/valve.png")

--BLEED--
ECAM_BLEED_mixer_img =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/BLEED/Top Mix Bleed.png")
ECAM_BLEED_valves_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/BLEED/Valve.png")
ECAM_BLEED_house_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/BLEED/house.png")

--PRESS--
ECAM_PRESS_needle_img =         sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/PRESS/Needle.png")
ECAM_PRESS_outflow_needle_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/PRESS/outflow_valve.png")
ECAM_PRESS_pack_triangle_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/PRESS/Triangle.png")

--ELEC
ECAM_ELEC_ess_tr_box_img =       sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/ELEC/ESS_TR.png")
ECAM_ELEC_emer_box_img =         sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/ELEC/Emer_Gen.png")
ECAM_ELEC_inv_box_img =          sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/ELEC/STAT_INV.png")
ECAM_ELEC_apu_box_img =          sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/ELEC/APU_GEN.png")

--HYD--
ECAM_HYD_PTU_img =        sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/HYD/PTU.png")
ECAM_HYD_G_status_img =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/HYD/GREEN.png")
ECAM_HYD_B_status_img =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/HYD/BLUE.png")
ECAM_HYD_Y_status_img =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/HYD/YELLOW.png")

--FUEL
ECAM_FUEL_xfeed_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FUEL/crossfeed.png")
ECAM_FUEL_l_pump_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FUEL/pump_left.png")
ECAM_FUEL_r_pump_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FUEL/pump_right.png")
ECAM_FUEL_pumps_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FUEL/pumps.png")
ECAM_FUEL_valves_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FUEL/Valve.png")

--APU--
ECAM_APU_valve_img =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/APU/Valve.png")
ECAM_APU_needle_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/APU/Needle.png")
ECAM_APU_gen_img =        sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/APU/ApuGen.png")
ECAM_APU_triangle_img =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/APU/Triangle.png")

--COND--
ECAM_COND_grey_lines_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/COND/grey_lines.png")
ECAM_COND_arrows_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/COND/Temp_Arrow.png")
ECAM_COND_valves_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/COND/Valve.png")

--DOOR--
ECAM_DOOR_grey_lines_img =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/DOOR/grey_lines.png")
ECAM_DOOR_statics_img =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/DOOR/static_doors.png")
ECAM_DOOR_cargo_door_img =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/DOOR/cargo.png")
ECAM_DOOR_l_cabin_door_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/DOOR/cabin_left.png")
ECAM_DOOR_r_cabin_door_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/DOOR/cabin_right.png")
ECAM_DOOR_vs_arrows_img =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/DOOR/Arrow.png")

--WHEEL--
ECAM_WHEEL_hyd_boxes_img =         sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/WHEEL/hyd_squares.png")
ECAM_WHEEL_l_nose_gear_door_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/WHEEL/leftnosegeardoor.png")
ECAM_WHEEL_r_nose_gear_door_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/WHEEL/nosegeardoor.png")
ECAM_WHEEL_l_main_gear_door_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/WHEEL/geardoor.png")
ECAM_WHEEL_r_main_gear_door_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/WHEEL/rightgeardoor.png")
ECAM_WHEEL_gears_img =             sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/WHEEL/gear.png")

--FCTL--
ECAM_FCTL_bgd_img =              sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/FCTL.png")
ECAM_FCTL_grey_lines_img =       sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/FCTL_grey.png")
ECAM_FCTL_computer_backets_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/computer_braket.png")
ECAM_FCTL_left_arrows_img =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/ArrowLeft.png")
ECAM_FCTL_right_arrows_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/ArrowRight.png")
ECAM_FCTL_rudder_img =           sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/Rudder.png")
ECAM_FCTL_rudder_track_img =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/rudder_track.png")
ECAM_FCTL_left_rudder_lim_img =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/LeftLimiter.png")
ECAM_FCTL_right_rudder_lim_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/RightLimiter.png")
ECAM_FCTL_rudder_trim_img =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/rudder_trim.png")
ECAM_FCTL_spoiler_arrow_img =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/FCTL/SpoilerArrow.png")

--STS--

--CRUISE--
ECAM_CRUISE_bgd_img =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/CRUISE/cruise.png")
ECAM_CRUISE_vs_arrow_img = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ECAM/CRUISE/Arrow.png")

--EFB--
EFB_cursor =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/cursor.png") 
EFB_toggle =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Toggle.png")
EFB_highlighter =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/highlighter.png")

EFB_CSS_logo = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/OFF page/CSS.png")
EFB_Charging_Overlay = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/charging_overlay.png") -- 1058, 5, 75x14

------------GROUND-------------

EFB_GROUND_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/overlay.png")
EFB_GROUND_plane =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Plane.png")

EFB_GROUND_ac    =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/AC.png")
EFB_GROUND_as    =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/AS.png")
EFB_GROUND_cat1  =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/Cat 1.png")
EFB_GROUND_cat2  =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/Cat 2.png")
EFB_GROUND_fuel  =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/Fuel.png")
EFB_GROUND_gpu   =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/GPU.png")
EFB_GROUND_ldcl1 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/LDCL 1.png")
EFB_GROUND_ldcl2 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/LDCL 2.png")
EFB_GROUND_lv    =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/LV.png")
EFB_GROUND_ps1   =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/PS 1.png")
EFB_GROUND_ps2   =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/PS 2.png")
EFB_GROUND_uld1  =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/ULD1.png")
EFB_GROUND_uld2  =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/ULD2.png")
EFB_GROUND_wv    =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Ground Vehicles/WV.png")

------------GROUND SUBPAGE2-------------
EFB_GROUND2_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/airplanes.png")
EFB_GROUND2_caft =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/caft.png")
EFB_GROUND2_cfront =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/cfront.png")
EFB_GROUND2_l1 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/l1.png")
EFB_GROUND2_l2 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/l2.png")
EFB_GROUND2_l3 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/l3.png")
EFB_GROUND2_l4 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/l4.png")
EFB_GROUND2_l5 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/l5.png")
EFB_GROUND2_r1 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/r1.png")
EFB_GROUND2_r2 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/r2.png")
EFB_GROUND2_r3 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/r3.png")
EFB_GROUND2_r4 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/r4.png")
EFB_GROUND2_r5 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/r5.png")

EFB_GROUND2_closeall_button =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/GND page/Page 2/closeall_button.png")
------------LOAD-------------

EFB_LOAD_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/PERF page/Version 2/bgd.png")

EFB_LOAD_compute_button =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/PERF page/compute_button.png")

------------LOAD_SUBPAGE2-------------

EFB_LOAD_s2_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/PERF page/Version 2/subpage 2/bgd.png")

------------LOAD_SUBPAGE3-------------

EFB_LOAD_s3_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/PERF page/Version 2/subpage3/bgd.png")
EFB_LOAD_s3_generate_button =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/PERF page/Version 2/subpage3/generate_button.png")

-----------CONFIG------------

EFB_CONFIG_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/CONFIG page/overlay.png")
EFB_CONFIG_slider =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/CONFIG page/slider_ball.png")
EFB_CONFIG_save =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/CONFIG page/save_button.png")
EFB_CONFIG_hud =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/CONFIG page/hud.png")
EFB_CONFIG_dropdown1 =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/CONFIG page/dropdown1.png")
EFB_CONFIG_align_button =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/CONFIG page/align_button.png")


--SIMBRIEF

Simbrief_bgd =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/NETWORK page/SIMBRIEF/subpage_2_bgd.png")
Simbrief_apply =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/NETWORK page/SIMBRIEF/apply_button.png")
Simbrief_send =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/NETWORK page/SIMBRIEF/send_button.png")

-----------HOME------------

EFB_HOME_bgd =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/HOME page/overlay.png")

EFB_INFO_selector =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/EFB/Icons/MANUAL page/page_selector.png")

--temp textures for popup windows rendering--
CAPT_PFD_popup_texture = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/capt_pfd.png")
FO_PFD_popup_texture =   sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/fo_pfd.png")
CAPT_ND_popup_texture =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/capt_nd.png")
FO_ND_popup_texture =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/fo_nd.png")
EWD_popup_texture =      sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/ewd.png")
ECAM_popup_texture =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/ecam.png")
ISIS_popup_texture =     sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/popups/isis.png")
MCDU_popup_texture =     sasl.gl.createTexture(560, 530)

--FAILURES_UI

Button_bgd =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/failures_ui/btn-empty.png")
R_master =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/failures_ui/r_master.png")
R_warn =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/failures_ui/r_warn.png")
Y_master =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/failures_ui/y_master.png")
Y_caut =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/failures_ui/y_caut.png")

--ISIS TEST DRAWINGS
ISIS_horizon =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/isis horizon v3.png")
ISIS_horizon_mask = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/horizon_mask.png")
ISIS_backlit = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/backlit_helper_v2.png")
ISIS_horizon_wings = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/horizon_wings.png")
ISIS_spd_pointer = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/spd_pointer.png")
ISIS_alt_window = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/alt_box.png")
ISIS_alt_scrolling = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/AltDisplay_tens-1.png")
ISIS_SI = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/Beta-1.png")
ISIS_roll_arrow = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/Triangle-1.png")
ISIS_localiser = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/lshdiamond-1.png")
ISIS_glideslope = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/lsvdiamond-1.png")
ISIS_lsh = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/lsh-1.png")
ISIS_lsv = sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/lsv-1.png")

--ISIS BUGS DRAWINGS
ISIS_BUGS_arrow =  sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/ISIS/V2/BUGS/arrow.png")


-- MCDU --
MCDU_lr_arrows =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/MCDU/lr_arrows.png")
MCDU_ud_arrows =    sasl.gl.loadImage(moduleDirectory .. "/Custom Module/textures/MCDU/ud_arrows.png")


