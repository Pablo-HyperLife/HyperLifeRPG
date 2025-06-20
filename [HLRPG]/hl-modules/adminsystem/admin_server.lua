local adminRanks = {
    [1] = {Name = "Pomocnik", Color = {0, 255, 0}},
    [2] = {Name = "Opiekun", Color = {0, 191, 255}},
    [3] = {Name = "Administrator", Color = {255, 69, 0}},
    [4] = {Name = "Head Administrator", Color = {178, 34, 34}},
    [5] = {Name = "Owner", Color = {255, 215, 0}}
}

addCommandHandler("duty", function(player, cmd)
    local adminLevel = getElementData(player, "admin_level") or 0
    if adminLevel == 0 then return end -- Zwykły gracz nie może użyć

    local onDuty = not getElementData(player, "onDuty")
    setElementData(player, "onDuty", onDuty)

    if onDuty then
        local rankInfo = adminRanks[adminLevel]
        local r, g, b = unpack(rankInfo.Color)
        setPlayerNametagColor(player, r, g, b)
        outputChatBox("Wszedłeś na służbę. Masz dostęp do komend administracyjnych.", player, r, g, b)
        outputChatBox("Panel zgłoszeń: /raporty | Panel admina: /ap", player, 200, 200, 200)
    else
        setPlayerNametagColor(player, 255, 255, 255) -- Reset do białego
        outputChatBox("Zszedłeś ze służby.", player, 255, 194, 14)
    end
end)

-- Przykładowe komendy-placeholdery
addCommandHandler("raporty", function(player, cmd)
    if getElementData(player, "onDuty") then
        outputChatBox("Otwarto panel zgłoszeń...", player, 0, 255, 0)
    end
end)
addCommandHandler("ap", function(player, cmd)
    if getElementData(player, "onDuty") then
        outputChatBox("Otwarto panel admina...", player, 0, 255, 0)
    end
end)