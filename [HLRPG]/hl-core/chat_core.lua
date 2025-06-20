local chatRadius = 20.0 -- Zasięg czatu lokalnego w metrach

addEventHandler("onPlayerChat", root, function(message, messageType)
    cancelEvent() -- Anulujemy domyślną wiadomość, by stworzyć własną

    if messageType == 0 then -- Zwykła wiadomość (IC)
        -- Budowanie prefixu
        local rankPrefix = ""
        local adminLevel = getElementData(source, "admin_level") or 0
        local factionName = getElementData(source, "faction_tag") -- np. "LSPD"
        
        if getElementData(source, "onDuty") and adminLevel > 0 then
            rankPrefix = "[ADMIN]"
        elseif factionName then
            rankPrefix = "["..factionName.."]"
        else
            rankPrefix = "[Gracz]"
        end
        
        local finalMessage = string.format("%s [IC] [%s] %s: %s", rankPrefix, getElementData(source, "pid"), getPlayerName(source), message)
        
        -- Rozsyłanie wiadomości lokalnie
        local x, y, z = getElementPosition(source)
        for _, player in ipairs(getElementsByType("player")) do
            if getDistanceBetweenPoints3D(x, y, z, getElementPosition(player)) <= chatRadius then
                -- Można dodać kolory w zależności od rangi
                outputChatBox(finalMessage, player, 220, 220, 220)
            end
        end
    end
end)

-- Komendy do innych czatów (/g, /f, /o)
-- Czat globalny
addCommandHandler("g", function(player, cmd, ...)
    local message = table.concat({...}, " ")
    local finalMessage = string.format("[GLOBAL] %s: %s", getPlayerName(player), message)
    outputChatBox(finalMessage, root, 255, 194, 14) -- Złoty kolor dla globala
end)

-- Tutaj dodaj logikę dla czatu frakcyjnego (/f) i organizacyjnego (/o)
-- Będzie ona sprawdzać getElementData(player, "faction_id") etc. i wysyłać do odpowiednich graczy.