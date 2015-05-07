
local HomeMainLayer = class("HomeMainLayer",function(params)
        return display.newLayer()
end)

function HomeMainLayer:ctor(params)
	aaa = PJLabelHelper:createTextStyle3({
		text = "主界面",
		posX = 0,
		posY = display.cy - 200,
		color = ccc3(0, 0, 0)
		}):addTo(self)

end

function HomeMainLayer:openAnimation()
	print("open HomeMainLayer")
end


function HomeMainLayer:closeAnimation(callback)
    callback()
end

return HomeMainLayer