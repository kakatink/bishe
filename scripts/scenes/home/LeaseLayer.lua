
local LeaseLayer = class("LeaseLayer",function(params)
        return display.newLayer()
end)

function LeaseLayer:ctor(params)
		ui.newTTFLabel({
		text = "租借",
		x =0,
		y = display.cy-200,
		color = cc.c3b(0, 0, 0)
		}):addTo(self)
		print("创建2")
end

function LeaseLayer:openAnimation()
	print("open LeaseLayer")
end


function LeaseLayer:closeAnimation(callback)
    callback()
end

return LeaseLayer