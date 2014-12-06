function loadTypes()
	local contents, size = love.filesystem.read( "Resources/mobs.lua", all )
	mobTypes = {}
	mobTypes = unserialize(contents)
	
	local contents, size = love.filesystem.read( "Resources/items.lua", all )
	itemTypes = {}
	itemTypes = unserialize(contents)
	
	local contents, size = love.filesystem.read( "Resources/terrain.lua", all )
	terrainTypes = {}
	terrainTypes = unserialize(contents)
	
	local contents, size = love.filesystem.read( "Resources/player.lua", all )
	player = {}
	player = unserialize(contents)
	
	local contents, size = love.filesystem.read( "Resources/spells.lua", all )
	spells = {}
	spells = unserialize(contents)
end

function startup()
	xOff = 512
	yOff = 512
	currentX = 512
	currentY = 512
	status = "Initializing Coordinate System..."
	initCoords()
	status = "Loading Resources..."
	loadTypes()
	status = "Generating Terrain..."
	fillWorld()
	status = "Seeding Trees..."
	addTrees(30000)
	status = "Simulated Growth Algorithm..."
	growTrees(5)
	status = "Placing Mobs..."
	placeMobs(mobTypes.monsters.low.slime,10000)
	placeMobs(mobTypes.animals.low.rat,5000)
	status = "Adding Decorations..."
	addDecor(80000)
	status = "Inventing Magic..."
	makeMagic()
	status = "Placing Items..."
	placeItems(10000,itemTypes.weapons.onehand.swords.shortSword)
	screen = "main"
	popup = 0,0,0,0,{255,255,255}
end

function getMob(x,y)
	local mob = mobs[x][y]
	if mob == nil then
		return nil
	end
	return mobs[x][y]
end

function createMob(x,y,mobType)
	mobs[x][y] = {}
	mobs[x][y].name = mobType.name
	mobs[x][y].gfx = mobType.gfx
	mobs[x][y].tc = mobType.tc
	mobs[x][y].hp = mobType.hp
	mobs[x][y].dmg = mobType.dmg
	mobs[x][y].acc = mobType.acc
end

function placeMobs(mobType,amount)
	for i = 1,amount do
		j = math.random(1024)
		k = math.random(1024)
		local terry = terrain[j][k]
		if terry.pass == true and mobs[j][k] == nil then
			createMob(j,k,mobType)
		end
	end
end

function setTerrainType(x,y,terrainType)
	terrain[x][y] = {}
	terrain[x][y].gfx = terrainType.gfx
	terrain[x][y].bg = terrainType.bg
	terrain[x][y].tc = terrainType.tc
	terrain[x][y].name = terrainType.name
	terrain[x][y].pos = terrainType.pos
	terrain[x][y].pass = terrainType.pass
end

function getTerrain(x,y)
	local terry = terrain[x][y]
	return terry
end

function getItem(x,y)
	local item = items[x][y]
		if item == nil then
			return nil
		end
	return item
end

function fillWorld()
	for i = 0,1024 do
		for j = 0,1024 do
			setTerrainType(i,j,terrainTypes.floors.dirt)
		end
	end
end

function addTrees(num)
	math.randomseed(os.time())
	for i = 1,num do
		local x = math.random(1024)
		local y = math.random(1024)
		setTerrainType(x,y,terrainTypes.walls.tree)
	end
end

function growTrees(times)
	for i = 1,times do
		for j = 20,1004 do
			for k = 20,1004 do
				local terry = getTerrain(j,k)
				if string.match(terry.name,"wall") then
					local dir = math.random(4)
					if dir == 1 then
						setTerrainType(j+1,k,terrainTypes.walls.tree)
					elseif dir == 2 then
						setTerrainType(j-1,k,terrainTypes.walls.tree)
					elseif dir == 3 then
						setTerrainType(j,k+1,terrainTypes.walls.tree)
					elseif dir == 4 then
						setTerrainType(j,k-1,terrainTypes.walls.tree)
					end
				end
			end	
		end
	end
end

function initCoords()
	terrain = {}
	mobs = {}
	items = {}
	for i = 0,1024 do
		terrain[i] = {}
		mobs[i] = {}
		items[i] = {}
		for j = 0,1024 do
			terrain[i][j] = nil
			mobs[i][j] = nil
			items[i][j] = nil
		end
	end
end

function setTerrainGfx(x,y,str)
	local Terry = getTerrain(x,y)
	Terry.gfx = str
end

function getTerrainBg(x,y)
	local terry = terrain[x][y]
	return terry.bg[1],terry.bg[2],terry.bg[3]
end

function getTerrainTc(x,y)
	local terry = terrain[x][y]
	return terry.tc[1],terry.tc[2],terry.tc[3]
end

function getMobTc(x,y)
	local R = mobs[x][y].tc[1]
	local G = mobs[x][y].tc[2]
	local B = mobs[x][y].tc[3]
	return R,G,B
end

function getItemTc(x,y)
	local R = items[x][y].tc[1]
	local G = items[x][y].tc[2]
	local B = items[x][y].tc[3]
	return R,G,B
end

function isDead(x,y)
	if mobs[x][y].hp <= 0 then
		return true
	else
		return false
	end
end

function update()
	for i = 1,(winWidth-28)/14 do
		for j = 1,(winHeight-56)/14 do
			local x = (i-1)+xOff
			local y = (j-1)+yOff
			if getMob(x,y) ~= nil then
				if isDead(x,y) then
					mobs[x][y] = nil
				end
			end
		end
	end
end

function addDecor(num)
	for i = 1,num do
		local x = math.random(1024)
		local y = math.random(1024)
		local terry = getTerrain(x,y)
		if string.match(terry.name,"wall") then
			if string.match(terry.name,"Forest") then	
				terry.gfx = "^"
			elseif string.match(terry.name,"Rock") then
				terry.gfx = ";"
			end
		end
		if string.match(terry.name,"floor") then
			if string.match(terry.name,"Dirt") then
					terry.gfx = "~"
			end
		end
	end
end

function placeItems(num,itemType)
	math.randomseed(os.time())
	for i = 1,num do
		local x = math.random(1024)
		local y = math.random(1024)
		local item = getItem(x,y)
		if item == nil and terrain[x][y].pass then
			items[x][y] = {}
			items[x][y].name = itemType.name or ""
			items[x][y].weight = itemType.weight or 0
			items[x][y].desc = itemType.desc or ""
			items[x][y].dmg = itemType.dmg or {0,0}
			items[x][y].rng = itemType.rng or 0
			items[x][y].accMod = itemType.accMod or 0
			items[x][y].durability = itemType.durability or 100
			items[x][y].prefix = itemType.prefix or ""
			items[x][y].suffix = itemType.suffix or ""
			items[x][y].tc = itemType.tc or {255,255,255}
			items[x][y].gfx = itemType.gfx or "?"
			items[x][y].pos = {x,y}
			items[x][y].ac = itemType.ac or 0
			items[x][y].slots = itemType.slots or 0
			items[x][y].effect = itemType.effect or "none"
			items[x][y].magnitude = itemType.magnitude or 0
			items[x][y].pages = itemType.pages or nil
			items[x][y].questID = itemType.questID or nil
		end
	end
end