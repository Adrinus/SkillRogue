--Rogue by Steve Price McKibbon Jr. aka Adrinus or pricemac

require("Utilities.util")
require("gameplay")
require("Utilities.draw")

-- Beginning of LOVE2D Structure

function love.load()
	terrains = 0
	love.window.setTitle("Rogue")
	love.graphics.setBackgroundColor(0,0,0)
	desktopWidth, desktopHeight = love.window.getDesktopDimensions(1)
	love.window.setMode((math.floor(desktopWidth/14)*14)-14,(math.floor((desktopHeight-60)/14)*14)-14)
	winWidth, winHeight = love.window.getMode()
	tick = 0
	animTick = 0
	ticks = 0
	tps = 0
	xOff = 135
	yOff = 135
	mobList = {}
	terrainList = {}
	itemList = {}
	screen = "main"
	initCoords()
	generateTerrainTypes()
	fillWorld()
	addTrees(30000)
	growTrees(5)
	playerName = "Avatar"
	generateMobTypes()
	generateItemTypes()
	currentX = 135
	currentY = 135
	placeMobs(mobTypes.monsters.low.slime,10000)
	placeMobs(mobTypes.animals.low.rat,5000)
	addDecor(40000)
end

function love.update(dt)
	if tick < 1 then
		tick = tick + dt
		ticks = ticks + 1
	else
		tick = tick - 1
		tps = ticks
		ticks = 0
	end
	if animTick < 2 then
		animTick = animTick + dt
	else
		animTick = animTick - 2
	end
end

function love.mousepressed(x,y,key)
	
end

function love.keypressed(key,isrepeat)
	if key == "w" then
		if currentY > 1 then
			currentY = currentY - 1
			yOff = currentY
		end
	end
	if key == "a" then
		if currentX > 1 then
			currentX = currentX - 1
			xOff = currentX
		end
	end
	if key == "s" then
		if currentY < (winHeight-(((winHeight-21)/14)-1)) then
			currentY = currentY + 1
			yOff = currentY
		end
	end
	if key == "d" then
		if currentX < (winWidth-(((winWidth-28)/14)-1)) then
			currentX = currentX + 1
			xOff = currentX
		end
	end
end

function love.draw()
	drawWorld()
	if screen == "main" then
		drawHud()
	end
	love.graphics.print(tps,winWidth-20,1)
end

function love.quit()
	
end