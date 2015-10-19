local playMode = GAMESTATE:GetPlayMode()
if playMode ~= 'PlayMode_Regular' and playMode ~= 'PlayMode_Rave' and playMode ~= 'PlayMode_Battle' then
	curStage = playMode;
end;
local sStage = GAMESTATE:GetCurrentStage();
local tRemap = {
	Stage_1st		= 1,
	Stage_2nd		= 2,
	Stage_3rd		= 3,
	Stage_4th		= 4,
	Stage_5th		= 5,
	Stage_6th		= 6,
};

if tRemap[sStage] == PREFSMAN:GetPreference("SongsPerPlay") then
	sStage = "Stage_Final";
else
	sStage = sStage;
end;

local t = Def.ActorFrame {};
t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y);
		self:sleep(3.01);
	end;
	
	---- DOOR OPEN > CLOSE  CLOSE > OPEN
	Def.ActorFrame{
		LoadActor("../Door1")..{
		InitCommand=cmd(x,SCREEN_CENTER_X-SCREEN_WIDTH;zoom,1.01);
			OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X-135);
		};
	};
	Def.ActorFrame{
		LoadActor("../Door2")..{
		InitCommand=cmd(x,SCREEN_CENTER_X+SCREEN_WIDTH;zoom,1.01);
			OnCommand=cmd(linear,0.198;x,SCREEN_CENTER_X+134);
		};
	};
	LoadActor(("../eval_in"))..{
		StartTransitioningCommand=cmd(play);
	};
	--- Flash SONG BANNER  sound------
	LoadActor("SoundStage") .. {
	};
};

t[#t+1] = Def.ActorFrame {
	InitCommand=function(self)
		self:y(SCREEN_CENTER_Y-124);
	end;
	LoadActor("../ScreenStageInformation out/banner_stage")..{
		InitCommand=cmd(CenterX);
		OnCommand=cmd(zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1);
	};
};

if not GAMESTATE:IsCourseMode() then
--song jacket--
t[#t+1] = Def.ActorFrame {
	OnCommand=cmd(playcommand,'Set';CenterX;y,SCREEN_CENTER_Y-130;zoomy,0;sleep,0.099;sleep,0.396;linear,0.099;zoomy,1);
	Def.Sprite {
		SetCommand=function(self)
		local song = GAMESTATE:GetCurrentSong();
			if song:HasBanner() then
				self:LoadFromSongBanner(GAMESTATE:GetCurrentSong());
				self:setsize(256,80);
			else
				self:Load(THEME:GetPathG("","Common fallback banner"));
				self:setsize(256,80);
			end;
		end;
	};
};
else
t[#t+1] = LoadActor("CourseDisplay");
end;

t[#t+1] = Def.Sprite {
	Texture="../ScreenStageInformation out/rayo 1x2.png",
		InitCommand=function(self)
			self:Center()
			self:SetAllStateDelays(0.082)
		end
};

t[#t+1] = LoadActor("StageDisplay");

t[#t+1] = LoadActor("../ScreenStageInformation out/bottom_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_BOTTOM-27);
	OnCommand=cmd(addy,54;sleep,0.396;linear,0.198;addy,-54);
};

t[#t+1] = LoadActor("../ScreenStageInformation out/top_stage")..{
	InitCommand=cmd(CenterX;y,SCREEN_TOP+52);
	OnCommand=cmd(addy,-104;sleep,0.396;linear,0.198;addy,104);
};

return t