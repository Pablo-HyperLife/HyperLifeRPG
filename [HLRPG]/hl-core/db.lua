---
--- @doc Obsługa połączenia z bazą danych MySQL.
--- Skonfigurowano do pracy z serwerem testowym.
---

-- Dane do połączenia z bazą danych (zgodnie z Twoimi danymi)
local dbHost = "sql7.freesqldatabase.com"
local dbUser = "sql7785812"
local dbPass = "gQ18tYqlVS"
local dbName = "sql7785812"
local dbPort = 3306

-- Uchwyt połączenia
-- Składnia dla MTA: "mysql:host=...;dbname=...;port=..."
db = dbConnect("mysql", "host=" .. dbHost .. ";dbname=" .. dbName .. ";port=" .. dbPort, dbUser, dbPass)

-- Sprawdzenie, czy połączenie się udało
if not db then
    outputServerLog("---------------------------------------------------------")
    outputServerLog("BŁĄD KRYTYCZNY: Nie można połączyć się z bazą danych!")
    outputServerLog("Sprawdź dane logowania, status serwera SQL oraz ustawienia firewall.")
    outputServerLog("---------------------------------------------------------")
else
    outputServerLog("---------------------------------------------------------")
    outputServerLog("Pomyślnie połączono z zewnętrzną bazą danych MySQL.")
    outputServerLog("Host: " .. dbHost)
    outputServerLog("---------------------------------------------------------")
end

---
--- @doc Funkcja wykonująca zapytanie i oczekująca na wynik (np. SELECT).
--- @param query Zapytanie SQL.
--- @param ... Argumenty do zapytania.
--- @return Tabela z wynikami lub false w przypadku błędu.
---
function dbQuery(query, ...)
    if not db then return false end
    
    local queryHandle, numAffectedRows, lastInsertId
    -- Użycie dbQuery w bloku chronionym na wypadek błędu połączenia
    pcall(function()
        queryHandle = dbQuery(db, query, ...)
    end)
    
    return queryHandle
end

---
--- @doc Funkcja wykonująca zapytanie bez oczekiwania na wynik (np. INSERT, UPDATE, DELETE).
--- @param query Zapytanie SQL.
--- @param ... Argumenty do zapytania.
--- @return true w przypadku sukcesu, false w przypadku błędu.
---
function dbExec(query, ...)
    if not db then return false end

    local success = false
    -- Użycie dbExec w bloku chronionym
    pcall(function()
        success = dbExec(db, query, ...)
    end)

    return success
end