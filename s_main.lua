--[[
============================================================================================
============================================================================================
    Autor tohoto specifického resource: Lukk & LukkMTA DEVELOPERS
    Dny práce: 7.3.2024 - 7.3.2024
============================================================================================
============================================================================================
]]--

function HelpChat(thePlayer, cmd, ...)
    if not getElementData(thePlayer, "loggedin") == 1 then
        outputChatBox("Pro použití příkazu musíš být přihlášen.", thePlayer, 255, 194, 14)
        return
    end

    if not ... then
        outputChatBox("SYNTAX: /"..cmd.." [Zpráva]", thePlayer, 255, 194, 14)
        return
    end

    local players = exports.pool:getPoolElementsByType("player")
    message = table.concat({...}, " ")

    if not getElementData(thePlayer, "showHC") then
        setElementData(thePlayer, "showHC", true)    
    end

    for k, arrayPlayer in ipairs(players) do
        local logged = tonumber(getElementData(arrayPlayer, "loggedin"))
        local playerName = exports.global:getPlayerFullIdentity(thePlayer)
        local showHC = getElementData(arrayPlayer, "showHC")
        local isAdmin = exports.global:isStaff(arrayPlayer)

        if (logged==1) and (showHC) or isAdmin then
            outputChatBox("[HELPCHAT] "..playerName.." napsal zprávu: " .. message .. "", arrayPlayer, 196, 255, 255)
        end
    end
    
    if getElementData(thePlayer, "showHC") == true then
        setTimer(function ()
            removeElementData(thePlayer, "showHC")
        end, 60000, 1)
    end
end
addCommandHandler("hc", HelpChat, false, false)
addCommandHandler("helpchat", HelpChat, false, false)