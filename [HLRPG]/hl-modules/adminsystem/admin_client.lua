local adminRanks = {
    [1] = {Name = "Pomocnik", Color = {0, 255, 0}},
    [2] = {Name = "Opiekun", Color = {0, 191, 255}},
    [3] = {Name = "Administrator", Color = {255, 69, 0}},
    [4] = {Name = "Head Administrator", Color = {178, 34, 34}},
    [5] = {Name = "Owner", Color = {255, 215, 0}}
}

-- Rysowanie rangi nad głową
addEventHandler("onClientRender", root, function()
    for _, player in ipairs(getElementsByType("player")) do
        if getElementData(player, "onDuty") then
            local adminLevel = getElementData(player, "admin_level")
            if adminLevel and adminRanks[adminLevel] then
                local rankInfo = adminRanks[adminLevel]
                local r, g, b = unpack(rankInfo.Color)
                
                local x, y, z = getElementPosition(player)
                local sx, sy = getScreenFromWorldPosition(x, y, z + 1.2) -- 1.2 jednostki nad głową
                
                if sx and sy then -- Rysuj tylko jeśli gracz jest na ekranie
                    dxDrawText(rankInfo.Name, sx, sy, sx, sy, tocolor(r, g, b), 1.0, "default-bold", "center", "center", false, false, false, true)
                end
            end
        end
    end
end)