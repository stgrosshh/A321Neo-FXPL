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
-- File: 3.lua 
-- Short description: EFB page 3
-------------------------------------------------------------------------------

--------OK SO WORKFLOW OF THE SCRIPT!!!!!!! ~ Henrick 2 Jul 2021

--EFB_p3s1_onmousedown(x,y,i) this kind of function consisting of x y and i, are always run in a for loop.
--The for loop has to be looped from 1 to 6, because there are 6 sliders.
--when you click a slider, a variable "selected_slider" will be changed to the corresponding slider.
--This value is used to link the mouse cursor and the slider.
--EFB_p3s1_onmouseup() or not EFB_CURSOR_on_screen will make the selected slider become 0.
--
--Now comes the fun part.
--slider_to_weights_translator() is run every frame as it ensures that the actual values (in kg, ppl, etc) are always corresponding to the slider.
--draw_slider_corresponding_values() is drawn on top of the slider as a graphical display of the slider corresponding value.
--When the load button is called, set_values() is called. The slider corresponding value from slider_to_weights_translator() is set to the weights function.
--Weights function are created by Rico, in weights.lua.

-- To whoever is reading this, this is the ceiling of my coding ability. Please improve this if you can!
-- It is the second attempt of me writing this page, I abandoned the first page as the workflow was a mess and I lost track.

--11pm now, got to shower. Cheers!

-------------------------------------------------------------------------------
-- Includes
-------------------------------------------------------------------------------
include("EFB/EFB_pages/3_subpage2.lua")
include("EFB/EFB_pages/3_subpage3.lua")
include("libs/table.save.lua")
include('libs/geo-helpers.lua')
include("EFB/efb_systems.lua")
include("EFB/efb_topcat.lua")


-------------------------------------------------------------------------------
-- Constants
-------------------------------------------------------------------------------
local BUTTON_PRESS_TIME = 0.5
local WEIGHT_PER_PASSENGER = 88 --kg
local DRY_OPERATING_WEIGHT = 46300
local NUMBER_OF_SUBPAGES = 3

-------------------------------------------------------------------------------
-- Global variables
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-----------------------------------------------------------DO NOT TOUCH!!!!!!
-------------------------------------------------------------------------------

New_takeoff_data_available = true

-- Graphics and others
local dropdown_expanded = {false, false}
local dropdown_selected = {1,1}
local dropdown_1 = {}
local dropdown_2 = {}

local avionics_bay_is_initialising = false

key_p3s1_focus = 0 --0 nothing, 7 dep, 8 arr
local key_p3s1_buffer = ""

local load_button_begin = 0
local reset_button_begin = 0

efb_subpage_number = 1

deparr_apts = {"", ""}

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-----------------------------------------------------------DO NOT TOUCH!!!!!!
-------------------------------------------------------------------------------

local slider_pos = {0,0.5,0,0,0,5000/FUEL_TOT_MAX}
local slider_actual_values = {0,0.5,0,0,0,0}
local focused_slider = 0
local touched_sliders_after_loading = false

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

function backpropagate_current_weights_to_local_sliders()
    slider_pos[1] = WEIGHTS.get_passengers_weight()/WEIGHT_MAX_PASSENGERS -- pax
    slider_pos[2] = 0.5
    slider_pos[3] = WEIGHTS.get_fwd_cargo_weight()/WEIGHT_MAX_FWD_CARGO -- front cargo
    slider_pos[4] = WEIGHTS.get_aft_cargo_weight()/WEIGHT_MAX_AFT_CARGO -- aft cargo
    slider_pos[5] = WEIGHTS.get_bulk_cargo_weight()/WEIGHT_MAX_BULK_CARGO -- bulk cargo
    slider_pos[6] = get(FOB) / FUEL_TOT_MAX
end

EFB.load_page_backpropagate_current_weights = backpropagate_current_weights_to_local_sliders

