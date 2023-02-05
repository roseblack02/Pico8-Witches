pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--main tab
function _init()
	music(2)
	--draw black but not green
	palt(0,false)
	palt(11,true)
	mode="start"
	frame=0
	offset=1.5
	--start menu
	menu_colour=7
	menu_flame=136
	title_y=-40
	--stats
	level=1
	books=0
	lives=2
	keys=false
	win=false
	--levels
	map_x=0
	map_y=0
	--objects
	game_objects={}
	fireballs={}
	sparks={}
	local i
	for i=1,200 do
		add(sparks,{
			x=0,y=0,velx=0,vely=0,r=0,alive=false,mass=0
		})
	end
end

function _update()
	if mode=="start" then
		update_start()
	elseif mode=="tutorial" then
		update_tutorial()
	elseif mode=="game" then
		update_game()
	elseif mode=="over" then
		update_over()
	end
end

function _draw()
	if mode=="start" then
		draw_start()
	elseif mode=="tutorial" then
		draw_tutorial()
	elseif mode=="game" then
		draw_game()
	elseif mode=="over" then
		draw_over()
	end
end
-->8
--game states
	function update_start()
		--resetting stats
		win=false
		level=1
		lives=2
		books=0
		frame_counter(30)
		--fire animation and text flash
		if frame>15 then
			menu_colour=2
			menu_flame=140
		else
			menu_colour=7
			menu_flame=136
		end
		if title_y==1 then
			sfx(1)
		end
		if title_y<2 then
			title_y+=1
		end
		if btnp(5) then
			mode="tutorial"
			sfx(6)
		end
	end

	function draw_start()
		cls(0)
		spr(64,33,title_y,10,2)
		spr(96,23,title_y+17,11,2)
		spr(128,32,64,8,8)
		spr(menu_flame,32,88,4,4)
		--display text when title text drops down
		if title_y==2 then
			print("press ❎ to start",30,50,menu_colour)
		end
	end

	function update_tutorial()
		if btnp(5) then
			start_game()
			sfx(6)
		end
	end

	function draw_tutorial()
		cls(0)
		spr(37,60,0)
		print("you only have 2 health",20,11,2)
		print("you only have 2 health",20,10,7)
		spr(16,60,17)
		print("goblins will deal 1 damage",12,28,2)
		print("goblins will deal 1 damage",12,27,7)
		spr(7,60,34)
		print("use books to cast fire with ❎",4,45,2)
		print("use books to cast fire with ❎",4,44,7)
		spr(20,60,51)
		print("fire will brighten the dungeon",2,62,2)
		print("fire will brighten the dungeon",2,61,7)
		print("and eliminate goblins",22,69,2)
		print("and eliminate goblins",22,68,7)
		spr(39,60,75)
		print("torches will light up",22,86,2)
		print("torches will light up",22,85,7)
		print("the dungeon for longer",20,93,2)
		print("the dungeon for longer",20,92,7)
		spr(23,60,99)
		print("find keys to unlock the gates",6,110,2)
		print("find keys to unlock the gates",6,109,7)
		print("and escape the dungeon",20,117,2)
		print("and escape the dungeon",20,116,7)
	end

	function start_game()
		--removing key
		keys=false
		--removing objects from previous level
		remove(game_objects)
		if level==1 then
			map_x=0
			map_y=0
			make_book(16,16)
			make_book(8,32)
			make_book(24,80)
			make_book(64,48)
			make_book(112,8)
			make_book(40,64)
			make_book(80,112)
			make_book(104,64)
			make_book(112,104)
			make_key(24,96)
			make_gate(120,88)
			make_torch(48,32)
			make_torch(80,32)
			make_torch(104,56)
			make_goblin(32,24,false)
			make_goblin(8,48,false)
			make_goblin(24,48,true)
			make_goblin(64,8,false)
			make_goblin(40,96,false)
			make_goblin(56,80,false)
			make_goblin(104,56,true)
			make_goblin(96,112,false)
			make_player(8,8)
		elseif level==2 then
			map_x=17
			map_y=0
			make_book(8,112)
			make_book(64,104)
			make_book(80,72)
			make_book(32,48)
			make_book(8,48)
			make_book(104,8)
			make_book(112,80)
			make_key(112,112)
			make_gate(120,32)
			make_torch(8,64)
			make_torch(72,80)
			make_torch(64,16)
			make_goblin(8,64,false)
			make_goblin(40,112,true)
			make_goblin(64,72,false)
			make_goblin(8,32,false)
			make_goblin(88,56,true)
			make_goblin(104,16,true)
			make_goblin(112,72,true)
			make_goblin(104,112,true)
			make_player(8,88)
		elseif level==3 then
			map_x=34
			map_y=0
			make_book(8,8)
			make_book(16,72)
			make_book(48,64)
			make_book(16,112)
			make_book(8,112)
			make_book(64,8)
			make_key(48,112)
			make_gate(120,56)
			make_torch(16,8)
			make_torch(16,96)
			make_torch(104,8)
			make_goblin(8,56,false)
			make_goblin(24,32,false)
			make_goblin(40,16,true)
			make_goblin(56,24,false)
			make_goblin(8,88,false)
			make_goblin(48,104,true)
			make_goblin(72,104,true)
			make_goblin(104,72,true)
			make_goblin(112,16,false)
			make_player(8,32)
		elseif level==4 then
			map_x=51
			map_y=0
			make_book(24,80)
			make_book(32,64)
			make_book(64,88)
			make_book(88,72)
			make_book(88,96)
			make_gate(120,56)
			make_boss(48,16)
			make_dagger(60,8)
			make_player(8,56)
			music(6)
		end
		mode="game"
	end

	function update_game()
		frame_counter(30)
		local fireball
		for fireball in all(fireballs) do
		fireball:update()
		end
		local obj
		for obj in all(game_objects)do
			obj:update()
		end
		local i
		for i=1,#sparks do
			if sparks[i].alive then
				sparks[i].x+=sparks[i].velx/sparks[i].mass
				sparks[i].y+=sparks[i].vely/sparks[i].mass
				sparks[i].r-=0.1
				if sparks[i].r<0.1 then
					sparks[i].alive=false
				end
			end
		end
		if lives<=0 then
			mode="over"
			--death music
			music(0)
		end
	end

	function draw_game()
		cls(0)
		map(map_x,map_y)
		local fireball
		for fireball in all(fireballs) do
		fireball:draw()
		end
		local obj
		for obj in all(game_objects)do
			obj:draw()
		end
		local i
		for i=1,#sparks do
			if sparks[i].alive then
				circfill(
				sparks[i].x,
				sparks[i].y,
				sparks[i].r,
				8
				)
			end
		end
		draw_ui()
	end

	function update_over()
		frame_counter(30)
		--fire animation and text flash
		if frame>15 then
			menu_colour=2
			menu_flame=140
		else
			menu_colour=7
			menu_flame=136
		end
		if title_y<2 then
			title_y+=1
		end
		if btnp(5) then
			mode="start"
			sfx(6)
			--main music
			music(2)
		end
		--update so the player hit effect does not carry over into the next game
		local i
		for i=1,#sparks do
			if sparks[i].alive then
				sparks[i].x+=sparks[i].velx/sparks[i].mass
				sparks[i].y+=sparks[i].vely/sparks[i].mass
				sparks[i].r-=0.1
				if sparks[i].r<0.1 then
					sparks[i].alive=false
				end
			end
		end
	end

	function draw_over()
		if win then
			cls(12)
			--background
			--clouds
			circfill(15,13,2,7)
			circfill(20,20,4,7)
			circfill(27,22,5,7)
			circfill(36,20,4,7)
			circfill(26,16,4,7)
			circfill(32,16,3,7)

			circfill(70,24,4,7)
			circfill(79,28,6,7)
			circfill(88,26,6,7)
			circfill(97,24,4,7)
			circfill(76,20,4,7)
			circfill(86,20,6,7)
			circfill(94,20,4,7)
			--hill dist
			circfill(10,70,12,13)
			rectfill(-2,70,22,128,13)

			circfill(39,65,17,13)
			rectfill(22,65,56,128,13)

			circfill(69,67,13,13)
			rectfill(56,67,82,128,13)

			circfill(99,75,17,13)
			rectfill(82,75,116,128,13)

			circfill(126,66,10,13)
			rectfill(116,66,136,128,13)	

			rectfill(0,90,128,128,3)
			print("you have escaped!",30,41,2)
			print("you have escaped!",30,40,7)
			print("press ❎ to start",30,50,menu_colour)
			spr(128,32,64,8,8)
			spr(204,48,80,4,4)
			spr(menu_flame,32,88,4,4)
		else
			cls(0)
			spr(200,48,48,4,4)
			print("you died",48,41,2)
			print("you died",48,40,7)
			print("press ❎ to restart",26,88,menu_colour)
		end
	end
