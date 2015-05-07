
local PriceLayer = class("PriceLayer",function(params)
        return display.newLayer()
end)

function PriceLayer:ctor(params)
	ui.newTTFLabel({
		text = "价格",
		x = 0,
		y = display.cy-200,
		color = cc.c3b(0, 0, 0)
		}):addTo(self)
	print("创建3")
end

function PriceLayer:openAnimation()
	print("open PriceLayer")
end


function PriceLayer:closeAnimation(callback)
    callback()
end

return PriceLayer