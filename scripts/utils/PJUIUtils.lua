--
-- Author: 张伟超
-- Date: 2014-08-07 09:53:25
--
PJUIUtils = {}

-- 切换场景
-- @param name 场景名字
-- @param params    传递给下一个场景的参数
-- @param callback  回调函数
-- @param transitionParams  切换效果参数
function switchScene(name, params,transitionParams,callback)
	
	CCDirector:sharedDirector():getActionManager():removeAllActions()
	local scene = require(string.format("scenes.%s.scene", name))
	if transitionParams then
		display.replaceScene(scene.new(params), transitionParams.style, transitionParams.time, transitionParams.more)
	else
		display.replaceScene(scene.new(params))
	end

	if type(callback) == "function" then
		-- 必须延迟，不然会在替换场景之前执行
		local handle
		handle = CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(function()
			CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(handle)
			handle = nil
			callback()
		end, 0.5 , false)
	end
end

--@字符串奖励解析统一接口（格式 item:1=2;2=3|mount:2=4|equip:2|gold:30|gem:100|key:67）
function getStringRewards(string)
	--@item:道具  equip:装备  gold:金币 gem:钻石 ore:矿石 mount:坐骑 key:钥匙
	local typeArr = string.split(string,"|")
	for i=1,#typeArr do
		local typeData = typeArr[i]
		local subArr = string.split(typeData,":")
		local rewardName = subArr[1]
		local subRewardStr = subArr[2]
		local rewardArr = string.split(subRewardStr,";")
		if rewardName=='item' then
			for j,v in ipairs(rewardArr) do
				local strArr = string.split(rewardArr[j],"=")
				local id = tonumber(strArr[1])
				local amout = tonumber(strArr[2])
				GameData.player.daojus[id].num = GameData.player.daojus[id].num+amout
			end
		elseif rewardName=='equip' then
			local id = tonumber(rewardArr[1])
			GameData.player.equips[id].level=1
			GameData.player.equips[id].enchantLevel=1
		elseif rewardName=='gold' then
			local rewardAmout = tonumber(rewardArr[1])
			GameData.player.info.coin = GameData.player.info.coin+rewardAmout
		elseif rewardName=='gem' then
			local rewardAmout = tonumber(rewardArr[1])
			GameData.player.info.jewel = GameData.player.info.jewel+rewardAmout
		elseif rewardName=='mount' then
			for j,v in ipairs(rewardArr) do
				local strArr = string.split(rewardArr[j],"=")
				local id = tonumber(strArr[1])
				local amout = tonumber(strArr[2])
				GameData.player.mounts[id].debrisNum=GameData.player.mounts[id].debrisNum+amout
			end
		elseif rewardName=='key' then
			local rewardAmout = tonumber(rewardArr[1])
			GameData.player.info.keys=GameData.player.info.keys+rewardAmout
		elseif rewardName == "ore" then
			local rewardAmout = tonumber(rewardArr[1])
			GameData.player.info.up=GameData.player.info.up+rewardAmout	
		end
	end
	GameState.save(GameData)
end


--@字符串奖励解析统一接口（格式 item:1=2;2=3|mount:2=4|equip:2|gold:30|gem:100|key:67）
function getRewardsShowInfo(string)
	local index,resultArr = 1,{}

	local typeArr = string.split(string,"|")
	for i=1,#typeArr do
		local typeData = typeArr[i]
		local subArr = string.split(typeData,":")

		local rewardName = subArr[1]
		local subRewardStr = subArr[2]
		local rewardArr = string.split(subRewardStr,";")
		if rewardName=='item' then
			for j,v in ipairs(rewardArr) do
				local strArr = string.split(rewardArr[j],"=")
				local id = tonumber(strArr[1])
				local amout = tonumber(strArr[2])
				resultArr[index] = {}
				resultArr[index].res = itemCsv:getDataByIndex(id).res
				resultArr[index].amout = amout
				resultArr[index].name = itemCsv:getDataByIndex(id).name
				resultArr[index].type = rewardName
				index = index + 1
			end
		elseif rewardName=='equip' then
			local id = tonumber(rewardArr[1])
			resultArr[index] = {}
			resultArr[index].res = equipsNewCsv:getDataByIndex(id).res
			resultArr[index].amout = 1
			resultArr[index].name = equipsNewCsv:getDataByIndex(id).equipName
			resultArr[index].type = rewardName
			index = index + 1
		elseif rewardName=='gold' then
			local rewardAmout = tonumber(rewardArr[1])

			if rewardAmout>0 then
				resultArr[index] = {}
				resultArr[index].res = "newHomeRes/common/tubiao-1.png"
				resultArr[index].amout = rewardAmout
				resultArr[index].name = "金币"
				resultArr[index].type = rewardName
				index = index + 1
			end
		elseif rewardName=='gem' then
			local rewardAmout = tonumber(rewardArr[1])

			if rewardAmout>0 then
				resultArr[index] = {}
				resultArr[index].res = "newHomeRes/common/tubiao-2.png"
				resultArr[index].amout = rewardAmout
				resultArr[index].name = "钻石"
				resultArr[index].type = rewardName
				index = index + 1
			end
		elseif rewardName=='mount' then
			for j,v in ipairs(rewardArr) do
				local strArr = string.split(rewardArr[j],"=")
				local id = tonumber(strArr[1])
				local amout = tonumber(strArr[2])
				
				resultArr[index] = {}
				resultArr[index].res = mountCsv:getDataByIndex(id).res
				resultArr[index].amout = amout
				resultArr[index].name = mountCsv:getDataByIndex(id).name
				resultArr[index].type = rewardName
				index = index + 1
			end
		elseif rewardName=='key' then
			local rewardAmout = tonumber(rewardArr[1])
			if rewardAmout>0 then
				resultArr[index] = {}
				resultArr[index].res = "newHomeRes/common/tubiao-3.png"
				resultArr[index].amout = rewardAmout
				resultArr[index].name = "钥匙"
				resultArr[index].type = rewardName
				index = index + 1
			end
		elseif rewardName=='ore' then
			local rewardAmout = tonumber(rewardArr[1])
			if rewardAmout>0 then
				resultArr[index] = {}
				resultArr[index].res = "newHomeRes/common/tubiao-4.png"
				resultArr[index].amout = rewardAmout
				resultArr[index].name = "矿石"
				resultArr[index].type = rewardName
				index = index + 1
			end
		end
	end

	return resultArr
