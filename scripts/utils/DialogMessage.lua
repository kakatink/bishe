--
-- Author: xuewenjie
-- Date: 2015-03-31 13:29:50
--

local leadRes = "newHomeRes/lead/"
local DialogMessage = class("DialogMessage", function(message)
	return display.newLayer()
end)

function DialogMessage:ctor(message)
	local bg=display.newScale9Sprite(leadRes.."equipmentdialg.png", 0,0,CCSize(500, 450)):addTo(self)
	bg:setTouchEnabled(true)

	PJLabelHelper:createTextStyle4({text=message,
		posX=55,posY=200,dimensions=CCSize(395, 180),size=22}):addTo(bg)
end

return DialogMessage