assets = {
   images = {},
   audio = {},
   fonts = {}
}

function draw_splash(tut, loading_status)
   love.graphics.clear()
   love.graphics.draw( assets.images.logo, 0, 0 )
   love.graphics.setFont( assets.fonts.font )
   love.graphics.printf( tut, 0, 200, love.graphics.getWidth(), "center"  )
   love.graphics.setFont( assets.fonts.bfont )
   love.graphics.printf("Loading",0,love.graphics.getHeight()/3,love.graphics.getWidth(),"center")
   love.graphics.printf(string.rep("+", loading_status)..string.rep("-", 5-loading_status),0,love.graphics.getHeight()/2,love.graphics.getWidth(),"center")
   love.graphics.present()
end

function bottom_rigth_engine(e) 
   if fuel > 0 then
	    
      objects.ship.rs = objects.ship.rs + 1 * e 
      objects.ship.ys = objects.ship.ys - math.floor(math.sin(objects.ship.angle)*4 + 0.5)/4 * 50 * e
      objects.ship.xs = objects.ship.xs - math.floor(math.cos(objects.ship.angle)*4 + 0.5)/4 * 50 * e

      fuel = fuel - 10 * e
	    
      if math.random(ra()) == 1 then
	 newGasPar(objects.ship.x,objects.ship.y,objects.ship.angle,"d")
      end
   end
end

function top_left_engine(e)
   if fuel > 0 then
	    
      objects.ship.rs = objects.ship.rs + 1 * e
      objects.ship.ys = objects.ship.ys + math.floor(math.sin(objects.ship.angle)*4 + 0.5)/4 * 50 * e
      objects.ship.xs = objects.ship.xs + math.floor(math.cos(objects.ship.angle)*4 + 0.5)/4 * 50 * e

      fuel = fuel - 10 * e
      
      if math.random(ra()) == 1 then
	 newGasPar(objects.ship.x,objects.ship.y,objects.ship.angle,"q")
      end
   end
end

function bottom_left_engine(e)
   if fuel > 0 then
	    
      objects.ship.rs = objects.ship.rs - 1 * e
      objects.ship.ys = objects.ship.ys + math.floor(math.sin(objects.ship.angle)*4 + 0.5)/4 * 50 * e
      objects.ship.xs = objects.ship.xs + math.floor(math.cos(objects.ship.angle)*4 + 0.5)/4 * 50 * e

      fuel = fuel - 10 * e
	    
      if math.random(ra()) == 1 then
	 newGasPar(objects.ship.x,objects.ship.y,objects.ship.angle,"a")
      end
   end	
end

function top_right_engine(e)
   if fuel > 0 then
	    
      objects.ship.rs = objects.ship.rs - 1 * e
      objects.ship.ys = objects.ship.ys - math.floor(math.sin(objects.ship.angle)*4 + 0.5)/4 * 50 * e
      objects.ship.xs = objects.ship.xs - math.floor(math.cos(objects.ship.angle)*4 + 0.5)/4 * 50 * e

      fuel = fuel - 10 * e
	    
      if math.random(ra()) == 1 then
	 newGasPar(objects.ship.x,objects.ship.y,objects.ship.angle,"e")
      end
   end			
end

function bottom_engine(e)
   if fuel > 0 then
      objects.ship.ys = objects.ship.ys - math.floor(math.cos(objects.ship.angle)*4 + 0.5)/4 * 200 * e
      objects.ship.xs = objects.ship.xs + math.floor(math.sin(objects.ship.angle)*4 + 0.5)/4 * 200 * e
	    
      fuel = fuel - 20 * e
	    
      if math.random(ra()) == 1 then
	 newGasPar(objects.ship.x,objects.ship.y,objects.ship.angle,"s")
      end
   end
end

function top_engine(e)
   if fuel > 0 then
      objects.ship.ys = objects.ship.ys + math.floor(math.cos(objects.ship.angle)*4 + 0.5)/4 * 200 * e
      objects.ship.xs = objects.ship.xs - math.floor(math.sin(objects.ship.angle)*4 + 0.5)/4 * 200 * e
	    
      fuel = fuel - 20 * e
	    
      if math.random(ra()) == 1 then
	 newGasPar(objects.ship.x,objects.ship.y,objects.ship.angle,"w")
      end
   end
end

function toggle_shields()
   if not pause then
      shields = not shields
      
      if shields and not deathmess then
	 drawList[100][4] = "shields"
      else
	 drawList[100][4] = nil
      end
   end	 
end

function pause()
   if not help then pause = not pause ppause = not ppause end
	 
   if pause then
      love.graphics.setShader(greyOut)
   else
      love.graphics.setShader()
   end

end


function load_images()
   -- overrides previous assets.images
   assets.images = {
      logo = assets.images.logo, -- logo was already loaded
      speakerOn = love.graphics.newImage("speaker.png"),
      speakerOff = love.graphics.newImage("no_speaker.png"),
      boom = love.graphics.newImage("boom.png"),
      fullscreen = love.graphics.newImage("fullscreen.png")
   }
end

function load_audio()
   assets.audio = {
      mus1 = love.audio.newSource("astr1.wav", "stream"),
      mus2 = love.audio.newSource("astr2.wav", "stream")
   }
end

function load_fonts()
   assets.fonts = {
      font = love.graphics.newFont("pcsenior.ttf",12),
      mfont = love.graphics.newFont("pcsenior.ttf",16),
      mbfont = love.graphics.newFont("pcsenior.ttf",36),
      bfont = love.graphics.newFont("pcsenior.ttf",48)
   }

end

