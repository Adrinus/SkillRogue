function drawWorld()
	for i = 14,winWidth-28,14 do
		for j = 28,winHeight-56,14 do
			local x = ((i/14)-1) + xOff
			local y = ((j/14)-1) + yOff
			local terry = getTerrain(x,y)
			love.graphics.setColor(getTerrainBg(x,y))
			love.graphics.rectangle("fill",i,j,14,14)
			love.graphics.setColor(getTerrainTc(x,y))
			love.graphics.print(terry.gfx,i,j)
			if mobs[x][y] ~= nil then
				local gfx = mobs[x][y].gfx
				love.graphics.setColor(getMobTc(x,y))
				love.graphics.print(gfx,i,j)
			end
		end
	end
end

function drawStatus()
	love.graphics.setColor(220,220,220,255)
	love.graphics.print(status,(winWidth/2)-80,(winHeight/2)-50)
end

function drawHud()
	love.graphics.setColor(50,50,60,255)
	love.graphics.rectangle("fill",0,0,winWidth,27)
	local screenBottom = ((math.floor((winHeight-56)/14))*14)+15
	love.graphics.rectangle("fill",0,screenBottom,winWidth,55)
	love.graphics.setColor(220,220,220,255)
	love.graphics.rectangle("line",0,0,winWidth,27)
	love.graphics.rectangle("line",0,screenBottom,winWidth,(winHeight-screenBottom))
	love.graphics.setColor(220,220,220,255)
	love.graphics.rectangle("line",0,28,13,screenBottom-28)
	love.graphics.rectangle("line",4,28,5,screenBottom-28)
	love.graphics.rectangle("line",(winWidth-14),28,13,screenBottom-28)
	love.graphics.rectangle("line",(winWidth-14)+4,28,5,screenBottom-28)
end

function drawSplash()
	love.graphics.setColor(200,50,50,255)
	love.graphics.print("N",(winWidth/2)-50,(winHeight/2)-50)
	love.graphics.setColor(200,200,200,255)
	love.graphics.print("ew Game",(winWidth/2)-40,(winHeight/2)-50)
end