local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
  }

local GUI							= {}
GUI.Time							= 0

Citizen.CreateThread(function()
	local handsup = false
	while true do
		Wait(0)
		local lPed = GetPlayerPed(-1)
		RequestAnimDict("random@mugging3")
		if (IsControlJustPressed(1, 73) and (GetGameTimer() - GUI.Time) > 150) then
			if handsup then
				if DoesEntityExist(lPed) then
					Citizen.CreateThread(function()
					RequestAnimDict("random@mugging3")
				while not HasAnimDictLoaded("random@mugging3") do
					Citizen.Wait(100)
				end
				
				handsup = false
				ClearPedSecondaryTask(lPed)
				TriggerServerEvent("esx_thief:update", handsup)
				end)
			end
				else
					if DoesEntityExist(lPed) then
						Citizen.CreateThread(function()
							RequestAnimDict("random@mugging3")
							while not HasAnimDictLoaded("random@mugging3") do
								Citizen.Wait(100)
							end

							if not handsup then
								handsup = true
								TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 6.0, -6.0, -1, 49, 0, 0, 0, 0)
                TriggerServerEvent("esx_thief:update", handsup)
							end
						end)
					end
				end
				
				GUI.Time  = GetGameTimer()
			end
	end
end)