function love.load()
   local loading_status = 0

   screenWidth = 800
   screenHeight = 600
	
   assets.images.logo = love.graphics.newImage("logo.png")
   
   keyBind = {
      en_t = "w",
      en_b = "s",
      en_tl = "q",
      en_tr = "e",
      en_bl = "a",
      en_br = "d",
      
      shld = "rmb",
      sens = "tab",
      
      pause = "p",
      
      self_dest = "f9"
   }
   
   tut = "Gameplay Tip: Use "..keyBind.en_t..", "..keyBind.en_b..", "..keyBind.en_bl..", "..keyBind.en_br..", "..keyBind.en_tl.." and "..keyBind.en_tr.." to operate engines, use mouse buttons to operate laser and shields. Try to get as many points as you can without crashing. Good luck!"
   
   love.graphics.setBackgroundColor(0,0,0)
   love.graphics.setLineWidth(2)
   love.graphics.setLineStyle("rough")
   love.graphics.setPointSize(2)

   load_fonts()
   
   draw_splash(tut, loading_status)
   loading_status = loading_status + 1
   
   load(function()
	 collisionParticles = true
	 writefile = true

	 if love.filesystem.getInfo("config.lua").type == file then
	    dofile("config.lua")
	 end
   end)
   
   load(function()
	 if love.graphics.getSupported()["pixeleffect"] then
	    greyOut = love.graphics.newPixelEffect[[
			vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
			{
				if(color.r > 0.5){
					color.r = 0.5 + abs(color.r - 0.5)/2;
				}
				else{
					color.r = 0.5 - abs(color.r - 0.5)/2;
				}
				
				if(color.g > 0.5){
					color.g = 0.5 + abs(color.g - 0.5)/2;
				}
				else{
					color.g = 0.5 - abs(color.g - 0.5)/2;
				}
				
				if(color.b > 0.5){
					color.b = 0.5 + abs(color.b - 0.5)/2;
				}
				else{
					color.b = 0.5 - abs(color.b - 0.5)/2;
				}
			
				return vec4(color.r, color.g, color.b, color.a);
			}
		]]
			redOut = love.graphics.newPixelEffect[[
			vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 pixel_coords)
			{
				if(color.r > 0.5){
					color.r = 1;
				}
				else{
					color.r = color.r +0.5;
				}
				
				if(color.g > 0.5){
					color.g = 0.5 + abs(color.g - 0.5)/2;
				}
				else{
					color.g = 0.5 - abs(color.g - 0.5)/2;
				}
				
				if(color.b > 0.5){
					color.b = 0.5 + abs(color.b - 0.5)/2;
				}
				else{
					color.b = 0.5 - abs(color.b - 0.5)/2;
				}
			
				return vec4(color.r, color.g, color.b, color.a);
			}
		]]
	 end
	end
   )

   writefile = true
   
   sup = load (function()	
	 if writefile then
	    if not love.filesystem.getInfo("scores.txt").type == file then
	       love.filesystem.write("scores.txt","Mad Joe - 1 000 000\r\nLovely Lary - 290 000\r\nNoShield Johny - 120 000\r\nGo Power - 80 000\r\nMaria the Female-one - 36 000\r\nOne-eyed Tim - 13 000\r\nBestmen - 5 700\r\nusername - 3 300\r\nThat Guy - 1 200\r\nloler - 1")
	    end
	    
	    scores = {}
	    
	    local n = 1
	    
	    for line in love.filesystem.lines("scores.txt") do
	       scores[n] = {string.gsub(line," %-.+",""),string.gsub(line,".+%- ","")}
	       n = n+1
	    end
	 end
   end)

   if sup then sup() else writefile = false end

   load_audio()
   
   bob = true

   draw_splash(tut, loading_status)
   loading_status = loading_status + 1
   
   muel = 5999

   maxTxt = 100
   maxGas = 1000
   maxAstro = math.ceil(100*screenWidth*screenHeight/1000000)
   liMax = 100
   maxPeb = 5000
   
   if maxAstro < 100 then maxAstro = 100 end
   
   DeclareClasses()

   draw_splash(tut, loading_status)
   loading_status = loading_status + 1
   
   LoadStuff()

   draw_splash(tut, loading_status)
   loading_status = loading_status + 1
   
   --love.window.setIcon(love.image.newImage("Rysunek.png"))

   load_images()
   
   love.mouse.setVisible(false)
   
   keydown = {
      ["en_br"] = bottom_rigth_engine,
      ["en_tl"] = top_left_engine,
      ["en_bl"] = bottom_left_engine,
      ["en_tr"] = top_right_engine,
      ["en_b"] = bottom_engine,
      ["en_t"] = top_engine
   }
   keypress = {
      ["shld"] = toggle_shields,
      ["sens"] = function()
	 sensors = not sensors
      end,
      ["pause"] = pause,
      ["space"] = function()
	 if deathmess then love.graphics.setShader(greyOut) LoadStuff() end
      end,
      ["self_dest"] = function()
	 if not deathmess then colisions.ship = true end
      end,
      ["f1"] = function()
	 if not deathmess then help = not help end
	 
	 if help then
	    pause = true
	    ppause = true
	    love.graphics.setShader(greyOut)
	 else
	    pause = false
	    ppause = false
	    love.graphics.setShader()
	 end
      end,
      ["f2"] = function()
	 if deathmess and writefile then
	    hiscore = not hiscore
	 end
      end,
      ["f4"] = function()
	 if love.keyboard.isDown("lalt") then
	    love.event.push("quit")
	 end
      end,
      ["f12"] = function()
	 if hiscore and writefile then
	    
	    for n=1,10 do
	       scores[n] = {"---",0}
	    end
	 end
      end,
      ["f5"] = function()
	 mute = not mute
      end,
      ["escape"] = function()
	 pause = not pause
	 ppause = not ppause
	 
	 if pause then
	    love.graphics.setShader(greyOut)
	 else
	    love.graphics.setShader()
	 end
	 
	 if help then help = false end
      end,
      ["return"] = function()
	 if hiscore then
	    if got < 11 then
	       scores[got][1] = user
	       got = 11
	    end

	    love.graphics.setShader()
	    LoadStuff()	
	 end
      end,
      lmb = function()
	 if not deathmess and fuel > 0 and not pause then
	    local x,y
	    
	    x = love.mouse.getX()/(love.graphics.getWidth()/screenWidth)-screenWidth/2
	    y = love.mouse.getY()/(love.graphics.getWidth()/screenWidth)-screenHeight/2
	    
	    liList[100][liCount] = {math.sqrt(x^2+y^2)*math.cos(math.atan2(y,x)+ang)+screenWidth/2+ofx,math.sqrt(x^2+y^2)*math.sin(math.atan2(y,x)+ang)+screenHeight/2+ofy,screenWidth/2+ofx,screenHeight/2+ofy,math.random(3)+9,(love.mouse.getX()-screenWidth/2)*1000+screenWidth/2,(love.mouse.getY()-screenHeight/2)*1000+screenHeight/2,screenWidth/2,screenHeight/2,0}
	    liCount = liCount + 1
	    
	    fuel = fuel - 20
	    
	    if liCount > liMax then
	       liCount = 0
	    end
	 end
      end,	
      wu = function()
	 if screenWidth>love.graphics.getWidth() and canvasSup and not pause then
	    screenWidth = screenWidth/2
	    screenHeight = screenHeight/2
	    canvas = love.graphics.newCanvas(screenWidth,screenHeight)
	 end
      end,
      wd = function()
	 if screenWidth<love.graphics.getWidth()*5 and canvasSup and not pause then
	    screenWidth = screenWidth*2
	    screenHeight = screenHeight*2
	    canvas = love.graphics.newCanvas(screenWidth,screenHeight)
	 end
      end,
      any = function()
	 if inmess then love.graphics.setShader() inmess = false pause = false end
      end
   }
   keyrel = {
      any = function()
	 if pause then pause = false ppause = false end
      end
   }
   
   draw_splash(tut, loading_status)
   loading_status = loading_status + 1

   rkeyBind = {}
   
   for k,v in pairs(keyBind) do
      rkeyBind[v] = k
   end
   
   keyConst = {
      ["space"] = "space",
      ["kp0"] = 'numpad 0',
      ["kp1"] = 'numpad 1',
      ["kp2"] = 'numpad 2',
      ["kp3"] = 'numpad 3',
      ["kp4"] = 'numpad 4',
      ["kp5"] = 'numpad 5',
      ["kp6"] = 'numpad 6',
      ["kp7"] = 'numpad 7',
      ["kp8"] = 'numpad 8',
      ["kp9"] = 'numpad 9',
      ["kp."] = 'numpad .',
      ["kp,"] = 'numpad ,',
      ["kp/"] = 'numpad /',
      ["kp*"] = 'numpad *',
      ["kp-"] = 'numpad -',
      ["kp+"] = 'numpad +',
      ["kpenter"] = 'numpad enter',
      ["kp="] = 'numpad =',
      ["pageup"] = 'page up',
      ['pagedown'] = 'page down',
      ['scrolllock'] = 'scroll lock',
      ['rshift'] = 'right shift',
      ['lshift'] = 'left shift',
      ['rctrl'] = 'right ctrl',
      ['lctrl'] = 'left ctrl',
      ['ralt'] = 'right alt',
      ['lalt'] = 'left alt'
   }
   
   sizeEx = {
      [1] = {0,0},
      [2] = {4,1},
      [3] = {2,2},
      [4] = {4,2},
      [5] = {6,2},
      [6] = {4,3},
      [7] = {3,4},
      [8] = {4,4},
      [9] = {3,5},
      [10] = {4,5},
      [11] = {2,8},
      [12] = {4,6},
      [13] = {2,9},
      [14] = {4,7}
   }
   
   love.graphics.setBackgroundColor( 0, 0, 0 )

   love.graphics.clear()
   love.graphics.draw( assets.images.logo, 0, 0 )
   love.graphics.setFont( assets.fonts.font )
   love.graphics.printf( tut, 0, 200, love.graphics.getWidth(), "center"  )
   love.graphics.setFont( assets.fonts.mfont )
   love.graphics.printf("Your game is ready!\r\nPress any key to continue.",0,love.graphics.getHeight()*2/5,love.graphics.getWidth(),"center")
   love.graphics.present()
   
   love.graphics.setFont( assets.fonts.font )
   
   love.event.clear()
   love.event.wait()

   love.graphics.setShader(greyOut)
   love.window.setMode(screenWidth, screenHeight, fullscreen)
   
   assets.audio.mus1:play()
   
   step = 1 / 60
   timePast = love.timer.getTime()
end

