---
--- @doc Główny plik rdzenia serwera.
--- Odpowiedzialny za ładowanie podstawowych danych graczy i zarządzanie nimi.
---

-- Event wywoływany, gdy gracz dołącza na serwer
addEventHandler("onPlayerJoin", root, function()
    -- Ustawiamy podstawowe dane dla nowego gracza, zanim się zaloguje
    setElementData(source, "loggedIn", false)
    setElementData(source, "onDuty", false)
    setElementData(source, "admin_level", 0) -- Domyślnie gracz nie jest adminem
end)

-- Informacja w konsoli, że rdzeń się załadował
outputServerLog("[HLRPG] Moduł 'hl-core/core_server.lua' został pomyślnie załadowany.")