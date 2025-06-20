---
--- @doc Logika serwerowa dla systemu logowania i rejestracji.
---

-- Funkcja do hashowania hasła (prosta, w produkcji użyj bcrypt!)
function hashPassword(password)
    return password -- UWAGA: To tylko przykład! Użyj 'tea' lub zewnętrznej biblioteki.
end

-- Rejestracja
addEvent("onPlayerTryRegister", true)
addEventHandler("onPlayerTryRegister", root, function(username, password)
    local query = dbQuery("SELECT id FROM players WHERE name = ?", username)
    if #query > 0 then
        triggerClientEvent(source, "onLoginError", source, "Konto o tej nazwie już istnieje.")
    else
        local hashedPassword = hashPassword(password)
        dbExec("INSERT INTO players (name, password) VALUES (?, ?)", username, hashedPassword)
        local result = dbQuery("SELECT id FROM players WHERE name = ?", username)
        local pid = result[1].id
        setElementData(source, "pid", pid)
        triggerClientEvent(source, "onRegisterSuccess", source, "Rejestracja pomyślna! PID: " .. pid)
    end
end)

-- Logowanie
addEvent("onPlayerTryLogin", true)
addEventHandler("onPlayerTryLogin", root, function(username, password)
    local hashedPassword = hashPassword(password)
    local query = dbQuery("SELECT id, password FROM players WHERE name = ?", username)
    if #query == 0 then
        triggerClientEvent(source, "onLoginError", source, "Konto o tej nazwie nie istnieje.")
    elseif query[1].password ~= hashedPassword then
        triggerClientEvent(source, "onLoginError", source, "Błędne hasło.")
    else
        local pid = query[1].id
        setElementData(source, "pid", pid)
        setElementData(source, "loggedIn", true)
        outputChatBox("Pomyślnie zalogowano. Witaj " .. username .. "!", source, 0, 255, 0)
        -- Ukryj GUI logowania i pokaż wybór spawnu
        triggerClientEvent(source, "onLoginSuccess", source)
    end
end)