-- Ten skrypt bezpiecznie pobiera dane graczy i wysyła je do klienta.
-- Zapobiega to oszustwom i fałszowaniu danych.

addEvent("scoreboard:fetchData", true)
addEventHandler("scoreboard:fetchData", root, function()
    local playersData = {}
    for _, player in ipairs(getElementsByType("player")) do
        if getElementData(player, "loggedIn") then
            table.insert(playersData, {
                id = getElementID(player), -- Bieżące ID na serwerze
                pid = getElementData(player, "pid") or "N/A",
                name = getPlayerName(player),
                playTime = math.floor((getElementData(player, "play_time") or 0) / 60), -- w godzinach
                faction = getElementData(player, "faction_name") or "Brak",
                organization = getElementData(player, "org_name") or "Brak"
            })
        end
    end
    triggerClientEvent(source, "scoreboard:receiveData", source, playersData)
end)