function love.update(e)
   timePast = timePast + step
   
   if e > step then
      local e = step
   end
   
   if bob then
      if assets.audio.mus1:tell()>200 then
	 love.audio.play(assets.audio.mus2)
	 love.audio.stop(assets.audio.mus1)
	 
	 bob = nil
      end
   else
      if assets.audio.mus2:tell() > 173 then
	 assets.audio.mus2:seek(0)
      end
   end
   
   if mute then
      assets.audio.mus1:setVolume(0)
      assets.audio.mus2:setVolume(0)
   else
      if ppause and not help then
	 assets.audio.mus1:setVolume(0.1)
	 assets.audio.mus2:setVolume(0.1)
      else
	 assets.audio.mus1:setVolume(1)
	 assets.audio.mus2:setVolume(1)
      end
   end
   
   if not pause then
      
      for k,v in pairs(txtList) do
	 txtList[k][2] = v[2] - 10*e
	 
	 if v[4] - 100*e > 0 then
	    txtList[k][4] = v[4] - 100*e
	 else
	    txtList[k] = nil
	 end
      end
      
      for k,v in pairs(drawList[99]) do
	 if objects[v].col[4] - e*200 > 0 then
	    objects[v].col[4] = objects[v].col[4] - e*200
	 else
	    objects[v] = nil
	    drawList[99][k] = nil
	 end
      end
      
      for k,v in pairs(drawList[49]) do
	 if objects[v].col[4] - e*40 > 0 then
	    objects[v].col[4] = objects[v].col[4] - e*40
	 else
	    objects[v] = nil
	    drawList[49][k] = nil
	 end
      end
      
      drawList[102] = {}
      
      if not deathmess then
	 for k,v in pairs(pressed) do
	    if keydown[k] then
	       keydown[k](e)
	    end
	    
	    if keydown[rkeyBind[k]] then
	       keydown[rkeyBind[k]](e)
	    end
	 end
	 
	 if shields and fuel > 0 then
	    fuel = fuel - 10*e 
	 else
	    shields = false
	    drawList[100][4] = nil
	 end
	 
	 if sensors and fuel > 0 then
	    fuel = fuel - e 
	 else 
	    sensors = false
	 end
	 
	 if math.sqrt(math.abs(objects.ship.x - objects.motherShip.x) + math.abs(objects.ship.y - objects.motherShip.y)) < 25 then
	    fuel = muel
	 end
      end
      
      objects.ship:update(e)
      
      objects.motherShields.angle = objects.motherShip.angle
      
      objects.motherShields.xs = objects.motherShip.xs
      objects.motherShields.ys = objects.motherShip.ys
      objects.motherShields.rs = objects.motherShip.rs
      
      objects.motherShields.x = objects.motherShip.x
      objects.motherShields.y = objects.motherShip.y
      
      objects.shields.angle = objects.ship.angle
      objects.shields.x = objects.ship.x
      objects.shields.y = objects.ship.y
      
      objects.pointer.x = objects.ship.x
      objects.pointer.y = objects.ship.y

      if math.random(4)==1 then newAstr() end
      
      ofx = objects.ship.x - screenWidth/2
      ofy = objects.ship.y - screenHeight/2

      ang = objects.ship.angle
      
      for k,v in pairs(ptList) do
	 if v[3] - e*50 > 0 and ((v[1] > ofx/20-screenWidth and v[1] < screenWidth+ofx/20) or (v[2] > - screenHeight - ofy/20 and v[2] < screenHeight - ofy/20)) then
	    v[3] = v[3] - e*50
	 else
	    ptList[k] = {math.random(screenWidth*5)-2*screenWidth-ofx/20,math.random(screenHeight*5)-2*screenHeight-ofy/20,math.random(255)}
	 end
	 
	 local fi1,fi2,r1,r2,r,x,y
	 x = screenWidth/2 - ptList[k][1] - ofx/20
	 y = screenHeight/2 - ptList[k][2] - ofy/20
	 
	 fi1 = math.atan2(y,x)
	 
	 r = math.sqrt(x^2 + y^2)

	 fi2 = fi1 - ang
	 
	 ptList[k][4] = r * math.cos(fi2) + screenWidth/2
	 ptList[k][5] = r * math.sin(fi2) + screenHeight/2
      end
      
      for m,tab in pairs(drawList) do
	 for k,v in pairs(tab) do
	    if v ~= "ship" then
	       objects[v]:update(e)
	    end
	 end
      end
      
      objects.pointer.angle = math.atan2(objects.ship.x - objects.motherShip.x,-objects.ship.y + objects.motherShip.y)
      objects.pointer.cx = objects.ship.cx
      objects.pointer.cy = objects.ship.cy
      
      if not deathmess then
	 if sensors then
	    for k,v in pairs(drawList[50]) do
	       local n = "pointer"..k
	       local a = math.sqrt((objects.ship.x-objects[v].x)^2+(objects.ship.y-objects[v].y)^2)
	       
	       if a<800 and a>90 then
		  objects[n].angle = math.atan2(objects.ship.x - objects[v].x,-objects.ship.y + objects[v].y)
		  
		  objects[n].x = objects.ship.x
		  objects[n].y = objects.ship.y
		  objects[n].cx = objects.ship.cx
		  objects[n].cy = objects.ship.cy
		  
		  objects[n].col = ct(objects[v].col)
		  objects[n].col[4] = 255*(800-a)/800
		  
		  objects[n]:cam(ofx,ofy,ang)

		  drawList[102][k+2] = "pointer"..k
	       else
		  drawList[102][k+2] = nil
	       end
	    end
	 end
	 
	 if drawList[100][4] then
	    for n,m in pairs(drawList[50]) do
	       if math.abs(objects.shields.x-objects[m].x) < 70-objects[m].odim[2] and math.abs(objects.shields.y-objects[m].y) < 70-objects[m].odim[2] then
		  for	a,b in ipairs(objects[m].vertices) do
		     if a%2 == 1 and (math.abs(objects.shields.x-objects[m].vertices[a]) < 70 and math.abs(objects.shields.y-objects[m].vertices[a+1]) < 70) then
			if objects.shields:checkHit(objects[m].vertices[a],objects[m].vertices[a+1]) then
			   colisions[n] = true
			end
		     end
		  end
	       end
	    end
	 else
	    for n,m in pairs(drawList[50]) do
	       if math.abs(objects.ship.x-objects[m].x) < 60-objects[m].odim[2] and math.abs(objects.ship.y-objects[m].y) < 60-objects[m].odim[2] then
		  for	a,b in ipairs(objects[m].vertices) do
		     if a%2 == 1 then
			if objects.ship:checkHit(objects[m].vertices[a],objects[m].vertices[a+1]) then
			   if -objects[m].odim[2]/10 > 3 then
			      colisions[n] = true
			      colisions["ship"] = true
			   else
			      txtList[txtCount] = {love.graphics.getWidth()/2+math.random(51)-26,love.graphics.getHeight()/2-60-math.random(10),"+"..(50*math.ceil(-objects[m].odim[2]/10)),255}
			      txtCount = txtCount +1
			      score = score+50*math.ceil(-objects[m].odim[2]/10)
			      drawList[50][n] = nil
			      break
			   end
			end
		     end
		  end
	       end
	    end
	 end
      end
      
      for n,m in pairs(liList) do
	 for k,v in pairs(m) do
	    if v[10] then
	       v[10] = objects.ship.xs*e
	       v[11] = objects.ship.ys*e
	       
	       v[1] = v[1] + v[10]
	       v[3] = v[3] + v[10]
	       
	       v[2] = v[2] + v[11]
	       v[4] = v[4] + v[11]
	    end
	    
	    liList[n][k][6] = (v[1]-v[3])*1000+v[3] - ofx
	    liList[n][k][7] = (v[2]-v[4])*1000+v[4] - ofy
	    liList[n][k][8] = v[3] - ofx
	    liList[n][k][9] = v[4] - ofy
	    
	    for i=1,2 do
	       local fi1,fi2,r1,r2,r,cx,cy
	       
	       cx = screenWidth/2 - v[4+i*2]
	       cy = screenHeight/2 - v[5+i*2]
	       
	       r = math.sqrt(cx^2+cy^2)
	       
	       fi1 = math.atan2(-cy,-cx)

	       fi2 = fi1 - ang

	       liList[n][k][4+i*2] = r * math.cos(fi2)+screenWidth/2
	       liList[n][k][5+i*2] = r * math.sin(fi2)+screenHeight/2
	    end
	    
	    liList[n][k][5] = liList[n][k][5]-60*e
	    
	    if liList[n][k][5] <= 0.5 then
	       liList[n][k] = nil
	    else
	       local a,b,dx,dy,dcx,dcy
	       
	       a = ((v[7]-v[9])/(v[6]-v[8]))
	       b = v[7]-a*v[6]
	       
	       ap = ((v[6]-v[8])/(v[7]-v[9]))
	       bp = v[6]-ap*v[7]
	       
	       for n,m in pairs(drawList[50]) do
		  if ((objects[m].cx<v[8]+70 and v[6]<v[8]+70) or (objects[m].cx>v[8]-70 and v[6]>v[8]-70)) and ((objects[m].cy<v[9]+70 and v[7]<v[9]+70) or (objects[m].cy>v[9]-70 and v[7]>v[9]-70)) then
		     if objects[m]:checkHit(objects[m].cx,f(objects[m].cx,a,b)) or objects[m]:checkHit(f(objects[m].cy,ap,bp),objects[m].cy) then
			colisions[n] = true
		     end
		  end
	       end
	    end
	 end
      end
      
      local x1,y1
      motherShields = false
      
      for k,v in pairs(drawList[50]) do
	 local obj = objects[v]
	 
	 if math.abs(obj.x-objects.ship.x) > screenWidth*1.5 or math.abs(obj.y-objects.ship.y) > screenHeight*1.5 then
	    drawList[50][k] = nil
	 else
	    
	    local objv = objects[v].vertices
	    
	    x1 = math.abs(objects[v].x - objects.motherShip.x)
	    y1 = math.abs(objects[v].y - objects.motherShip.y)
	    
	    if x1 < 1230 and y1 < 1230 then
	       motherShields = true
	    end
	    
	    for n,m in pairs(drawList[50]) do
	       if k ~= n then
		  local objm = objects[m]

		  if math.abs(obj.cx - objm.cx) < -objm.odim[2]-obj.odim[2] and math.abs(obj.cy - objm.cy) < -objm.odim[2]-obj.odim[2] then
		     for	a,b in ipairs(objv) do
			if a%2 == 1 then
			   if math.abs(objm.cx - objv[a]) < -objm.odim[2]-obj.odim[2] and math.abs(objm.cy - objv[a+1]) < -objm.odim[2]-obj.odim[2] then
			      if objm:checkHit(objv[a],objv[a+1]) then
				 local s1,s2,m1,m2
				 
				 s1 = obj.odim[2]
				 s2 = objm.odim[2]
				 
				 if s1>s2 then
				    m1 = obj.odim[2]^2
				    m2 = objm.odim[2]^2
				    
				    objects[m].xs = (objm.xs*m2+obj.xs*m1)/(m1+m2)
				    objects[m].ys = (objm.ys*m2+obj.ys*m1)/(m1+m2)
				    
				    colisions[k] = true
				 elseif s1<s2 then
				    m1 = obj.odim[2]^2
				    m2 = objm.odim[2]^2
				    
				    objects[v].xs = (objm.xs*m2+obj.xs*m1)/(m1+m2)
				    objects[v].ys = (objm.ys*m2+obj.ys*m1)/(m1+m2)
				    
				    colisions[n] = true
				 else
				    objects[v].xs = objm.xs
				    objects[v].ys = objm.ys
				    
				    objects[m].xs = obj.xs
				    objects[m].ys = obj.ys
				    
				    colisions[k] = true
				    colisions[n] = true
				    
				    --[[objects[v].x = obj.x + math.cos(math.atan2(obj.y-objm.y,obj.x-objm.x))
				       objects[v].y = obj.y + math.sin(math.atan2(obj.y-objm.y,obj.x-objm.x))
				       
				       objects[m].x = objm.x - math.cos(math.atan2(obj.y-objm.y,obj.x-objm.x))
				       objects[m].y = objm.y - math.sin(math.atan2(obj.y-objm.y,obj.x-objm.x))]]
				 end
			      end
			   end
			end
		     end
		  end
	       end
	    end
	    
	    if math.abs(obj.cx - objects.motherShields.cx) < 700 and math.abs(obj.cy - objects.motherShields.cy) < 700 then
	       for	a,b in ipairs(obj.vertices) do
		  if a%2 == 1 then
		     if objects.motherShields:checkHit(obj.vertices[a],obj.vertices[a+1]) then
			colisions[k] = true
		     end
		  end
	       end
	    end
	    
	    if not deathmess then
	       if drawList[100][4] then
		  for	a,b in ipairs(obj.vertices) do
		     if a%2 == 1 then
			if math.abs(obj.cx - objects.ship.cx) < 70-obj.odim[2] and math.abs(obj.cy - objects.shields.cy) < 70-obj.odim[2] then
			   if objects.shields:checkHit(obj.vertices[a],obj.vertices[a+1]) then
			      colisions[k] = true	
			   end
			end
		     end
		  end
	       elseif math.abs(obj.cx - objects.ship.cx) < 56-obj.odim[2] and math.abs(obj.cy - objects.shields.cy) < 56-obj.odim[2] and not colisions[v] then
		  for	a,b in ipairs(obj.vertices) do
		     if a%2 == 1 then
			if objects.ship:checkHit(obj.vertices[a],obj.vertices[a+1]) then
			   if -obj.odim[2]/10 > 3 then
			      colisions[k] = true
			      colisions["ship"] = true
			   else
			      txtList[txtCount] = {love.graphics.getWidth()/2+math.random(51)-26,love.graphics.getHeight()/2-60-math.random(10),"+"..(50*math.ceil(-obj.odim[2]/10)),255}
			      txtCount = txtCount +1
			      
			      if txtCount>maxTxt then
				 txtCount = 1
			      end
			      
			      score = score+50*math.ceil(-obj.odim[2]/10)
			      drawList[50][k] = nil
			      break
			   end
			end
		     end
		  end
	       end
	    end

	 end
      end
      
      if motherShields then
	 drawList[80][2] = "motherShields"
      else
	 drawList[80][2] = nil
      end
      
      for k,v in pairs(drawList[49]) do
	 if objects[v].col[4] - e*40 > 0 then
	    objects[v].col[4] = objects[v].col[4] - e*40
	    
	    if motherShields then
	       if math.abs(objects[v].cx - objects.motherShields.cx) < 630 and math.abs(objects[v].cy - objects.motherShields.cy) < 630 then
		  if objects.motherShields:checkHit(objects[v].cx,objects[v].cy) then
		     drawList[49][k] = nil
		  end
	       end
	    else
	       if math.abs(objects[v].cx - objects.motherShip.cx) < 566 and math.abs(objects[v].cy - objects.motherShip.cy) < 566 then
		  if objects.motherShip:checkHit(objects[v].cx,objects[v].cy) then
		     drawList[49][k] = nil
		  end
	       end
	    end
	    
	    if shields then
	       if math.abs(objects[v].cx - objects.shields.cx) < 70 and math.abs(objects[v].cy - objects.shields.cy) < 70 then
		  if objects.shields:checkHit(objects[v].cx,objects[v].cy) then
		     drawList[49][k] = nil
		  end
	       end
	    else
	       if math.abs(objects[v].cx - objects.ship.cx) < 56 and math.abs(objects[v].cy - objects.ship.cy) < 56 then
		  if objects.ship:checkHit(objects[v].cx,objects[v].cy) then
		     drawList[49][k] = nil
		  end
	       end
	    end
	    
	 else
	    objects[v] = nil
	    drawList[49][k] = nil
	 end
      end
      
      for i,v in pairs(colisions) do
	 HandleColisions(i,collisionParticles)
      end
      
      if colisions.ship then
	 
	 if drawList[100] then
	    shields = false
	    
	    drawList[101] = {}
	    
	    for i=1,16 do
	       objects["remains"..i] = poly.new(objects.ship.x,objects.ship.y,{-20,-20,-20,20,20,20,20,-20},"fill",{0xff,0xff,0xff,0xff},math.random(500)-250+objects.ship.xs,math.random(500)-250+objects.ship.ys,math.random(10)-5)
	       objects["remains"..i]:cam(ofx,ofy,ang)
	       drawList[101][i] = "remains"..i
	    end
	    
	    for i=1,80 do
	       objects["gas"..gasCount+i] = poly.new(objects.ship.x,objects.ship.y,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"fill",{0xfc,0xf7,0x5e,0xff},((math.random(2000)-1000)/2)*math.sin(math.random(628)/100)+objects.ship.xs,((math.random(2000)-1000)/2)*math.cos(math.random(628)/100)+objects.ship.ys,math.random()*math.pi)
	       drawList[99][gasCount+i] = "gas"..gasCount+i
	    end
	    
	    if got < 11 then
	       hiscore = true
	       
	       local sscore = ((score-(((score-score%1000)/1000)%1000)*1000-score%1000)/1000000).."h"..(((score-score%1000)/1000)%1000).."|"..(score%1000)
	       
	       sscore = string.gsub(sscore,"0h","l")
	       
	       sscore = string.gsub(sscore,"h(%d)|"," 00%1|")
	       sscore = string.gsub(sscore,"h(%d%d)|"," 0%1|")
	       sscore = string.gsub(sscore,"h"," ")
	       
	       sscore = string.gsub(sscore,"l0|","")
	       sscore = string.gsub(sscore,"l","")
	       
	       sscore = string.gsub(sscore,"|(%d%d%d)"," %1")
	       sscore = string.gsub(sscore,"|(%d%d)"," 0%1")
	       
	       scores[10] = {"",sscore}
	       
	       table.sort(scores, function(a,b) return tonumber(string.gsub(a[2]," ",""),10)>tonumber(string.gsub(b[2]," ",""),10) end)
	    end
	 end
	 
	 drawList[100] = {}
	 drawList[102] = {}
	 
	 objects.ship.xs = 0
	 objects.ship.ys = 0
	 objects.ship.rs = 0
	 
	 
	 deathmess = true
	 inmess = false
	 
	 colisions.ship = nil
      else
	 objects.ship.cx = screenWidth/2
	 objects.ship.cy = screenHeight/2
	 objects.ship.cangle = 0
	 
	 objects.ship:cam(ofx,ofy,ang)
      end
      
      if writefile then
	 for k,v in spairs(scores) do
	    if score > tonumber(string.gsub(v[2]," ",""),10) and k < got then
	       got = k
	       dod = true
	    end
	 end
      end
      
      if dod then if got < 11 and scores[got][1]~="---" then txtList[100+got] = {screenWidth/2,20,"You bested "..scores[got][1],255} dod = false end end
	 
   end
   
   objects.ast1:checkHit(love.mouse.getX(),love.mouse.getY())
   
   if help and te(drawList[102]) then
      drawList[102][3] = "pointer1"
      
      objects.pointer1.x = objects.ship.x
      objects.pointer1.y = objects.ship.y
   end
