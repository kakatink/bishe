--
-- Author: xuewenjie
-- Date: 2015-03-24 15:50:41
--
MainLayerManager = {}

local k_Tag=1000

local topReplaceList={"scenes.newHome.top.PJEnergyStoreLayer",
	"scenes.newHome.top.PJGoldStoreLayer",
	"scenes.newHome.top.PJJewelStoreLayer",
	"scenes.newHome.top.PJOreStoreLayer",
	"scenes.newHome.playersetting.PJPlayersettingLayer"}

function MainLayerManager:new() --private method.
    local store = nil

    return function(self)
        if store then return store end
        local o = {}
        setmetatable(o, self)
        self.__index = self
        store = o
        return o
    end
end

function MainLayerManager:setDialogLayer(dialogLayer)
	self.dialogLayer=dialogLayer
	self.dialogList={}
	self.dialogCacheList={}
end

--params.layer
--params.data
--params.top
--params.bg
function MainLayerManager:pushDialog(params)
	
		if params.top then
			local count=#self.dialogCacheList
			for i=1,count do
				table.remove(self.dialogCacheList,1)
			end
		end

		local existIndex=self:getLayerListIsExistIndex()
		if existIndex~=-1 then
			table.remove(self.dialogCacheList,existIndex)
		end

		table.insert(self.dialogCacheList,{layer=params.layer,data=params.data})

		if #self.dialogList~=0 then
			self.dialogList[#self.dialogList]:closeAnimation(function ()
				self:closeDialog()
				local dialog=require(params.layer).new(params.data):addTo(self.dialogLayer)

				local homeBgLayer=require("utils.HomeBgLayer").new(params.bg):addTo(dialog,-1)

			    dialog:openAnimation()
				dialog:zorder(self.dialogLayer:getChildrenCount()+1)
				table.insert(self.dialogList, dialog)
				end)
		else
			local dialog=require(params.layer).new(params.data):addTo(self.dialogLayer)

			local homeBgLayer=require("utils.HomeBgLayer").new(params.bg):addTo(dialog,-1)

		    dialog:openAnimation()
			dialog:zorder(self.dialogLayer:getChildrenCount()+1)
			table.insert(self.dialogList, dialog)
		end
end

function MainLayerManager:popDialog()
	if #self.dialogCacheList>1 then
		table.remove(self.dialogCacheList,#self.dialogCacheList)
		self.dialogList[#self.dialogList]:closeAnimation(function ()
			self:closeDialog()
			local dialog=require(self.dialogCacheList[#self.dialogCacheList].layer).new(self.dialogCacheList[#self.dialogCacheList].data):addTo(self.dialogLayer)
			local homeBgLayer=require("utils.HomeBgLayer").new(self.dialogCacheList[#self.dialogCacheList].bg):addTo(dialog,-1)
		    dialog:openAnimation()
			dialog:zorder(self.dialogLayer:getChildrenCount()+1)
			table.insert(self.dialogList, dialog)
			end)
	end
end

function MainLayerManager:onTouchToClose(node)
    node:setTouchEnabled(true)
    node:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            MainLayerManager:instance():closeDialog()
        end
    end)
end

function MainLayerManager:closeDialog()
	self.dialogList[#self.dialogList]:removeFromParent()

	table.remove(self.dialogList,#self.dialogList)

	print("closeDialog")
end

function MainLayerManager:getLayerListIsExistIndex()
	for i=1,#self.dialogCacheList do
		for j=1,#topReplaceList do
			if self.dialogCacheList[i].layer==topReplaceList[j] then
				return i
			end
		end
	end
	return -1
end


MainLayerManager.instance = MainLayerManager:new() --implement single instance object.