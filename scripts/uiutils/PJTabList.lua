
local PJTabList = class("PJTabList",function(params)
        return display.newNode()
end)


--params.tabs[i].normalbg
--params.tabs[i].selectedbg
--params.tabs[i].image
--params.tabs[i].text
--params.tabs[i].layer
--params.tabs[i].tag
--params.width
--params.mainLayer
function PJTabList:ctor(params)
	self.params=params

	self.tabs={}
    display.newSprite(self.params.bg, 360, 67):addTo(self)
    for i=1,#self.params.tabs do
    	local fileData = self.params.tabs[i]
    	local tabs={}
        tabs.normal = display.newSprite(fileData.normalbg, (i-1)*self.params.width+12, 0):addTo(self)
        tabs.normal:setAnchorPoint(0.5,0.5)
        local image=display.newSprite(fileData.image, 0, 0):addTo(tabs.normal)
        image:setAnchorPoint(0.5,0.5)
        image:setScale(0.8)
        image:setPosition(52, 78)
        PJLabelHelper:createTextStyle1({text=fileData.text,posX=60,posY=18,spaceWidth=10,size=30}):addTo(tabs.normal)

        tabs.normal:setAnchorPoint(ccp(0,0))
        tabs.selected = display.newSprite(fileData.selectedbg, (i-1)*self.params.width+12, 0):addTo(self)
        tabs.selected:setAnchorPoint(ccp(0,0))
        tabs.layer=fileData.layer
        self:onTouch(tabs.normal,i)
        table.insert(self.tabs, tabs)
    end

    self.tabs[1].normal:setVisible(true)
    self.tabs[1].selected:setVisible(false)
end


function PJTabList:onTouch(node,tag)
    node:setTouchEnabled(true)
    node:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            
                for i=1,#self.tabs do
                    self.tabs[i].normal:setVisible(true)
                    self.tabs[i].selected:setVisible(true)
                end
                self.tabs[tag].normal:setVisible(true)
                self.tabs[tag].selected:setVisible(false)

                MainLayerManager:instance():pushDialog({layer=self.tabs[tag].layer,data={text="main layer "..tag},top=true})
        
        end
    end)
end

function PJTabList:selectTab(tag)
    for i=1,#self.tabs do
        self.tabs[i].normal:setVisible(true)
        self.tabs[i].selected:setVisible(true)
    end
    self.tabs[tag].normal:setVisible(true)
    self.tabs[tag].selected:setVisible(false)

    MainLayerManager:instance():pushDialog({layer=self.tabs[tag].layer,data={text="main layer "..tag},top=true})
end

function PJTabList:testPrint()
    print("testPrint")
end

return PJTabList