{
	["weapons"]={
		["onehand"]={
			["swords"]={
				["shortSword"]={
					["name"]="Short Sword",
					["dmg"]={2,6},
					["rng"]=1,
					["accMod"]=10,
					["durability"]=100,
					["prefix"]="",
					["suffix"]="",
					["tc"]={150,150,0},
					["gfx"]="/",
					["pos"]={0,0},
					["desc"]="A short blade.",
					["weight"]=2,
				},
			},
		},
		["twohand"]={
			["bows"]={
				["shortBow"]={
					["name"]="Short Bow",
					["dmg"]={2,12},
					["rng"]=2,
					["accMod"]=5,
					["durability"]=100,
					["prefix"]="",
					["suffix"]="",
					["tc"]={150,150,0},
					["gfx"]="{",
					["pos"]={0,0},
					["desc"]="A short, lightweight bow.",
					["weight"]=1,
				},
			},
		},
	},
	["armor"]={
		["head"]={
			["helms"]={
				["leather"]={
					["name"]="Leather Helm",
					["ac"]=2,
					["weight"]=1,
					["prefix"]="",
					["suffix"]="",
					["durability"]=100,
					["tc"]={150,150,0},
					["gfx"]="n",
					["pos"]={0,0},
					["desc"]="A simple helmet made from hardened leather",
					["slots"]=0,
					["weight"]=1,
				},
			},
		},
		["hands"]={
			["gauntlets"]={
				["leather"]={
					["name"]="Leather Gauntlets",
					["ac"]=1,
					["weight"]=0.5,
					["prefix"]="",
					["suffix"]="",
					["durability"]=100,
					["tc"]={150,150,0},
					["gfx"]="%",
					["pos"]={0,0},
					["desc"]="Simple leather armor for the hands and arms.",
					["slots"]=0,
					["weight"]=0.5,
				},		
			},
		},
		["feet"]={
			
		},
		["back"]={
			
		},
		["chest"]={
			
		},
		["legs"]={
			
		},
	},
	["items"]={
		["consumable"]={
			["food"]={
				["bread"]={
					["name"]="Loaf of Bread",
					["effect"]="heal",
					["magnitude"]=5,
					["tc"]={150,150,0},
					["gfx"]="B",
					["pos"]={0,0},
					["desc"]="Doughy goodness.",
					["weight"]=0.2,
				},
			},
		},
		["tool"]={
			["journal"]={
				["name"]="Journal",
				["desc"]="A book for keeping notes",
				["effect"]="book",
				["weight"]=0.1,
				["tc"]={150,150,0},
				["gfx"]="#",
				["pages"]={
					["1"]={"","","","","","","","","","","","","","","","","","","",""},
					["2"]={"","","","","","","","","","","","","","","","","","","",""},
					["3"]={"","","","","","","","","","","","","","","","","","","",""},
					["4"]={"","","","","","","","","","","","","","","","","","","",""},
					["5"]={"","","","","","","","","","","","","","","","","","","",""},
				},
			},
			["book"]={
				["name"]="Old Book",
				["desc"]="An old book",
				["effect"]="book",
				["weight"]=0.1,
				["tc"]={80,80,50},
				["gfx"]="#",
				["pages"]={
					["1"]={"Dear diary,","","Today I met a strange man.","He killed me.","","","","","","","","","","","","","","","",""},
					["2"]={"","","","","","","","","","","","","","","","","","","",""},
					["3"]={"","","","","","","","","","","","","","","","","","","",""},
					["4"]={"","","","","","","","","","","","","","","","","","","",""},
					["5"]={"lol","","","","","","","","","","","","","","","","","","",""},
				},
			},
		},
		["reagent"]={
			
		},
		["quest"]={
			["testKey"]={
				["name"]="Key of 1000 Truthes",
				["questID"]="testLock",
				["tc"]={150,150,0},
				["gfx"]="&",
				["pos"]={0,0},
				["desc"]="And in the hands of a total noob too.",
				["weight"]=0,
			},
		},
		["part"]={
			["machinery"]={
				["clockwork"]={
					["gears"]={
						["mithril"]={
							["name"]="Mithril Gear",
							["tc"]={150,150,0},
							["gfx"]="*",
							["pos"]={0,0},
							["desc"]="Mithril gears, absolutely lavish.",
							["weight"]=0.1,
						},
					},
				},
			},
		},
	},
}