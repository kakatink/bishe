
local HomeBgLayer = class("HomeBgLayer", function(params)
	return display.newColorLayer(ccc4(0, 0, 0, 100))
end)

function HomeBgLayer:ctor(bg)
	local bg=display.newScale9Sprite(bg or "di.png", 0,0,CCSize(720,1280)):addTo(self)
	--local bg=display.newSprite(bg or "shouye.jpg", 0,0):addTo(self)
end

return HomeBgLayer