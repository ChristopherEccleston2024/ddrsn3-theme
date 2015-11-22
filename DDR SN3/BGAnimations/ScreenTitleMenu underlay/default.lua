local counter = 0;
local t = Def.ActorFrame{
};
if GAMESTATE:GetCoinMode() == 'CoinMode_Home' then
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:zoom(1);
	end;
	LoadActor(THEME:GetPathB("ScreenWithMenuElements","background/honeyright.png"))..{
		InitCommand=cmd(halign,1;x,SCREEN_RIGHT;CenterY;blend,Blend.Add;;diffusealpha,0.5);
	};
	LoadActor(THEME:GetPathB("ScreenLogo","background/ddrsn_logo.png"))..{
		InitCommand=cmd(x,SCREEN_CENTER_X-1;y,SCREEN_CENTER_Y-8;zoom,0.9;);
	};
	Def.Quad{
		InitCommand=cmd(FullScreen;diffuse,color("0,0,0,0.6"));
	};
	LoadActor("image")..{
		InitCommand=cmd(x,SCREEN_LEFT+182;y,SCREEN_CENTER_Y-50);
		OnCommand=cmd(addx,-274;accelerate,0.4;addx,274);
		TitleSelectionMessageCommand=function(self, params)
			local path = "/Themes/"..THEME:GetCurThemeName().."/Graphics/_ScreenTitleMenu image "..string.lower(params.Choice)..".png"
			if FILEMAN:DoesFileExist(path) then
				self:Load(path)
			end
		end;
		OffCommand=cmd(accelerate,0.4;addx,-SCREEN_WIDTH);
	};
	LoadActor("left_panel")..{
		InitCommand=cmd(x,SCREEN_LEFT+47;y,SCREEN_CENTER_Y);
		OnCommand=cmd(addx,-94;decelerate,0.2;addx,94);
		OffCommand=cmd(accelerate,0.2;addx,-94);
	};
	LoadActor("home_dialog")..{
		InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-80);
		OnCommand=cmd(zoomy,0;sleep,0.1;accelerate,0.3;zoomy,1);
	};
	Def.BitmapText{
		Font="_russell_square";
		Text="";
		InitCommand=function(self) self:hibernate(0.4):Center(X):y(SCREEN_BOTTOM-100):zoom(0.9):maxwidth(513):wrapwidthpixels(513):valign(0):vertspacing(8) end;
		TitleSelectionMessageCommand=function(self, params) self:settext(THEME:GetString("ScreenTitleMenu","Description"..params.Choice)) end;
		OnCommand=cmd(cropbottom,1;sleep,0.1;accelerate,0.3;cropbottom,0);
	};
};
elseif GAMESTATE:GetCoinMode() == 'CoinMode_Pay' or 'CoinMode_Freeplay' then
t[#t+1] = Def.ActorFrame {
	LoadActor(THEME:GetPathB("","ScreenLogo background/serial"))..{
		InitCommand=cmd(halign,0;x,SCREEN_LEFT;y,SCREEN_TOP+20);
	};
	LoadActor(THEME:GetPathB("","ScreenLogo background/JOINT PREMIUM"))..{
		InitCommand=cmd(x,SCREEN_RIGHT-48;y,SCREEN_CENTER_Y-180);
	};
}
end

return t