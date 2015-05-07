local PJTabList = import("uiutils.PJTabList")
local HomeBottomLayer = class("HomeBottomLayer",function(params)
        return display.newLayer()
end)

HomeBottomLayer.tabInstance={}

function HomeBottomLayer:ctor(params)
    self.params = params or {}

    self.tabListInfo={}
    self.tabListInfo.tabs = {
        {normalbg="anniu.png",selectedbg="anniudi.png",text="所有",layer="scenes.home.HomeMainLayer"},
        {normalbg="anniu.png",selectedbg="anniudi.png",text="出租",layer="scenes.home.LeaseLayer"},
        {normalbg="anniu.png",selectedbg="anniudi.png",text="金额",layer="scenes.home.PriceLayer"},

    }
    self.tabListInfo.width=240
    self.buttonList = {}
    for i=1,#self.tabListInfo.tabs do
        local button = self:createTab(self.tabListInfo.tabs[i])
        table.insert(self.buttonList, button)
        self.buttonList[i].normal:addTo(self):setPosition((i-1)*display.width/3, 0)
        self.buttonList[i].selected:addTo(self):setPosition((i-1)*display.width/3, 0)
    end
    self.buttonList[1].selected:setVisible(true)
    self.buttonList[1].normal:setTouchEnabled(false)
 --    self.tabListInfo.bg="biaoti.png"
 --    self.tabListInfo.mainLayer=self.params.mainLayer

    -- HomeBottomLayer.tabInstance=PJTabList.new(self.tabListInfo):addTo(self)
end

function HomeBottomLayer:createTab(prams)
    local button = {}
    --button.normal = display.newScale9Sprite(prams.normalbg,CCSize(display.width/3,80))
    button.normal = display.newSprite(prams.normalbg)
    button.normal:setAnchorPoint(0,0)
    --button.selected = display.newScale9Sprite(prams.selected,CCSize(display.width/3,80))
    button.selected = display.newSprite(prams.selectedbg)
    button.selected:setAnchorPoint(0,0)
    button.selected:setVisible(false)
    button.normal:setTouchEnabled(true)
    button.normal:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            for k,v in pairs(self.buttonList) do
                v.selected:setVisible(false)
                v.normal:setTouchEnabled(true)
            end
            button.selected:setVisible(true)
            print(prams.text)
            return true 
        elseif event.name == "moved" then
        
        elseif event.name == "ended" then
            MainLayerManager:instance():pushDialog({layer=prams.layer,data={},top = true})
            button.normal:setTouchEnabled(false)
        end
    end)
    return button
end

return HomeBottomLayer