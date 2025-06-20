---
--- @doc Logika serwerowa do obsługi spawnów.
---

local spawnPoints = {
    -- Nazwa, Współrzędne (X, Y, Z), Mapa do załadowania
    {"Los Santos - Metro", {1630, -2268, 13.5}, "spawnLS.map"},
    {"Fort Carson", {-325, 938, 25.4}, "spawnFC.map"},
    {"Palomino Creek", {2245, 185, 10.8}, "spawnPC.map"},
    {"Las Venturas - Whitewood", {2035, 2372, 10.8}, "spawnLV.map"}
}

-- Kiedy gracz się zaloguje, pokaż mu wybór spawnu
addEvent("onPlayerLoginSuccess", true)
addEventHandler("onPlayerLoginSuccess", root, function()
    triggerClientEvent(source, "showSpawnSelection", source, spawnPoints)
end)

-- Kiedy gracz wybierze spawn
addEvent("onPlayerSelectSpawn", true)
addEventHandler("onPlayerSelectSpawn", root, function(spawnIndex)
    if spawnPoints[spawnIndex] then
        local pos = spawnPoints[spawnIndex][2]
        spawnPlayer(source, pos[1], pos[2], pos[3], 0, 70, 0, "main_station")
        fadeCamera(source, true)
        outputChatBox("Witaj w " .. spawnPoints[spawnIndex][1] .. "!", source, 255, 194, 14)
    end
end)