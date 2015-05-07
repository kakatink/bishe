require("config")
require("framework.init")
require("utils.init")
require("uiutils.init")

GameState = require(cc.PACKAGE_NAME .. ".api.GameState")
GameData = {}
session = 100

local gameApp = class("gameApp", cc.mvc.AppBase)

function gameApp:ctor()
	gameApp.super.ctor(self)
end

function gameApp:run()
	CCFileUtils:sharedFileUtils():addSearchPath("res/")

	--require("csv.CsvLoader").loadCsv()

	self:initUserDefault()

	switchScene("home", nil,{style = "fade",time = 1,more = ccc3(30, 30, 30)})
end

function gameApp:initUserDefault()
	-- init GameState
	GameState.init(function(param)
		local returnValue = nil
		if param.errorCode then
			CCLuaLog("error")
		else
			-- crypto
			if param.name == "save" then
				local str = json.encode(param.values)
				str = crypto.encryptXXTEA(str, "abcd")
				returnValue = { data = str }
			elseif param.name == "load" then
				local str = crypto.decryptXXTEA(param.values.data, "abcd")
				returnValue = json.decode(str)
			end
		end
		return returnValue 
	end, "default.bin", "windy")
	-- if io.exists(GameState.getGameStatePath()) then
        GameData=GameState.load()
    -- end
    if not GameData then 
		GameData = {}
		GameData.player = {}

	end

	if not GameData.authInfo then
		GameData.authInfo = {}
	end

end

function gameApp:exit()
    CCDirector:sharedDirector():endToLua()
    os.exit()
end

return gameApp