end

function love.draw()
   pix = love.graphics.getShader()
   love.graphics.setShader(pix)
   
   love.graphics.setBackgroundColor( 0, 0, 0 )
   
   
   for k,v in pairs(ptList) do
      if v[4] then
	 love.graphics.setColor(1,1,1,v[3]/255)
	 
	 love.graphics.points(v[4],v[5])
      end
   end
   
   for m,tab in spairs(drawList) do
      if liList[m] then
	 for k,v in pairs(liList[m]) do
	    love.graphics.setColor(1,math.random(50)/255,math.random(50)/255,1)

	    love.graphics.setLineWidth(v[5])
	    love.graphics.setLineStyle("smooth")
	    love.graphics.line(v[6],v[7],v[8],v[9])
	    love.graphics.setLineWidth(2)
	    love.graphics.setLineStyle("rough")
	 end
      end
      
      for k,v in pairs(tab) do
	 if fixedList[m][k] then
	    love.graphics.setColor(objects[v].col[1]/0xff, objects[v].col[2]/0xff, objects[v].col[3]/0xff, objects[v].col[4]/0xff)
	    
	    objects[v]:cam(ofx,ofy,ang)
	    
	    if (objects[v].cx < screenWidth+50 and objects[v].cx > -50) or (objects[v].cy < screenHeight+50 and objects[v].cy > -50) then
	       objects[v]:rotate(objects[v].cangle)
	       love.graphics.polygon(objects[v].mode,objects[v].vertices)
	    elseif v == "motherShip" or "motherShields" then
	       objects[v]:rotate(objects[v].cangle)
	       love.graphics.polygon(objects[v].mode,objects[v].vertices)
	    end
	 else
	    fixedList[m][k]=v
	 end
      end
   end
   
   if not hiscore then
      DrawCursor()
   end
   
   love.graphics.setShader()
   
   for k,v in pairs(txtList) do
      love.graphics.setColor(0xbd/0xff,0xb7/0xff,0x6b/0xff,v[4]/0xff)
      local fo = love.graphics.getFont()
      love.graphics.setFont(assets.fonts.mfont)
      
      love.graphics.printf(v[3],v[1]-300,v[2],600,"center")
      
      love.graphics.setFont(assets.fonts.font)
   end
   
   love.graphics.setColor(1,1,1,1)
   
   if mute then
      love.graphics.draw(assets.images.speakerOff,screenWidth-92,0)
   else
      love.graphics.draw(assets.images.speakerOn,screenWidth-92,0)
   end
   
   love.graphics.draw(assets.images.boom,screenWidth-41,0)
   love.graphics.draw(assets.images.fullscreen,screenWidth-41,0)
   
   love.graphics.setFont(assets.fonts.font)
   
   love.graphics.printf("[F5]",screenWidth-92,32,32,"center")
   love.graphics.printf("[F9]",screenWidth-41,32,32,"center")
   love.graphics.printf("[F11]",screenWidth-41,32,32,"center")
   
   if not hiscore then
      love.graphics.print("fuel:\nscore:",0,0)
      love.graphics.print("\n"..score,100,0)
      love.graphics.setColor((0xcf+(fuel/muel)*0x30)/0xff,(0x10+(fuel/muel)*0xef)/0xff,(0x20+(fuel/muel)*0xdf)/0xff,1)
      love.graphics.print(math.floor(fuel+0.5),100,0)
      love.graphics.setColor(1,1,1,1)
   end
   
   if pause then love.graphics.printf("PAUSED",0,20,love.graphics.getWidth(),"center") end
   
   if inmess then
      love.graphics.setFont(assets.fonts.bfont)
      
      local word = string.gsub(keyBind.en_t,"(%a)(.)",function(a,b) return string.upper(a)..b end,1)..string.gsub(keyBind.en_b,"(%a).",string.upper,1)..string.gsub(keyBind.en_bl,"(%a).",string.upper,1)..string.gsub(keyBind.en_br,"(%a).",string.upper,1)..string.gsub(keyBind.en_tl,"(%a).",string.upper,1)..string.gsub(keyBind.en_tr,"(%a).",string.upper,1).." you go!"
      
      if string.len(word) > 24 then
	 word = "#rad_ctrl_bud"
      end
      
      love.graphics.printf(word,0,screenHeight*1/3,screenWidth,"center")
      love.graphics.setFont(assets.fonts.font)
   end
   
   if deathmess then
      love.graphics.setFont(assets.fonts.bfont)
      
      if hiscore then
	 love.graphics.printf("HI-SCORE",0,screenHeight/2-200,screenWidth,"center")
	 
	 love.graphics.setFont(assets.fonts.mfont)
	 
	 local shift = 0
	 for k,v in pairs(scores) do
	    if k == got then
	       love.graphics.printf(k..". "..user,0,screenHeight/2-120+shift,screenWidth,"left")
	       if blink > 10 then love.graphics.setColor(1,1,1,0) blink = blink+1 else love.graphics.setColor(1,1,1,1) blink = blink+1 end
	       if blink > 20 then blink = 0 end					
	       love.graphics.printf(k..". "..user.."_",0,screenHeight/2-120+shift,screenWidth,"left")
	       love.graphics.setColor(1,1,1,1)
	       love.graphics.printf(" - ",0,screenHeight/2-120+shift,screenWidth,"center")
	       love.graphics.printf(v[2],0,screenHeight/2-120+shift,screenWidth,"right")
	       shift = shift + 20
	    else
	       love.graphics.printf(k..". "..v[1],0,screenHeight/2-120+shift,screenWidth,"left")
	       love.graphics.printf(" - ",0,screenHeight/2-120+shift,screenWidth,"center")
	       love.graphics.printf(v[2],0,screenHeight/2-120+shift,screenWidth,"right")
	       shift = shift + 20
	    end
	 end
	 
	 love.graphics.setFont(assets.fonts.font)
	 love.graphics.printf("[[Press return to try again]]",0,screenHeight-100,screenWidth,"center")
	 
	 love.graphics.print("F12 to clear the board",0,screenHeight-20)
	 
	 pix = redOut
      else
	 love.graphics.setFont(assets.fonts.bfont)
	 love.graphics.setColor(0xda/0xff,0x8a/0xff,0x67/0xff,1)
	 love.graphics.printf("Dead already?\nOh well...",0,love.graphics.getHeight()*1/3,love.graphics.getWidth(),"center")
	 love.graphics.setFont(assets.fonts.font)
	 love.graphics.printf("Your score: "..score.."\n\n\n\n\n[[Press space to try again]]",0,love.graphics.getHeight()*2/3,love.graphics.getWidth(),"center")
	 if writefile then
	    love.graphics.print("Press F2 to see hi-scores",0,screenHeight-20)
	 end
	 love.graphics.setColor(1,1,1,1)
	 pix = redOut
      end
   end
   
   if help then
      love.graphics.setColor(1,1,1,100/0xff)
      
      love.graphics.rectangle("fill",screenWidth/2-35,screenHeight/2-60,70,120)
      
      love.graphics.setFont(assets.fonts.mbfont)
      
      for	k,v in pairs(drawList[102]) do 
	 love.graphics.setColor(objects[v].col[1]/0xff,objects[v].col[2]/0xff,objects[v].col[3]/0xff,1)
	 love.graphics.polygon("fill",objects[v].vertices[1],objects[v].vertices[2],objects[v].vertices[3],objects[v].vertices[4],objects[v].vertices[5],objects[v].vertices[6])
	 
	 love.graphics.setColor(1,1,1,100/255)
	 love.graphics.line(objects[v].vertices[1],objects[v].vertices[2],screenWidth/2-200,screenHeight/2-40)
      end
      
      love.graphics.setColor(1,1,1,1)
      
      love.graphics.printf(keyConst[keyBind.sens] or keyBind.sens,screenWidth/2-500,screenHeight/2-58,300,"right")
      love.graphics.printf(keyConst[keyBind.shld] or keyBind.shld,screenWidth/2-500,screenHeight/2+38,300,"right")
      
      love.graphics.line(screenWidth/2-35,screenHeight/2,screenWidth/2-200,screenHeight/2+58)
      
      love.graphics.setColor(0xfc/0xff,0xf7/0xff,0x5e/0xff,1)
      
      love.graphics.printf(keyConst[keyBind.en_t] or keyBind.en_t,screenWidth/2-55,screenHeight/2-105,110,"center")
      love.graphics.printf(keyConst[keyBind.en_b] or keyBind.en_b,screenWidth/2-55,screenHeight/2+65,110,"center")
      love.graphics.printf(keyConst[keyBind.en_tl] or keyBind.en_tl,screenWidth/2-125,screenHeight/2-75,100,"center")
      love.graphics.printf(keyConst[keyBind.en_tr] or keyBind.en_tr,screenWidth/2+25,screenHeight/2-75,100,"center")
      love.graphics.printf(keyConst[keyBind.en_bl] or keyBind.en_bl,screenWidth/2-125,screenHeight/2+25,100,"center")
      love.graphics.printf(keyConst[keyBind.en_br] or keyBind.en_br,screenWidth/2+25,screenHeight/2+25,100,"center")
      
      love.graphics.setFont(assets.fonts.font)
      
      angle = angle or 0
      angle = angle - 0.01
      
      love.graphics.setColor(0x36/0xff,0x45/0xff,0x4f/0xff,1)
      love.graphics.polygon('fill',screenWidth/2+250+math.sin(angle)*100,screenHeight/2-150+math.cos(angle)*100,screenWidth/2+250+math.sin(angle+math.pi/2)*100,screenHeight/2-150+math.cos(angle+math.pi/2)*100,screenWidth/2+250+math.sin(angle+math.pi)*100,screenHeight/2-150+math.cos(angle+math.pi)*100,screenWidth/2+250+math.sin(angle+math.pi*3/2)*100,screenHeight/2-150+math.cos(angle+math.pi*3/2)*100)
      
      love.graphics.setColor(0x9f/0xff,0x81/0xff,0x70/0xff,1)
      love.graphics.polygon('fill',screenWidth/2+250+math.sin(angle)*50,screenHeight/2+math.cos(angle)*50,screenWidth/2+250+math.sin(angle+math.pi*2/5)*50,screenHeight/2+math.cos(angle+math.pi*2/5)*50,screenWidth/2+250+math.sin(angle+math.pi*4/5)*50,screenHeight/2+math.cos(angle+math.pi*4/5)*50,screenWidth/2+250+math.sin(angle+math.pi*6/5)*50,screenHeight/2+math.cos(angle+math.pi*6/5)*50,screenWidth/2+250+math.sin(angle+math.pi*8/5)*50,screenHeight/2+math.cos(angle+math.pi*8/5)*50)
      
      love.graphics.setColor(0x87/0xff,0x97/0xff,0x79/0xff,1)
      love.graphics.polygon('fill',screenWidth/2+250+math.sin(angle)*20,screenHeight/2+150+math.cos(angle)*20,screenWidth/2+250+math.sin(angle+math.pi*2/5)*20,screenHeight/2+150+math.cos(angle+math.pi*2/5)*20,screenWidth/2+250+math.sin(angle+math.pi*4/5)*20,screenHeight/2+150+math.cos(angle+math.pi*4/5)*20,screenWidth/2+250+math.sin(angle+math.pi*6/5)*20,screenHeight/2+150+math.cos(angle+math.pi*6/5)*20,screenWidth/2+250+math.sin(angle+math.pi*8/5)*20,screenHeight/2+150+math.cos(angle+math.pi*8/5)*20)
      
      love.graphics.setColor(1,1,1,1)
      
      love.graphics.printf('refuel here',screenWidth/2,screenHeight/2-158,500,'center')
      love.graphics.printf('shoop da whoop these',screenWidth/2+100,screenHeight/2-8,300,'center')
      love.graphics.printf('eat those',screenWidth/2+100,screenHeight/2+142,300,'center')
      
      
      love.graphics.print('Fuel cost:\n\nMAIN THRUSTERS - 20/s\nSIDE THRUSTERS - 10/s\nSHIELDS - 10/s\nSCANERS - 1/s\nMINING LASER - 20/use',0,screenHeight-120)
      
      love.graphics.setFont(assets.fonts.font)
   end
   
   love.graphics.setColor(1,1,1,1)

   if not help and not deathmess then
      love.graphics.printf("Need some help?\nWaggle that F1 button!",0,screenHeight-30,screenWidth,"right")
      if sensors then love.graphics.setColor(0x8D/0xff,0xB6/0xff,0) else love.graphics.setColor(0xCE/0xff,0x20/0xff,0x29/0xff) end
      love.graphics.print("sensors",0,screenHeight-16)
   end
   
   love.graphics.setShader(pix)
   
   local timeNow = love.timer.getTime()
   if timePast <= timeNow then
      timePast = timeNow
      return
   end
   love.timer.sleep(timePast - timeNow)
