--
-- Author: xuewenjie
-- Date: 2015-03-30 15:50:29
--

local commonRes = "newHomeRes/common/"
local clipnode={}
local width

local PJProgressBar = class("PJProgressBar", function(params)
    return display.newLayer()
end)
 
--params.bg
--params.bgWidth
--params.bgHeight
--params.fill
--params.height
--params.width
function PJProgressBar:ctor(params)
 	self.width=params.width
 	local bgRes=params.bg or commonRes.."jingyantiaodikuang.png"
 	local bgWidth=params.bgWidth or self.width
 	local bgHeight=params.bgHeight or (params.height or 36)

 	local fillRes=params.fill or commonRes.."jingyantiao.png"
 	local fillWidth=self.width
 	local fillHeight=params.height or 36

    local progress = display.newScale9Sprite(bgRes,0,0,CCSize(bgWidth,bgHeight))
    local fill = display.newScale9Sprite(fillRes,-(fillWidth-bgWidth)/2,-(fillHeight-bgHeight)/2,CCSize(fillWidth, fillHeight))
    self.y=-(fillWidth-bgWidth)/2

    -- fill:setPosition(fillWidth-bgWidth, 0)
    fill:setAnchorPoint(0,0)
    self.clipnode = display.newClippingRegionNode(CCRect(self.y,0,self.width,36))
    self.clipnode:addChild(fill)
    progress:addChild(self.clipnode)
    progress:addTo(self)
end
 
function PJProgressBar:setProgress(progress)
	self.clipnode:setClippingRegion(CCRect(self.y,0,self.width*progress/100,36))
end
 
return PJProgressBar