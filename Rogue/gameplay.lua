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
	addDecor(40000)
	status = "Inventing Magic..."
	makeMagic()
	screen = "main"
end

function getMob(x,y)
	local mob = mobs[x][y]
	if mob.hp == nil then
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

function addDecor(num)
	for i = 1,num do
		local x = math.random(1024)
		local y = math.random(1024)
		local terry = terrain[x][y]
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