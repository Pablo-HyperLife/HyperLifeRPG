local sx, sy = guiGetScreenSize()
local scoreboardVisible = false
local playersData = {}

-- Przełączanie widoczności scoreboardu
bindKey("tab", "both", function()
    scoreboardVisible = not scoreboardVisible
    showCursor(scoreboardVisible)
    if scoreboardVisible then
        triggerServerEvent("scoreboard:fetchData", localPlayer) -- Poproś serwer o świeże dane
        addEventHandler("onClientRender", root, drawScoreboard)
    else
        removeEventHandler("onClientRender", root, drawScoreboard)
    end
end)

-- Odbieranie danych z serwera
addEvent("scoreboard:receiveData", true)
addEventHandler("scoreboard:receiveData", root, function(data)
    playersData = data
end)


function drawScoreboard()
    -- Tło
    dxDrawRectangle(sx * 0.5 - 400, sy * 0.5 - 250, 800, 500, tocolor(20, 20, 20, 200))
    dxDrawText("HLRPG Scoreboard", sx * 0.5 - 400, sy * 0.5 - 245, sx * 0.5 + 400, sy * 0.5 - 215, tocolor(255, 255, 255), 1.5, "default-bold", "center", "center")
    dxDrawText("Graczy online: " .. #playersData, sx * 0.5 - 390, sy * 0.5 - 215, sx * 0.5 + 390, sy * 0.5 - 195, tocolor(200, 200, 200), 1.0, "default", "left", "center")

    -- Nagłówki
    local startY = sy * 0.5 - 180
    dxDrawText("PID", sx * 0.5 - 390, startY, sx * 0.5 - 340, startY + 20, tocolor(255, 194, 14), 1.0, "default-bold", "left", "center")
    dxDrawText("ID", sx * 0.5 - 330, startY, sx * 0.5 - 290, startY + 20, tocolor(255, 194, 14), 1.0, "default-bold", "left", "center")
    dxDrawText("Nazwa Gracza", sx * 0.5 - 280, startY, sx * 0.5 - 50, startY + 20, tocolor(255, 194, 14), 1.0, "default-bold", "left", "center")
    dxDrawText("Godziny", sx * 0.5 - 40, startY, sx * 0.5 + 50, startY + 20, tocolor(255, 194, 14), 1.0, "default-bold", "left", "center")
    dxDrawText("Frakcja / Organizacja", sx * 0.5 + 60, startY, sx * 0.5 + 390, startY + 20, tocolor(255, 194, 14), 1.0, "default-bold", "left", "center")
    
    -- Lista graczy
    for i, data in ipairs(playersData) do
        local rowY = startY + 25 * i
        dxDrawText(data.pid, sx * 0.5 - 390, rowY, sx * 0.5 - 340, rowY + 20, tocolor(255, 255, 255), 1.0, "default", "left", "center")
        dxDrawText(data.id, sx * 0.5 - 330, rowY, sx * 0.5 - 290, rowY + 20, tocolor(255, 255, 255), 1.0, "default", "left", "center")
        dxDrawText(data.name, sx * 0.5 - 280, rowY, sx * 0.5 - 50, rowY + 20, tocolor(255, 255, 255), 1.0, "default", "left", "center")
        dxDrawText(data.playTime .. "h", sx * 0.5 - 40, rowY, sx * 0.5 + 50, rowY + 20, tocolor(255, 255, 255), 1.0, "default", "left", "center")
        dxDrawText(data.faction .. " / " .. data.organization, sx * 0.5 + 60, rowY, sx * 0.5 + 390, rowY + 20, tocolor(255, 255, 255), 1.0, "default", "left", "center")
    end
end