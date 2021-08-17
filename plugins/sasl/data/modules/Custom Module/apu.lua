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
-- File: apu.lua 
-- Short description: APU-related part (see also fuel, electrical and bleed)
-------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- APU management file
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Constants
----------------------------------------------------------------------------------------------------

local FLAP_OPEN_TIME_SEC = 20
local FLAP_CLOSE_N2 = 5         -- flap does not close immediately on master switch off but based on N2
local APU_START_WAIT_TIME = 5
local APU_TEST_TIME = 20

----------------------------------------------------------------------------------------------------
-- Global variables
----------------------------------------------------------------------------------------------------
local master_switch_status  = false    -- master switch is a toggle push button, actual status controlled by logic
local master_switch_disabled_time = 0  -- startup and shutdown sequence is driven by some timers for some situations
local master_switch_enabled_time = 0
local start_requested = false
local master_is_on_time = 0
local test_in_progress = false
local test_is_ok       = false

local random_egt_apu = 0
local random_egt_apu_last_update = 0
----------------------------------------------------------------------------------------------------
-- Init
----------------------------------------------------------------------------------------------------
function onAirportLoaded()
    set(Apu_bleed_xplane, 0)
    set(APU_EGT, get(OTA))
end
----------------------------------------------------------------------------------------------------
-- Command handlers
----------------------------------------------------------------------------------------------------
sasl.registerCommandHandler ( APU_cmd_master, 0 , function(phase)
    if phase == SASL_COMMAND_BEGIN then
        if master_switch_status then
            if master_switch_disabled_time ~= 0 then 
                master_switch_disabled_time = 0
            else
                master_switch_disabled_time = get(TIME)
            end
        else
            master_is_on_time = get(TIME)
            master_switch_status = true
            if master_switch_disabled_time == 0 then
                master_switch_enabled_time = get(TIME)
            end
        end
    end
end)

sasl.registerCommandHandler ( APU_cmd_start, 0 , function(phase)
    if phase == SASL_COMMAND_BEGIN then
        if master_switch_status then
            start_requested = true
        end
    end
    return 1
end)

sasl.registerCommandHandler ( MNTN_APU_test, 0 , function(phase)
    if phase == SASL_COMMAND_BEGIN then
        test_in_progress = not test_in_progress
    end
    return 1
end)

sasl.registerCommandHandler ( MNTN_APU_reset, 0 , function(phase)
    if phase == SASL_COMMAND_BEGIN then
        test_in_progress = false
        test_is_ok = false
    end
    return 1
end)

----------------------------------------------------------------------------------------------------
-- Various functions
----------------------------------------------------------------------------------------------------

function update_egt()

    if get(TIME) - random_egt_apu_last_update > 2 then
        random_egt_apu = math.random() * 6 - 3
        random_egt_apu_last_update = get(TIME)
    end

    local apu_n1 = get(Apu_N1)

    if master_switch_status and get(FAILURE_ENG_APU_FAIL) == 0 then
        if apu_n1 < 1 then
            Set_dataref_linear_anim(APU_EGT, get(OTA), -50, 1000, 1)
        elseif apu_n1 <= 25 then
             local target_egt = Math_rescale(0, get(OTA), 25, 900+random_egt_apu, apu_n1)
            Set_dataref_linear_anim(APU_EGT, target_egt, -50, 1000, 50)
        elseif apu_n1 <= 50 then
            local target_egt = Math_rescale(25, 900, 50,  800+random_egt_apu, apu_n1)
            Set_dataref_linear_anim(APU_EGT, target_egt, -50, 1000, 50)
        elseif apu_n1 > 50 then
            local target_egt = Math_rescale(50, 800, 100, 400+random_egt_apu, apu_n1)
            Set_dataref_linear_anim(APU_EGT, target_egt, -50, 1000, 50)
        end
    else
        Set_dataref_linear_anim(APU_EGT, get(OTA), -50, 1000, 3)
    end
end

local function single_battery_condition_fault()
    return (ELEC_sys.batteries[1].is_connected_to_dc_bus and not ELEC_sys.batteries[2].is_connected_to_dc_bus)
        or (not ELEC_sys.batteries[1].is_connected_to_dc_bus and ELEC_sys.batteries[2].is_connected_to_dc_bus)
end

