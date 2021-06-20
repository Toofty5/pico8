pico-8 cartridge // http://www.pico-8.com
version 32
__lua__
function _init()
	things={}
	spawn_x=64
	spawn_y=128
	spawn_v=10
	gravity=1
	angle=.25
	sides=5
	thisvert=1	
	
end

function _draw()
	cls()
//	test()
	
	print("sides:"..sides,0,0)
	
	for thing in all(things) do
		local x=thing.x
		local y=thing.y
		local z=thing.z
		local r=thing.r
		local col=thing.col
		//circfill(thing.x,thing.y,thing.z,thing.col)
		polyfill(x,y,sides,z,r,col)
	end
	

end

function _update()
	update_shoot()
end

function update_shoot()
	if btnp(❎) then
		spawn(10)
	end
	if btnp(🅾️) then
		sides+=1
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
		if thing.age>40 then
			del(things,thing)
		end
	end
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


function polyfill(x,y,sides,size,r,col)
	local rot={} //vertex rotations
	for i=0,sides do
		add(rot,r+i/sides)
	end

	verts={} //vertex coords
	for r in all(rot) do
		local x1=x+size*cos(r)
		local y1=y+size*sin(r)
		local x2=x+size*cos(r+1/sides)
		local y2=y+size*sin(r+1/sides)

		trifill({x,y,x1,y1,x2,y2},col)
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


-->8
--trifill
function trifill(vertices,col)
	//need to find lua copy fn
	local tvertices={
		vertices[1],
		vertices[2],
		vertices[3],
		vertices[4],
		vertices[5],
		vertices[6],
		}
	
	v_sort(tvertices)
	
	local x1=tvertices[1]
	local y1=tvertices[2]
	local x2=tvertices[3]
	local	y2=tvertices[4]
	local x3=tvertices[5]
	local y3=tvertices[6]
	
	if y2-y1>0 then
		dx1=(x2-x1)/(y2-y1)
	else dx1=0 end
	if y3-y1>0 then
		dx2=(x3-x1)/(y3-y1)
	else dx2=0 end
	if y3-y2>0 then
		dx3=(x3-x2)/(y3-y2)
	else dx3=0 end

	if dx1>dx2 then
		for i=0,y2-y1 do
			local y=y1+i
			local xs=x1+dx2*i
			line(xs,y,x1+dx1*i,y,col)	
		end
		for i=0,y3-y2 do
			local y=y2+i
			local xs=x1+dx2*(y-y1)
			line(xs,y,x2+dx3*i,y,col)
		end
	else // dx1<=dx2
		for i=0,y2-y1 do
			local y=i+y1
			local xa=x1+dx1*i
			local xb=x1+dx2*i
			line(xa,y,xb,y,col)
		end
		for i=0,y3-y2 do
			local y=i+y2
			local xa=x2+i*dx3
			local xb=x1+dx2*(y-y1)
			line (xa,y,xb,y,col)
		end
	end
end

//sort vertex tables by y
function v_sort(a)
	for i=2,#a,2 do
		local j=i
		while j>2 and a[j-2] > a[j] do
			a[j],a[j-2] = a[j-2],a[j]
			a[j-1],a[j-3] = a[j-3],a[j-1]
			j-=2
		end	
	end
end


-->8
--test

function test()
	polyfill(64,64,5,10,0,7)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
