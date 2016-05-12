--Mixing theme versions can cause problems, so if you do the game just crashes.
local badFiles = {"/Scripts/06 MyGrooveRadarHelpers.lua",
"/Scripts/05 ProfileData.lua"}

for _, path in pairs(badFiles) do
    if FILEMAN:DoesFileExist(THEME:GetCurrentThemeDirectory()..path) then
        UndocumentedFeature("You aren't using a clean copy of DDR SuperNOVA 3!")
    end
end