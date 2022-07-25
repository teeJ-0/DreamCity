Config                            = {}
Config.Locale                     = 'en'

Config.DrawDistance               = 100.0
Config.MaxInService               = 30
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = { r = 204, g = 204, b = 0 }

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }

Config.WegenwachtBlip1 = {
	Pos   = { x = -344.56, y = -119.25, z = 39.01}						
}

Config.WegenwachtBlip2 = {
	Pos   = { x = 1762.67, y = 3325.91, z = 41.44}						
}

Config.Zones = {

	MechanicActions = {
		Pos   = { x = -323.02, y = -146.21, z = 39.02},
		Size  = { x = 0.6, y = 0.6, z = 0.4 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
    
    MechanicActions2 = {
		Pos   = { x = 1766.83, y = 3324.59, z = 41.44},
		Size  = { x = 0.6, y = 0.6, z = 0.4 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
    
    VoertuigSpawner = {
		Pos   = { x = 1778.39, y = 3324.67, z = 41.43},
		Size  = { x = 0.6, y = 0.6, z = 0.4 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 36,
        SpawnPoint = { x = 1768.82, y = 3340.72, z = 40.78, heading = 300.88, radius = 1.0 }
	},
    
    VehicleDeleters = {
		Pos   = { x = 1750.49, y = 3313.78, z = 40.24},
		Size  = { x = 4.0, y = 4.0, z = 0.6 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 25,
	}
}

Config.AuthorizedVehicles = {
	--car = {
        Shared = {
            {label = 'Flatbed', model = 'flatbed', price = 1}
        },
        
		stagair = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		monteur = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		eerstemonteur = {
			{label = 'brabus', model = 'b800f', price = 1}
		},
        
        hoofdmonteur = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		autotechnicus = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		autotechnischspecialist = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		autotechnischingenieur = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		teamleider = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		manager = {
			{label = 'brabus', model = 'b800f', price = 1}
		},

		directeur = {
			{label = 'brabus', model = 'b800f', price = 1}
		},
}

Config.Kleding = {
	werkplaats = { 
		male = {
			['tshirt_1'] = 54,  ['tshirt_2'] = 0,
			['torso_1'] = 1,   ['torso_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 46,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
		},
		female = {
			['tshirt_1'] = 65,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 100,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1'] = 6,  ['bproof_2'] = 2,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
    
    werkplaats_overal = { 
		male = {
			['tshirt_1'] = 89,  ['tshirt_2'] = 0,
			['torso_1'] = 66,   ['torso_2'] = 1,
			['arms'] = 42,
			['pants_1'] = 39,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
		},
		female = {
			['tshirt_1'] = 65,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 100,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1'] = 6,  ['bproof_2'] = 2,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	},
    
    standaard_jas = { 
		male = {
			['tshirt_1'] = 0,  ['tshirt_2'] = 0,
			['torso_1'] = 18,   ['torso_2'] = 2,
			['arms'] = 42,
			['pants_1'] = 46,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1'] = 0,  ['bproof_2'] = 0,
			['mask_1'] = 0,   ['mask_2'] = 0,
		},
		female = {
			['tshirt_1'] = 65,  ['tshirt_2'] = 0,
			['torso_1'] = 85,   ['torso_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 100,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['bproof_1'] = 6,  ['bproof_2'] = 2,
			['mask_1'] = 0,   ['mask_2'] = 0
		}
	}
}