end



function love.keypressed(key,uni)
   if not hiscore or key == "return" or key == "f12" then
      keypress.any(key)
      
      if keypress[key] then
	 keypress[key]()
      end
      
      if keypress[rkeyBind[key]] then
	 keypress[rkeyBind[key]]()
      end
      
      pressed[key] = true
   elseif key == "backspace" then
      user = string.sub(user,1,string.len(user)-1)
   end
end

function love.textinput(t)
   if hiscore then
      user = user..t
   end
end

function love.keyreleased(key)
   if keyrel[key] then
      keyrel[key]()
   end
   
   if keyrel[rkeyBind[key]] then
      keyrel[rkeyBind[key]]()
   end
   
   pressed[key] = nil
end

function love.mousepressed(x,y,key)
   keypress.any(key)
   
   if key == 1 then
      pressed["lmb"] = "true"
      
      if keypress.lmb then
	 keypress.lmb()
      end
   elseif key == 2 then
      pressed["rmb"] = "true"
      
      if keypress.rmb then
	 keypress.rmb()
      end
      
      if keypress[rkeyBind["rmb"]] then
	 keypress[rkeyBind["rmb"]]()
      end
   else
      pressed[key] = "true"
      
      if keypress[key] then
	 keypress[key]()
      end
   end
end

