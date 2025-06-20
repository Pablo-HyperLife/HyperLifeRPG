-- Komenda /admins
addCommandHandler("admins", function(player, cmd)
    outputChatBox("--- Administracja na służbie ---", player, 255, 194, 14)
    local foundAdmins = false
    for _, admin in ipairs(getElementsByType("player")) do
        if getElementData(admin, "onDuty") then
            local rankName = getElementData(admin, "admin_rank_name") or "Admin" -- Pobierz nazwę rangi
            outputChatBox(string.format("* %s - %s", rankName, getPlayerName(admin)), player, 0, 255, 0)
            foundAdmins = true
        end
    end
    if not foundAdmins then
        outputChatBox("Obecnie żaden administrator nie jest na służbie.", player, 200, 200, 200)
    end
end)

-- Komenda /time
addCommandHandler("time", function(player, cmd)
    local time = getRealTime()
    time.hour = time.hour + (time.isDST and 2 or 1) -- Poprawka na strefę czasową Polski
    local timeString = string.format("Aktualna data i godzina: %02d.%02d.%d, %02d:%02d", time.monthday, time.month + 1, time.year + 1900, time.hour, time.minute)
    outputChatBox(timeString, player, 255, 194, 14)
end)

-- Inne komendy (/report, /komendy, /animacje) implementujesz w podobny sposób
-- używając addCommandHandler i logiki opartej o GUI lub outputChatBox.