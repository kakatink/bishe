--
-- Author: xuewenjie
-- Date: 2015-04-02 14:21:14
--

local scheduler = require("framework.scheduler")

local leadRes = "newHomeRes/lead/"
local ShowMessage = class("ShowMessage", function(message,duration)
	return display.newLayer()
end)

function ShowMessage:ctor(message,duration)

	local displayDuration=duration or 2
	local layer = display.newColorLayer(ccc4(0, 0, 0, 200)):addTo(self)
	layer:setPosition(-300,0)
	layer:setContentSize(CCSizeMake(600,26))
	local msg=PJLabelHelper:createTextStyle4({text="",
		posX=300,posY=13,dimensions=CCSize(600, 60),size=20,color=ccc3(224, 215, 90),align=ui.TEXT_ALIGN_CENTER,valign=ui.TEXT_VALIGN_CENTER}):addTo(layer)
	msg:setString(message)
	-- print("msg.width",msg:getViewSize().width,"msg.height",msg:getContentSize().height)
	-- msg:getViewSize()
	layer:setPosition(-300, -600)
	transition.execute(layer, 
        CCMoveTo:create(0.2, CCPoint(-300, 0)), 
        { delay = 0, easing="backOut",  onComplete = function()   end,})
	transition.execute(layer, 
        CCMoveTo:create(0.2, CCPoint(-900, 0)), 
        { delay = displayDuration-0.2, easing="backIn",  onComplete = function()   end,})

	local function onInterval(dt)
		DialogManager:instance():closeMsg()
  	end
  	scheduler.performWithDelayGlobal(onInterval, displayDuration)
end


return ShowMessage