-->8
--game objects
--from bridgs
function make_game_object(name,x,y,props)
	local obj={
		name=name,
		x=x,
		y=y,
		velocity_x=0,
		velocity_y=0,
		update=function(self)
		end,
		draw=function(self)
		end,
		draw_bounding_box=function(self,colour)
			rect(self.x,self.y,self.x+self.width,self.y+self.height,colour)
		end,
		--collision
		check_for_hit=function(self,other)
			return bounding_box_overlapping(self,other)
		end
	}
	local key,value
	for key,value in pairs(props) do
		obj[key]=value
	end
	add(game_objects,obj)
	return obj
end

function make_player(x,y)
	return make_game_object("player",x,y,{
		width=7,
		height=7,
		move_speed=8,
		is_casting=false,
		casted=false,
		is_light=false,
		is_left=false,
		is_up=false,
		is_down=false,
		invulnerable=0,
		sprite=1,
		light_counter=0,
		light_sprite=8,
		update=function(self)
			--light animation
			if frame<15 then
				self.light_sprite=8
			else
				self.light_sprite=12
			end
			--friction
			self.velocity_x*=0
			self.velocity_y*=0
			--move left
			if btnp(0) then
				self.velocity_x=-self.move_speed
				self.is_left=true
				self.is_up=false
				self.is_down=false
			end
			--move right
			if btnp(1) then
				self.velocity_x=self.move_speed
				self.is_left=false
				self.is_up=false
				self.is_down=false
			end
			--move up
			if btnp(2) then
				self.velocity_y=-self.move_speed
				self.is_up=true
				self.is_down=false
			end
			--move down
			if btnp(3) then
				self.velocity_y=self.move_speed
				self.is_up=false
				self.is_down=true
			end
			--spell cast
			if btnp(5) and books>0 and not self.casted then
				add(fireballs,make_fireball(self.x,self.y))
				self.is_casting=true
				self.casted=true
				self.light_counter+=30
				books-=1
				sfx(2)
			else
				self.is_casting=false
			end
			self.light_counter-=1
			self.light_counter=mid(0,self.light_counter,90)
			--limiting velocity
			self.velocity_x=mid(-8,self.velocity_x,8)
			self.velocity_y=mid(-8,self.velocity_y,8)
			--lighting settings and boss room settings
			if level==4 then
				if self.x>16 and self.x<104 then
					self.is_light=true
				else
					self.is_light=false
				end
				if self.y+self.velocity_y<56 then
					self.velocity_y=0
				end
			else
				if self.light_counter==0 and not self.casted then
					self.is_light=false
				else
					self.is_light=true
				end
			end
			--map collision
			local collision=hit_wall(self.x+self.velocity_x,self.y+self.velocity_y,self.width,self.height,4)
			if collision~="none" then
				--no movement
			else
				--applying velocity
				self.x+=self.velocity_x
				self.y+=self.velocity_y
			end
			--setting the sprite
			if self.is_up then
				self.sprite=3
			elseif self.is_down then
				self.sprite=2
			else
				self.sprite=1
			end
			--goblin collision
			for_each_game_object("goblin",function(goblin)
				if self:check_for_hit(goblin) 
				and not goblin.is_dead 
				and self.invulnerable==0 then
					--sparks effect
					explosion(self.x+self.width/2,self.y+self.height/2,self.width/2,5)
					lives-=1
					self.invulnerable=45
					sfx(4)
					--screenshake
					offset=0.5
				end
			end)
			--dagger collision
			for_each_game_object("dagger",function(dagger)
				if self:check_for_hit(dagger) 
				and self.invulnerable==0 then
					--sparks effect
					explosion(self.x+self.width/2,self.y+self.height/2,self.width/2,5)
					lives-=1
					self.invulnerable=45
					sfx(4)
					--screenshake
					offset=0.5
				end
			end)
			self.invulnerable-=1
			self.invulnerable=mid(0,self.invulnerable,45)
			--book collision
			for_each_game_object("book",function(book)
				if self:check_for_hit(book) 
				and not book.is_collected then
					books+=1
					book.is_collected=true
					sfx(3)
				end
			end)
			--key collision
			for_each_game_object("key",function(key)
				if self:check_for_hit(key) 
				and not key.is_collected then
					keys=true
					key.is_collected=true
					sfx(3)
				end
			end)
			--gate collision
			for_each_game_object("gate",function(gate)
				if self:check_for_hit(gate) 
				and not gate.is_opened then
					self.x-=8
					if keys then
						gate.is_opened=true
						sfx(5)
					end
				elseif self:check_for_hit(gate) 
				and gate.is_opened then
					if level==4 then
						--win game
						win=true
						mode="over"
						--victory music
						music(4)
					else
						--move to next level
						level+=1
						start_game()
						sfx(1)
					end
				end
			end)
		end,
		draw=function(self)
			spr(self.sprite,self.x,self.y,1,1,self.is_left)
			if not self.is_light then
				--light circle
				spr(self.light_sprite,self.x-12,self.y-12,4,4)
				rectfill(self.x-13,self.y-12,0,self.y+19,0)
				rectfill(self.x+19,self.y-12,128,self.y+19,0)
				rectfill(0,self.y-12,128,0,0)
				rectfill(0,self.y+19,128,128,0)
			else
				--dark screen edges
				spr(12,0,0,2,2)
				spr(40,0,112,2,2)
				spr(10,112,0,2,2)
				spr(46,112,112,2,2)
				local i
				for i=0,6 do
					spr(28,0,16+(i*16),2,2)
					spr(30,112,16+(i*16),2,2)
					spr(9,12+(i*16),0,2,2)
					spr(45,12+(i*16),112,2,2)
				end
			end
			--screenshake on hit
			if self.invulnerable>40 and self.invulnerable<45 then
				screen_shake()
			else
				--reset camera
				camera(0,0)
			end
			--print(self.x..", "..self.y,10,10,7)
			--print(self.invulnerable,10,18,7)
		end
	})
