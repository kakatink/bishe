--
-- Author: xuewenjie
-- Date: 2015-04-02 11:21:21
--
local leadRes = "newHomeRes/lead/"
local equipmentRes = "newHomeRes/equipment/"
local commonRes = "newHomeRes/common/"

local DialogMessageYesOrNo = class("DialogMessageYesOrNo", function(params)
	return display.newLayer()
end)

--params.title
--params.message
--params.yesText
--params.noText
--params.yesCallback
--params.noCallback
function DialogMessageYesOrNo:ctor(params)
	self.yesCallback=params.yesCallback
	self.noCallback=params.noCallback
	local bg=display.newSprite(equipmentRes.."dialogBg.png",0,0):addTo(self)
	bg:setTouchEnabled(true)

	PJLabelHelper:createTextStyle5({text="",posX=300,posY=310,size=36,align=ui.TEXT_ALIGN_CENTER,dimensions=CCSize(600, 40)}):addTo(bg):setString(params.title)

	if params.iconRes then
		local icon=display.newSprite(params.iconRes,params.iconX,params.iconY):addTo(bg)
	end
	
	PJLabelHelper:createTextStyle4({text="",
		posX=300,posY=150,dimensions=CCSize(500, 180),size=28}):addTo(bg):setString(params.message)

	local yesBtn=PJUIHelper:createButtonSimple({image=commonRes.."btnBg.png",posX=140,posY=80,callback=function() self:yesTodo() end}):addTo(bg)
	PJLabelHelper:createTextStyle5({text="",posX=105,posY=40,size=36,align=ui.TEXT_ALIGN_CENTER,dimensions=CCSize(200, 40)}):addTo(yesBtn):setString(params.yesText or "确 定")
	local noBtn=PJUIHelper:createButtonSimple({image=commonRes.."btnBg.png",posX=460,posY=80,callback=function() self:noTodo() end}):addTo(bg)
	PJLabelHelper:createTextStyle5({text="",posX=105,posY=40,size=36,align=ui.TEXT_ALIGN_CENTER,dimensions=CCSize(200, 40)}):addTo(noBtn):setString(params.noText or "容我想想")
	
end

function DialogMessageYesOrNo:yesTodo()
	if self.yesCallback then 
		self.yesCallback()
	else
		DialogManager:instance():closeDialog()
	end
end

function DialogMessageYesOrNo:noTodo()
	if self.noCallback then 
		self.noCallback()
	else
		DialogManager:instance():closeDialog()
	end
end

return DialogMessageYesOrNo