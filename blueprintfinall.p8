pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
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
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbbb00000000000000000000000000
0077600000677700000000000880088000000000000000000000000000000000000000000000000000000000000000000b777bb00000bbb00000000000000000
0677777007777760006770008888888800000000000000000000000000000000000000000000000000000000000000000b7007bb000bb7700000000000000000
070707700770707007777600888888880000000000000000000000000000000000000000000000000000000000000000bbb777bb00bb77000000000000000000
077777700777777007070700088888800000000000000000000000000000000000000000000000000000000000000000b33bbb330bbbb7700000000000000000
067777600677776007777700008888000000000000000000000000000000000000000000000000000000000000000000bb33333b033bbb300000000000000000
000000000000000006677700000880000000000000000000000000000000000000000000000000000000000000000000b33bbb330b3333300000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bbbbbb0b33bbb330000000b00000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000700070700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000006770007000070000070000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000077000007000007777700000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000770000007000070000070000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000067700000007000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000007000000070700000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000300000000
00000000000000000000000000000000000000000000000000000000000000003333366300000000000000000000000000bbb000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000665363350000000000000000000000000b77bb00000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000055635535000000000000000000000000b7077bb0000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000d656555d000000000000000000000000bb77bbbb000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000065555666000000000000000000000000b33bbb33000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000555665d5000000000000000000000000bb33333b000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000d6665dd6000000000000000000000000b33bbb33000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000dd55566600000000000000000000000000000000000000000000000000000000
00077000000a700000a777000000000000000000000000000000000000000000000000000000000000000000000000000b000000000000000000000000000000
000a700000077000000770000000000000000000000000000000000000000000000000000000000000000000000000000bbb0000000000000000000000000000
000770000007a000000a700000000000000000000000000000000000000000000000000000000000000000000bbb3000b77bb000000000000000000000000000
0007a000000a7000000770000000000000000000000000000000000000000000000000000000000000000000b878b0007077b300000000000000000000000000
000a700000077000000770000000000000000000000000000000000000000000000000000000000000000000b787bbb0b77bbbb0000000000000000000000000
00077000000770000007a0000000000000000000000000000000000000000000000000000000000000000000b878bb3b3bb33bbb000000000000000000000000
0007a0000007a000000a700000000000000000000000000000000000000000000000000000000000000000003bbbbb3b00000000000000000000000000000000
0007700000777a00000770000000000000000000000000000000000000000000000000000000000000000000bbbbb00b00000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000003200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2828282828282828282828282828283100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000000000000000000000000000000ec5010c5013c5014c5025150231502215020150201501f1501e1501e1501e1501e1501f15036150351501f0501e0501d0500e0500c0500805007050000000000000000
00100000000002d4502c4502845024450214501d75018750137501475015750187501f75023450274502f4503345009550125501b5502d5502805025050210501b05016050110500c0500a0500a0501215012150
001000000000015750167500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000025150211500725012150021501e1502215000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000005150051500515005150000000505000000000001f0500000000000000000000036450000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0010000010000120501405025000190501d0500300026050290502a05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002470024700241502715027150280502e05035050360503915000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000180501d0502505033050330501f35025350293503c0503c05000000000003e0503e050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000000002d0502b0502b0502a0502705026050250501d1001610009100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01024344
