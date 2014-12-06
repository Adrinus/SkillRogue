--Rogue by Steve Price McKibbon Jr. aka Adrinus or pricemac

require("gameplay")
require("Resources.magic")
require("Utilities.util")
require("Utilities.draw")

function love.load()
	love.window.setTitle("Rogue")
	love.graphics.setBackgroundColor(0,0,0)
	desktopWidth, desktopHeight = love.window.getDesktopDimensions(1)
	love.window.setMode((math.floor(desktopWidth/14)*14)-14,(math.floor((desktopHeight-60)/14)*14)-14)
	winWidth, winHeight = love.window.getMode()
	screen = "splash"
	tick = 0
	ticks = 0
	animTick = 0
	tps = 0
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
	if screen == "main" then
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
	if screen == "splash" then
		if key == "n" then
			screen = "loading"
			startup()
		end
	end
end

function love.draw()
	if screen == "splash" then
		drawSplash()
	end
	if screen == "main" then
		drawWorld()
		drawHud()
	end
	if screen == "loading" then
		drawStatus()
	end
	love.graphics.print(tps,winWidth-20,1)
end

function love.quit()
	output(debugOut(spells))
end