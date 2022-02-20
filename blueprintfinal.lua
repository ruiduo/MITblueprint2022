function _init()
	p1 = {}
	--ready player 1
	p1.x = 50
	p1.y = 122
	p1.sprite = 1
	p1.dir = 0 -- left is 0, right is 1
	p1.speed = 2
	p1.moving = false
	p1.mounted = true
	bone = {}
	--the bones he stands on
	bone.sprite = 0
	
	tbone = {}
	--the bones he throws

	
	enemy = {}
	enemy.x = 100
	enemy.phase = 0
	--phase 1 and phase 2 animations
	enemy.sprite = 40
	enemy.moving = true
	enemy.alive = true
	groundbone = {}
	gamesetup()
end

function gamesetup()
	for i=1, 3, 1 do
		addgroundbone(p1.x+(10*i))
	end
	maxbone = 6
end

function controls()
	if (btn(0) and p1.x>=1) then
		p1.x -= 1
		p1.dir = 0
	end
	if (btn(1) and p1.x<122) then
		p1.x += 1
		p1.dir = 1
	end
	if (p1.dir == 1) then
		p1.sprite = 1
	end
	if (p1.dir == 0) then
		p1.sprite = 0
	end
end
function _update()

	if p1.y > (122-(maxbone*6)) then
		p1.y -= 6
	end
	if p1.y < (122-(maxbone*6)) then
		p1.y += 5
	end
	controls()
	if btnp(5) and maxbone > 0 then
		tbone.dir = p1.dir
		if tbone.dir == 1 then
		addtbone(p1.x)
		sfx(o2)
		maxbone -= 1
		end
	end
	if btnp(4) and enemy.alive == false then
		enemy.alive = true
		sfx(08)
	end
	foreach(tbone, updatetbone)
	foreach(groundbone, updategroundbone)
	print(tbone)
end

function addtbone(x)
 add(tbone,{x=x})
end
function addgroundbone(x)
	add(groundbone,{x=x})
end

function updatetbone(t)
--can only shoot foward
	if (t.x >= enemy.x) and enemy.alive ==true then		enemy.alive = false
		enemy.alive = false	
		sfx(06)
	end
	if t.x > 128 then
		del(tbone,t)
	end
	t.x += 2
end

function updategroundbone(g)
	if p1.x == g.x then
	del(groundbone,g)
	maxbone += 1
	sfx(05)
	end
end
	
function drawtbone(t)
	spr(22, t.x, p1.y)
end

function drawgroundbone(g)
	spr(22, g.x, 122)
end

function bonetime()
	for i = 0,maxbone, 1 do
		bone.sprite = 21
	 spr(bone.sprite,p1.x,(p1.y+5+(i*6)))
	end
end

function drawenemy()
	if enemy.alive == true then
		enemy.sprite = 44
	end
	if enemy.alive == false then
		enemy.sprite = 59
	end
 spr(enemy.sprite, enemy.x, p1.y)
end
	
function _draw()
	cls()
	spr(p1.sprite, p1.x, p1.y)
	bonetime()
	drawenemy()
	foreach(tbone, drawtbone)
	foreach(groundbone, drawgroundbone)
end