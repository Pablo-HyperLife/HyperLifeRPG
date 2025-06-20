local sx, sy = guiGetScreenSize()

addEventHandler("onClientRender", root, function()
    -- Sprawdzamy czy gracz jest zalogowany, by nie pokazywać HUDa w panelu logowania
    if getElementData(localPlayer, "loggedIn") then
        -- Pasek zdrowia
        local health = getElementHealth(localPlayer)
        dxDrawRectangle(sx - 220, sy - 50, 200, 20, tocolor(50, 50, 50, 150)) -- tło paska
        dxDrawRectangle(sx - 220, sy - 50, health * 2, 20, tocolor(200, 0, 0, 200)) -- pasek
        dxDrawText(math.floor(health) .. "%", sx - 220, sy - 50, sx - 20, sy - 30, tocolor(255, 255, 255), 1.0, "default-bold", "center", "center")

        -- Gotówka "YANG"
        local cash = getElementData(localPlayer, "cash") or 0
        dxDrawRectangle(sx - 220, sy - 80, 200, 25, tocolor(50, 50, 50, 150))
        dxDrawText("YANG: " .. cash, sx - 215, sy - 80, sx - 20, sy - 55, tocolor(255, 194, 14), 1.2, "default-bold", "left", "center")
    end
end)