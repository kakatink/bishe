
function __G__TRACKBACK__(errorMessage)
    print("----------------------------------------")
    print("LUA ERROR: " .. tostring(errorMessage) .. "\n")
    print(debug.traceback("", 2))
    print("----------------------------------------")
end

local writablePath = CCFileUtils:sharedFileUtils():getWritablePath()


game = require("gameApp").new()
xpcall(function() game:run() end, __G__TRACKBACK__)
