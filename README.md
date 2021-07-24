# 使用GamemakerStudio2制作《炸弹人》心得体会

>本篇为观看up主红色激情的教学视频所写的心得体会
>视频地址：[红激教你做游戏-GameMaker8游戏制作教程(新增番外篇)p5](https://www.bilibili.com/video/BV1Es41167QH?p=5)

我发现只是按流程总结代码已经没什么意义了，反而会浪费时间，因此，之后的学习总结将变为心得体会，只会记录一些出现的bug以及调制的方法，加深印象，留下足迹，方便以后记不起来的时候查看

## 碰撞检测时横向检测&纵向检测分开检测

目的在于当玩家碰到墙壁后会根据碰撞墙体与玩家坐标值的判断来进行适当的滑行达到仍然可以走而不是顶在墙上动不了。一口气说这么长的话好累&#x1F611;

## 玩家行走时动画不再播放,只是一个动作

我找了半天也不知道问题为甚么会出现,最终锁定问题是出现在动画控制代码块,将image_index+=0.1调成image_index+=0.2后解决了不再动的问题.
后来我询问了群友，群友告诉我**建议自己写一个变量，然后step里让image_index=你这个变量**。于是乎，将动画控制区块的代码改写为：

```GML
//***动画控制
if(dx!=0||dy!=0)
{
	image_index=image_index_player;	
	if(image_index_player<4)image_index_player+=0.1;
	else image_index_player=0;
}
```

*其中，image_index_player在创建事件中初始化为0*

**Sunskyman**告诉我加image_speed也可以正常行走

```GML
if(dx!=0||dy!=0)
{
	image_speed=0.1;
}
```



## 炸弹爆炸却炸不碎墙

原因我用来判断爆炸检测用的语句是`if(tmp==obj_wall_brik)`
其中**tmp**是`tmp=collision_point(x+16,y,obj_wall_father,0,0);`，
这个函数返回的是碰撞到的obj_wall_father的实例ID,很显然对象ID怎么能等于一个类呢，因此要改成红激写的`if(tmp.sprite_index==spr_wall_brik)`

## 加入行走音效

我开始加入行走音效是直接加在按键判断里面，但是发现会播放很多个声音，导致声音很大而且杂乱无章，后来我想尝试先判断这个声音是否在播放，如果不再播放就再播放一个相同的声音，但我发现还是很难听。最终我在控制动画代码区块中，精灵动画每过两张图片就播放一次，这样好听多了，而且和画面同步，因为行走精灵图片一共4张，每两张就会踏下一步来，正好。

```GML
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
```

**一定要是3.9**，不能是4，如果是4，那么4和0都会播放一次,连续播放两下，就有点难听了。