function love.mousereleased(x,y,key)
   if key == 1 then
      pressed["lmb"] = "false"
   elseif key == 2 then
      pressed["rmb"] = "false"
   else
      pressed[key] = "false"
   end
end

function love.focus(b)
   if not help and not deathmess and not ppause then pause = not b end
end

function love.quit()
   if writefile then
      
      local str = ""
      
      for k,v in spairs(scores) do
	 str = str..v[1].." - "..v[2].."\r\n"
      end
      
      love.filesystem.write("scores.txt",str)
   end
end



function te(tab)
   for _, _ in pairs(tab) do
      return false
   end
   return true
end

function spairs(t)
   local keys = {}
   for k in pairs(t) do keys[#keys+1] = k end

   table.sort(keys)

   local i = 0
   return function()
      i = i + 1
      if keys[i] then
	 return keys[i], t[keys[i]]
      end
   end
end

function ct(tab)
   local copy
   copy = {}
   
   if type(tab) == "table" then
      for k,v in pairs(tab) do
	 if type(v) == "table" then
	    copy[k] = ct(v)
	 else
	    copy[k] = v
	 end
      end
   else
      return tab
   end
   
   return setmetatable(copy,getmetatable(tab))
end

function f(x,a,b)
   return a*x+b
end

function ra()
   local r = love.timer.getFPS()/100
   
   if r > 1 then return r else return 1 end
end



function DeclareClasses()
   poly = {}
   poly.__index = poly
   
   function poly.new(x,y,dim,mode,col,xs,ys,rs,angle)
      return setmetatable({
	    col = col or {255,255,255,255}, mode = mode or "fill",
	    dim = dim, odim = ct(dim), vertices = {},
	    x = x, y = y, angle = angle or 0, cangle = ct(angle) or 0,
	    xs = xs or 0, ys = ys or 0, rs = rs or 0,
	    cx = x, cy = y
			  },poly)
   end
   
   function newGasPar(x,y,ang,t)
      local xs, ys
      
      if t == "q" then
	 x = x + math.floor(math.sin(ang)*100 + 0.5)/4
	 y = y - math.floor(math.cos(ang)*100 + 0.5)/4

	 x = x - math.cos(ang)*25
	 y = y - math.sin(ang)*25

	 xs = - math.floor(math.cos(ang)*100 + 0.5)/2 + objects.ship.xs
	 ys = - math.floor(math.sin(ang)*100 + 0.5)/2 + objects.ship.ys
      elseif t == "a" then
	 x = x - math.floor(math.sin(ang)*100 + 0.5)/4
	 y = y + math.floor(math.cos(ang)*100 + 0.5)/4

	 x = x - math.cos(ang)*25
	 y = y - math.sin(ang)*25

	 xs = - math.floor(math.cos(ang)*100 + 0.5) + objects.ship.xs
	 ys = - math.floor(math.sin(ang)*100 + 0.5) + objects.ship.ys
      elseif t == "e" then
	 x = x + math.floor(math.sin(ang)*100 + 0.5)/4
	 y = y - math.floor(math.cos(ang)*100 + 0.5)/4

	 x = x + math.cos(ang)*25
	 y = y + math.sin(ang)*25

	 xs = math.floor(math.cos(ang)*100 + 0.5) + objects.ship.xs
	 ys = math.floor(math.sin(ang)*100 + 0.5) + objects.ship.ys
      elseif t == "d" then
	 x = x - math.floor(math.sin(ang)*100 + 0.5)/4
	 y = y + math.floor(math.cos(ang)*100 + 0.5)/4

	 x = x + math.cos(ang)*25
	 y = y + math.sin(ang)*25

	 xs = math.floor(math.cos(ang)*100 + 0.5)/2 + objects.ship.xs
	 ys = math.floor(math.sin(ang)*100 + 0.5)/2 + objects.ship.ys
      elseif t == "w" then
	 x = x + math.floor(math.sin(ang)*100 + 0.5)/2
	 y = y - math.floor(math.cos(ang)*100 + 0.5)/2

	 xs = math.floor(math.sin(ang)*100 + 0.5)/2 + objects.ship.xs
	 ys = - math.floor(math.cos(ang)*100 + 0.5)/2 + objects.ship.ys
      elseif t == "s" then
	 x = x - math.floor(math.sin(ang)*100 + 0.5)/2
	 y = y + math.floor(math.cos(ang)*100 + 0.5)/2

	 xs = - math.floor(math.sin(ang)*100 + 0.5)/2 + objects.ship.xs
	 ys = math.floor(math.cos(ang)*100 + 0.5)/2 + objects.ship.ys
      end	
      
      xs = xs + (math.random(1000)-500)/16
      ys = ys + (math.random(1000)-500)/16
      
      local ofx = objects.ship.x - screenWidth/2
      local ofy = objects.ship.y - screenHeight/2

      local ang = objects.ship.angle
      
      objects["gas"..gasCount] = poly.new(x,y,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},xs,ys,(math.random(30)-20)/10,(math.random(30)-20)/10)
      objects["gas"..gasCount]:cam(ofx,ofy,ang)
      drawList[99][gasCount] = "gas"..gasCount
      
      if gasCount > maxGas then
	 gasCount = 1
      else
	 gasCount = gasCount + 1
      end		
   end
   
   function newAstr(size,x,y,xs,ys)
      local size = size
      
      if not size then size = math.floor(math.sqrt(math.random(196))) end
      
      local ox,oy,rem1,rem2,rem3,xe,ye,a,na
      
      rem1 = screenWidth/2+65
      rem2 = screenHeight/2+65
      rem3 = 0
      
      for i=1,maxAstro do
	 if drawList[50][i] then
	    xe = math.abs(objects[drawList[50][i]].cx-screenWidth/2)
	    ye = math.abs(objects[drawList[50][i]].cy-screenHeight/2)
	    
	    if rem1 < xe and rem2 < ye then
	       rem3 = i
	       
	       rem1 = xe
	       rem2 = ye
	    end
	 else
	    rem3 = i
	    break
	 end
      end
      
      if rem3 == 0 then return end
      
      
      ox = math.random(3) - 2
      if ox == 0 then
	 oy = (math.random(2) - 1.5) * 2
      else
	 oy = math.random(3) - 2
      end
      
      x = x or screenWidth*(ox + math.abs(ox)/4) + math.random(screenWidth*(1 - math.abs(ox)/2))+ofx + ox*screenWidth/2
      y = y or screenHeight*(oy + math.abs(oy)/4) + math.random(screenHeight*(1 - math.abs(oy)/2))+ofy + oy*screenWidth/2
      
      xs = xs or math.random(51) - 26
      ys = ys or - math.random(50)-80
      
      if size < 4 then
	 col = {0x87,0x97,0x79,255}
      else
	 col = {0x9f,0x81,0x70,255}
      end
      
      --	{0,-20*size,-10*size*math.cos(math.rad(18)),-10*size*math.sin(math.rad(18)),-10*size*math.sin(math.rad(36)),10*size*math.cos(math.rad(36)),10*size*math.sin(math.rad(36)),10*size*math.cos(math.rad(36)),10*size*math.cos(math.rad(18)),-10*size*math.sin(math.rad(18))}
      
      a = 5
      
      na = "ast"..rem3
      
      objects[na] = poly.new(x,y,{0,-a*2*size,-a*size*math.cos(math.rad(18)),-a*size*math.sin(math.rad(18)),-a*size*math.sin(math.rad(36)),a*size*math.cos(math.rad(36)),a*size*math.sin(math.rad(36)),a*size*math.cos(math.rad(36)),a*size*math.cos(math.rad(18)),-a*size*math.sin(math.rad(18))},"fill",col,xs,ys,math.random()*4-2,(math.random(314)-628)/100)
      drawList[50][rem3] = na
   end
   
   function newPebble(x,y,xs,ys)
      if pebCount<maxPeb then
	 pebCount = pebCount+1
      else
	 pebCount = 1
      end
      
      objects["peb"..pebCount] = poly.new(x,y,{0,-5,-2.5*math.cos(math.rad(18)),-2.5*math.sin(math.rad(18)),-2.5*math.sin(math.rad(36)),2.5*math.cos(math.rad(36)),2.5*math.sin(math.rad(36)),2.5*math.cos(math.rad(36)),2.5*math.cos(math.rad(18)),-2.5*math.sin(math.rad(18))},"fill",{0x9f,0x81,0x70,255},xs,ys,(math.random(30)-10)/5,(math.random(30)-20)/10)
      objects["peb"..pebCount]:cam(ofx,ofy,ang)
      drawList[49][pebCount] = "peb"..pebCount
   end
   
   function poly:checkHit(x,y)		
      local a,b,c,d,p1,p2,p3,pt

      local A1,A2,A3,At
      
      pt = {love.mouse.getX(),love.mouse.getY()}
      pt = {x,y}
      
      for i=1,#self.vertices - 5,2 do
	 
	 p1 = {self.vertices[1],self.vertices[2]}
	 p2 = {self.vertices[i+2],self.vertices[i+3]}
	 p3 = {self.vertices[i+4],self.vertices[i+5]}
	 
	 a = p3[2] - p2[2]
	 b = p3[1] - p2[1]
	 c = b*p3[2] - a*p3[1]
	 
	 d = math.abs(a*p1[1]-b*p1[2]+c)/math.sqrt(a^2+b^2)
	 
	 At = d*math.sqrt((p3[2]-p2[2])^2+(p3[1]-p2[1])^2)
	 
	 d = math.abs(a*pt[1]-b*pt[2]+c)/math.sqrt(a^2+b^2)
	 
	 A1 = d*math.sqrt((p3[2]-p2[2])^2+(p3[1]-p2[1])^2)
	 
	 if A1 < At then
	    
	    a = p3[2] - p1[2]
	    b = p3[1] - p1[1]
	    c = b*p3[2] - a*p3[1]
	    
	    d = math.abs(a*pt[1]-b*pt[2]+c)/math.sqrt(a^2+b^2)
	    
	    A2 = d*math.sqrt((p1[2]-p3[2])^2+(p1[1]-p3[1])^2)
	    
	    if A1+A2 < At then
	       
	       a = p1[2] - p2[2]
	       b = p1[1] - p2[1]
	       c = b*p1[2] - a*p1[1]
	       
	       d = math.abs(a*pt[1]-b*pt[2]+c)/math.sqrt(a^2+b^2)
	       
	       A3 = d*math.sqrt((p1[2]-p2[2])^2+(p1[1]-p2[1])^2)
	       
	       if A1+A2+A3 < At+1 then return true end

	       if A1+A2+A3 >= 3*At then return false end
	       
	    end
	 end
      end
   end
   
   function poly:rotate(ang)
      local x1, y2, fi1, fi2, r1, r2, r
      
      for i,v in pairs(self.odim) do
	 if i%2 == 1 then				
	    x1 = self.odim[i]
	    y1 = self.odim[i+1]
	    
	    fi1 = math.atan2(y1,x1)

	    r1 = y1/math.sin(fi1)
	    r2 = x1/math.cos(fi1)

	    r = (r1 + r2)/2

	    fi2 = fi1 + ang
	    
	    self.vertices[i] = r * math.cos(fi2) + self.cx
	    self.vertices[i+1] = r * math.sin(fi2) + self.cy
	 end
      end
      
      if self.id then self.id = 3 end
   end
   
   function poly:update(e)
      self.x = self.x + self.xs * e
      self.y = self.y + self.ys * e
      
      self.angle = self.angle + self.rs * e
      self.cangle = self.cangle + self.rs * e
   end
   
   function poly:cam(ofx,ofy,angel)
      self.cx = self.x - ofx
      self.cy = self.y - ofy
      
      local fi1,fi2,r1,r2,r,cx,cy
      cx = screenWidth/2 - self.cx
      cy = screenHeight/2 - self.cy
      
      r = math.sqrt(cx^2+cy^2)
      
      fi1 = math.atan2(-cy,-cx)

      fi2 = fi1 - angel

      self.cx = r * math.cos(fi2)+screenWidth/2
      self.cy = r * math.sin(fi2)+screenHeight/2
      
      self.cangle = self.angle - angel
      
      self.id = true
   end
