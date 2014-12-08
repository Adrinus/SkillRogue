--Rogue by Steve Price McKibbon Jr. aka Adrinus or pricemac

require("gameplay")
require("Resources.magic")
require("Utilities.util")
require("Utilities.draw")

function love.load()
	love.window.setTitle("Rogue")
	--love.graphics.setFont(love.graphics.newFont( "Resources/arialbd.ttf", 12 ))
	love.graphics.setBackgroundColor(0,0,0)
	desktopWidth, desktopHeight = love.window.getDesktopDimensions(1)
	love.window.setMode((math.floor(desktopWidth/14)*14)-14,(math.floor((desktopHeight-60)/14)*14)-14)
	winWidth, winHeight = love.window.getMode()
	screen = "splash"
	tick = 0
	ticks = 0
	animTick = 0
	tps = 0
	xOff = 0
	yOff = 0
	mobs = {}
	interact = "examine"
	step = 0
	growcycles = 1
end

function love.update(dt)
	if tick < 1 then
		tick = tick + dt
		ticks = ticks + 1
		if screen == "main" then
			bubbleFloat()
		end
	else
		tick = tick - 1
		tps = ticks
		ticks = 0
		if screen == "main" then
			update()
		end
	end
	if screen == "loading" then
		if step == 0 then
			status = "Creating World"
			step = 1
		elseif step == 1 then
			createWorld()
			status = "Placing Town"
		elseif step == 2 then
			placeTown()
			status = "Placing Cave"
		elseif step == 3 then
			placeCave()
			status = "Growing Biomes: 0%"
		elseif step == 4 then
			if growcycles < 31 then
				growSeeds()
				status = "Growing Biomes: " ..math.floor((growcycles/30)*100) .."%"
				growcycles = growcycles + 1
			else
				step = 5
				status = "Placing Barriers"
				growcycles = 0
			end
		elseif step == 5 then
			placeWalls()
			status = "Growing Barriers"
		elseif step == 6 then
			growWalls()
			status = "Final Touches"
		elseif step == 7 then
			placeMobs(mobTypes.monsters.low.slime,10000)
			placeMobs(mobTypes.animals.low.rat,5000)
			addDecor(80000)
			placeItems(10000,itemTypes.weapons.swords.shortSword)
			clearPlayer()
			screen = "main"
			step = 0
		end
	end
	--Animations tick here
	if animTick < 2 then
		animTick = animTick + dt
	else
		animTick = animTick - 2
		
	end
end

function love.mousepressed(x,y,key)
	if screen == "main" then
		if key == "l" and x > 14 and x < winWidth-14 and y > 28 and y < winHeight-56 then
			local tileX = math.floor((x/14)-2) + (xOff-math.floor((((winWidth-28)/14)-1)/2))
			local tileY = math.floor((y/14)-1) + (yOff-math.floor((((winHeight-56)/14)-1)/2))
			if interact == "smash" then
				if math.sqrt((player.posX-tileX)^2) < 2 and math.sqrt((player.posY-tileY)^2) < 2 then
					local terry = terrain[tileX][tileY]
					if terry.name == "Wooden wall" then
						setTerrainType(tileX,tileY,terrainTypes.floors.cobble)
						newBubble(x,y,"Smash!",{100,100,100},{200,0,0})
					elseif terry.name == "Rock wall" then
						setTerrainType(tileX,tileY,terrainTypes.floors.rock)
						newBubble(x,y,"Smash!",{100,100,100},{200,0,0})
					elseif terry.name == "Forest wall" then
						setTerrainType(tileX,tileY,terrainTypes.floors.dirt)
						newBubble(x,y,"Smash!",{100,100,100},{200,0,0})
					else
						newBubble(x,y,"Can't Smash",{100,100,100},{0,0,0})
					end
				end
			end
		end
	end
end

function love.keypressed(key,isrepeat)
	if screen == "main" then
		if key == "up" then
			if player.posY > 1 and terrain[player.posX][player.posY-1].pass and getMob(player.posX,player.posY-1) == nil then
				player.posY = player.posY - 1
				yOff = player.posY
			end
		elseif key == "left" then
			if player.posX > 1 and terrain[player.posX-1][player.posY].pass and getMob(player.posX-1,player.posY) == nil then
				player.posX = player.posX - 1
				xOff = player.posX
			end
		elseif key == "down" and terrain[player.posX][player.posY+1].pass and getMob(player.posX,player.posY+1) == nil then
			if player.posY < (winHeight-(((winHeight-21)/14)-1)) then
				player.posY = player.posY + 1
				yOff = player.posY
			end
		elseif key == "right" and terrain[player.posX+1][player.posY].pass and getMob(player.posX+1,player.posY) == nil then
			if player.posX < (winWidth-(((winWidth-28)/14)-1)) then
				player.posX = player.posX + 1
				xOff = player.posX
			end
		elseif key == "s" then
			interact = "smash"
		end
	end
	if screen == "splash" then
		if key == "n" then
			startup()
			screen = "loading"
		end
	end
end

function love.draw()
	if screen == "splash" then
		drawSplash()
	end
	if screen == "main" then
		drawWorld()
		drawBubbles()
		drawHud()
	end
	if screen == "loading" then
		drawStatus()
	end
	if screen == "popup" then
		drawPopup(popup)
	end
	love.graphics.print("Ticks per Second - " ..tps,winWidth-200,1)
end

function love.quit()
	
end