end

function make_fireball(x,y)
	local fireball={
		x=x,
		y=y,
		width=7,
		height=7,
		move_speed=2,
		sprite=4,
		sprite_vert=false,
		sprite_hor=false,
		direction="none",
		update=function(self)
			--check if player is casting spell
			for_each_game_object("player",function(player)
				if player.is_casting then
					if player.is_down then
						self.direction="down"
						self.sprite=4
						self.sprite_vert=true
					elseif player.is_up then
						self.direction="up"
						self.sprite=4
						self.sprite_vert=false
					elseif player.is_left then
						self.direction="left"
						self.sprite=20
						self.sprite_vert=false
						self.sprite_hor=true
					else
						self.direction="right"
						self.sprite=20
						self.sprite_vert=false
						self.sprite_hor=false
					end
				end
				--map collision
				local collision=hit_wall(self.x,self.y,self.width,self.height,1)
				if collision~="none" then
					player.casted=false
					remove(fireballs)
					sfx(1)
				end
				--torch collision
				for_each_game_object("torch",function(torch)
					if bounding_box_overlapping(self,torch) and not torch.is_lit then
						--sparks effect
						explosion(self.x+self.width/2,self.y+self.height/2,self.width/2,2)
						torch.is_lit=true
						player.casted=false
						player.light_counter+=90
						remove(fireballs)
						sfx(2)
					end
				end)
				--goblin collision
				for_each_game_object("goblin",function(goblin)
					if bounding_box_overlapping(self,goblin) and not goblin.is_dead then
						--sparks effect
						explosion(self.x+self.width/2,self.y+self.height/2,self.width/2,5)
						goblin.is_dead=true
						player.casted=false
						remove(fireballs)
						sfx(0)
					end
				end)
				--boss collision
				for_each_game_object("boss",function(boss)
					if bounding_box_overlapping(self,boss) and not boss.is_dead then
						--sparks effect
						explosion(self.x+self.width/2,self.y+self.height/2,self.width/2,10)
						boss.health-=1
						boss.is_hit+=5
						player.casted=false
						remove(fireballs)
						if boss.health>0 then
							sfx(0)
						else
							sfx(7)
						end
					end
				end)
			end)
			--move speed
			if self.direction=="down" then
				self.y+=self.move_speed
			elseif self.direction=="up" then
				self.y-=self.move_speed
			elseif self.direction=="left" then
				self.x-=self.move_speed
			else
				self.x+=self.move_speed
			end
			frame_counter(30)
			--fire anim
			if self.direction=="down" or self.direction=="up" then
				if frame>0 and frame<11 then
					self.sprite=4
				elseif frame>10 and frame<21 then
					self.sprite=5
				elseif frame>20 and frame<31 then
					self.sprite=6
				elseif frame==0 then
					self.sprite=4
				end
			elseif self.direction=="left" or self.direction=="right" then
				if frame>0 and frame<11 then
					self.sprite=20
				elseif frame>10 and frame<21 then
					self.sprite=21
				elseif frame>20 and frame<31 then
					self.sprite=22
				elseif frame==0 then
					self.sprite=20
				end
			end
		end,
		draw=function(self)
			spr(self.sprite,self.x,self.y,1,1,self.sprite_hor,self.sprite_vert)
		end
	}
	return fireball
end

function make_goblin(x,y,is_vert)
	return make_game_object("goblin",x,y,{
		width=7,
		height=7,
		move_speed=8,
		is_vert=is_vert,
		move=false,
		is_left=false,
		sprite=16,
		is_dead=false,
		update=function(self)
			--setting movement based on if they move horizontally or vertically
			if self.is_vert then
				self.velocity_y+=self.move_speed
			else
				self.velocity_x+=self.move_speed
			end
			--limiting velocity
			self.velocity_x=mid(-8,self.velocity_x,8)
			self.velocity_y=mid(-8,self.velocity_y,8)
			--move every 0.5 seconds
			if frame==15 or frame==30 then
				self.move=true
			else
				self.move=false
			end
			--map collision
			local collision=hit_wall(self.x+self.velocity_x,self.y+self.velocity_y,self.width,self.height,1)
			if collision~="none" then
				self.move_speed=-self.move_speed
			else
				if self.move then
					--applying velocity if no collision
					self.x+=self.velocity_x
					self.y+=self.velocity_y
				end
			end
			--setting the sprite
			if self.velocity_y<0then
				self.sprite=18
			elseif self.velocity_y>0 then
				self.sprite=17
			else
				self.sprite=16
			end
			if self.velocity_x<0 then
				self.is_left=true
			else
				self.is_left=false
			end
		end,
		draw=function(self)
			if not self.is_dead then
				spr(self.sprite,self.x,self.y,1,1,self.is_left)
			end
		end,
	})
end

function make_boss(x,y)
	return make_game_object("boss",x,y,{
		width=32,
		height=32,
		health=5,
		is_hit=0,
		is_dead=false,
		update=function(self)
			self.is_hit-=1
			self.is_hit=mid(0,self.is_hit,5)
			if self.health<=0 then
				self.is_dead=true
				keys=true
			end
			if self.is_hit>0 then
				--screenshake
				offset=1.5
			end
		end,
		draw=function(self)
			if not self.is_dead then
				spr(76,self.x,self.y,4,4)
			end
			--screenshake on hit
			if self.is_hit>0 then
				screen_shake()
			else
				--reset camera
				camera(0,0)
			end
		end
	})
end

function make_dagger(x,y)
	return make_game_object("dagger",x,y,{
		width=8,
		height=16,
		dagger_frame=0,
		indicator=false,
		ind_x=0,
		ind_y=0,
		update=function(self)
			self.dagger_frame+=1
			if self.dagger_frame>60 then
				self.dagger_frame=0
			end
			for_each_game_object("player",function(player)
				for_each_game_object("boss",function(boss)
					if player.x>16 and player.x<104 then
						if self.dagger_frame>30 and self.dagger_frame<60 and not boss.is_dead then
							self.attack=false
							self.indicator=false
							self.ind_x=player.x-1
							self.ind_y=player.y-1
							self.x=player.x
							self.y=8
						else
							self.indicator=true
							self.y+=8
						end
					else
						--dont attack when player is not it boss arena
					end
				end)
			end)
		end,
		draw=function(self)
			for_each_game_object("boss",function(boss)
				if not boss.is_dead then
					spr(75,self.x,self.y,1,2)
					if self.indicator then
						rect(self.ind_x,self.ind_y,self.ind_x+9,self.ind_y+9,8)
					end
				end
			end)
		end
	})
end

function make_book(x,y)
	return make_game_object("book",x,y,{
		width=8,
		height=8,
		is_collected=false,
		draw=function(self)
			if not self.is_collected then
				spr(7,self.x,self.y)
			end
		end
	})
end

function make_key(x,y)
	return make_game_object("key",x,y,{
		width=8,
		height=8,
		is_collected=false,
		draw=function(self)
			if not self.is_collected then
				spr(23,self.x,self.y)
			end
		end
	})
