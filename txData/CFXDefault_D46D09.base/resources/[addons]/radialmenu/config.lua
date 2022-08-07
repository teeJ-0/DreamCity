-- Menu configuration, array of menus to display
menuConfigs = {
	['emotes'] = {                                  -- Example menu for emotes when player is on foot
		enableMenu = function()                     -- Function to enable/disable menu handling
			local player = GetPlayerPed(-1)
			return IsPedOnFoot(player)
		end,
		data = {                                    -- Data that is passed to Javascript
			keybind = "243",                         -- Wheel keybind to use (case sensitive, must match entry in keybindControls table)
			style = {                               -- Wheel style settings
				sizePx = 600,                       -- Wheel size in pixels
				slices = {                          -- Slice style settings
					default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.60 },
					hover = { ['fill'] = '#ff8000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 },
					selected = { ['fill'] = '#ff8000', ['stroke'] = '#000000', ['stroke-width'] = 2, ['opacity'] = 0.80 }
				},
				titles = {                          -- Text style settings
					default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
					hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
					selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
				},
				icons = {
					width = 64,
					height = 64
				}
			},
			wheels = {                              -- Array of wheels to display
				{
					navAngle = 270,                 -- Oritentation of wheel
					minRadiusPercent = 0.3,         -- Minimum radius of wheel in percentage
					maxRadiusPercent = 0.6,         -- Maximum radius of wheel in percentage
					labels = {"CANCEL", "NO", "CHEER", "CLAP", "FOLDARMS", "LEAN"},
					commands = {"e cancel", "e no", "e cheer", "e slowclap", "e foldarms", "e leanwall"}
				},
				{
					navAngle = 285,                 -- Oritentation of wheel
					minRadiusPercent = 0.6,         -- Minimum radius of wheel in percentage
					maxRadiusPercent = 0.9,         -- Maximum radius of wheel in percentage
					labels = {"SALUTE", "FINGER", "PEACE", "FACEPALM", "DAMN", "FAIL", "DEAD", "GANG1", "GANG2", "COP", "HOLSTER", "CROWDS"},
					commands = {"e salute", "e finger", "e peace", "e palm", "e damn", "e fail", "e dead", "e gang1", "e gang2", "e copidle", "e holster", "e copcrowd2"}
				}
			}
		}
	},
	['vehicles'] = {                                -- Example menu for vehicle controls when player is in a vehicle
		enableMenu = function()                     -- Function to enable/disable menu handling
			local player = GetPlayerPed(-1)
			return IsPedInAnyVehicle(player, false)
		end,
		data = {                                    -- Data that is passed to Javascript
			keybind = "F5",                         -- Wheel keybind to use (case sensitive, must match entry in keybindControls table)
			style = {                               -- Wheel style settings
				sizePx = 400,                       -- Wheel size in pixels
				slices = {                          -- Slice style settings
					type = "PieSlice",
					default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
					hover = { ['fill'] = '#ff8000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
					selected = { ['fill'] = '#ff8000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
				},
				titles = {                          -- Text style settings
					default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
					hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
					selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
				},
				icons = {
					width = 64,
					height = 64
				}
			},
			wheels = {                              -- Array of wheels to display
				{
					navAngle = 270,                 -- Oritentation of wheel
					minRadiusPercent = 0.4,         -- Minimum radius of wheel in percentage
					maxRadiusPercent = 0.9,         -- Maximum radius of wheel in percentage
					labels = {"imgsrc:images/engine.png", "imgsrc:images/key.png", "imgsrc:images/doors.png", "imgsrc:images/neon.png"},
					events = {"glz_veh:engine", nil, nil, "glz_veh:neons"},
					commands = {nil, "carlock"},
					menu = {nil, nil, "vehDoors"}	-- Menus can be opened too, just put name of it
				}
			}
		}
	},

	['vehDoors'] = {                                -- Example menu for vehicle controls when player is in a vehicle
		enableMenu = function()                     -- Function to enable/disable menu handling
			return false
		end,
		data = {                                    -- Data that is passed to Javascript
			keybind = nil,
			style = {                               -- Wheel style settings
				sizePx = 400,                       -- Wheel size in pixels
				slices = {                          -- Slice style settings
					type = "PieSlice",
					default = { ['fill'] = '#000000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.60 },
					hover = { ['fill'] = '#ff8000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 },
					selected = { ['fill'] = '#ff8000', ['stroke'] = '#000000', ['stroke-width'] = 3, ['opacity'] = 0.80 }
				},
				titles = {                          -- Text style settings
					default = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
					hover = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' },
					selected = { ['fill'] = '#ffffff', ['stroke'] = 'none', ['font'] = 'Helvetica', ['font-size'] = 16, ['font-weight'] = 'bold' }
				},
				icons = {
					width = 64,
					height = 64
				}
			},
			wheels = {                              -- Array of wheels to display
				{
					navAngle = 270,                 -- Oritentation of wheel
					minRadiusPercent = 0.4,         -- Minimum radius of wheel in percentage
					maxRadiusPercent = 0.9,         -- Maximum radius of wheel in percentage
					labels = {"imgsrc:images/hood.png", "imgsrc:images/doorR.png", "imgsrc:images/doorR.png", "imgsrc:images/trunk.png", "imgsrc:images/doorL.png", "imgsrc:images/doorL.png"},
					events = {{"radialmenu:doors", 4}, {"radialmenu:doors", 1}, {"radialmenu:doors", 3}, {"radialmenu:doors", 5}, {"radialmenu:doors", 2}, {"radialmenu:doors", 0}}
				}
			}
		}
	}
}
