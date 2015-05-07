--
-- Author: xuewenjie
-- Date: 2015-03-25 14:19:56
--
PJLabelHelper={}

GAME_FONT = "font/fzyhjt.ttf"

--params.text utf-8
--params.posX
--params.posY
--params.spaceWidth
--params.color
--params.size
--params.outLineColor
--params.align
function PJLabelHelper:createTextStyle1(params)
    local g = display.newNode()
    local size=params.size or 45
    for i=1,#params.text do
        g.label = ui.newTTFLabel({
        text = params.text[i],
        font = GAME_FONT,
        size = size,
        color = params.color or ccc3(255,255,0),
        x = params.posX+((size+params.spaceWidth)*(i-1))-#params.text*size/2, 
        y = params.posY,
        align = params.align or ui.TEXT_ALIGN_CENTER,
        valign = ui.TEXT_VALIGN_CENTER
        })
        g:addChild(g.label,1)

        ui.createOutline(g.label,3,params.outLineColor or ccc3(102,21,21),255,GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    end
    return g
end

--params.text utf-8
--params.posX
--params.posY
--params.spaceWidth
function PJLabelHelper:createTextStyle2(params)
    local g = display.newNode()
    for i=1,#params.text do
        g.label = ui.newTTFLabel({
        text = params.text[i],
        font = GAME_FONT,
        size = 45,
        color = ccc3(255,255,255),
        x = params.posX+((45+params.spaceWidth)*(i-1))-#params.text*45/2, 
        y = params.posY,
        align = ui.TEXT_ALIGN_CENTER,
        valign = ui.TEXT_VALIGN_CENTER
        })
        g:addChild(g.label,1)
        ui.createOutline(g.label,4,ccc3(37,78,77),255,GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA)
    end
    return g
end

--params.text
--params.posX
--params.posY
--params.color
--params.size
function PJLabelHelper:createTextStyle3(params)
    local label = ui.newTTFLabelWithOutline({
        text = params.text,
        font = GAME_FONT,
        size = params.size or 38,
        color = params.color or ccc3(255,255,0),
        x = params.posX, 
        y = params.posY,
        })
    return label
end

--params.text
--params.posX
--params.posY
--params.dimensions
--params.color
--params.size
--params.valign
--params.align
function PJLabelHelper:createTextStyle4(params)
    local label = ui.newTTFLabel({
        text = params.text,
        font = GAME_FONT,
        size = params.size or 28,
        color = params.color or ccc3(255,255,255),
        x = params.posX, 
        y = params.posY,
        align = params.align or ui.TEXT_ALIGN_LEFT,
        valign = params.valign or  ui.TEXT_VALIGN_TOP,
        dimensions = params.dimensions
        })
    return label
end

--params.text
--params.posX
--params.posY
--params.dimensions
--params.color
--params.size
--params.align
function PJLabelHelper:createTextStyle5(params)
    local label = ui.newTTFLabelWithOutline({
        text = params.text,
        font = GAME_FONT,
        size = params.size or 38,
        color = params.color or ccc3(255,255,0),
        x = params.posX, 
        y = params.posY,
        align = params.align or ui.TEXT_ALIGN_LEFT,
        valign = ui.TEXT_VALIGN_TOP,
        dimensions = params.dimensions
        })
    return label
end

--params.text
--params.posX
--params.posY
--params.color
--params.size
function PJLabelHelper:createTextStyle6(params)
    local label = ui.newTTFLabel({
        text = params.text,
        font = GAME_FONT,
        size = params.size or 38,
        color = params.color or ccc3(255,255,0),
        x = params.posX, 
        y = params.posY
        })
    
    return label
end

