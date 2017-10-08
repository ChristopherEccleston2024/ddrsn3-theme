local group_colors = {
	["1-Licenses"]= color "#FFFFFF",
	["2-KONAMI Originals"]= color "#00CC00",
	["3-Requests"]= color "#FFFF00",
	["4-Revivials"]= color "#33CCFF",
	["5-NOVAmix"]= color "#FF00FF",
	["6a-ENCORE EXTRA STAGE"]= color "#FF9933",
	["6b-EXTRA STAGE"]= color "#FF0000",
	["7-DLC"]= color "#FF9933",
};

local group_names = {
	["1-Licenses"]= "Licenses",
	["2-KONAMI Originals"]= "KONAMI Originals",
	["3-Requests"]= "Requests",
	["4-Revivials"]= "Revivals",
	["5-NOVAmix"]= "NOVAmix",
	["6a-ENCORE EXTRA STAGE"]= "ENCORE EXTRA STAGE",
	["6b-EXTRA STAGE"]= "EXTRA STAGE",
	["7-DLC"]= "DLC",
};

local t = Def.ActorFrame {
	--Main
	Def.Quad{
		InitCommand=cmd(setsize,148,148);
		SetCommand=function(self, param)
			local group = param.Text;
			local color_grp= group_colors[group] or SongAttributes.GetGroupColor(group);
			self:diffuse(color_grp);
		end;
	};
	--Shade
	Def.Quad{
		InitCommand=cmd(setsize,148,148;fadetop,0.8;diffuse,color("0,0,0,0.75"));
	};
	--Black BG
	Def.Quad{
		InitCommand=cmd(setsize,128,128;diffuse,color("0,0,0,1"));
	};
	Def.Banner{
		Name="Banner";
		InitCommand=cmd(scaletoclipped,128,128);
		SetCommand=function(self,param)
			local group= param.Text;
			if group then
				self:LoadFromSongGroup(group)
			else
				self:Load(THEME:GetPathG("","Common fallback Jacket"));
			end;
		end;
	};
	Def.BitmapText{
		Font="_handelgothic bt 20px";
		InitCommand=cmd(maxwidth,128;zoom,0.8;y,64;valign,1;strokecolor,color("0,0,0,1"));
		SetMessageCommand=function(self, param)
		local group = param.Text;
		local groupname = group_names[group];
			self:settext(groupname or SongAttributes.GetGroupName(group));
		local color_grp= group_colors[group] or SongAttributes.GetGroupColor(group);
			self:diffuse(color_grp);
		end;
	};
};
return t;