local function draw_each_component_UI() -- draw the lovely filling polygon animation
    local left_wing_ll = {643,514}
    local left_wing_ul = {643,552}
    local left_wing_lr = {744,542}
    local left_wing_ur = {744,610}

    local right_wing_ll = {815,542}
    local right_wing_ul = {815,611}
    local right_wing_lr = {916,514}
    local right_wing_ur = {916,552}

    main_starting_point = {757,542}
    act_starting_point = {757,621}
    rct_starting_point = {757,502}

    local act_rct_width = 46
    local act_rct_hight = 30
    local center_width = 46
    local center_hight = 70

    local cargo_bulk_starting_point = {949,468}
    local cargo_aft_starting_point = {949,506}
    local cargo_fwd_starting_point = {949,583}

    local pax_starting_point = {1019,468}
    local pax_height = 185

    local filled_ratio = {
        math.min(get(Fuel_quantity[1])/FUEL_LR_MAX ,1) , -- left wing tank
        math.min(get(Fuel_quantity[2])/FUEL_LR_MAX ,1) , -- right wing tank
        math.min(get(Fuel_quantity[0])/FUEL_C_MAX ,1) , -- center tank
        math.min(get(Fuel_quantity[3])/FUEL_ACT_MAX ,1) , -- act
        math.min(get(Fuel_quantity[4])/FUEL_RCT_MAX,1) , -- rct
      WEIGHTS.get_bulk_cargo_weight()/WEIGHT_MAX_BULK_CARGO, -- bulk cargo
      WEIGHTS.get_aft_cargo_weight()/WEIGHT_MAX_AFT_CARGO, -- aft cargo
      WEIGHTS.get_fwd_cargo_weight()/WEIGHT_MAX_FWD_CARGO, -- front cargo
      WEIGHTS.get_passengers_weight()/WEIGHT_MAX_PASSENGERS, -- pax
    }

    sasl.gl.drawConvexPolygon ({    left_wing_ll[1] 
                                    , left_wing_ll[2] 
                                    , left_wing_ul[1] 
                                    , Math_rescale(0    ,left_wing_ll[2], 1 ,left_wing_ll[2] + (left_wing_ul[2]-left_wing_ll[2]), filled_ratio[1])
                                    , left_wing_ur[1]  
                                    , Math_rescale(0    ,left_wing_lr[2], 1 ,left_wing_lr[2] + (left_wing_ur[2]-left_wing_lr[2]), filled_ratio[1])
                                    , left_wing_lr[1] 
                                    , left_wing_lr[2] 
                                } , true , 0 ,EFB_SLIDER_COLOUR )

    sasl.gl.drawConvexPolygon ({    right_wing_ll[1] 
                                , right_wing_ll[2] 
                                , right_wing_ul[1] 
                                , Math_rescale(0    ,right_wing_ll[2], 1 ,right_wing_ll[2] + (right_wing_ul[2]-right_wing_ll[2]), filled_ratio[2])
                                , right_wing_ur[1]  
                                , Math_rescale(0    ,right_wing_lr[2], 1 ,right_wing_lr[2] + (right_wing_ur[2]-right_wing_lr[2]), filled_ratio[2])
                                , right_wing_lr[1] 
                                , right_wing_lr[2] 
                                } , true , 0 ,EFB_SLIDER_COLOUR )
    sasl.gl.drawRectangle( main_starting_point[1] , main_starting_point[2] ,center_width, center_hight * filled_ratio[3] , EFB_SLIDER_COLOUR)
    sasl.gl.drawRectangle( act_starting_point[1] , act_starting_point[2] ,act_rct_width, act_rct_hight * filled_ratio[4] , EFB_SLIDER_COLOUR)
    sasl.gl.drawRectangle( rct_starting_point[1] , rct_starting_point[2] ,act_rct_width, act_rct_hight * filled_ratio[5] , EFB_SLIDER_COLOUR)
    sasl.gl.drawRectangle( cargo_bulk_starting_point[1] , cargo_bulk_starting_point[2] ,act_rct_width, act_rct_hight * filled_ratio[6] , EFB_SLIDER_COLOUR)
    sasl.gl.drawRectangle( cargo_aft_starting_point[1] , cargo_aft_starting_point[2] ,center_width, center_hight * filled_ratio[7] , EFB_SLIDER_COLOUR)
    sasl.gl.drawRectangle( cargo_fwd_starting_point[1] , cargo_fwd_starting_point[2] ,center_width, center_hight * filled_ratio[8] , EFB_SLIDER_COLOUR)
    sasl.gl.drawRectangle( pax_starting_point[1] , pax_starting_point[2] ,center_width, pax_height * filled_ratio[9] , EFB_SLIDER_COLOUR)
end

local function number_to_loadsheet_format(number)
    return Fwd_string_fill(tostring(number), "0", 5)
end



local function within(what,min,max)
    if what <= max and what >= min then 
        return true 
    else 
        return false 
    end
end

