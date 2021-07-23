/// @description Insert description here
// You can write your code in this editor
var dx,dy,psp,tmp;//临时变量
dx=0;
dy=0;
psp=0.5;

//***死亡检测
if(state==1)
{
	sprite_index=spr_playe_dead;
	image_index_playerdead+=0.038;
	image_index=image_index_playerdead;
	if(timer>0)timer-=1;
	else game_restart();
	exit;
}

//**移动控制 
if(keyboard_check(ord("W")))
{
	dy=-1;
	face=1;

}
else
if(keyboard_check(ord("S")))
{
	dy=1;
	face=3;

}
else
if(keyboard_check(ord("A")))
{
	dx=-1;
	face=2;

}
else
if(keyboard_check(ord("D")))
{
	dx=1;
	face=0;
}
else
{
	image_index=0;
}
//***丢炸弹
if(keyboard_check_pressed(ord("J")))
{
	instance_create_depth(x-((x+8) mod 16)+8,y-((y+8) mod 16)+8,0,obj_boom);
	audio_play_sound(snd_boom_creat,0,false);
}
//***碰撞检测
//**横向检测
tmp=collision_rectangle(x+2+dx*psp,y,x+13+dx*psp,y+15,obj_wall_father,0,0);
if(tmp)
{
	if(tmp.y>y)dy=-1;
	if(tmp.y<y)dy=1;
	dx=0;
}
//**纵向检测
tmp=collision_rectangle(x+2,y+dy*psp,x+13,y+15+dy*psp,obj_wall_father,0,0);
if(tmp)
{
	if(tmp.x>x)dx=-1;
	if(tmp.x<x)dx=1;
	dy=0;
}
//***坐标计算
x+= dx*psp;
y+= dy*psp;
//***动画控制
if(dx!=0||dy!=0)
{
	image_index=image_index_player;	
	//image_index_player+=0.1;
		if((image_index_player mod 2)==0)
	{
		audio_play_sound(snd_step_0,0,false);
	}
	if(image_index_player<3.9)image_index_player+=0.1;
	else image_index_player=0;

}
//***外观改变
switch(face)
{
	case 0:sprite_index=spr_playe_right;break;
	case 1:sprite_index=spr_playe_up;break;
	case 2:sprite_index=spr_playe_left;break;
	case 3:sprite_index=spr_playe_down;break;
}
