--
-- Author: xuewenjie
-- Date: 2015-03-23 13:42:00
--
DialogManager = {}

local k_Tag=1000


function DialogManager:new() --private method.
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


function DialogManager:setDialogLayer(dialogLayer)
	self.dialogLayer=dialogLayer
	self.dialogList={}
    self.messageList={}
end


--params.layer
--params.data
--params.notMaskClose
function DialogManager:showDialog(params)
	local dialog=require(params.layer).new(params.data):addTo(self.dialogLayer)
	dialog:zorder(self.dialogLayer:getChildrenCount()+1)

    local maskLayer=require("utils.MaskLayer").new()
    maskLayer:addTo(dialog,-1)
    maskLayer:setPosition(-display.width/2,-display.height/2)
    DialogManager:onTouchToClose(maskLayer,params.notMaskClose)
	table.insert(self.dialogList, dialog)
end

--params.message
--params.notMaskClose
function DialogManager:showMessage(params)
    local dialog=require("utils.DialogMessage").new(params.message):addTo(self.dialogLayer)
    dialog:zorder(self.dialogLayer:getChildrenCount()+1)

    local maskLayer=require("utils.MaskLayer").new()
    maskLayer:addTo(dialog,-1)
    maskLayer:setPosition(-display.width/2,-display.height/2)
    DialogManager:onTouchToClose(maskLayer,params.notMaskClose)
    table.insert(self.dialogList, dialog)
end

--params.title
--params.message
--params.yesText
--params.noText
--params.yesCallback
--params.noCallback
--params.notMaskClose
function DialogManager:showMessageYesOrNo(params)
    local dialog=require("utils.DialogMessageYesOrNo").new(params):addTo(self.dialogLayer)
    dialog:zorder(self.dialogLayer:getChildrenCount()+1)

    local maskLayer=require("utils.MaskLayer").new()
    maskLayer:addTo(dialog,-1)
    maskLayer:setPosition(-display.width/2,-display.height/2)
    DialogManager:onTouchToClose(maskLayer,params.notMaskClose)
    table.insert(self.dialogList, dialog)
end


--notMaskClose
function DialogManager:onTouchToClose(node,notMaskClose)
    node:setTouchEnabled(true)
    node:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            if not notMaskClose then
                DialogManager:instance():closeDialog()
            end
        end
    end)
end



function DialogManager:closeDialog()
	self.dialogList[#self.dialogList]:removeFromParent()

	table.remove(self.dialogList,#self.dialogList)

	print("closeDialog")
end

function DialogManager:closeAllDialog()

	local count=#self.dialogList
	for i=1,count do
		self.dialogList[1]:removeFromParent()
		table.remove(self.dialogList,1)
	end

	print("closeAllDialog")
end

--message
--duration
function DialogManager:showMsg(message,duration)
    local dialog=require("utils.ShowMessage").new(message,duration):addTo(self.dialogLayer)
    dialog:zorder(99999)
    table.insert(self.messageList, dialog)
end

function DialogManager:closeMsg()
    self.messageList[1]:removeFromParent()
    table.remove(self.messageList,1)
    print("closeDialog")
end

DialogManager.instance = DialogManager:new() --implement single instance object.