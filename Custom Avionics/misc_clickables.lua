-- this is component for all clickables on panel, that don't included with gauges
size = {2048, 2048}

-- datarefs
defineProperty("rv2_sw", globalPropertyi("an-24/gauges/rv_2_sw")) -- switch for radioaltimeter
defineProperty("feet_meter_sw", globalPropertyf("an-24/gauges/feet_meter_sw")) -- gauge switcher ON/OF
defineProperty("GIK_button", globalPropertyi("an-24/gauges/GIK_button")) -- button for sync GIK with mag compass
defineProperty("GIK_sw", globalPropertyi("an-24/gauges/GIK_sw")) -- ON/OFF GIK
defineProperty("GPK_sw", globalPropertyi("an-24/gauges/GPK_sw")) -- ON/OFF GPK
defineProperty("uvid_30_sw", globalPropertyf("an-24/gauges/uvid_30_sw")) -- UVID-30 switcher ON/OF
defineProperty("sq_emerg_cap", globalPropertyi("an-24/sq/sq_emerg_cap"))
defineProperty("curs_mp1_sw", globalPropertyi("an-24/gauges/curs_mp1_sw"))
defineProperty("curs_mp2_sw", globalPropertyi("an-24/gauges/curs_mp2_sw"))
defineProperty("ark_vor", globalPropertyi("an-24/gauges/ark_vor")) -- switcher ARK/VOR
defineProperty("weel_switch", globalPropertyi("an-24/gauges/noseweel")) -- nosewheel mode
defineProperty("nav_light_sw", globalPropertyi("an-24/misc/nav_light_sw")) -- nav lights and beacons switch
defineProperty("lan_light_sw", globalPropertyi("an-24/misc/lan_light_sw")) -- landing lights switch
defineProperty("lan_light_open_sw", globalPropertyi("an-24/misc/lan_light_open_sw")) -- landing lights switch
defineProperty("cockpit_red", globalPropertyf("an-24/misc/cockpit_red")) -- red cockpit light rotary
defineProperty("cockpit_spot1", globalPropertyf("an-24/misc/cockpit_spot1")) -- cockpit spotlight rotary
defineProperty("cockpit_spot2", globalPropertyf("an-24/misc/cockpit_spot2")) -- cockpit spotlight rotary
defineProperty("cockpit_panel", globalPropertyf("an-24/misc/cockpit_panel")) -- cockpit spotlight rotary
defineProperty("wiper_sw", globalPropertyi("sim/cockpit2/switches/wiper_speed"))  -- 0=off,1=25%speed,2=50%speed,3=100%speed.
defineProperty("siren_button", globalPropertyi("an-24/gauges/siren_button")) -- button for temporary OFF sirene
defineProperty("cabin_left_window", globalPropertyi("sim/cockpit2/switches/custom_slider_on[2]"))  -- open/close cabin_left_window
defineProperty("cabin_right_window", globalPropertyi("sim/cockpit2/switches/custom_slider_on[3]"))  -- open/close cabin_right_window
defineProperty("cabin_left_glass", globalPropertyi("sim/cockpit2/switches/custom_slider_on[0]"))  -- open/close cabin_left_glass
defineProperty("cabin_right_glass", globalPropertyi("sim/cockpit2/switches/custom_slider_on[1]"))  -- open/close cabin_right_glass
defineProperty("nl10m_subpanel", globalPropertyi("an-24/panels/nl10m_subpanel"))
--defineProperty("rud_stopor", globalPropertyi("sim/cockpit2/switches/custom_slider_on[19]")) -- stopor lever, that fixes RUDs

local switch_sound = loadSample('sounds/custom/metal_switch.wav')
local cap_sound = loadSample('sounds/custom/cap.wav')
local btn_click = loadSample('sounds/custom/plastic_btn.wav')
local rot_click = loadSample('sounds/custom/rot_click.wav')
local plastic_sound = loadSample('sounds/custom/plastic_switch.wav')

local switcher_pushed = false

