local text = ScreenString("HeaderText")
local row = ...

local af = Def.ActorFrame{
	Def.Quad{
		Name="SongWheelTopBorder",
		InitCommand=cmd(diffuse, color("#999999"); zoomto,_screen.w, 32; valign, 0),
		OnCommand=function(self) self:xy( _screen.cx, 0 ) end,
		SwitchFocusToSongsMessageCommand=cmd(zoomtoheight, 0),
		SwitchFocusToGroupsMessageCommand=cmd(sleep,0.2; zoomtoheight, 32),
	},

	-- "Choose Your Song"
	Def.BitmapText{
		Name="HeaderText",
		Font="_wendy small",
		Text=text,
		InitCommand=cmd(diffusealpha,0; zoom,WideScale(0.5,0.6); horizalign, left; xy, 10, 15 ),
		OnCommand=cmd(sleep, 0.1; decelerate,0.33; diffusealpha,1),
		OffCommand=cmd(accelerate,0.33; diffusealpha,0),
		SwitchFocusToSongsMessageCommand=function(self) self:settext(""):diffusealpha(0) end,
		SwitchFocusToGroupsMessageCommand=function(self) self:settext(text):sleep(0.2):linear(0.2):diffusealpha(1) end,
	},
}

-- Stage Number
if not PREFSMAN:GetPreference("EventMode") then
	Def.BitmapText{
		Font=PREFSMAN:GetPreference("EventMode") and "_wendy monospace numbers" or "_wendy small",
		Name="Stage Number",
		InitCommand=function(self)
			self:diffusealpha(0):zoom( WideScale(0.5,0.6) ):xy(_screen.cx, 15)
		end,
		OnCommand=function(self)
			self:settext( SSM_Header_StageText() )
				:sleep(0.1):decelerate(0.33):diffusealpha(1)
		end,
	}
end

return af