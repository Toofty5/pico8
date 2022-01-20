pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
fire = {}

function _update()
	if btn(❎) then 
		spawn_fire(64,128)
	end	
	
	update_fire()
end

function _draw()
	draw_fire()	
end

function spawn_fire(x,y)
	local x = x
	local y = y
	local age = 10
	local dx=0
	local dy=-10
	local particle={x,y,dx,dy,age}
	add(fire,particle)
end

function update_fire()
	for part in all(fire) do
		part.y += part.dy
	end
end


function draw_fire(x,y)
	for part in all(fire) do
		pset(part.x,part.y,4)
		print(part.x)

	end
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
