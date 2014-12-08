function drawWorld()
	local screenTop = 28
	local screenHeight = math.floor(((winHeight-(28+screenTop))/14)-1)
	local screenLeft = 14
	local screenWidth = math.floor(((winWidth-(14-screenLeft))/14)-1)
	for i = 14,winWidth-28,14 do
		for j = 28,winHeight-56,14 do
			local x = ((i/14)-1) + xOff-math.floor(screenWidth/2)
			local y = ((j/14)-1) + yOff-math.floor(screenHeight/2)
			local terry = getTerrain(x,y)
			love.graphics.setColor(getTerrainBg(x,y))
			love.graphics.rectangle("fill",i,j,14,14)
			love.graphics.setColor(getTerrainTc(x,y))
			love.graphics.print(terry.gfx,i,j)
			if getMob(x,y) ~= nil then
				local gfx = mobs[x][y].gfx
				love.graphics.setColor(getMobTc(x,y))
				love.graphics.print(gfx,i,j)
			end
			if getItem(x,y) ~= nil then
				local gfx = items[x][y].gfx
				love.graphics.setColor(getItemTc(x,y))
				love.graphics.print(gfx,i,j)
			end
			if player.posX == x and player.posY == y then
				love.graphics.setColor(255,255,255)
				love.graphics.print("@",i,j)
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

function getRGB(bgtc)
	local R = 0
	local G = 0
	local B = 0
	R = bgtc[1]
	G = bgtc[2]
	B = bgtc[3]
	return R,G,B
end

function drawBubbles()
	if #bubbles > 0 then
		for i = 1,#bubbles do
			local bubX = bubbles[i].x
			local bubY = bubbles[i].y
			local width = bubbles[i].wid
			local txt = bubbles[i].text
			love.graphics.setColor(getRGB(bubbles[i].bg))
			love.graphics.rectangle("fill",bubX,bubY,width,14)
			love.graphics.setColor(getRGB(bubbles[i].tc))
			love.graphics.print(txt,bubX,bubY)
		end
	end
end

function drawPopup(x,y,w,h,bg)
	love.graphics.setColor(getRGB(bg))
	love.graphics.rectangle("fill",x,y,w,h)
end