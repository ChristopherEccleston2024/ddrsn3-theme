local player = ({...})[1]
local dimensions = {x=220,y=80}
local short_player = ToEnumShortString(player)
local sideFlipMultiplier = short_player=='P1' and -1 or 1
local horizAlign, beginningX, endX
do
	local baseBeginningX = (dimensions.x/2)-8 
	local horizAligns = {P1=0,P2=1}
	horizAlign = horizAligns[short_player]
	beginningX = baseBeginningX * (sideFlipMultiplier)
	endX = -beginningX
end

local maxTextWidth = dimensions.x-46 --radar size and then some padding

local t =  Def.ActorFrame{
	--become invisible at first in case our player isn't joined right now
	InitCommand=function(s) s:visible(false) end;
	Def.Quad{InitCommand=function(s) s:setsize(dimensions.x,dimensions.y):diffuse{0,0,0,0.95} end};
	Def.BitmapText{
		Font="_futura std medium 20px",
		InitCommand=function(s) s:y(-10):x(beginningX):halign(horizAlign):maxwidth(maxTextWidth) end,
		HandleAppearCommand=function(s, params)
			local description = params.Steps:GetDescription()
			if params.Steps:GetAuthorCredit() == description then
				--center yourself, this is the only one that shows
				s:y(-2)
			else
				s:y(-10)
			end
			s:settext(description) 
		end
	};
	Def.BitmapText{
		Font="_futura std medium 20px",
		InitCommand=function(s) s:y(6):zoom(0.6):x(beginningX):halign(horizAlign):maxwidth(maxTextWidth):max_dimension_use_zoom(true) end,
		HandleAppearCommand=function(s, params)
			local author = params.Steps:GetAuthorCredit() 
			if author == params.Steps:GetDescription() then
				--idk what to do about this situation. this is what happens to SM files.
				s:settext("")
			elseif author ~= ""  then
				s:settext("by "..author)
			else
				s:settext("by ???")
			end
		end
	};
}
local stepsCommandName = "CurrentSteps"..short_player.."ChangedMessageCommand"
t[stepsCommandName] = function(s)
	local steps = GAMESTATE:GetCurrentSteps(player)
	if GAMESTATE:GetCurrentSong() and steps and steps:GetDifficulty() == 'Difficulty_Edit' then
		s:playcommand("HandleAppear",{Steps=steps}):visible(true)
	else
		s:visible(false)
	end
end
--if we get kicked out of a group due to player join, fire this so the window hides
t.CurrentSongChangedMessageCommand = function(s) s:playcommand(stepsCommandName) end

return t