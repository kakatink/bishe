--
-- Author: xuewenjie
-- Date: 2015-03-25 10:13:43
--

local scheduler = require("framework.scheduler")

PJUIHelper={}

local commonRes = "newHomeRes/common/"
local equipmentRes = "newHomeRes/equipment/"
local GAME_FONT = "font/fzyhjt.ttf"

GrayColor=ccc3(125,130,138)
IconRankFrame={
    commonRes.."whiteIconFrame.png",
    commonRes.."greenIconFrame.png",
    commonRes.."purpleIconFrame.png"
}

--params.name
--params.icon
--params.hasReturn
function PJUIHelper:createCommonTitle(params)
	local title = display.newSprite(commonRes.."crossBar.png", -80, 370)
    if params.icon then
        display.newSprite(params.icon, 50, 55):addTo(title)
        PJLabelHelper:createTextStyle1({text=params.name,posX=170,posY=42,spaceWidth=15,align=ui.TEXT_ALIGN_LEFT}):addTo(title)
    else
        PJLabelHelper:createTextStyle1({text=params.name,posX=95,posY=42,spaceWidth=15,align=ui.TEXT_ALIGN_LEFT}):addTo(title)
    end
    
    if params.hasReturn then
        PJUIHelper:createButtonSimple({image=commonRes.."btnReturn.png",posX=620,posY=44,callback=function() MainLayerManager:instance():popDialog() end}):addTo(title)
    end
    return title
end



--params.bg
--params.icon
--params.name
--params.callback
--params.posX
--params.posY
function PJUIHelper:createButtonStyle1(params)
    local btn = display.newSprite(equipmentRes..params.bg, params.posX, params.posY)
    display.newSprite(equipmentRes..params.icon, 30, 55):addTo(btn)

    PJLabelHelper:createTextStyle2({text=params.name,posX=300,posY=52,spaceWidth=15}):addTo(btn)

    btn:setTouchEnabled(true)
    btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            btn:setScale(btn:getScale()*1.1)
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            btn:setScale(btn:getScale()/1.1)
            if btn:getCascadeBoundingBox():containsPoint(CCPointMake(event.x, event.y)) then
                params.callback()
            end
        end
    end)

    return btn
end

--params.image
--params.image1
--params.posX
--params.posY
--params.callback
--params.swallowEnabled
function PJUIHelper:createButtonStyle2(params)
    print (params.posY)
    local btn = display.newNode()
    btn:setPosition(params.posX, params.posY)

    local image = display.newSprite(params.image):addTo(btn)
    local image1=display.newSprite(params.image1):addTo(btn)
    image1:setVisible(false)

    btn:setTouchEnabled(true)
    btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            btn:setScale(btn:getScale()*1.1)
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            btn:setScale(btn:getScale()/1.1)
            if btn:getCascadeBoundingBox():containsPoint(CCPointMake(event.x, event.y)) then
                if params.callback() then
                    image:setVisible(false)
                    image1:setVisible(true)
                    btn:setTouchEnabled(false)
                end
            end
        end
    end)
    return btn
end

-- --params.posX
-- --params.posY
-- function PJUIHelper:createButtonMainReturn(params)
--     local btn = display.newSprite(commonRes.."btnReturn.png", params.posX, params.posY)

--     btn:setTouchEnabled(true)
--     btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
--         if event.name == "began" then
--             return true 
--         elseif event.name == "moved" then
            
--         elseif event.name == "ended" then
--             MainLayerManager:instance():popDialog()
--         end
--     end)
--     return btn
-- end

--params.image
--params.posX
--params.posY
--params.callback
--params.swallowEnabled
function PJUIHelper:createButtonSimple(params)
    print (params.posY)
    local btn = display.newSprite(params.image, params.posX, params.posY)


    btn:setTouchEnabled(true)
    btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            btn:setScale(btn:getScale()*1.1)
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then

            btn:setScale(btn:getScale()/1.1)
            if btn:getCascadeBoundingBox():containsPoint(CCPointMake(event.x, event.y)) then
                params.callback()
            end
        end
    end)
    return btn
end

--params.image
--params.image1
--params.posX
--params.posY
--params.callback
--params.swallowEnabled
function PJUIHelper:createButtonSimple1(params)
    print (params.posY)
    local btn = display.newNode()
    btn:setPosition(params.posX, params.posY)

    local image = display.newSprite(params.image):addTo(btn)
    local image1=display.newSprite(params.image1):addTo(btn)
    image1:setVisible(false)

    btn:setTouchEnabled(true)
    btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            image:setVisible(false)
            image1:setVisible(true)
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            image:setVisible(true)
            image1:setVisible(false)
            if btn:getCascadeBoundingBox():containsPoint(CCPointMake(event.x, event.y)) then
                params.callback()
            end
        end
    end)
    return btn
end

function PJUIHelper:createButtonSimple2(params)
    print (params.posY)
    local btn = display.newNode()
    btn:setPosition(params.posX, params.posY)

    local image = display.newSprite(params.image):addTo(btn)
    local image1=display.newSprite(params.image1):addTo(btn,2)
    local visible = false
    image1:setVisible(false)

    btn:setTouchEnabled(true)
    btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            btn:setScale(btn:getScale()*1.1)
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            btn:setScale(btn:getScale()/1.1)
            if visible then
                image1:setVisible(false)
                visible = false
                params.callback()
            else
                image1:setVisible(true)
                visible = true
                params.callback1()
            end
           
            -- if btn:getCascadeBoundingBox():containsPoint(CCPointMake(event.x, event.y)) then
            --     params.callback()
            -- end
        end
    end)
    return btn