end

function LoadStuff()
   fuel = 5999
   score = 0
   
   sensors = true
   shields = false
   motherShield = false
   
   inmess = true
   deathmess = false
   help = false
   pause = false
   ppause = false
   hiscore = false
   
   txtCount = 0
   gasCount = 23
   astCount = 1
   liCount = 1
   pebCount = 1

   thr1Count = 2
   thr2Count = 2
   shlCount = 2
   pewCount = 2
   
   user = ""
   got = 11
   blink = 0
   
   ofx = 0
   ofy = 0
   ang = 0
   
   colisions = {}
   pressed = {}
   
   objects = {
      ship = poly.new(screenWidth/2,screenHeight/2,{-25,-50,-25,50,25,50,25,-50}),
      motherShip = poly.new(-100,300,{-400,-400,-400,400,400,400,400,-400},"fill",{0x36,0x45,0x4f,255},0,0,0.25),
      shields = poly.new(screenWidth/2,screenHeight/2,{-35,-60,35,-60,35,60,-35,60},"fill",{0xff,0xff,0xff,120}),
      motherShields = poly.new(-100,300,{-440,-440,-440,440,440,440,440,-440},"fill",{0x36,0x45,0x4f,120}),
      pointer = poly.new(screenWidth/2,screenHeight/2,{0,200,-10,80,10,80},"fill"),
      
      ast1 = poly.new(screenWidth-200,screenHeight/2,{0,-40,-20*math.cos(math.rad(18)),-20*math.sin(math.rad(18)),-20*math.sin(math.rad(36)),20*math.cos(math.rad(36)),20*math.sin(math.rad(36)),20*math.cos(math.rad(36)),20*math.cos(math.rad(18)),-20*math.sin(math.rad(18))},"fill",{0x9f,0x81,0x70,255},-40,-25,-2),
      
      gas1 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas2 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas3 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas4 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas5 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas6 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas7 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas8 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas9 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas10 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas11 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas12 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas13 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas14 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas15 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas16 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas17 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas18 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(100)-500)/2,math.random()*math.pi),
      gas19 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas20 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas21 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi),
      gas22 = poly.new(screenWidth/2,screenHeight/2,{0,-12,-12*math.cos(math.rad(60)),6,12*math.cos(math.rad(60)),6},"line",{0xfc,0xf7,0x5e,0xff},math.random(100)-50,(math.random(1000)-500)/2,math.random()*math.pi)
   }

   ptList = {}
   liList = {
      [100] = {
      }
   }
   txtList = {}
   
   for i = 0,375 do
      ptList[i] = {math.random(screenWidth*5)-2*screenWidth,math.random(screenHeight*5)-2*screenHeight,math.random(255)}
   end

   drawList = {
      [49] = {
      },
      [50] = {
	 "ast1"
      },
      [80] = {
	 "motherShip"
      },
      [99] = {
	 "gas1",
	 "gas2",
	 "gas3",
	 "gas4",
	 "gas5",
	 "gas6",
	 "gas7",
	 "gas8",
	 "gas9",
	 "gas10",
	 "gas11",
	 "gas12",
	 "gas13",
	 "gas14",
	 "gas15",
	 "gas16",
	 "gas17",
	 "gas18",
	 "gas19",
	 "gas20",
	 "gas21",
	 "gas22"
      },
      [100] = {
	 "ship",
	 "pointer"
      },
      [101] = {
      },
      [102] = {
      }
   }

   for i = 0,maxAstro*8+1 do
      objects["pointer"..i] = poly.new(screenWidth/2,screenHeight/2,{0,200,-10,80,10,80},"fill",{0xff,0xff,0,0xff})
      objects["pointer"..i]:rotate(0)
   end
   
   fixedList = ct(drawList)
