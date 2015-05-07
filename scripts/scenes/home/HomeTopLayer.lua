
local HomeTopLayer = class("HomeTopLayer",function(params)
        return display.newLayer()
end)

function HomeTopLayer:ctor(params)
	self.title = display.newSprite("biaoti.png", 0, 0):addTo(self)
	self.title:setAnchorPoint(0,1)
end

return HomeTopLayer