end

--@成就数值加value
function addValueAchievement(achieType,value)

	if not GameData.player.info.achieState[tostring(achieType)] then
		GameData.player.info.achieState[tostring(achieType)] = {}
		GameData.player.info.achieState[tostring(achieType)].achieID = achievementCsv:getFirstIDByType(achieType)
		GameData.player.info.achieState[tostring(achieType)].state = 0
		GameData.player.info.achieState[tostring(achieType)].value = 0
	end

	local achieve = GameData.player.info.achieState[tostring(achieType)]

	local achievementID = achieve.achieID
	local achieveData = achievementCsv:getDataByIndex(achievementID)
	local needValue = achieveData.value or 0

	local newValue = achieve.value + value
	achieve.value = newValue

	local curState = achieve.state or 0
	if newValue>= needValue and curState==0 then
		achieve.state = 1
	end
	GameState.save(GameData)
end

--@成就数值设置value
function setValueAchievement(achieType,value)

	-- local achieve = GameData.player.info.achieState[tostring(achieType)]

	if not GameData.player.info.achieState[tostring(achieType)] then
		GameData.player.info.achieState[tostring(achieType)] = {}
		GameData.player.info.achieState[tostring(achieType)].achieID = achievementCsv:getFirstIDByType(achieType)
		GameData.player.info.achieState[tostring(achieType)].state = 0
		GameData.player.info.achieState[tostring(achieType)].value = 0
	end

	local achieve = GameData.player.info.achieState[tostring(achieType)]

	local achievementID = achieve.achieID
	local achieveData = achievementCsv:getDataByIndex(achievementID)

	if achieve.value<value then
		achieve.value = value
	end
	local needValue = achieveData.value or 0
	local curState = achieve.state or 0
	if value>=needValue and curState==0 then
		achieve.state = 1
	end

	print("achieve.state",achieve.state)

	GameState.save(GameData)
end

function setAchievement_Type5()
	local value=0
	for i=1,#GameData.player.info.curEquips do
		local equipID = GameData.player.info.curEquips[i]
		local equip = GameData.player.equips[tostring(equipID)]
		if equip.qualityId>2 then
			value = value + 1
		end
	end
	setValueAchievement(5,value)
end

--成就具体数值
function getAchievementInit(achieID)

	local achieType = achievementCsv:getDataByIndex(achieID).achieType
	local value = 0
	if achieType==5 then
		for i=1,#GameData.player.info.curEquips do
			local equipID = GameData.player.info.curEquips[i]
			local equip = GameData.player.equips[tostring(equipID)]
			if equip.qualityId>2 then
				value = value + 1
			end
		end
	end

	return value
end

--@成就数值设置value
function setNextAchievement(achievementID)

	local achieveData = achievementCsv:getDataByIndex(achievementID)

	local typeValue = achieveData.achieType
	
	local achieve = GameData.player.info.achieState[tostring(typeValue)]
	if achieve.achieID == achievementID then
		local newID = achievementCsv:getNextAchievementByID(achievementID)
		if newID>0 then
			achieve.achieID = newID
			achieve.state = 0

			local nextAchieveData = achievementCsv:getDataByIndex(newID)
			if achieve.value>=nextAchieveData.value then
				achieve.state = 1
			end
		else
			achieve.state = 2
		end

		GameState.save(GameData)
	end
end