--
-- Author: xuewenjie
-- Date: 2015-03-25 15:48:51
--
PJAnimationHelper={}

--params.node
--params.duration
function PJAnimationHelper:commonTitleOpenAnimation(params)
    params.node:setPosition(-80, 610)
    transition.execute(params.node, 
        CCMoveTo:create(params.duration, CCPoint(-80, 370)), 
        { delay = 0,  onComplete = function() end,})
end


--params.node
--params.duration
--params.callback
function PJAnimationHelper:commonTitleCloseAnimation(params)
    params.node:setPosition(-80, 370)
    transition.execute(params.node, 
        CCMoveTo:create(params.duration, CCPoint(-80, 610)), 
        { delay = 0,  onComplete = function() if params.callback then params.callback() end end,})
end