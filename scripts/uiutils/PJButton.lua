--
-- Author: 张伟超
-- Date: 2014-08-07 09:53:25
--

local PJButton = class("PJButton",function()
        return display.newNode()
    end)

--使用简例：
--[[

    --传入sprite 或者 传入图片路径均可；
    
    local nor = display.newSprite(PUBLIC_RES.."btn_red_n.png")
    local sel = display.newSprite(PUBLIC_RES.."btn_gold_n.png")
    local dis = display.newSprite(PUBLIC_RES.."btn_gray_star.png")

    local PJButton = require("uiutils/PJButton")
    local button = PJButton.new({
        normal = nor,
        selected = sel,
        disabled = dis,
        text = "确认",
        border = 2,
        callback = function() print(" == callback == ") end
        })
    :pos(display.cx,display.cy + 500)
    :addTo(self,999)

]]

function PJButton:ctor(params)
    --单张图片的sprite
    --多张图片的sprite
    self.params = params
    self.isSelected = false
    self.isDisabled = false 
    self.label = nil 
    self.isAction = true      --是否启用缩放动作；

    self.normal = self.params.normal
    self.selected = self.params.selected or nil 
    self.disabled = self.params.disabled or nil 
    local border =  self.params.border or nil

    if self.normal and type(self.normal) == "string" then
        self.normal = display.newSprite(self.normal)
    end
    if self.selected and type(self.selected) == "string" then
        self.selected = display.newSprite(self.selected)
    end
    if self.disabled and type(self.disabled) == "string" then
       self.disabled = display.newSprite(self.disabled)
    end

    if self.params.text then
        local params = {}

        --是否有描边，描边大小
        if self.params.border then
            params.outlineWidth = self.params.border
        end
        --描边颜色
        if self.params.borderColor then
            params.outlineColor = self.params.borderColor
        end
        --大小
        if self.params.size then
            params.size = self.params.size
        else
            params.size = 25
        end
        --指定颜色
        if self.params.color then
            params.color = self.params.color
        end
        --位置
        local xx = 0
        local yy = 0
        if self.params.fontPos then
            xx = self.params.fontPos.x
            yy = self.params.fontPos.y
        end
        --内容
        params.text = self.params.text
        --默认字体
        params.font = GAME_FONT
        params.align = ui.TEXT_ALIGN_CENTER
        if self.params.border then
            self.label = ui.newTTFLabelWithOutline(params)
        else
            self.label = ui.newTTFLabel(params)
        end
        self.label:pos(xx,yy)
        self.label:addTo(self,999)
    end
    self:addChild(self.normal)
    if self.selected then
        self:addChild(self.selected)
        self.selected:setVisible(false)
    end
    if self.disabled then
        self:addChild(self.disabled)
        self.disabled:setVisible(false)
    end
    self:setTouchEnabled(true)
    self:onTouch()
end

--调节文字位置：
function PJButton:reset(x,y)
    if self.label then
        self.label:setPosition(x,y)
    end
end

--重置文字
function PJButton:setString(string)
    if self.label then
        self.label:setString(string)
    end
end  

function PJButton:setFontPosAddition(x,y)
    if self.label then
        self.label:setPosition(x,y)
    end
end 

function PJButton:onTouch()
    self:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            if self.selected then
                self:setSelected(true)
            end
            if self.isAction then
                self:runAction(CCScaleTo:create(0.1, 1.2))
            end
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            self:setNormal()
            if self.isAction then
                self:runAction(CCScaleTo:create(0.1, 1.0))
            end 
            if self:getCascadeBoundingBox():containsPoint(CCPointMake(event.x, event.y)) then
                self.params.callback()
            end
            
        end
    end)
end

function PJButton:setSelected(isSelect)
    self.isSelected = isSelect
    if self.selected then
        self.normal:setVisible(not isSelect)
        self.selected:setVisible(isSelect)
        if self.disabled then
            self.disabled:setVisible(false)
        end 
    else
        self.normal:setVisible(true)
        if isSelect then
            self.normal:setColor(ccc3(255, 255, 255))
        else
            self.normal:setColor(ccc3(200, 200, 200))
        end
        
    end
end


function PJButton:setDisabled(isdisbale)
    self.isDisabled = isdisbale
    self:setTouchEnabled(not isdisbale)
    if self.disabled then
        self.disabled:setVisible(isdisbale)
        self.normal:setVisible(not isdisbale)
        if self.selected then
            self.selected:setVisible(false)
        end
    else
        if isdisbale then
            self.normal:setColor(ccc3(200, 200, 200))
        else
            self.normal:setColor(ccc3(255, 255, 255))
        end
        
    end
end

function PJButton:setNormal()
    self.normal:setVisible(true)
    self.normal:setColor(ccc3(255, 255, 255))
    self.isSelected = false
    self.isDisabled = false 
    if self.isdisbale then
        self.isdisbale:setVisible(false)
    end
    if self.selected then
        self.selected:setVisible(false)
    end
end


return PJButton