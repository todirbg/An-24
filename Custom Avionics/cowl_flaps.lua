-- this is cowl flaps logic
size = {2048, 2048}
defineProperty("frame_time", globalPropertyf("an-24/time/frame_time")) -- time for frames

defineProperty("flap1_sw", globalPropertyf("an-24/cowl/flap_switch_L"))  -- cowl flap manipulator switch
defineProperty("flap2_sw", globalPropertyf("an-24/cowl/flap_switch_R")) -- cowl flap manipulator switch

defineProperty("flap1", globalPropertyf("sim/flightmodel/engine/ENGN_cowl[0]")) -- current position
defineProperty("flap2", globalPropertyf("sim/flightmodel/engine/ENGN_cowl[1]"))	-- current position

defineProperty("flap1_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[0]")) -- sim manipulators
defineProperty("flap2_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[1]")) -- sim manipulators

defineProperty("flap3_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[2]")) -- sim manipulators
defineProperty("flap4_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[3]")) -- sim manipulators
defineProperty("flap5_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[4]")) -- sim manipulators
defineProperty("flap6_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[5]")) -- sim manipulators
defineProperty("flap7_sim", globalPropertyf("sim/cockpit2/engine/actuators/cowl_flap_ratio[6]")) -- sim manipulators

--defineProperty("oil_t_1", globalPropertyf("sim/cockpit2/engine/indicators/oil_temperature_deg_C[0]"))
--defineProperty("oil_t_2", globalPropertyf("sim/cockpit2/engine/indicators/oil_temperature_deg_C[1]"))

defineProperty("oil_t_1", globalPropertyf("an-24/engines/oil_temp_left"))
defineProperty("oil_t_2", globalPropertyf("an-24/engines/oil_temp_right"))


-- power
defineProperty("bus_DC_27_volt", globalPropertyf("an-24/power/bus_DC_27_volt"))


--local switch_sound = loadSample('sounds/custom/metal_switch.wav')
--local switcher_pushed = false

registerCommandHandler(createCommand("An-24/Engine/oilr_left_auto", "Oil radiator left auto."), 0, function(p) if p == 0 and get(flap1_sw) ~= 1 then set(flap1_sw, 1) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_left_off", "Oil radiator left off."), 0, function(p) if p == 0 and get(flap1_sw) ~= 0 then set(flap1_sw, 0) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_left_open", "Oil radiator left open."), 0, function(p) if p ~= 2 then set(flap1_sw, 2) else set(flap1_sw, 0) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_left_close", "Oil radiator left close."), 0, function(p) if p ~= 2 then set(flap1_sw, 3) else set(flap1_sw, 0) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_right_auto", "Oil radiator right auto."), 0, function(p) if p == 0 and get(flap2_sw) ~= 1 then set(flap2_sw, 1) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_right_off", "Oil radiator right off."), 0, function(p) if p == 0 and get(flap2_sw) ~= 0 then set(flap2_sw, 0) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_right_open", "Oil radiator right open."), 0, function(p) if p ~= 2 then set(flap2_sw, 2) else set(flap2_sw, 0) end return 0 end)
registerCommandHandler(createCommand("An-24/Engine/oilr_right_close", "Oil radiator right close."), 0, function(p) if p ~= 2 then set(flap2_sw, 3) else set(flap2_sw, 0) end return 0 end)


function update()

	-- cowl flaps switchers has 4 positions:
	-- 0 = neutral, 1 = auto, 2 = close, 3 = open
	local passed = get(frame_time)
	local power = get(bus_DC_27_volt) > 21
	-- left engine
	local flap_L = get(flap1)
	local switch_L = get(flap1_sw)
	local oil_t_L = get(oil_t_1)
	if power then
		if switch_L == 1 then -- automatic mode
			if oil_t_L > 75 then flap_L = flap_L + passed * 0.01
			elseif oil_t_L < 65 then flap_L = flap_L - passed * 0.01 end
		elseif switch_L == 2 then flap_L = flap_L - passed * 0.1 -- close
		elseif switch_L == 3 then flap_L = flap_L + passed * 0.1 -- open
		end
	end
	-- set linits
	if flap_L > 1 then flap_L = 1
	elseif flap_L < 0 then flap_L = 0 end
	
	-- right engine
	local flap_R = get(flap2)
	local switch_R = get(flap2_sw)
	local oil_t_R = get(oil_t_2)
	if power then
		if switch_R == 1 then -- automatic mode
			if oil_t_R > 75 then flap_R = flap_R + passed * 0.01
			elseif oil_t_R < 65 then flap_R = flap_R - passed * 0.01 end
		elseif switch_R == 2 then flap_R = flap_R - passed * 0.1 -- close
		elseif switch_R == 3 then flap_R = flap_R + passed * 0.1 -- open
		end
	end
	-- set linits
	if flap_R > 1 then flap_R = 1
	elseif flap_R < 0 then flap_R = 0 end
	
	-- set results	
	set(flap1_sim, flap_L)
	set(flap2_sim, flap_R)
	set(flap3_sim, flap_R)
	set(flap4_sim, flap_R)
	set(flap5_sim, flap_R)
	set(flap6_sim, flap_R)
	set(flap7_sim, flap_R)
end

--[[
components = {

	-- left engine
    -- switcher UP
	clickable {
        position = { 842, 316, 17, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not switcher_pushed then
				switcher_pushed = true
				playSample(switch_sound, 0)
				if get(flap1_sw) ~= 1 then set(flap1_sw, 1)
				else set(flap1_sw, 0) end
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    -- switcher LEFT
	clickable {
        position = { 842, 307, 8, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not switcher_pushed then
				switcher_pushed = true
				playSample(switch_sound, 0)
				set(flap1_sw, 2)
			end
			return true
		end,
		onMouseUp = function()
			set(flap1_sw, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end,
    },
    -- switcher RIGHT
	clickable {
        position = { 851, 307, 8, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not switcher_pushed then
				switcher_pushed = true
				playSample(switch_sound, 0)
				set(flap1_sw, 3)
			end
			return true
		end,
		onMouseUp = function()
			set(flap1_sw, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end,
    },

	
	-- right engine
    -- switcher UP
	clickable {
        position = { 860, 316, 17, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not switcher_pushed then
				switcher_pushed = true
				playSample(switch_sound, 0)
				if get(flap2_sw) ~= 1 then set(flap2_sw, 1)
				else set(flap2_sw, 0) end
			end
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    -- switcher LEFT
	clickable {
        position = { 860, 307, 8, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not switcher_pushed then
				switcher_pushed = true
				playSample(switch_sound, 0)
				set(flap2_sw, 2)
			end
			return true
		end,
		onMouseUp = function()
			set(flap2_sw, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end,
    },
    -- switcher RIGHT
	clickable {
        position = { 869, 307, 8, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			if not switcher_pushed then
				switcher_pushed = true
				playSample(switch_sound, 0)
				set(flap2_sw, 3)
			end
			return true
		end,
		onMouseUp = function()
			set(flap2_sw, 0)
			playSample(switch_sound, 0)
			switcher_pushed = false
			return true
		end,
    },
	

}
--]]