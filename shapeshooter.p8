pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	things={}
	spawn_x=64
	spawn_y=64
	spawn_v=10
	gravity=1
	angle=.25
end

function _draw()
	cls()

	for thing in all(things) do
		local x=thing.x
		local y=thing.y
		local z=thing.z
		local r=thing.r
		local col=thing.col
		//circfill(thing.x,thing.y,thing.z,thing.col)
		sqr(x,y,z,r,col)
	end
end

function _update()
	if btn(❎) then
		spawn(1)
	end
	if btn(⬅️) then
		angle+=.01
	end
	if btn(➡️) then
		angle-=.01
	end
	if btn(⬆️) then
		spawn_v+=1
	end
	if btn(⬇️) then
		spawn_v-=1
	end
	
	for thing in all(things) do
		thing.x+=thing.dx
		thing.y+=thing.dy
		thing.z+=thing.dz
		thing.dy+=gravity
		thing.r+=thing.dr
		thing.age+=1
		if thing.age>100 then
			del(things,thing)
		end
	end
	spawn(1)
	angle+=.1	
end

water={1,6,7,12}
fire={2,8,9,10,7}

function spawn(num)
	for i=0,num do
	
		dev_a=angle+rnd(.01)-.02
		dev_v=spawn_v+rnd(4)-2
		
		add(things, { 
					x=spawn_x,
					y=spawn_y,
					z=5,
					dx=dev_v*cos(dev_a),
					dy=dev_v*sin(dev_a),
					dz=rnd(1)-.5,
					r=rnd(.25),
					dr=-.1*cos(dev_a),
					col=flr(rnd(15))+1,
					age=0
			})
	end
end

function sqr(x,y,size,r,col)
	local r0=r
	local r1=r+0.25
	local r2=r+0.5
	local r3=r+0.75
	x1=x+size*cos(r0)
	y1=y+size*sin(r0)
	x2=x+size*cos(r1)
	y2=y+size*sin(r1)
	x3=x+size*cos(r2)
	y3=y+size*sin(r2)
	x4=x+size*cos(r3)
	y4=y+size*sin(r3)
	line(x1,y1,x2,y2,col)
	line(x2,y2,x3,y3,col)
	line(x3,y3,x4,y4,col)
	line(x4,y4,x1,y1,col)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