components = {

	-- rud_stopor
--[[
    switch {
        position = { 680, 115, 17, 45},
        state = function()
            return get(rud_stopor) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(rud_stopor) ~= 0 then
                set(rud_stopor, 0)
            else
                set(rud_stopor, 1)
            end
            return true;
        end
    },
--]]
	-- NL10
    switch {
        position = { 0, 1850, 48, 70},
        state = function()
            return get(nl10m_subpanel) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(nl10m_subpanel) ~= 0 then
                set(nl10m_subpanel, 0)
            else
                set(nl10m_subpanel, 1)
            end
            return true;
        end
    },

	-- cabin_left_window switcher
    switch {
        position = { 677, 235, 15, 15},
        state = function()
            return get(cabin_left_window) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(cabin_left_window) ~= 0 then
                set(cabin_left_window, 0)
            else
                set(cabin_left_window, 1)
            end
            return true;
        end
    },
	-- cabin_right_window switcher
    switch {
        position = { 677, 218, 15, 15},
        state = function()
            return get(cabin_right_window) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(cabin_right_window) ~= 0 then
                set(cabin_right_window, 0)
            else
                set(cabin_right_window, 1)
            end
            return true;
        end
    },

	-- cabin_left_glass switcher
    switch {
        position = { 694, 235, 15, 15},
        state = function()
            return get(cabin_left_glass) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(cabin_left_glass) ~= 0 then
                set(cabin_left_glass, 0)
            else
                set(cabin_left_glass, 1)
            end
            return true;
        end
    },

	-- cabin_right_glass switcher
    switch {
        position = { 694, 218, 15, 15},
        state = function()
            return get(cabin_right_glass) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(cabin_right_glass) ~= 0 then
                set(cabin_right_glass, 0)
            else
                set(cabin_right_glass, 1)
            end
            return true;
        end
    },

	-- siren_button
    clickable {
        position = {690, 500, 17, 17},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			set(siren_button, 1)
			if not switcher_pushed then
				playSample(btn_click, 0)
			end
			switcher_pushed = true
			return true
		end,
		onMouseUp  = function()
			set(siren_button, 0)
			switcher_pushed = false
			playSample(btn_click, 0)
			return true
		end,
    },
--[[
	-- RV2 switcher
    switch {
        position = { 805, 327, 15, 15},
        state = function()
            return get(rv2_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(rv2_sw) ~= 0 then
                set(rv2_sw, 0)
            else
                set(rv2_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- feet meter switch
    switch {
        position = { 786, 253, 15, 15},
        state = function()
            return get(feet_meter_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(feet_meter_sw) ~= 0 then
                set(feet_meter_sw, 0)
            else
                set(feet_meter_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- GIK sync button
    clickable {
        position = {737, 522, 40, 23},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			set(GIK_button, 1)
			if not switcher_pushed then
				playSample(btn_click, 0)
			end
			switcher_pushed = true
			return true
		end,
		onMouseUp  = function()
			set(GIK_button, 0)
			switcher_pushed = false
			playSample(btn_click, 0)
			return true
		end,
    },
--]]
	-- GIK switcher
    switch {
        position = { 806, 272, 15, 15},
        state = function()
            return get(GIK_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(GIK_sw) ~= 0 then
                set(GIK_sw, 0)
            else
                set(GIK_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- GPK switcher
    switch {
        position = { 843, 272, 15, 15},
        state = function()
            return get(GPK_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(GPK_sw) ~= 0 then
                set(GPK_sw, 0)
            else
                set(GPK_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- UVID30 switcher
    switch {
        position = { 862, 272, 15, 15},
        state = function()
            return get(uvid_30_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(uvid_30_sw) ~= 0 then
                set(uvid_30_sw, 0)
            else
                set(uvid_30_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- transponder emerg button cap
    switch {
        position = { 568, 304, 30, 60},
        state = function()
            return get(sq_emerg_cap) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(cap_sound, 0)
			switcher_pushed = true
			if get(sq_emerg_cap) ~= 0 then
                set(sq_emerg_cap, 0)
            else
                set(sq_emerg_cap, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- left CursMP switcher
    switch {
        position = { 843, 384, 17, 17},
        state = function()
            return get(curs_mp1_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(curs_mp1_sw) ~= 0 then
                set(curs_mp1_sw, 0)
            else
                set(curs_mp1_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- right CursMP switcher
    switch {
        position = { 860, 384, 17, 17},
        state = function()
            return get(curs_mp2_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(curs_mp2_sw) ~= 0 then
                set(curs_mp2_sw, 0)
            else
                set(curs_mp2_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },


	-- ARK/VOR switcher
    switch {
        position = { 937, 384, 17, 17},
        state = function()
            return get(ark_vor) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(ark_vor) ~= 0 then
                set(ark_vor, 0)
            else
                set(ark_vor, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
--[[
	-- nosewheel switch up
    clickable {
        position = {823, 335, 18, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			local a = get(weel_switch)
			if not switcher_pushed and a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			switcher_pushed = true
			set(weel_switch, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- nosewheel switch up
    clickable {
        position = {823, 326, 18, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			local a = get(weel_switch)
			if not switcher_pushed and a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			switcher_pushed = true
			set(weel_switch, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- ANO switcher
    switch {
        position = { 805, 307, 17, 17},
        state = function()
            return get(nav_light_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(nav_light_sw) ~= 0 then
                set(nav_light_sw, 0)
            else
                set(nav_light_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
	-- landing light
    clickable {
        position = { 823, 315, 17, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			local a = get(lan_light_sw)
			if not switcher_pushed and a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			switcher_pushed = true
			set(lan_light_sw, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    clickable {
        position = { 823, 307, 17, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			local a = get(lan_light_sw)
			if not switcher_pushed and a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			switcher_pushed = true
			set(lan_light_sw, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },


	-- landing light open switch
    switch {
        position = { 823, 250, 17, 17},
        state = function()
            return get(lan_light_open_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if not switcher_pushed then
			playSample(switch_sound, 0)
			switcher_pushed = true
			if get(lan_light_open_sw) ~= 0 then
                set(lan_light_open_sw, 0)
            else
                set(lan_light_open_sw, 1)
            end
		end
            return true;

        end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },

	-- panel light

    clickable {
        position = { 937, 326, 17, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			local a = get(cockpit_panel)
			if not switcher_pushed and a < 1 then
				playSample(switch_sound, 0)
				a = a + 1
			end
			switcher_pushed = true
			set(cockpit_panel, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
    clickable {
        position = { 937, 335, 17, 8},  -- search and set right

       cursor = {
            x = 16,
            y = 32,
            width = 16,
            height = 16,
            shape = loadImage("clickable.png")
        },

       	onMouseClick = function()
			local a = get(cockpit_panel)
			if not switcher_pushed and a > -1 then
				playSample(switch_sound, 0)
				a = a - 1
			end
			switcher_pushed = true
			set(cockpit_panel, a)
			return true
		end,
		onMouseUp = function()
			switcher_pushed = false
			return true
		end,
    },
--]]
    -- cockpit red light
    rotary {
        -- image = rotaryImage;
        value = cockpit_red;
        step = 0.1;
        position = { 482, 224, 18, 18 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            playSample(rot_click, 0)
			if v > 1 then v = 1
			elseif v < 0 then v = 0 end
			return v
        end;
    };

    -- cockpit spotlight1
    rotary {
        -- image = rotaryImage;
        value = cockpit_spot1;
        step = 0.1;
        position = { 503, 224, 18, 18 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            playSample(rot_click, 0)
			if v > 1 then v = 1
			elseif v < 0 then v = 0 end
			return v
        end;
    };

    -- cockpit spotlight2
    rotary {
        -- image = rotaryImage;
        value = cockpit_spot2;
        step = 0.1;
        position = { 523, 224, 18, 18 };

        -- round inches hg to millimeters hg
        adjuster = function(v)
            playSample(rot_click, 0)
			if v > 1 then v = 1
			elseif v < 0 then v = 0 end
			return v
        end;
    };

	-- wiper
    switch {
        position = {785, 450, 90, 47},
        state = function()
            return get(wiper_sw) ~= 0
        end,
        --btnOn = get(tmb_up),
        --btnOff = get(tmb_dn),
        onMouseClick = function()
            if get(wiper_sw) ~= 0 then
                set(wiper_sw, 0)
            else
                set(wiper_sw, 2)
            end
            return true;
        end
    },

}