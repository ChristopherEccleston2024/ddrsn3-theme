-- single
return Def.ActorFrame{
	LoadActor("_item")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+84;y,SCREEN_CENTER_Y+52;draworder,99);
		OnCommand=cmd(addx,379;sleep,0.264;decelerate,0.264;addx,-390;decelerate,0.1;addx,11);
		EnabledCommand=cmd(diffuse,color("1,1,1,1"));
		DisabledCommand=cmd(diffuse,color("0.5,0.5,0.5,1"));
		OffCommand=cmd(decelerate,0.05;addx,-11;decelerate,0.264;addx,390);
	};
	LoadActor("../_Style highlight")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+84;y,SCREEN_CENTER_Y+52;draworder,99);
		OnCommand=cmd(diffusealpha,0;sleep,0.264;sleep,0.528;diffusealpha,1);
		GainFocusCommand=cmd(visible,true;glowshift;blend,Blend.Add;;effectcolor1,color("0,0,2,0");effectcolor2,color("#ffff00");effectperiod,0.528);
		LoseFocusCommand=cmd(visible,false);
		OffCommand=cmd(visible,false);
	};
};