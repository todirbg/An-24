--[[

  File: glbl_drfs.lua
  -----
  Declare all datarefs

--]]

-- Main
drf_main = {
  frame_time_old = cGPf(pfx.."time/frame_time"),
  frame_time = gPf("sim/operation/misc/frame_rate_period"),
}

-- Settings
drf_set = {
  lang = cGPi(pfx.."set/language"), -- Language selector: 0 - ENG, 1 - RUS
--  hide_gps = cGPi(pfx.."set/hide_GPS", 1), -- by default GPS is hidden
  kln_init = cGPi(pfx.."set/kln_init"), -- KLN90B init status
  kln90b_pri = cGPi(pfx.."set/kln90b_pri"), -- Primary KLN90B for pilot
  kln90b_sec = cGPi(pfx.."set/kln90b_sec"), -- Secondary KLN90B for copilot
  gns430_pri = cGPi(pfx.."set/gns430_pri"), -- Primary GNS430 for pilot
  gns430_sec = cGPi(pfx.."set/gns430_sec"), -- Secondary GNS430 for copilot
  switch_rud = cGPi(pfx.."set/switch_rud"), -- switch or hold RUD stopers
}

-- Power
drf_pwr = {
  bus_dc27 = cGPf(pfx.."power/bus_DC_27_volt", 27),
}

-- Engine
drf_engn = {
  virt_rud1 = cGPf(pfx.."misc/virt_rud1"), -- virtual rud ENGN #1
  virt_rud2 = cGPf(pfx.."misc/virt_rud2"), -- virtual rud ENGN #2
  virt_rud3 = cGPf(pfx.."misc/virt_rud3"), -- virtual rud RU19
  thro_comm_1 = gP("sim/flightmodel/engine/ENGN_thro[0]"),
  thro_comm_2 = gP("sim/flightmodel/engine/ENGN_thro[1]"),
  thro_comm_3 = gP("sim/flightmodel/engine/ENGN_thro[2]"),
  thro_need_1 = gP("sim/flightmodel/engine/ENGN_thro_use[0]"),
  thro_need_2 = gP("sim/flightmodel/engine/ENGN_thro_use[1]"),
  thro_need_3 = gP("sim/flightmodel/engine/ENGN_thro_use[2]"),
}

-- Lights
lfdlamp = cGPfa(pfx.."lights/LFDLAMP", 10)
cfdlamp = cGPfa(pfx.."lights/CFDLAMP", 10)
ccfdlamp = cGPfa(pfx.."lights/CCFDLAMP", 10)
rfdlamp = cGPfa(pfx.."lights/RFDLAMP", 10)
lfdgdl = cGPfa(pfx.."lights/LFDGaugesDownLeft", 10)
lfdgdr = cGPfa(pfx.."lights/LFDGaugesDownRight", 10)
lfdgul = cGPfa(pfx.."lights/LFDGaugesUpLeft", 10)
lfdgur = cGPfa(pfx.."lights/LFDGaugesUpRight", 10)
rfdgdl = cGPfa(pfx.."lights/RFDGaugesDownLeft", 10)
rfdgdr = cGPfa(pfx.."lights/RFDGaugesDownRight", 10)
rfdgul = cGPfa(pfx.."lights/RFDGaugesUpLeft", 10)
rfdgur = cGPfa(pfx.."lights/RFDGaugesUpRight", 10)
olb = cGPfa(pfx.."lights/overhead_lamp_bort", 10)
oll = cGPfa(pfx.."lights/overhead_lamp_left", 10)
olr = cGPfa(pfx.."lights/overhead_lamp_right", 10)
olpl = cGPfa(pfx.."lights/overhead_lamp_pilotleft", 10)
olpr = cGPfa(pfx.."lights/overhead_lamp_pilotright", 10)
olnl = cGPfa(pfx.."lights/overhead_lamp_navleft", 10)
olnr = cGPfa(pfx.."lights/overhead_lamp_navright", 10)
olrad = cGPfa(pfx.."lights/overhead_lamp_rad", 10)
-- Lights in the cockpit
ollm = cGPi(pfx.."lights/overhead_lamp_left_mode") -- 0 off, 1 red, 2 white
ollb = cGPf(pfx.."lights/overhead_lamp_left_bright", 1)
ollru = cGPf(pfx.."lights/overhead_lamp_left_rot_updown", 45)
ollra = cGPf(pfx.."lights/overhead_lamp_left_rot_around")
olrm = cGPi(pfx.."lights/overhead_lamp_right_mode") -- 0 off, 1 red, 2 white
olrb = cGPf(pfx.."lights/overhead_lamp_right_bright", 1)
olrru = cGPf(pfx.."lights/overhead_lamp_right_rot_updown", 45)
olrra = cGPf(pfx.."lights/overhead_lamp_right_rot_around")
olprm = cGPi(pfx.."lights/overhead_lamp_pilot_right_mode") -- 0 off, 1 red, 2 white
olprb = cGPf(pfx.."lights/overhead_lamp_pilot_right_bright", 1)
olprru = cGPf(pfx.."lights/overhead_lamp_pilot_right_rot_updown", 45)
olprra = cGPf(pfx.."lights/overhead_lamp_pilot_right_rot_around")
olplm = cGPi(pfx.."lights/overhead_lamp_pilot_left_mode") -- 0 off, 1 red, 2 white
olplb = cGPf(pfx.."lights/overhead_lamp_pilot_left_bright", 1)
olplru = cGPf(pfx.."lights/overhead_lamp_pilot_left_rot_updown", 45)
olplra = cGPf(pfx.."lights/overhead_lamp_pilot_left_rot_around")
olnlm = cGPi(pfx.."lights/overhead_lamp_nav_left_mode") -- 0 off, 1 red, 2 white
olnlb = cGPf(pfx.."lights/overhead_lamp_nav_left_bright", 1)
olnlru = cGPf(pfx.."lights/overhead_lamp_nav_left_rot_updown", 50)
olnlra = cGPf(pfx.."lights/overhead_lamp_nav_left_rot_around")
olnrm = cGPi(pfx.."lights/overhead_lamp_nav_right_mode") --0 off, 1 red, 2 white
olnrb = cGPf(pfx.."lights/overhead_lamp_nav_right_bright", 1)
olnrru = cGPf(pfx.."lights/overhead_lamp_nav_right_rot_updown", 30)
olnrra = cGPf(pfx.."lights/overhead_lamp_nav_right_rot_around", 30)
olradm = cGPi(pfx.."lights/overhead_lamp_rad_mode") -- 0 off, 1 red, 2 white
olradb = cGPf(pfx.."lights/overhead_lamp_rad_bright", 1)
olradru = cGPf(pfx.."lights/overhead_lamp_rad_rot_updown", 20)
olradra = cGPf(pfx.."lights/overhead_lamp_rad_rot_around", -6)
