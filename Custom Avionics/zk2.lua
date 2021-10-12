size = {200, 200}

-- define property table
-- source
defineProperty("gyro_curse", globalPropertyf("an-24/gauges/GPK_curse"))  -- gyro curse from GIK
--defineProperty("obs", globalPropertyf("sim/cockpit2/radios/actuators/nav1_obs_deg_mag_pilot")) -- curse for VOR1
defineProperty("frame_time", globalPropertyf("an-24/time/frame_time")) -- time for frames
defineProperty("flight_time", globalPropertyf("sim/time/total_running_time_sec"))  -- local time since aircraft was loaded
-- signals to autopilot
defineProperty("ap_curse", globalPropertyf("an-24/ap/curse_zk")) -- curse for autopilot

defineProperty("SC_master", globalPropertyi("scp/api/ismaster")) -- status of SmartCopilot
defineProperty("zk_scale_angle_smartcopilot", globalPropertyf("an-24/gauges/zk_scale_angle_smartcopilot")) -- dataref for SmartCopilot synchronisation
defineProperty("zk_rotate_dir_smartcopilot", globalPropertyi("an-24/gauges/zk_rotate_dir_smartcopilot")) -- dataref for SmartCopilot synchronisation
defineProperty("sc_curse_angle", globalPropertyf("an-24/gauges/sc_ZK_curse_angle")) -- dataref for SmartCopilot synchronisation

-- images
defineProperty("scale", loadImage("scales_1.png", 318, 317.5, 196, 196))
defineProperty("curse_needle", loadImage("needles.dds", 218, 70, 87, 179))
defineProperty("scale_triangle", loadImage("kppm.dds", 30, 223, 13, 23))
defineProperty("black_cap", loadImage("covers.dds", 0, 55, 56, 56)) -- black cap image
-- set(obs, 0)
-- Shared Flight

-- local variables
local scale_angle = 0
local curse_angle = 0
local rotate_dir = 0
local duration = 0
--local obs = 0

-- turn zk left
turn_left_command = findCommand("sim/autopilot/heading_down")
function turn_left_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if phase == 1 then
		duration = duration + 0.1
		sc_angle(duration, -1)
	else
		duration = 0
	end
	return 0
end
registerCommandHandler(turn_left_command, 0, turn_left_handler)

-- turn zk right
turn_right_command = findCommand("sim/autopilot/heading_up")
function turn_right_handler(phase)  -- for all commands phase equals: 0 on press; 1 while holding; 2 on release
	if phase == 1 then
		duration = duration + 0.1
		sc_angle(duration, 1)
	else
		duration = 0
	end
	return 0
end
registerCommandHandler(turn_right_command, 0, turn_right_handler)

function sc_angle(dur, dir)
	if dur < 6 then
		scale_angle = ((scale_angle + 181 * dir) % 360) - 180
		set(zk_scale_angle_smartcopilot, scale_angle)
	else
		scale_angle = ((scale_angle + 182 * dir) % 360) - 180
		set(zk_scale_angle_smartcopilot, scale_angle)
	end
end

-- postframe calculaions
function update()
	-- time calculations
	local passed = get(frame_time)
  -- time bug workaround
	if passed > 0 then
--[[
		if get(SC_master) ~= 1 then
			--scale_angle = -obs
			-- rotate scale
			scale_angle = scale_angle + (rotate_dir + get(zk_rotate_dir_smartcopilot)) * passed * 20
			if scale_angle > 180 then scale_angle = scale_angle - 360
			elseif scale_angle < -180 then scale_angle = scale_angle + 360 end
			set(zk_scale_angle_smartcopilot, scale_angle)
		else
			scale_angle = get(zk_scale_angle_smartcopilot)
		end

		if get(SC_master) == 1 then
			curse_angle = get(sc_curse_angle)
		else
			local v = get(gyro_curse) + scale_angle
			local delta = v - curse_angle
			if delta > 180 then delta = delta - 360
			elseif delta < -180 then delta = delta + 360 end
			curse_angle = curse_angle + 3 * delta * passed
			if curse_angle > 180 then curse_angle = curse_angle - 360
			elseif curse_angle < -180 then curse_angle = curse_angle + 360 end
			set(sc_curse_angle,curse_angle)
		end
--]]
		scale_angle = get(zk_scale_angle_smartcopilot)

		if get(SC_master) == 1 then
			curse_angle = get(sc_curse_angle)
		else
			local v = get(gyro_curse) + scale_angle
			local delta = v - curse_angle
			if delta > 180 then delta = delta - 360
			elseif delta < -180 then delta = delta + 360 end
			curse_angle = curse_angle + 3 * delta * passed
			if curse_angle > 180 then curse_angle = curse_angle - 360
			elseif curse_angle < -180 then curse_angle = curse_angle + 360 end
			set(sc_curse_angle,curse_angle)
		end
			--set curse for AP
		set(ap_curse, curse_angle)
	end
end


components = {
	-- position gauge
--[[	rectangle {
		position = {99, 99, 2, 2},
		color = {1, 0, 0, 1},
	}, --]]

	-- scale
	needle {
		position = {2, 2, 196, 196,},
		image = get(scale),
		angle = function()
			return scale_angle
		end
	},

	-- curse needle
	needle {
		position = {15, 15, 170, 170,},
		image = get(curse_needle),
		angle = function()
			return curse_angle
		end
	},

	-- position triangle
	texture {
		position = {94, 177, 12, 23},
		image = get(scale_triangle),

	},

	-- black cap
	texture{
	    position = { 79, 78, 44, 44 },
        image = get(black_cap),
	}
}