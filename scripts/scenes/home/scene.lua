
ZORDER_TOPLAYER = 3
ZORDER_MAINLAYER = 1
ZORDER_BOTTOMLAYER = 2
ZORDER_DIALOGLAYER = 4

MAIN_LAYER_POS_X=display.width/2
MAIN_LAYER_POS_Y=display.height/2

local HomeTopLayer = import(".HomeTopLayer")
local HomeMainLayer = import(".HomeMainLayer")
local HomeBottomLayer = import(".HomeBottomLayer")

local HomeScene = class("HomeScene", function(params)
    return display.newScene("HomeScene")
end)

function HomeScene:ctor(params)
    self.params = params or {}
end

function HomeScene:onEnter()
	self.topLayer=HomeTopLayer.new()
	self.topLayer:addTo(self,ZORDER_TOPLAYER,0)
	self.topLayer:setPosition(0, display.height)

	self.mainLayer=display.newLayer()
	self.mainLayer:addTo(self,ZORDER_MAINLAYER,0)
	self.mainLayer:setPosition(display.width/2, display.height/2)
	MainLayerManager:instance():setDialogLayer(self.mainLayer)
	MainLayerManager:instance():pushDialog({layer="scenes.home.HomeMainLayer",data={text="main layer 1"}})

	self.bottomLayer=HomeBottomLayer.new({mainLayer=self.mainLayer})
	self.bottomLayer:addTo(self,ZORDER_BOTTOMLAYER,0)

	self.dialogLayer=display.newLayer()
	self.dialogLayer:addTo(self,ZORDER_DIALOGLAYER,0)
	self.dialogLayer:setPosition(display.width/2, display.height/2)
	DialogManager:instance():setDialogLayer(self.dialogLayer)
end

return HomeScene