end
--params.image
--params.posX
--params.posY
--params.callback
--params.callback1
--params.swallowEnabled
--params.class
function PJUIHelper:createButtonSimpleForScroll(params)
    print (params.posY)
    local btn = display.newSprite(params.image, params.posX, params.posY,params.class)

    btn:setTouchEnabled(true)
    btn:setTouchSwallowEnabled(false)
    local posX=0
    local posY=0
    btn:addNodeEventListener(NODE_TOUCH_EVENT, function(event)
        if event.name == "began" then
            posX=event.x
            posY=event.y
            return true 
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then
            if posX<=(event.x+15) and posX>=(event.x-15) and posY<=(event.y+15) and posY>=(event.y-15) then
                params.callback()
            end
            if params.callback1 then
                params.callback1()
            end
        end
    end)
    return btn
end



--params.posX
--params.posY
--params.contentSize
--params.viewSize
--params.parent
--params.top
--params.moveCallback
--params.direction
--params.paramsLayer
--params.fixToEnd
--params.bottomHeight
function PJUIHelper:createScroll(params)
    local posY=params.posY
    if params.fixToEnd then
        local bottomHeight=params.bottomHeight or 134
        params.viewSize=CCSize(params.viewSize.width,params.viewSize.height+(posY+(display.height/2-bottomHeight)))
        posY=-(display.height/2-bottomHeight)
        -- posY=posY+posY*(display.height/1200-1)
    end


    local cScroll = CCScrollView:create(params.viewSize, display.newColorLayer(ccc4(255, 0, 0, 0)))
    cScroll:setContentSize(params.contentSize)
    -- cScroll:setActualRect(CCRect(0,0,3000,3000))
    cScroll:setClippingToBounds(true)
    cScroll:setDirection(params.direction or 1) --0 横向 1竖向
    cScroll:setBounceable(true)
    cScroll:setPosition(params.posX,posY)
    cScroll:addTo(params.parent)
    if params.top then
        cScroll:setContentOffset(ccp(0,-params.contentSize.height+params.viewSize.height))
    end
    local index=0
    cScroll:setTouchEnabled(true)
    cScroll:addNodeEventListener(cc.NODE_TOUCH_CAPTURE_EVENT, function(event)
        if event.name == "began" then
            local pos = params.parent:convertToNodeSpace(ccp(event.x, event.y))
            if cScroll:getBoundingBox():containsPoint(pos) then
                return true
            else
                return false
            end
        elseif event.name == "moved" then
            
        elseif event.name == "ended" then

        end
    end)

    
    local function scrollView2DidScroll()
        local progress=1
        if params.direction then
            progress=-cScroll:getContentOffset().x/(params.contentSize.width-params.viewSize.width)
        else
            progress=-cScroll:getContentOffset().y/(params.contentSize.height-params.viewSize.height)
        
        end
        params.moveCallback(progress)
    end  
  
    cScroll:registerScriptHandler(scrollView2DidScroll, CCScrollView.kScrollViewScroll)

    return cScroll
end


--params.bg
--params.bgWidth
--params.bgHeight
--params.bar
--params.barPosX
--params.barPosY
--params.posX
--params.posY
--params.fixToEnd
--params.bottomHeight
function PJUIHelper:createProgressBar(params)
    local posY=params.posY
    local bgWidth=params.bgWidth
    if params.fixToEnd then
        local bottomHeight=params.bottomHeight or 134
        bgWidth=bgWidth+(posY+(display.height/2-bottomHeight))
        params.barPosX=params.barPosX+(posY+(display.height/2-bottomHeight))
        posY=-(display.height/2-bottomHeight)
    end

    local scrollBar=display.newScale9Sprite(params.bg or commonRes.."scrollBarBg.png", params.posX or 0,posY or 0,
        cc.size(bgWidth or 740, params.bgHeight or 25))
    scrollBar:setAnchorPoint(0,0)
    local bar=display.newSprite(params.bar or commonRes.."scrollBar.png",params.barPosX or 680,params.barPosY or 12):addTo(scrollBar)
    scrollBar:setRotation(-90)
    bar:setScaleY(1.5)
    return scrollBar,bar
end

function PJUIHelper:scrollProgress(params)
    local width=params.width
    if params.fixToEnd then
        local bottomHeight=params.bottomHeight or 134
        width=width+(params.bgPosY+(display.height/2-bottomHeight))
    end

    if params.progress>1 then
        params.progress=1
    elseif params.progress<0 then
        params.progress=0
    end

    params.bar:setPosition(width*params.progress+params.fixX, params.posY)
end

--params.background
--params.fillImg

function PJUIHelper:createProgress(params)
    local progress = display.newScale9Sprite(params.background,0,0,CCSize(500, 36))

    local fill = display.newScale9Sprite(params.fillImg,0,0,CCSize(500, 36))
    fill:setAnchorPoint(0,0)
    local clipnode = display.newClippingRegionNode(CCRect(0,0,500,36))
    clipnode:addChild(fill)
    progress:addChild(clipnode)

    return progress
end

function PJUIHelper:setSpriteAndChildrenGray(sprite)
    sprite:setFilter(filter.newFilter("GRAY", {0.2, 0.3, 0.5, 0.1}))
    local children = sprite:getChildren()
    if children then
        for i = 0,children:count()-1 do
            local item = children:objectAtIndex(i)
            print(type(item))
            item:setFilter(filter.newFilter("GRAY", {0.2, 0.3, 0.5, 0.1}))
        end
    end
end

function PJUIHelper:clearSpriteAndChildrenGray(sprite)
    sprite:clearFilter()

    local children = sprite:getChildren()
    if children then
        print("children:count()",children:count())
        for i = 0,children:count()-1 do
            local item = children:objectAtIndex(i)       
            item:clearFilter()
        end
    end
end