end

function make_gate(x,y)
	return make_game_object("gate",x,y,{
		width=8,
		height=8,
		is_opened=false,
		draw=function(self)
			if not self.is_opened then
				spr(19,self.x,self.y)
			end
		end
	})
end

function make_torch(x,y)
	return make_game_object("torch",x,y,{
		width=8,
		height=8,
		is_lit=false,
		sprite=53,
		update=function(self)
			for_each_game_object("player",function(player)
				if player.light_counter==0 then
					self.is_lit=false
				end
			end)
			if frame>0 and frame<11 then
				self.sprite=53
			elseif frame>10 and frame<21 then
				self.sprite=54
			elseif frame>20 and frame<31 then
				self.sprite=55
			elseif frame==0 then
				self.sprite=53
			end
		end,
		draw=function(self)
			if not self.is_lit then
				spr(39,self.x,self.y)
			else
				spr(self.sprite,self.x,self.y)
			end
		end
	})
end
-->8
--functions
function frame_counter(limit)
	frame+=1
	if frame>limit then
		frame=0
	end
end

function remove(list)
	local i
	for i=1,#list do
		del(list, list[1])
	end
end

function draw_ui()
	rectfill(0,0,128,8,0)
	local i
	for i=1,2 do
		if lives>=i then
			spr(37,i*9-8,0)
		else
			spr(36,i*9-8,0)
		end
	end
	local key_sprite
	if keys then
		key_sprite=23
	else
		key_sprite=38
	end
	spr(key_sprite,18,0)
	spr(7,27,0)
	print(books,36,1,7)
	for_each_game_object("gate",function(gate)
		if gate.is_opened then
			print("gate is open!",52,1,3)
		else
			print("gate is closed",52,1,8)
		end
	end)
end

--from bridgs
function for_each_game_object(name,callback)
	local obj
	for obj in all(game_objects) do
		if obj.name==name then
			callback(obj)
		end
	end
end

--spark effect from mikamulperi
function explosion(x,y,r,particles)
	local selected=0
	for i=1,#sparks do
		if not sparks[i].alive then
			sparks[i].x=x
			sparks[i].y=y
			sparks[i].velx= -1+rnd(4)
			sparks[i].vely= -1+rnd(4)
			sparks[i].mass=0.5+rnd(1)
			sparks[i].r=0.2+rnd(r)
			sparks[i].alive=true
			selected+=1
			if selected==particles then
			break end
		end
	end
end

--screenshake from doc robs
function screen_shake()
  local fade = 0.95
  local offset_x=16-rnd(32)
  local offset_y=16-rnd(32)
  offset_x*=offset
  offset_y*=offset
  
  camera(offset_x,offset_y)
  offset*=fade
  if offset<0.05 then
    offset=0
  end
end
-->8
--collision
--collision from bridgs
function rects_overlapping(left1,right1,top1,bottom1,left2,right2,top2,bottom2)
	return right1>left2 and right2>left1 and bottom1>top2 and bottom2>top1
end

--collision from bridgs
function bounding_box_overlapping(obj1,obj2)
	return rects_overlapping(obj1.x,obj1.x+obj1.width,obj1.y,obj1.y+obj1.height,obj2.x,obj2.x+obj2.width,obj2.y,obj2.y+obj2.height)
end

--map collision 
function check_tile(x,y,flag)
	local tile_x=x/8+map_x
 	local tile_y=y/8+map_y
 	local tile=mget(tile_x,tile_y)
 	return fget(tile,flag)
end

--map collision 
function hit_wall(x,y,width,height,indent)
 	if (check_tile(x+indent,y,0)) and (check_tile(x+width-indent,y,0)) then
 		return "top"
 	elseif (check_tile(x+indent,y+height,0)) and (check_tile(x+width-indent,y+height,0)) then
 		return "bottom"
 	elseif (check_tile(x,y+indent,0)) and (check_tile(x,y+height-indent,0)) then
 		return "left"
 	elseif (check_tile(x+width,y+indent,0)) and (check_tile(x+width,y+height-indent,0)) then
 		return "right"
 	else
 		return "none"
 	end