local function draw_slider_corresponding_values()
    local passenger_weight = Round(slider_actual_values[1],1)
    local passenger_number = tostring(Round(slider_actual_values[1]/WEIGHT_PER_PASSENGER,0).." PAX")
    local fwd_cargo_weight = slider_actual_values[3]
    local aft_cargo_weight = slider_actual_values[4]
    local bulk_cargo_weight = slider_actual_values[5]
    local fuel_weight = slider_actual_values[6]
    local total_traffic_load = passenger_weight +fwd_cargo_weight + aft_cargo_weight + bulk_cargo_weight
    local dow = DRY_OPERATING_WEIGHT
    local zfw = DRY_OPERATING_WEIGHT + total_traffic_load
    local tow = zfw + fuel_weight
    local overweight = tonumber(tow) > 101000

    drawTextCentered(Font_Airbus_panel,  630 ,426 - 52 * 0, passenger_number , 17, true, false, TEXT_ALIGN_RIGHT, EFB_WHITE)
    drawTextCentered(Font_Airbus_panel,  630 ,426 - 52 * 1, slider_actual_values[2] <= 0.5 and "FWD" or "AFT" , 17, true, false, TEXT_ALIGN_RIGHT, EFB_WHITE)
    drawTextCentered(Font_Airbus_panel,  630 ,426 - 52 * 2, tostring(fwd_cargo_weight).." KG" , 17, true, false, TEXT_ALIGN_RIGHT, EFB_WHITE)
    drawTextCentered(Font_Airbus_panel,  630 ,426 - 52 * 3, tostring(aft_cargo_weight).." KG" , 17, true, false, TEXT_ALIGN_RIGHT, EFB_WHITE)
    drawTextCentered(Font_Airbus_panel,  630 ,426 - 52 * 4, tostring(bulk_cargo_weight).." KG" , 17, true, false, TEXT_ALIGN_RIGHT, EFB_WHITE)
    drawTextCentered(Font_Airbus_panel,  630 ,426 - 52 * 5, tostring(fuel_weight).." KG" , 17, true, false, TEXT_ALIGN_RIGHT, EFB_WHITE)

    passenger_weight = number_to_loadsheet_format(passenger_weight)
    fwd_cargo_weight = number_to_loadsheet_format(fwd_cargo_weight)
    aft_cargo_weight = number_to_loadsheet_format(aft_cargo_weight)
    bulk_cargo_weight = number_to_loadsheet_format(bulk_cargo_weight)
    fuel_weight = number_to_loadsheet_format(fuel_weight)
    total_traffic_load = number_to_loadsheet_format(total_traffic_load)
    dow = number_to_loadsheet_format(dow)
    tow = Fwd_string_fill(tostring(tow), "0", 6)


    local colour = touched_sliders_after_loading and ECAM_YELLOW or EFB_LIGHTBLUE

    for i=1, 5 do
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,480 - 157/6*0 -99   , string.sub(passenger_weight, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,480 - 157/6*1 -99   , string.sub(fwd_cargo_weight, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,480 - 157/6*2 -99   , string.sub(aft_cargo_weight, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,480 - 157/6*3 -99   , string.sub(bulk_cargo_weight, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,480 - 157/6*4 -99   , string.sub("00000", i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,480 - 157/6*5 -99   , string.sub(total_traffic_load, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,317           -99   , string.sub(dow, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,273 - 157/6*0 -99   , string.sub(zfw, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
        drawTextCentered(Font_ECAMfont,  933 + (i-1)*118/4 ,243           -99   , string.sub(fuel_weight, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, colour)
    end

    drawTextCentered(Font_ECAMfont, 721+35,436, Round_fill(WEIGHTS.get_current_cg_perc(),1).."%" , 20, true, false, TEXT_ALIGN_CENTER, colour)

    for i=1, 6 do
        drawTextCentered(Font_ECAMfont,  933 + (i-2)*118/4 ,203 -99            , string.sub(tow, i,i) , 17, true, false, TEXT_ALIGN_RIGHT, overweight and ECAM_RED or colour)
    end

    local text = touched_sliders_after_loading and "WEIGHTS NOT APPLIED" or "WEIGHTS APPLIED" 
    text = overweight and "ACFT OVERWEIGHT" or text
    drawTextCentered(Font_ECAMfont,  963 ,429, text, 22, true, false, TEXT_ALIGN_CENTER, overweight and ECAM_RED or colour)
end

local function draw_sliders(x,y,i)

    if i ~= 2 then
        sasl.gl.drawRectangle( 52 ,399 - (i-1)*52,  560 * slider_pos[i],     15, EFB_DARKGREY)
    elseif slider_pos[2] > 0.5 then
        sasl.gl.drawRectangle( 52+560/2 ,399 - (i-1)*52,  560 * (slider_pos[i]-0.5),     15, EFB_DARKGREY)
    elseif slider_pos[2] < 0.5 then
        sasl.gl.drawRectangle( 52+560/2+ 560 * (slider_pos[i]-0.5) ,399 - (i-1)*52,  -560 * (slider_pos[i]-0.5),     15, EFB_DARKGREY)
    end

    local cursor_is_near_slider = within(EFB_CURSOR_X,(x-2)+ 560 * slider_pos[i],(x-2)+30+ 560 * slider_pos[i]) and within(EFB_CURSOR_Y,y-2,y-2+19) 
    if cursor_is_near_slider or focused_slider == i then
        sasl.gl.drawRectangle( (x-2)+ 560 * slider_pos[i] + (1-slider_pos[i]) - 1,   y-2,      29 + 1,     18 + 1, focused_slider == i and EFB_SLIDER_COLOUR or EFB_WHITE)
    end
    sasl.gl.drawRectangle(      x + 559 * slider_pos[i],        y,      26,     15,  focused_slider == i and EFB_SLIDER_COLOUR or EFB_LIGHTBLUE)
end

local function EFB_p3s1_onmousedown(x,y,i) --the mose down function is put inside the button loop
    if within(EFB_CURSOR_X,(x-2)+ 560 * slider_pos[i],(x-2)+30+ 560 * slider_pos[i]) and within(EFB_CURSOR_Y,y-2,y-2+19) then
        focused_slider = i
        touched_sliders_after_loading = true
    end
end

function EFB_p3s1_onmouseup()
    focused_slider = 0
end

local function EFB_p3s1_move_slider()
    if focused_slider ~= 0 then
        slider_pos[focused_slider] = Math_rescale(52 + 13, 0, 52+560 + 13, 1, EFB_CURSOR_X)
    end
end

local function reset_slider_when_mouse_leave()
    if not EFB_CURSOR_on_screen then
        focused_slider = 0
    end
end

local function slider_to_weights_translator()
    slider_actual_values[1] = Math_rescale(0, 0, 1, WEIGHT_MAX_PASSENGERS, slider_pos[1])
    slider_actual_values[2] = slider_pos[2]
    slider_actual_values[3] = Math_rescale(0, 0, 1, WEIGHT_MAX_FWD_CARGO, slider_pos[3])
    slider_actual_values[4] = Math_rescale(0, 0, 1, WEIGHT_MAX_AFT_CARGO, slider_pos[4])
    slider_actual_values[5] = Math_rescale(0, 0, 1, WEIGHT_MAX_BULK_CARGO, slider_pos[5])
    slider_actual_values[6] = Math_rescale(0, 0, 1, FUEL_TOT_MAX, slider_pos[6])
    for i=1, 6 do
        if i == 1 then
            slider_actual_values[i] = math.floor(slider_actual_values[i])
        elseif i == 2 then
            --do nothing
        else
            slider_actual_values[i] = Round(slider_actual_values[i],-2)
        end
    end

    slider_actual_values[6] = slider_actual_values[6] >= 31085 and 31085 or slider_actual_values[6] 

    -- Sooooooooooo
    -- Rico made things very complicated lol
    -- when I round the fuel value, FUEL_TOT_MAX = 31085 is rounded to 31000
    -- Then his assert function in the set_fuel() denied me setting it as 31000, and the script crashes
    -- this line is to prevent the maximum fuel after rounding to exceed 31085 no matter what
end

local function set_values()
    touched_sliders_after_loading = false
    local CG_effect = (1-slider_actual_values[1]/WEIGHT_MAX_PASSENGERS)/2
    WEIGHTS.set_passengers_weight(Round(slider_actual_values[1]/WEIGHT_PER_PASSENGER,0)*WEIGHT_PER_PASSENGER ,(slider_actual_values[2]-0.5) * CG_effect + 0.5)
    WEIGHTS.set_fwd_cargo_weight(slider_actual_values[3])
    WEIGHTS.set_aft_cargo_weight(slider_actual_values[4])
    WEIGHTS.set_bulk_cargo_weight(slider_actual_values[5])
    set_fuel(slider_actual_values[6])
    -- so long story short, there was an issue which set_fuel(40000) will only add 39990 kg of fuel
    --the issue is not in this script, it is rico's set fuel function.
    --therefore, for every 40000 kg of fuel, 10 kg has to be added.
    --that is where 10 * (slider_actual_values[6]/40000)  come from
end

----------------KEYOARD STUFF

local function set_takeoff_runway_data_to_global()
    if AvionicsBay.is_initialized() and AvionicsBay.is_ready() then
        local apts = AvionicsBay.apts.get_by_name(deparr_apts[1])
        if #apts > 0 then    -- If the airport exists
        local apt = apts[1] 

            local selected1 = Round(dropdown_selected[1]/2, 0)
            if selected1 > 0 and apt ~= nil then
                local bearing = apt.rwys[selected1].bearing
                if Round(dropdown_selected[1]/2, 0) == dropdown_selected[1]/2 then
                    set(TOPCAT_torwy_bearing, apt.rwys[selected1].bearing + 180)
                    set(TOPCAT_torwy_length, apt.rwys[selected1].distance)
                else
                    set(TOPCAT_torwy_bearing, apt.rwys[selected1].bearing)
                    set(TOPCAT_torwy_length, apt.rwys[selected1].distance)
                end
            end
        end 
    end
end

local function set_landing_runway_data_to_global()
    if AvionicsBay.is_initialized() and AvionicsBay.is_ready() then
        local apts = AvionicsBay.apts.get_by_name(deparr_apts[2])
        if #apts > 0 then    -- If the airport exists
        local apt = apts[1] 

            local selected2 = Round(dropdown_selected[2]/2, 0)
            if selected2 > 0 and apt ~= nil then
                local bearing = apt.rwys[selected2].bearing
                if Round(dropdown_selected[2]/2, 0) == dropdown_selected[2]/2 then
                    set(TOPCAT_ldgrwy_bearing, apt.rwys[selected2].bearing + 180)
                    set(TOPCAT_ldgrwy_length, apt.rwys[selected2].distance)
                else
                    set(TOPCAT_ldgrwy_bearing, apt.rwys[selected2].bearing)
                    set(TOPCAT_ldgrwy_length, apt.rwys[selected2].distance)
                end
                set(TOPCAT_ldgrwy_elev, apt.alt)
            end
        end 
    end
end

local airport_reset_flags = {true,true} -- 1 is dep 2 is arr
local function request_departure_runway_data()
    if AvionicsBay.is_initialized() and AvionicsBay.is_ready() and not airport_reset_flags[1] then
        local apts = AvionicsBay.apts.get_by_name(deparr_apts[1])
        if #apts > 0 then    -- If the airport exists
            local apt = apts[1]    -- Take the airport
            dropdown_1 = {} -- CLEAR IT FIRST
            for i=1, #apt.rwys do
                table.insert(dropdown_1, apt.rwys[i].name) 
                table.insert(dropdown_1, apt.rwys[i].sibl_name) 
                set_takeoff_runway_data_to_global() -- SET THE RUNWAY DATA AFTER PLUGGING IN THE TABLE, SO THAT THE NUMBERS DO NOT REMAIN IN 0,0 IN CASE THE USER DOESN'T TOUCH THE DROPDOWN AT ALL
            end
        end
        airport_reset_flags[1] = true
        avionics_bay_is_initialising = false
    elseif not airport_reset_flags[1] then
        avionics_bay_is_initialising = true
    end
end

local function request_arrival_runway_data()
    if AvionicsBay.is_initialized() and AvionicsBay.is_ready() and not airport_reset_flags[2] then
        local apts = AvionicsBay.apts.get_by_name(deparr_apts[2])
        if #apts > 0 then    -- If the airport exists
            local apt = apts[1]    -- Take the airport
            dropdown_2 = {} -- CLEAR IT FIRST
            for i=1, #apt.rwys do

                table.insert(dropdown_2, apt.rwys[i].name) 
                table.insert(dropdown_2, apt.rwys[i].sibl_name) 
                set_landing_runway_data_to_global() -- SET THE RUNWAY DATA AFTER PLUGGING IN THE TABLE, SO THAT THE NUMBERS DO NOT REMAIN IN 0,0 IN CASE THE USER DOESN'T TOUCH THE DROPDOWN AT ALL
            end
        end
        airport_reset_flags[2] = true
        avionics_bay_is_initialising = false
    elseif not airport_reset_flags[2] then
        avionics_bay_is_initialising = true
    end
end

local function p3s1_dropdown_buttons( x,y,w,h, table, identifier)
    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, x - w/2, y-h/2,x + w/2, y + h/2,function ()
        dropdown_expanded[identifier] = not dropdown_expanded[identifier]
    end)
    for i=1, #table do
        if dropdown_expanded[identifier] then
            Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, x - w/2 + 5, y - h*i - 14, w-10 + ( x - w/2 + 5), h-2 + ( y - h*i - 14),function ()
                dropdown_selected[identifier] = i
                dropdown_expanded[identifier] = false
                set_takeoff_runway_data_to_global()--EVERYTIME THE USER CLICKS THE RUNWAY DROPDOWN MENU, IT REQUESTS THE RUNWAY DATA ONCE. THAT IS THE ONLY WAY I CAN THINK OF TO REFRESH RUNWAY DATA WITHOUT USING UPDATE LOOP.
                set_landing_runway_data_to_global()
            end)
        end
    end
    if dropdown_expanded[identifier] then
        I_hate_button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, x - w/2, y-h/2,x + w/2, y + h/2,function ()
            dropdown_expanded[identifier] = false
        end)
    end
end

local function draw_avionics_bay_standby()
    if avionics_bay_is_initialising then
        draw_standby_screen("INITIALISING AVIONICS BAY....")
    end
end

local function p3s1_plug_in_the_buffer()
    if key_p3s1_focus == 7 then
        if string.len(key_p3s1_buffer) <= 3 then --IF THE LENGTH OF THE STRING IS 0, THEN REVERT TO THE PREVIOUS VALUE. ELSE, PLUG-IN THE NEW VALUE.
            key_p3s1_focus = 0
            key_p3s1_buffer = ""
        else
            deparr_apts[1] = key_p3s1_buffer --PLUG THE SCRATCHPAD INTO THE ACTUAL TARGET AIRPORT
            key_p3s1_focus = 0
            key_p3s1_buffer = ""
            airport_reset_flags[1] = false
        end
    elseif key_p3s1_focus == 8 then
        if string.len(key_p3s1_buffer) <= 3 then --IF THE LENGTH OF THE STRING IS 0, THEN REVERT TO THE PREVIOUS VALUE. ELSE, PLUG-IN THE NEW VALUE.
            key_p3s1_focus = 0
            key_p3s1_buffer = ""
        else
            deparr_apts[2] = key_p3s1_buffer --PLUG THE SCRATCHPAD INTO THE ACTUAL TARGET AIRPORT
            key_p3s1_focus = 0
            key_p3s1_buffer = ""
            airport_reset_flags[2] = false
        end
    end
end

function p3s1_revert_to_previous_and_delete_buffer()
    key_p3s1_focus = 0
    key_p3s1_buffer = ""
end

local function p3s1_construct_the_buffer(char)
    if key_p3s1_focus < 7 then
        local read_n = tonumber(string.char(char)) --JUST TO MAKE SURE WHAT YOU TYPE IS A NUMBER
        if read_n ~= nil and string.len(key_p3s1_buffer) < 7 then -- "tonumber()" RETURNS nil IF NOT A NUMBER, ALSO MAKES SURE STRING LENGTH IS <7
            key_p3s1_buffer = key_p3s1_buffer..string.char(char)
        end
    elseif key_p3s1_focus >= 7 then
        local read_n = tonumber(string.char(char)) --JUST TO MAKE SURE WHAT YOU TYPE IS AN ALPHABET
        if read_n == nil and string.len(key_p3s1_buffer) < 7 then -- "tonumber()" RETURNS nil IF NOT A NUMBER, ALSO MAKES SURE STRING LENGTH IS <7
            key_p3s1_buffer = string.upper(key_p3s1_buffer..string.char(char))
        end
    end
end

function EFB_onKeyDown_page3_subpage_1(component, char, key, shiftDown, ctrlDown, altOptDown)
    if efb_subpage_number == 1 then
        if key_p3s1_focus == 0 then
            return false
        end
            if char == SASL_KEY_DELETE then --BACKSPACE
                key_p3s1_buffer = string.sub(key_p3s1_buffer, 1, -2)
            elseif char == SASL_VK_RETURN then --ENTER
                p3s1_plug_in_the_buffer()
            elseif char == SASL_VK_ESCAPE then --REVERT TO THE PREVIOUS VALUE.
                p3s1_revert_to_previous_and_delete_buffer()
            else
                p3s1_construct_the_buffer(char)
            end
        return true
    end
end


--------------------------------------------------------------------------------------------------------------------------------SUBPAGE 1

local function load_weights_from_file()
end

local function draw_focus_frame()
    if key_p3s1_focus == 7 then
        efb_draw_focus_frames(71, 565, 93, 27)
    elseif key_p3s1_focus == 8 then
        efb_draw_focus_frames(357, 565, 93, 27)
    end
end

local function runway_related_buttons()
    --------------------------------BELOW ARE FOR RUNWAY SELECTION FOR PERF!!!!!!!!!!!!!!!!!!!!!!!!
    --------------------------------BELOW ARE FOR RUNWAY SELECTION FOR PERF!!!!!!!!!!!!!!!!!!!!!!!!

    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, 71 , 565, 163, 591,function ()
        p3s1_plug_in_the_buffer()
        key_p3s1_focus = key_p3s1_focus == 7 and 0 or 7
    end)
    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, 357 , 565, 449, 591,function ()
        p3s1_plug_in_the_buffer()
        key_p3s1_focus = key_p3s1_focus == 8 and 0 or 8
    end)

    if key_p3s1_focus == 7 then
        click_anywhere_except_that_area( 71 , 565, 163, 591, p3s1_plug_in_the_buffer)
    elseif key_p3s1_focus == 8 then
        click_anywhere_except_that_area( 357, 565, 449, 591, p3s1_plug_in_the_buffer)
    end

    p3s1_dropdown_buttons(230, 578, 90, 28,    dropdown_1, 1)
    p3s1_dropdown_buttons(511, 578, 90, 28,    dropdown_2, 2)

    --------------------------------ABOVE ARE FOR RUNWAY SELECTION FOR PERF!!!!!!!!!!!!!!!!!!!!!!!!
    --------------------------------ABOVE ARE FOR RUNWAY SELECTION FOR PERF!!!!!!!!!!!!!!!!!!!!!!!!
end

local function draw_dropdowns()
    if string.len(key_p3s1_buffer) > 0 then --THE PURPOSE OF THIS IFELSE IS TO PREVENT THE CURSOR FROM COVERING UP THE PREVIOUS VALUE, WHEN THE SCRATCHPAD IS EMPTY.
        drawTextCentered( Font_ECAMfont , 116 , 578, key_p3s1_focus == 7 and key_p3s1_buffer or deparr_apts[1] , 20 ,false , false , TEXT_ALIGN_CENTER , EFB_FULL_GREEN )
        drawTextCentered( Font_ECAMfont , 403 , 578, key_p3s1_focus == 8 and key_p3s1_buffer or deparr_apts[2] , 20 ,false , false , TEXT_ALIGN_CENTER , EFB_FULL_GREEN )
    else
        drawTextCentered( Font_ECAMfont , 116 , 578, deparr_apts[1] , 20 ,false , false , TEXT_ALIGN_CENTER , EFB_FULL_GREEN )
        drawTextCentered( Font_ECAMfont , 403 , 578, deparr_apts[2] , 20 ,false , false , TEXT_ALIGN_CENTER , EFB_FULL_GREEN )
    end

    draw_dropdown_menu(230, 578, 90, 28, EFB_DROPDOWN_OUTSIDE, EFB_DROPDOWN_INSIDE, dropdown_1, dropdown_expanded[1], dropdown_selected[1])
    draw_dropdown_menu(511, 578, 90, 28, EFB_DROPDOWN_OUTSIDE, EFB_DROPDOWN_INSIDE, dropdown_2, dropdown_expanded[2], dropdown_selected[2])

end

local function draw_buttons()
    if get(TIME) -  load_button_begin > BUTTON_PRESS_TIME then
        SASL_drawSegmentedImg_xcenter_aligned (EFB_LOAD_s3_generate_button, 200,70,368,32,2,1)
    else
        SASL_drawSegmentedImg_xcenter_aligned (EFB_LOAD_s3_generate_button, 200,70,368,32,2,2)
    end

    if get(TIME) -  reset_button_begin > BUTTON_PRESS_TIME then
        SASL_drawSegmentedImg_xcenter_aligned (EFB_LOAD_s3_generate_button, 200 + 280,70,368,32,2,1)
    else
        SASL_drawSegmentedImg_xcenter_aligned (EFB_LOAD_s3_generate_button, 200 + 280,70,368,32,2,2)
    end

    drawTextCentered(Font_Airbus_panel,  197 ,85, "LOAD AIRCRAFT" , 18, true, false, TEXT_ALIGN_CENTER, EFB_BACKGROUND_COLOUR)
    drawTextCentered(Font_Airbus_panel,  479 ,85, "RESET DEFAULTS" , 18, true, false, TEXT_ALIGN_CENTER, EFB_BACKGROUND_COLOUR)
end


--------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------BELOW ARE THE LOOPS AND BUTTONS
--------------------------------------------------------------------------------------------------------------------------------


local function Subpage_1_buttons()
    runway_related_buttons()
    for i=1, 6 do
        EFB_p3s1_onmousedown(52,399 - (i-1)*52,i) 
    end

    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, 108,70,108+368/2,70+32,function () --refresh
        load_button_begin = get(TIME)
        set_values()
    end)

    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, 108+280,70,108+368/2+280,70+32,function () --refresh
        reset_button_begin = get(TIME)
        slider_pos[1] = 0
        slider_pos[2] = 0.5
        slider_pos[3] = 0
        slider_pos[4] = 0
        slider_pos[5] = 0
        slider_pos[6] = 5000/FUEL_TOT_MAX
        slider_to_weights_translator()
        set_values()
    end)

end

local function EFB_update_page_3_subpage_1() --UPDATE LOOP
    EFB_p3s1_move_slider()
    reset_slider_when_mouse_leave()
    slider_to_weights_translator()
    request_departure_runway_data()
    request_arrival_runway_data()
end

local function EFB_draw_page_3_subpage_1() -- DRAW LOOP

    draw_each_component_UI()

    sasl.gl.drawTexture (EFB_LOAD_bgd, 0 , 0 , 1143 , 800 , EFB_WHITE )

    for i=1, 6 do
        draw_sliders(52,399 - (i-1)*52, i)
    end

    draw_slider_corresponding_values()

    draw_dropdowns()

    draw_focus_frame()
    draw_buttons()
    draw_avionics_bay_standby()

--------------------------------------------------------------------------
end

-------------------------------------------------------------------------------
-- Initialization
-------------------------------------------------------------------------------
local function initialize()
end

initialize()

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SUBPAGE 2

local function EFB_draw_page_3_subpage_2() --DRAW LOOP
    p3s2_draw()
end

local function EFB_update_page_3_subpage_2() --UPDATE LOOP
    p3s2_update()
end

local function Subpage_2_buttons()
    p3s2_buttons()
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------SUBPAGE 3

local function EFB_draw_page_3_subpage_3() --DRAW LOOP
    p3s3_draw()
end

local function EFB_update_page_3_subpage_3() --UPDATE LOOP
    p3s3_update()
end

local function Subpage_3_buttons()
    p3s3_buttons()
end


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------MUTUAL LOOPS

local function mutual_button_loop()
    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, 1031,18,1099,48, function () --SELECTOR BUTTONS WORK AT ALL TIMES
        efb_subpage_number = math.min(efb_subpage_number + 1, NUMBER_OF_SUBPAGES)
        key_p3s1_focus = 0
        key_p3s1_buffer = ""
    end)
    Button_check_and_action(EFB_CURSOR_X, EFB_CURSOR_Y, 954,18,1021,48, function ()
        efb_subpage_number = math.max( efb_subpage_number - 1, 1)
    end)
end

local function mutual_update_loop()
end

local function mutual_draw_loop()
    SASL_draw_img_center_aligned (EFB_INFO_selector, 1026,33, 147, 32, EFB_WHITE) -- THIS IS THE SELECTOR, IT DRAWS ON ALL PAGES

        sasl.gl.drawText ( Font_Airbus_panel , 880 , 24 , "Page "..efb_subpage_number.."/"..NUMBER_OF_SUBPAGES.."", 20 , false , false , TEXT_ALIGN_CENTER , EFB_WHITE)

end

-------------------------------------------------------------------------------
-- Main Functions
-------------------------------------------------------------------------------


function EFB_execute_page_3_buttons()

    if  efb_subpage_number == 1 then
        Subpage_1_buttons()
    elseif efb_subpage_number == 2 then
        Subpage_2_buttons()
    elseif efb_subpage_number == 3 then
        Subpage_3_buttons()
    end

    mutual_button_loop()
end

--UPDATE LOOPS--
function EFB_update_page_3()

    if efb_subpage_number == 1 then
        EFB_update_page_3_subpage_1()
    elseif efb_subpage_number == 2 then
        EFB_update_page_3_subpage_2()
    elseif efb_subpage_number == 3 then
        EFB_update_page_3_subpage_3()
    end
    mutual_update_loop()
end

--DRAW LOOPS--
function EFB_draw_page_3()
    if efb_subpage_number == 1 then
        EFB_draw_page_3_subpage_1()
    elseif efb_subpage_number == 2 then
        EFB_draw_page_3_subpage_2()
    elseif efb_subpage_number == 3 then
        EFB_draw_page_3_subpage_3()
    end
    mutual_draw_loop()
end