local function update_button_datarefs()

    local is_faulty = get(FAILURE_ENG_APU_FAIL) == 1 or get(DC_bat_bus_pwrd) == 0 or single_battery_condition_fault()

    set(Apu_master_button_state,(master_switch_status and 1 or 0))

    pb_set(PB.ovhd.apu_master, master_switch_status and master_switch_disabled_time == 0, is_faulty)
    pb_set(PB.ovhd.apu_start, start_requested and (get(TIME) - master_is_on_time > APU_START_WAIT_TIME) , get(Apu_avail) == 1)

end

local function update_apu_flap()
    local elec_ok = get(DC_bat_bus_pwrd) == 1
    local apu_n1 = get(Apu_N1)
    if master_switch_status and elec_ok then
        if get(TIME) - master_switch_enabled_time > FLAP_OPEN_TIME_SEC then
            set(APU_flap, 1)
        else
            -- flap open delay not yet reached, keep it closed TODO what kind of power consumption is added here?
            ELEC_sys.add_power_consumption(ELEC_BUS_DC_BAT_BUS, 1, 2)   -- Guess
            set(APU_flap, 0)
        end
        Set_dataref_linear_anim(APU_flap_open_pos, 1, 0, 1, 1/FLAP_OPEN_TIME_SEC)
    else
        if elec_ok then
            -- Cannot move if not powered
            Set_dataref_linear_anim(APU_flap_open_pos, 0, 0, 1, 1/FLAP_OPEN_TIME_SEC)
            if get(APU_flap_open_pos) > 0 then
                ELEC_sys.add_power_consumption(ELEC_BUS_DC_BAT_BUS, 1, 2)   -- Guess
            end
        end
        -- APU flap closes only below a certain N1, see https://www.youtube.com/watch?v=Ye8y90KD1JA
        if apu_n1 < FLAP_CLOSE_N2 then set(APU_flap, 0) end
    end
end

local function update_start()
    if master_switch_status and get(FAILURE_ENG_APU_FAIL) == 0 and not test_in_progress and get(Fire_pb_APU_status) == 0 then 

        if start_requested and get(APU_flap) == 1 and get(Apu_avail) == 0 and get(DC_bat_bus_pwrd) == 1 and get(Apu_fuel_source) > 0 and not single_battery_condition_fault() then
            set(Apu_start_position, 2)
        elseif get(Apu_avail) == 1 and get(Apu_fuel_source) > 0 then
            set(Apu_start_position, 1)
            start_requested = false
        else
            set(Apu_start_position, 0)
        end
    else
        set(Apu_start_position, 0)
        start_requested = false
    end
end

local function update_gen()
    if not master_switch_status or get(FAILURE_ENG_APU_FAIL) == 1 then
        set(Ecam_apu_gen_state, 0)
    else
        if ELEC_sys.generators[3].switch_status == false then
            set(Ecam_apu_gen_state, 1)
        elseif ELEC_sys.generators[3].curr_voltage > 105 and ELEC_sys.generators[3].curr_hz > 385 then
            set(Ecam_apu_gen_state, 2)
        else
            set(Ecam_apu_gen_state, 3)
        end
    end
end

local function update_off_status()

    if master_switch_disabled_time ~= 0 then
        -- master switch turned off some time before
        if get(TIME) - master_switch_disabled_time > 60 or not PB.ovhd.ac_bleed_apu.status_bottom then
            -- in case APU bleed has been used actual shutdown will be delayed
            master_switch_status = false
            master_switch_disabled_time = 0
        end
    end

    -- Emergency shutdown
    if get(FAILURE_FIRE_APU) == 1 then
        master_switch_status = false
    end

end

function update_maintainence()

    if test_in_progress and master_switch_status then
        if test_start_time == 0 then
            test_start_time = get(TIME)
        end
        if get(TIME) - test_start_time > APU_TEST_TIME then
            test_is_ok = true
        end
    else
        test_start_time = 0
    end

    pb_set(PB.ovhd.mntn_apu_test, test_in_progress, test_is_ok)
end


----------------------------------------------------------------------------------------------------
-- update()
----------------------------------------------------------------------------------------------------
function update()

    perf_measure_start("apu:update()")

    --apu availability
    if get(Apu_N1) > 95 then
        set(Apu_avail, 1)
    elseif get(Apu_N1) < 100 then
        set(Apu_avail, 0)
    end

    update_off_status()
    update_egt()
    update_button_datarefs()
    update_apu_flap()
    update_start()
    update_gen()
    update_maintainence()
    
    perf_measure_stop("apu:update()")
end