end

function HandleColisions(i,ifPebbles)
   if type(i) == "number" then
      local size,x,y,xs,ys,lang,langa,n,m,na
      n = "ast"..i
      
      size = -objects[n].odim[2]/10
      lang = math.random(628)/100
      x = objects[n].x
      y = objects[n].y
      xs = objects[n].xs
      ys = objects[n].ys
      
      
      for m=1,sizeEx[size][1] do
	 langa = lang + (math.pi*2)*m/sizeEx[size][1]

	 newAstr(sizeEx[size][2],math.sin(langa)*((size-1)*5+2)+x,-math.cos(langa)*((size-1)+2)*5+y,math.sin(langa)*50+xs+math.random(16)-31,-math.cos(lang)*50+ys+math.random(16)-31)
      end
      
      for m=1,size*3 do
	 lang = lang + (math.pi*2)/m
	 
	 newPebble(x,y,math.cos(lang)*100+xs+math.random(31)-15,-math.sin(lang)*100+ys+math.random(31)-15)
      end
      
      drawList[50][i] = nil
      colisions[i] = nil
   end
end

function DrawCursor(col,x,y)
   local col = col or {255,255,255,120}
   
   return load(function()
	 love.graphics.setColor(col[1]/0xff,col[2]/0xff,col[3]/0xff,col[4]/0xff)
	 love.graphics.circle("line",x or love.mouse.getX(),y or love.mouse.getY(),8,100)
	 love.graphics.setColor(1,1,1,1)
   end)
end

function rand(seed)
   local n = seed*(32416190071^2)
   n = (n%(1301081))^2
   
   return n
end
