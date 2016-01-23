-- BeforeLoadingNextCourseSongMessageCommand
-- StartCommand
-- ChangeCourseSongInMessageCommand
-- ChangeCourseSongOutMessageCommand
-- FinishCommand
-- in stars

	-- song banner
	Def.Banner{
		Name="SongBanner";
		InitCommand=cmd(Center;scaletoclipped,568,176;diffusealpha,0);
		StartCommand=function(self)
			local course = GAMESTATE:GetCurrentCourse()
			local entry = course:GetCourseEntry(GAMESTATE:GetLoadingCourseSongIndex())
			self:LoadFromSong(entry:GetSong())

			self:linear(0.5)
			self:diffusealpha(1)
		end;
		ChangeCourseSongOutMessageCommand=cmd(sleep,1;linear,0.5;diffusealpha,0);
	};
};