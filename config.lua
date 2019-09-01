Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = false
Config.EnableArmoryManagement     = false
Config.EnableESXIdentity          = false
Config.EnableNonFreemodePeds      = false
Config.EnableLicenses             = false

Config.EnableHandcuffTimer        = true
Config.HandcuffTimer              = 10 * 60000

Config.EnableJobBlip              = false

Config.MaxInService               = -1
Config.Locale = 'en'

Config.Cloakrooms = {
	Cloakrooms = {
		vector3(452.6, -992.8, 30.6),
		vector3(-3257.45, 1225.79, 2.64),
		vector3(-450.2878112793, 6016.482421875, 31.716369628906),
		vector3(1857.2354736328, 3689.8408203125, 34.26708984375)
	}
}

Config.Uniforms = {

	Remove_Bag = {
		male = {
		    ['bags_1'] = 0,    ['bags_2'] = 0
		},
	    female = {
		    ['bags_1'] = 0,    ['bags_2'] = 0
		}  
	}, 

	Balistic_Vest = {
		male = {
		    ['tshirt_1'] = 124,    ['tshirt_2'] = 0
		},
	    female = {
		    ['tshirt_1'] = 124,    ['tshirt_2'] = 0
		}  
	}, 

	Duty_belt_1 = {
		male = {
		    ['tshirt_1'] = 129,    ['tshirt_2'] = 0
		},
	    female = {
		    ['tshirt_1'] = 129,    ['tshirt_2'] = 0
		}  
	}, 

	Duty_belt_2 = {
		male = {
		    ['tshirt_1'] = 130,    ['tshirt_2'] = 0
		},
	    female = {
		    ['tshirt_1'] = 130,    ['tshirt_2'] = 0
		}  
	}, 

	Duty_belt_3 = {
		male = {
		    ['tshirt_1'] = 58,    ['tshirt_2'] = 0
		},
	    female = {
		    ['tshirt_1'] = 58,    ['tshirt_2'] = 0
		}  
	}, 

	Duty_belt_4 = {
		male = {
		    ['tshirt_1'] = 122,    ['tshirt_2'] = 0
		},
	    female = {
		    ['tshirt_1'] = 122,    ['tshirt_2'] = 0
		}  
	},

	remove_vest = {
		male = {
		    ['tshirt_1'] = 57,    ['tshirt_2'] = 0
		},
	    female = {
		    ['tshirt_1'] = 57,    ['tshirt_2'] = 0
		}  
	},

	Tactical_Top_SWAT = {
		male = {
		    ['torso_1'] = 53,    ['torso_2'] = 0
		},
	    female = {
		    ['torso_1'] = 53,    ['torso_2'] = 0
		}  
	},

	Tactical_Top_SERT = {
		male = {
		    ['torso_1'] = 53,    ['torso_2'] = 3
		},
	    female = {
		    ['torso_1'] = 53,    ['torso_2'] = 3
		}  
	},

	Tactical_Top_SESU = {
		male = {
		    ['torso_1'] = 53,    ['torso_2'] = 1
		},
	    female = {
		    ['torso_1'] = 53,    ['torso_2'] = 1
		}  
	},

	Police_Shirt = {
		male = {
		    ['torso_1'] = 55,    ['torso_2'] = 0,
		    ['arms'] = 19,
		},
	    female = {
		    ['torso_1'] = 55,    ['torso_2'] = 0,
		    ['arms'] = 19,
		}  
	},

	Suit_Pants = {
		male = {
		    ['pants_1'] = 35,    ['pants_2'] = 0
		},
	    female = {
		    ['pants_1'] = 35,    ['pants_2'] = 0
		}  
	},	

	Tactical_Pants = {
		male = {
		    ['pants_1'] = 34,    ['pants_2'] = 0
		},
	    female = {
		    ['pants_1'] = 34,    ['pants_2'] = 0
		}  
	},	

	Suit_Shoes = {
		male = {
		    ['shoes_1'] = 10,    ['shoes_2'] = 0
		},
	    female = {
		    ['shoes_1'] = 10,    ['shoes_2'] = 0
		}  
	},	

	Posh_Work_Shoes = {
		male = {
		    ['shoes_1'] = 12,    ['shoes_2'] = 6
		},
	    female = {
		    ['shoes_1'] = 12,    ['shoes_2'] = 6
		} 
	},	

	Tactical_Shoes = {
		male = {
		    ['shoes_1'] = 25,    ['shoes_2'] = 0
		},
	    female = {
		    ['shoes_1'] = 25,    ['shoes_2'] = 0
		} 
	},	

	Police_ID_1 = {
		male = {
		    ['chain_1'] = 125,    ['chain_2'] = 0
		},
	    female = {
		    ['chain_1'] = 125,    ['chain_2'] = 0
		} 
	},	

	Police_ID_2 = {
		male = {
		    ['chain_1'] = 128,    ['chain_2'] = 0
		},
	    female = {
		    ['chain_1'] = 128,    ['chain_2'] = 0
		} 
	},	

	remove_helmet = {
		male = {
		    ['helmet_1'] = -1,   ['helmet_2'] = 0,
		},
	    female = {
		    ['helmet_1'] = -1,   ['helmet_2'] = 0,
		} 
	},		

	Basic_Helmet = {
		male = {
		    ['helmet_1'] = 39,   ['helmet_2'] = 0,
		},
	    female = {
		    ['helmet_1'] = 39,   ['helmet_2'] = 0,
		} 
	},		

	Police_Hat = {
		male = {
		    ['helmet_1'] = 46,   ['helmet_2'] = 0,
		},
	    female = {
		    ['helmet_1'] = 46,   ['helmet_2'] = 0,
		} 
	},	

	Black_Cap = {
		male = {
		    ['helmet_1'] = 58,   ['helmet_2'] = 2,
		},
	    female = {
		    ['helmet_1'] = 58,   ['helmet_2'] = 2,
		} 
	},

	Enhanced_Helmet = {
		male = {
		    ['helmet_1'] = 117,   ['helmet_2'] = 0,
		},
	    female = {
		    ['helmet_1'] = 117,   ['helmet_2'] = 0,
		} 
	},

	Riot_Helmet = {
		male = {
		    ['helmet_1'] = 124,   ['helmet_2'] = 15,
		},
	    female = {
		    ['helmet_1'] = 124,   ['helmet_2'] = 15,
		} 
	},

	Black_Beanie = {
		male = {
		    ['helmet_1'] = 120,   ['helmet_2'] = 0,
		},
	    female = {
		    ['helmet_1'] = 120,   ['helmet_2'] = 0,
		} 
	}
}