end
__gfx__
00000000b1222bbbbb1222bbbb1222bbbbaaaabbbbaaaabbbbaaaabbb444444b0000000000000000000000000000000000000000000000000000000000000000
00000000bb1222bbb122222bb122222bbaa9aa9bbaa9aaabbaa9aa9b2442244b0000000000000000000000000000000000000000000000000000000000000000
00700700111111221111111211111112ba9aa9abba9a9a9bba99a9ab2444444b000000000b0000b00bbb0b00b0b0b00000000000b00000000bb00b0000b00000
00077000bee1ff1bbe1ff1ebbeeeeeebbb9999bbbba999bbbb9a99ba2422224b0000b0b000b0bbbbb000b0bb00000000000b000b00b0b0b00000b0bbbb000000
00077000befffffbbeffffebbeeeeeebbb9999b9ab9999bbbb9989bb2444444b0000000b0bb0b0b0bbbbbb00bb0b00000000bb0b00bb0b0bb0bbbb0b00b0b000
00700700bb2222bbbb2222bbbb2ee2bbbb8998bbbb8998bbbb8998bb2444444b000b0b00b0bbbbbbb0bb0bbbb0b0b0b000000000bb0bbb0b0bb0bbbb0b000b00
00000000bbf222fbbf2222fbbf2222fbbbb98bbbbbb89bb88bb98bbb2778772b0000b0bbbbbbbbbbbbbbbbbb0bbb000000b0b00b0bbbbbbbbbbbb0bbb00b0000
00000000bb1bb1bbbb1bb1bbbb1bb1bbb8b88bbbbbb88bbbbbb88bbbb228222b00b00bbbbbbbbb0bbbbbbb0bbb0bb0b000000b0bbbbbbbbbbbbbbbbb0bb0b000
bb111dbbbb1dddbbbbddddbbddddddddbbbbbbbbbbbabbbbb8bbbbbbbbb99bbb00000bb0bbbbbbbbbbbbbbbbbbb0b000000000b00bbbbbbbbbbbbbbbbbb0b000
b1dddddbb1dddddbbddddddbdbdbbdbd8bbbbaabbbbbbaabbbbbbaabbbb9bbbb000b0bbbbb0bbbbbbbbbbbbbbbbb0b00000b0bbbbbbbbbbbbbbbbbbbbbbb0b00
1dd3dd3d1d3dd3dddddddddddbd99dbdbb8999aabb89a9aabb8999aabbb99bbb0000bb0bbbbbbbbbbbbbbbbbbb0bb0000000bb0bbbbbbbbbbbbbbb0bbbbbb000
1d32dd2d132dd23d1dddddd1db9009bd89999a9a88999a9a8999a99abbb9bbbb000b0bbbbbbbbbbbbbbbbbbbbbbb0000000b0bbbbbbbbbbbbbbbbbbbbbbb0000
1d33333d1333333d11111111db9009bd88999aaa899999aa88989aaabb999bbb00b0bbbbbbbbbbbbbbbbbbbbbb0bbb0000b0b0b0bbbbbbbbbbbbbbbbbbb0bb00
bbddddbbbbddddbbbb1111bbdbd99dbdbb8999aabb899aaabb8999aab9bbb9bb0000bbbbbbbbbbbbbbbbbbbbbbbb0b00000000bbbbbbbbbbbbbbbbbbbbbbb000
bb3ddd3bb3dddd3bb3dddd3bdbdbbdbdbbbbba9bbbbbb9abbbbbba9bb9bbb9bb000bb0bbbbbbbbbbbbbbbbbbbbbbb000000b0bbbbbbbbbbbbbbbbbbbbbbb0000
bb1bb1bbbb1bb1bbbb1bb1bbddddddddbbb9bbbbb8bbbbbbbbbbabbbbb999bbb00b0bbbbbbbbbbbbbbbbbbbbbbb0bbb00000bb0bbbbbbbbbbbbbbbbbbbbb0b00
5dddddd50000000000000000b555555bb22bb22bb22bb22bbbb55bbbbbbbbbbb0000bbbbbbbbbbbbbbbbbbb0bbbbbb000000bbbbbbbbbbbbbbbbbbbbbbb0b000
d5dddd510000050000050050544444452bb22bb228822882bbb5bbbbbbbbbbbb000b0bbbbbbbbbbbbbbbbbbbbbb0b000000b00bbbbbbbbbbbbbbbbbb0bbb0000
dd5555110055000000000000544444452bbbbbb228888882bbb55bbbbbbbbbbb000bbbbbbbbbbbbbbbbbbbbbbbbbb0b0000b0b0bbbbbbbbbbbbbbbb0bbbbb000
dd5555110000000000005000255555522bbbbbb228888882bbb5bbbbbb4444bb00000bbbbbbbbbbbbbbbbbbbbbbb0b0000000bbbbbbbbbbbbbbbbbbbbbbb0b00
dd5555115000500000000000242442422bbbbbb228888882bb555bbbbb2442bb0000b0bbbbbbbbbbbbbbbbbbb0bbb0000000b0bbbbbbbbbbbbbbbbbbbbbbb000
dd555511000000000500000024244242b2bbbb2bb288882bb5bbb5bbbbb24bbb00b00bbbbbbbbbbbbbbbbbbbbbb0b00000b00b0bbbbbbbbbbbbbbbbbbbb0b000
d5111151050005000000005054244245bb2bb2bbbb2882bbb5bbb5bbbbb24bbb0000b0b0bbbbbbbbbbbbbbbbbbbb00000000b0bbbbbbbbbbbbbbb0bbb0bb00b0
511111150000000000000000b555555bbbb22bbbbbb22bbbbb555bbbbbb22bbb00000bbbb0bbbbbb0bbbbbbbbbb0b0b000000bb0b0bbbbbbbbbbbbbb0bb0b000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb9bbabbbbbbabbbbbbbabb9b000bbbb0bbbbbbbbbbbbbbbb0b00000000b00b0bbbbbbbbbbbbbb0bbb000b000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaabbbbbaaab8bbbbaabbb0000b00bb0bbb0bbbbb0bb0bb0b00b000000b0bb0bb0bbbbbbbbbbbb0bb00b00
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbba99abbbba9abbbbba99abb00b0bb0b0bb0bbb00bbbbbbbbb0b0000000b0b00b0bbbbb0bbbb0bb0b00b0b00
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaba889babb989abbab988abb0000000b00b0b0bbb00bb0bbb00000000000000b00b0b0bb0b0bb0000b000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb4444bbba4444bbbb4444ab000000b0b00b0bb000b00b0b0b00b0b00000b0b0b000bb00b0b00b0b0000b000
ddddddddbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb44bbbbbb44bb9bbb44bbb000000000000b0000000b00000000000000000000b0b00b0b000b00000b0b000
bdbbbbdbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb24bbbbab24bbbb8b24bbb00000000000000000000000000000000000000b00000000b00b0000000000000
bdbbbbdbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb22bbbbbb22bbbbbb22bbb0000000000000000000000000000000000000000000000000000000000000000
bb7bbbbbbbbbbb7bbbb7bbbbbb7bbbbbbbbbbbbbbbb7bbbbbbbbbbbbbbbbbbbb000000000000000000000000bb1555bb00000000000000000000000000000000
b77bbbbbbbbbb77bbb77bbbbb77bbbbbbbbbbbbbbb77bbbbbbbb77bbbbbbbbbb000000000000000000000000bbb24bbb00000000000000000000000000000000
777bbbbbbbbb777bbb77bbbb777bbbbbbbbbbbbbb777bbbbbbbb77bbbbbbbbbb000000000000000000000000bbb24bbb00000000000050505050000000000000
277bbbbbbbbb277bbb72bbbb277bbbbbbbbbbbbbb277bbbbbbbb72bbbbbbbbbb000000000000000000000000b155555b00000000050505050505050000000000
b77bbbbbbbbbb77bbb2bbbbbb77bbbbbbbbbbbbbbb77bbbbbbb72bbbbbbbbbbb0000000000000000000000001555555500000000505550555555505500000000
b77bbbbb7bbbb77bbbb7bbb777777bbb77777777bb77777777b2bb77777777bb000000000000000000000000bbd666bb00000055555555555555550055000000
b77bbbb77bbbb77bbb77bb7777772bb777777777bb77777777bbb777777772bb000000000000000000000000bbd667bb00000500555555555505555550500000
b77bbb777bbbb77bb777bb222772bb7772222277bb77222277bb777222222b7b000000000000000000000000bbd666bb00005055555555555555555555050000
b77bbb277bbbb77bb277bbbbb77bbb277bbbbb72bb77bbbb77bb277bbbbbb77b000000000000000000000000bbd667bb00000555505555555555555550500000
b77bbbb77bbbb77bbb77bbbbb77bbbb77bbbb72bbb77bbbb77bbb77bbbbb777b000000000000000000000000bbd667bb00055555555555555555555555055000
b77bbbb77bbbb77bbb77bbbbb77bbbb77bbbb2bbbb77bbbb77bbb77bbbb7277b000000000000000000000000bbd667bb00505055555555522555555555500500
b77bbbb77bbbb77bbb77bbbbb77bbbb77bbbbbbbbb77bbbb77bbb77bbb72b77b000000000000000000000000bbd667bb00055555555555287255555550555000
b777bb7777bb777bbb77bbbbb77bbbb777bbbbbbbb77bbbb77bbb77bb72bb77b000000000000000000000000bbd667bb00550555555555287255555555555500
b27777722777772bbb77bbbbb77bbbb277777777bb77bbbb77bbb77b72b7777b000000000000000000000000bbd667bb05055555555555288255555555555550
bb27772bb27772bbbb72bbbbb72bbbbb27777772bb72bbbb72bbb2772b77772b000000000000000000000000bbd666bb00555555555555288255555555555500
bbb222bbbb222bbbbb2bbbbbb2bbbbbbb222222bbb2bbbbb2bbbbb22bb2222bb000000000000000000000000bbbd6bbb05555555555555522555555555550550
bb7777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb7bbbbbb0000000005055553333355555555333335555550
b777777777777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77bbbbbb0000000005555522333355555555333322555500
77722222222777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb777bbbbbb0000000000555533223355555555332233555550
277bbbbbbbb2777bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb277bbbbbb0000000005555533222255555555222233555500
b77bbbbbbbbb277bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb77bbbbbb0000000000555533222335555553322233555550
b77bbbbbbbbbb77bbbb77777777bbbb77777777bbbbb77777777bbbb77777777bbbb7777777bbb777777bbbb0000000005555533222333555533322233555050
b77bbbbbbbbbb77bbb777777777bbb777777772bbbb777777777bbb777777777bbb77777777bb7777772bbbb0000000000555533323333333333332333555500
b77bbbbbbbbbb77bb7772222277bb777222222b7bb7772222277bb7772222277bb777222277bb222772bbbbb0000000005505533333332333323333333550550
b77bbbbbbbbbb77bb277bbbbb72bb277bbbbbb77bb277bbbbb72bb277bbbbb72bb277bbbb77bbbbb77bbbbbb0000000000555533333333233233333333555500
b77bbbbbbbbbb77bbb77bbbb72bbbb77bbbbb777bbb77bbbb72bbbb77bbbb72bbbb77bbbb77bbbbb77bbbbbb0000000005050533333333322333333333555050
b77bbbbbbbbbb77bbb77bbb72bbbbb77bbbb7277bbb77bbbb2bbbbb77bbb72bbbbb77bbbb77bbbbb77bbbbbb0000000000505333333333333333333333350500
b77bbbbbbbbbb77bbb77b772bbbbbb77bbb72b77bbb77bbbbbbbbbb77b772bbbbbb77bbbb77bbbbb77bbbbbb0000000000000033333322222222333333000000
b777bbbbbbbb777bbb77722bbbbbbb77bb72bb77bbb777bbbbbbbbb77722bbbbbbb77bbbb77bbbbb77bbbbbb0000000000000005333233333333233350000000
b27777777777772bbb277777777bbb77b72b7777bbb277777777bbb277777777bbb77bbbb77bbbbb77bbbbbb0000000000000050533322222222333505000000
bb277777777772bbbbb27777772bbb2772b77772bbbb27777772bbbb27777772bbb72bbbb72bbbbb72bbbbbb0000000000000005055533333333555050000000
bbb2222222222bbbbbbb222222bbbbb22bb2222bbbbbb222222bbbbbb222222bbbb2bbbbb2bbbbbb2bbbbbbb0000000000000000500555555555500500000000
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbabbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbb2222bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbabbabbbbbbbb9bbbbbbbbbbbbbbabbbbbbbabbbaabbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbb2222222bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaabbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbb222222222bbbbbbbbbbbbbbbbb2bbbbbbbbbbbbbbbbbbbbbbaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaaaabbbbbbbbbbbb9bbb
bbbbbbbbbbbbbbbbbbbbbbbbb22222222222bbbbbbbbbbbbbbb22bbbbbbbbbbbbbbbabbbbbbbaabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbaaaabbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbb2211122222222bbbbbbbbbbbbb22bbbbbbbbbbbbbbbbbbbb9bbbaaabbbbbbbbbbbbbbbbbbbbbbabb9bbaaaaababbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbb222222112222222bbbbbbbbbbb222bbbbbbbbbbbbbbbbbbbbbbbb9aabbbb9bbbbabbbbbbbbbbbbbbbbbbaaa9abbbbb9bbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbb22222222212222221bbbbbbbbb222bbbbbbbbbbbbbbbbbbbbbbbbba9abbbbbbbbbbbbbbbbbbbbbbbbbbbbaaaaabbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbb222222222222222222122bbbbb222bbbbbbbbbbbbbbbbbbbb9bbbbaa9aabbbbbbbbbbbbbbbbbbbbbbbbbbaaa9aabbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbb222211222222222222222222222222bbbbbbbbbbbbbbbbbbbbbbbbba99aabbbbbbbbbbbbbbbbb9bbbbbbba9a99aabbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbb222112222221111112221111222222bbbbbbbbbbbbbbbbbbbbbbbbbaa99aabbbbbbbbbbbbbbbbbbbbbbbbbaaa999abbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbb221122222222222222222222211222bbbbbbbbbbbbbbbbbbbbbb8bbaaa999abbbbbbbbbbbbbbbbbbbb8bbbaaa9999aabbbbb8bbbbbbbbb
bbbbbbbbbbbbbbbbb211222222222222222222222222212bbbbbbbbbbbbbbbbbbbbbbbbbaaaa999abbbbbb8bbbbbbbbbbbbbbbbaaaa9989aabbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbb112222222222222222222222222222bbbbbbbbbbbbbbbbbbbbbbbbba9aa99899abbbbbbbbbbbbbbbbbbbbbaaaa99889aaabbbbbbbbbbbbbb
bbbbbbbbbbbbbbb22222222222222222222222222222222bbbbbbbbbbbbbbbbbbbb9bbbaaa99899aaabbbbbbbbbbbbbbbbbbbaaaa9998899aaabbbbbbabbbbbb
bbbbbbbbbbbbbb2222222222222222222222222222222222bbbbbbbbbbbbbbbbbbbbbbaaa9998899aabbbbbbbbbbbbbbbbbbbaaa99988899aaabbbbbbbbbbbbb
bbbbbbbbbbbbb22222222222222222222222222222222222222bbbbbbbbbbbbbbbbbbaaa99988899aaabbbbbbbbbbbbbbbbbaaaa999888989aabbbbbbbbbbbbb
bbbbbbbbbbbb22222222222222222222222222222222222222222bbbbbbbbbbbbbbbbaaa999888999aaabbbbbbbbbbbbbbbbaaa9998888999aaabbbbbbbbbbbb
bbbbbbbbbbb22222222222222222222222222222222222222222222bbbbbbbbbbbbbbaa99988888999aaabbbbbbbbbbbbbbba9a99988888999aaabbbbbbbbbbb
bbbbbbbbb2222222222222eeeeeeeeeeeeeeeeeeeeeeeee2222222222bbbbbbbbbbbbaa98988888999aaabbbbbbbbbbbbbbbaaa98988888999aaabbbbbbbbbbb
bbbbbbb2222222222eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee11111122bbbbbbbbbbaa999888888999aaabbbbabbbbbbbbbaaa999888889989aabbbbbbbbbbb
bbbbb222222222eeeeeeeeeeeeeeffeeeeeeeeeeeeeeeeeeeee1111111122bbbbbbbbaa999988888989aaabbbbbbbbbbbbbbaaa999888888999aabbbbbb8bbbb
bbb22111111111eeeeeeeeeeeeeffffeeeeeeeeeeeeeeeeeeee22222222bbbbbbbbbbaa999988888999aaabbbbbbbbbbbbbbbaa999988888999aabbbbbbbbbbb
b2211111111111eeeeeeeeeeeeefffffeeeeeeeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbaa99ff8ffffffffabbbbbbbbbbbbbbbbaa99ff8ffffffffbbbbbbbbbbb
bbb22222222222eeeeeeeeeeeeffffffeeeeeeeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbaaa9ff8fffffffffbbbbbbbbbbbbbbbbaaa9ff8fffffffffbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeeeeeefffffffeeeeeeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbbaa9ffffffffffffbbbbbbbbbbb9bbbbbaaaffffffffffffbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeeeeeffffffffffeeeeeeeeeeeeeeeebbbbbbbbbbbbbbbbb9bbbaaf22f22222fffbbbbbbbbbbbbbbbbbbaaf22f22222fffbbbabbbbbb
bbbbbbbbbbbbbbeeeeeeeeeeefffffffffffeeeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbffffffffffffbbbbbbbbbbbbbbbbbbbbffffffffffffbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeeeeeffffffffffffeeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbfffffffffffbbbbbbbbbbbbbb8bbbbbbfffffffffffbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeeeeffffffffffffffeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbfffffffffffbbbbbbbbbbbbbbbbbbbbbfffffffffffbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeeeeffffffffffffffeeeeeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbbfffffffffbbbbbbbbbbbbbbbbbbbbbbbfffffffffbbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeee222222ffffff222222eeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbfffffffbbbbbbbbbbbbbbbbbbbbbbbbbfffffffbbbbbbbbbbbb
bbbbbbbbbbbbbbeeeeeeeeeff222f2ffff2f222feeeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb22222222222222222222222222222222
bbbbbbbbbbbbbbeeeeeeeefff222ffffffff222ffeeeeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb22222222222222222222222222222222
bbbbbbbbbbbbbbeeeeeeeeffff2ffffffffff2fffeefeeeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb22222222222222222222222222222222
bbbbbbbbbbbbbbeeeeeeefffffffffffffffffffffefeeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb222222eeeeeeeeeeeeeeeeeeeeeeeee2
bbbbbbbbbbbbbbbeeeeefffffffffffff2ffffffffeffeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb2eeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
bbbbbbbbbbbbbbbeeeefffffffffffff2ffffffffffffeeeeebbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbeeeeeeeeeeeeffeeeeeeeeeeeeeeeeee
bbbbbbbbbbbbbbbeeeeffffffffffffffffffffffff77eeeebbbbbbb77bbbbbbbbbbbbbbbbbbbbbbbbb22222bbbbbbbbeeeeeeeeeeeffffeeeeeeeeeeeeeeeee
bbbbbbbbbbbbbbbeeeeeffffffffffffffffffffff4447777bbb7777444bbbbbbbbbbbbbbbbbbbbbbb2222222bbbbbbbeeeeeeeeeeefffffeeeeeeeeeeeeeeee
bbbbbbbbbbbbbbbbeeeeeffffffffff22fffffffff44444447774444444bbbbbbbbbbbbbbbbbbbbbb222222222bbbbbbeeeeeeeeeeffffffeeeeeeeeeeeeeeee
bbbbbbbbbbbbbbbbeeeeeeeffffffffffffffffffe44444442224444444bbbbbbbbbbbbbbbbbbbb11122222222bbbbbbeeeeeeeeeefffffffeeeeeeeeeeeeeee
bbbbbbbbbbbbbbbbeeeeeeeeffffffffffffffffee44444442224444444bbbbbbbbbbbbbbbbbbb1222222222222bbbbbeeeeeeeeeffffffffffeeeeeeeeeeeee
bbbbbbbbbbbbbbbbbeeeeeeeeefffffffffffffeee44444442224444444bbbbbbbbbbbbbbbbbb12222221122222bbbbbeeeeeeeeefffffffffffeeeeeeeeeeee
bbbbbbbbbbbbbbbbbbeeeeee222222ffff2222222e44444442224444444bbbbbbbbbbbbbbbbb2222222222122222bbbbeeeeeeeeeffffffffffffeeeeeeeeeee
bbbbbbbbbbbbbbbbbbeeee2222222222222222222244444442224444444bbbbbbbbbbbbbbbb22222222222212222bbbbeeeeeeeeffffffffffffffeeeeeeeeee
bbbbbbbbbbbbbbbbbbeee222222222222222222222444ffffff24444444bbbbbbbbbbbbbbb22222222222221b222bbbbeeeeeeeeffffffffffffffeeeeeeeeee
bbbbbbbbbbbbbbbbbbeee222222222222222222222444ffffff24444444bbbbbbbbbbbbbb222222222222222bbb22bbbeeeeeeefffffffffffffffeeeeeeeeee
bbbbbbbbbbffbffffffff22222222222222222222244fffffff2f444444bbbbbbbbbbbbb22222222222222222bbbbbbbeeeeeee2222fffffffff2222eeeeeeee
bbbbbbbbbbffbfffffffff2222222222222222222244fffffff2ff44444bbbbbbbbbbbb222222222222222222bbbbbbbeeeeee2ffff22fffff22ffff2eeeeeee
bbbbbbbbbbffffffffffff2222222222222222222244fff222f2ff44444bbbbbbbbbbb22222282222828222222bbbbbbeeeeeefffffffffffffffffffeefeeee
bbbbbbbbbbf22f22222fff2222222222222222222244f22ffff2ff44444bbbbbbbbb2122222222222228222222bbbbbbeeeeefffffffffffffffffffffefeeee
bbbbbbbbbbffffffffffff2222222222222222222244ffffffff2f44444bbbbbb222221222222222222282222212bbbbeeeefffffffffffff2ffffffffeffeee
bbbbbbbbbbbfffffffffff2222222222222222222244ffffffffff44444bbbbbb22222221112222222222282112222bbeeefffffffffffff2ffffffffffffeee
bbbbbbbbbbbfffffffffff2222222222222222222222ffffffffff44bbbbbbbb8822222222211111111111222222222beeeffffffff2ffffffff2ffffff77eee
bbbbbbbbbbbbfffffffff222222222222222222222222fffffffffbbbbbbbbbb88822222222222222222222222222228eeeefffffff2ffffffff2fffff444777
bbbbbbbbbbbb2fffffff1222222222222222222222222ffffffff2bbbbbbbbbbb8888882222222222222228822222288eeeeefffffff2ffffff2ffffff444444
bbbbbbbbbbbb2111111112222222222222222222222221ffffff22bbbbbbbbbbbb888888888822222222222222888888eeeeeeeffffff22ff22ffffffe444444
bbbbbbbbbbbb22111111122222222222222222222212211ffff122bbbbbbbbbbbbbb888888888888888888888888888beeeeeeeefffffff22fffffffee444444
bbbbbbbbbbbb221111112212222222222222222222122111111122bbbbbbbbbbbbbbb8888888888888888888888888bbbeeeeeeeeefffffffffffffeee444444
bbbbbbbbbbbb222111112122222222222222222222212111111122bbbbbbbbbbbbbbbbbbb88888888888888888bbbbbbbbeeeeee222222ffff2222222e444444
bbbbbbbbbbbbb2221112212222222222222222222221221111112bbbbbbbbbbbbbb88bbbbb8888bbbbb88888888bbbbbbbeeee22222222222222222222444444
bbbbbbbbbbbbbb222222122222222222222222222222122111222bbbbbbbbbbbbbbbb88bbbbbbbb8bbbb888888bbb8bbbbeee222222222222222222222444fff
bbbbbbbbbbbbbbbb11112222222222222222222222222122222bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbeee222222222222222222222444fff
__gff__
0000000000000000000000000000000000000000000000000000000000000000010000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
2020202020202020202020202020202000202020202020202020202020202020200020202020202020202020202020202020002020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2022212021222220212221222220212000202220212222202222222023222123200020222121202220222222212022212120002000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021222221212220222222232221222000202122212021202222222222212223200020212021202120222020222021222220002000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202021212120212020202020212000202120212021202321222021212220200020212121202120222122212021222120002000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2022212122222220222022232320212000202122212022202020202020202121212013222022222220202120202020202120002000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020212020202020222021222122222000202221202021202122212222202220200020222122202121222221222220222120002000000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021222221212222212022202020202000202222202222222121202222212121200020212022202222212121222320212020002020203030303030303030303020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2022232120202020202022202222222000202020202022202121222221202222200020222222202020202022222320222222201322202122212222212222212120212220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2022202220212222212221202221222000202121222221202020202020202022200020222022202222222022222320212020002022202221202022222020222220222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021232120222020202022202222222000202020212022202121222122202221200020212221202222212022222220222220002021202122212121212122212120222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2022212220222022222222202022202000202221222022202223212322202221200020202020202022202021202020202220002021202120222120202122202220222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020222020202021222221222120132121202021202122222222202220200020222121212121212222212320222220002022202122222122222122222220222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021222220212222222022202022202000202122222021202020202021202122200020212222202022202021222121212120002022202222202021212020212120212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2021202020222020202022202222222000202020212021202122222022202222200020212321202122212022222220222120002021222122222221222221222121212000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2022212221222222222221202121222000202221222021222221212121202221200020222222202222222023222320232320002022222222222122212121212121222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2020202020202020202020202020202000202020202020202020202020202020200020202020202020202020202020202020002020202020202020202020202020202000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0304000025653196301863016630136200e6200d6100b615000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0303000018053180300c0200c02018610186101861500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400001d65011630106300f6200d6200b6100861500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500001e1501e140211402413024135000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0b0300003165331630306302e6302b620266202561023615000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010500001c1502115026150211001c150211502615024100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
01050000171501b1301f1100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
030400003d6533d6503c6403a64037630326301962023625000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
09140020011140111001120011200113001130011300113503114031100312003120031300313003130031350a1140a1200a1200a135081140812008120081350011400110001200012000130001300013000135
09140020051140511005120051200513005130051300513507114071100712007120071300713007130071350d1140d1200d1200d1350c1140c1200c1200c1350311403110031200312003130031300313003135
0914002008114081100812008120081300813008130081350a1140a1100a1200a1200a1300a1300a1300a135111141112011120111350f1140f1200f1200f1350711407110071200712007130071300713007135
091400200c1140c1100c1200c1200c1300c1300c1300c1350d1140d1100d1200d1200d1300d1300d1300d13514114141201412014135131141312013120131350a1140a1100a1200a1200a1300a1300a1300a135
09140020011140111001120011200113001130011300113503114031100312003120031300313003130031350a1140a1200a1200a135081140811008110081200812008120081200813008130081300813008135
09140020051140511005120051200513005130051300513507114071100712007120071300713007130071350d1140d1200d1200d1350c1140c1100c1100c1200c1200c1200c1200c1300c1300c1300c1300c135
0914002008114081100812008120081300813008130081350a1140a1100a1200a1200a1300a1300a1300a135111141112011120111350f1140f1100f1100f1200f1200f1200f1200f1300f1300f1300f1300f135
091400200c1140c1100c1200c1200c1300c1300c1300c1350d1140d1100d1200d1200d1300d1300d1300d13514114141201412014135131141311013110131201312013120131201313013130131301313013135
011000200e5140e5100e5200e5200e5300e5300e5300e5350a5140a5100a5200a5200a5300a5300a5300a5350d5140d5100d5200d5200d5300d5300d5300d5350951409510095200952009530095300953009535
0110002011514115101152011520115301153011530115350e5140e5100e5200e5200e5300e5300e5300e53510514105101052010520105301053010530105350d5140d5100d5200d5200d5300d5300d5300d535
011000201551415510155201552015530155301553015535115141151011520115201153011530115301153513514135101352013520135301353013530135351051410510105201052010530105301053010535
011000200e5140e5100e5200e5200e5300e5300e5300e5350a5140a5100a5200a5200a5300a5300a5300a5350d5140d5100d5200d5200d5200d5200d5300d5300d5300d5300d5300d53510514105201053010535
0110002011514115101152011520115301153011530115350e5140e5100e5200e5200e5300e5300e5300e53510514105101053010520105201052010530105301053010530105301053513514135201353013535
011000201551415510155201552015530155301553015535115141151011520115201153011530115301153513514135101352013520135201352013530135301353013530135301353516514165201653016535
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011100201e1141e1201e1301e1351d1141d1201d1301d1351a1241a1251d1241d125181001a1141a1201a1351e1141e1101e1201e1201e1301e1301e1301e1352311423110231202312023130231302313023135
0111002021114211202113021135201142012020130201351e1241e1252012420125181001e1141e1201e13521114211102112021120211302113021130211352611426110261202612026130261302613026135
011100202511425120251302513523114231202313023135211242112523124231251810021114211202113525114251102512025120251302513025130251352a1142a1102a1202a1202a1302a1302a1302a135
011100201a1141a1201a1301a1351911419120191301913517124171251912419125181001711417120171351a1141a1101a1201a1201a1301a1301a1301a1351711417120171301713519114191201913019135
011100201e1141e1201e1301e1351d1141d1201d1301d1351a1241a1251d1241d125181001a1141a1201a1351e1141e1101e1201e1201e1301e1301e1301e1351a1141a1201a1301a1351d1141d1201d1301d135
0111002021114211202113021135201142012020130201351e1241e1252012420125181001e1141e1201e13521114211102112021120211302113021130211351e1141e1201e1301e13520114201202013020135
011100202511425120251302513523114231202313023135211242112523124231251810021114211202113525114251102512025120251302513025130251352111421120211302113523114231202313023135
091100200551405520055200553504514045200452004535095140952009520095300953509515025140252505514055100552005520055300553005530055350451404520045200453508514085200852008535
0111002009514095200952009535085140852008520085350c5140c5200c5200c5300c5350c51505514055250951409510095200952009530095300953009535085140852008520085350b5140b5200b5200b535
011100200c5140c5200c5200c5350b5140b5200b5200b53510514105201052010530105351051509514095250c5140c5100c5200c5200c5300c5300c5300c5350b5140b5200b5200b5350e5140e5200e5200e535
01110020105141052010520105350e5140e5200e5200e5351551415520155201553015535155150c5140c52510514105101052010520105301053010530105350e5140e5200e5200e53511514115201152011535
091100200551405520055200553504514045200452004535095140952009520095300953509515025140252505514055100552005520055200552005530055300553005530055300553508514085200853008535
0111002009514095200952009535085140852008520085350c5140c5200c5200c5300c5350c51505514055250951409510095200952009520095200953009530095300953009530095350b5140b5200b5300b535
011100200c5140c5200c5200c5350b5140b5200b5200b53510514105201052010530105351051509514095250c5140c5100c5200c5200c5200c5200c5300c5300c5300c5300c5300c5350e5140e5200e5300e535
01110020105141052010520105350e5140e5200e5200e5351551415520155201553015535155150c5140c52510514105101052010520105201052010530105301053010530105301053511514115201153011535
0303000009133091250a1001510012100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 08090a0b
02 0c0d0e0f
01 1011125a
02 13141544
01 1a171819
02 1a1b1c1d
01 1e1f2021
02 22232425

