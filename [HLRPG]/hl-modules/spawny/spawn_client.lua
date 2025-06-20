---
--- @doc Zaawansowany, dynamiczny interfejs wyboru spawnu (wersja bez grafik).
--- @author TwojaNazwa
--- @version 1.1
---

-- =================================================================
-- Konfiguracja i Zmienne Stanu
-- =================================================================
local sx, sy = guiGetScreenSize()
local isSpawnScreenVisible = false
local spawnPoints = {}
local hoveredSpawnIndex = -1
local selectedSpawnIndex = -1
local font = "default-bold"
local fontScale = 1.0

-- Paleta kolorów
local colors = {
    background = tocolor(25, 28, 32, 230),
    panel = tocolor(45, 48, 52, 200),
    white = tocolor(255, 255, 255),
    gray = tocolor(150, 150, 150),
    accent = tocolor(255, 194, 14),
    accent_hover = tocolor(255, 215, 80)
}

-- =================================================================
-- Główne Funkcje (Odbieranie danych, pokazywanie/ukrywanie UI)
-- =================================================================

addEvent("showSpawnSelection", true)
addEventHandler("showSpawnSelection", root, function(serverSpawnPoints)
    -- ZMIANA: Usunięto odwołania do 'image' w poniższej tabeli.
    spawnPoints = {
        { name = serverSpawnPoints[1][1], desc = "Główny hub społeczny serwera.\nStrefa dla pieszych, idealna na start.", coords = serverSpawnPoints[1][2] },
        { name = serverSpawnPoints[2][1], desc = "Pustynne miasteczko z unikalnym klimatem.\nUważaj na lokalne gangi.", coords = serverSpawnPoints[2][2] },
        { name = serverSpawnPoints[3][1], desc = "Spokojna, wiejska okolica.\nIdealne miejsce dla tych, którzy cenią sobie ciszę.", coords = serverSpawnPoints[3][3] },
        { name = serverSpawnPoints[4][1], desc = "Dzielnica mieszkalna w sercu miasta hazardu.\nSzybki dostęp do atrakcji Las Venturas.", coords = serverSpawnPoints[4][4] }
    }
    
    showSpawnUI(true)
end)

function showSpawnUI(state)
    isSpawnScreenVisible = state
    showCursor(state)
    
    if state then
        addEventHandler("onClientRender", root, renderSpawnUI)
        addEventHandler("onClientClick", root, handleMouseClick)
    else
        removeEventHandler("onClientRender", root, renderSpawnUI)
        removeEventHandler("onClientClick", root, handleMouseClick)
        selectedSpawnIndex = -1
        hoveredSpawnIndex = -1
    end
end

-- =================================================================
-- Rysowanie Interfejsu (onClientRender)
-- =================================================================

function renderSpawnUI()
    local panelWidth, panelHeight = 900, 550
    local panelX, panelY = (sx - panelWidth) / 2, (sy - panelHeight) / 2

    dxDrawRectangle(panelX, panelY, panelWidth, panelHeight, colors.background)
    dxDrawText("Wybierz Miejsce Odrodzenia", panelX, panelY + 10, panelX + panelWidth, panelY + 50, colors.white, 1.5, font, "center", "center")

    -- Lewa kolumna - lista spawnów
    local listX, listY = panelX + 30, panelY + 80
    local listWidth, listItemHeight = 250, 45
    hoveredSpawnIndex = -1

    for i, spawn in ipairs(spawnPoints) do
        local itemY = listY + (i - 1) * (listItemHeight + 10)
        local bgColor = colors.panel
        local textColor = colors.gray
        
        if isCursorInArea(listX, itemY, listWidth, listItemHeight) then
            hoveredSpawnIndex = i
            bgColor = tocolor(60, 63, 67, 220)
        end
        
        if selectedSpawnIndex == i then
            bgColor = colors.accent
            textColor = colors.background
        elseif hoveredSpawnIndex == i then
            textColor = colors.white
        end
        
        dxDrawRectangle(listX, itemY, listWidth, listItemHeight, bgColor)
        dxDrawText(spawn.name, listX + 15, itemY, listX + listWidth - 15, itemY + listItemHeight, textColor, 1.1, font, "left", "center")
    end

    -- Prawa kolumna - detale spawnu
    local detailsX, detailsY = listX + listWidth + 30, listY
    local detailsWidth, detailsHeight = panelWidth - listWidth - 90, panelHeight - 180
    
    local indexToShow = selectedSpawnIndex
    if indexToShow == -1 then indexToShow = hoveredSpawnIndex end

    if indexToShow ~= -1 then
        local data = spawnPoints[indexToShow]
        -- ZMIANA: Usunięto rysowanie obrazka i zmieniono układ tekstu.
        dxDrawText(data.name, detailsX, detailsY + 20, detailsX + detailsWidth, detailsY + 50, colors.accent, 1.6, font, "left", "top")
        dxDrawRectangle(detailsX, detailsY + 70, detailsWidth * 0.5, 2, colors.accent) -- Ozdobna linia
        dxDrawText(data.desc, detailsX, detailsY + 90, detailsX + detailsWidth, detailsY + detailsHeight, colors.white, 1.1, "default", "left", "top", true)
    else
        dxDrawText("Najedź na spawn, aby zobaczyć szczegóły...", detailsX, detailsY, detailsX + detailsWidth, detailsY + detailsHeight, colors.gray, 1.2, "default", "center", "center", true)
    end

    -- Przycisk "Wybierz"
    local buttonWidth, buttonHeight = 200, 50
    local buttonX, buttonY = (sx - buttonWidth) / 2, panelY + panelHeight - buttonHeight - 20
    
    local buttonColor = colors.panel
    local buttonTextColor = colors.gray
    
    if selectedSpawnIndex ~= -1 then
        buttonTextColor = colors.white
        if isCursorInArea(buttonX, buttonY, buttonWidth, buttonHeight) then
            buttonColor = colors.accent_hover
        else
            buttonColor = colors.accent
        end
    end
    
    dxDrawRectangle(buttonX, buttonY, buttonWidth, buttonHeight, buttonColor)
    dxDrawText("WYBIERZ", buttonX, buttonY, buttonX + buttonWidth, buttonY + buttonHeight, buttonTextColor, 1.2, font, "center", "center")
end


-- =================================================================
-- Obsługa Kliknięć
-- =================================================================

function handleMouseClick(button, state)
    if not isSpawnScreenVisible or button ~= "left" or state ~= "down" then return end

    local panelX, panelY = (sx - 900) / 2, (sy - 550) / 2
    local listX, listY = panelX + 30, panelY + 80
    local listWidth, listItemHeight = 250, 45
    
    for i, spawn in ipairs(spawnPoints) do
        local itemY = listY + (i - 1) * (listItemHeight + 10)
        if isCursorInArea(listX, itemY, listWidth, listItemHeight) then
            selectedSpawnIndex = i
            playSoundFrontEnd(40)
            return
        end
    end

    local buttonWidth, buttonHeight = 200, 50
    local buttonX, buttonY = (sx - buttonWidth) / 2, panelY + 550 - buttonHeight - 20
    
    if selectedSpawnIndex ~= -1 and isCursorInArea(buttonX, buttonY, buttonWidth, buttonHeight) then
        triggerServerEvent("onPlayerSelectSpawn", localPlayer, selectedSpawnIndex)
        showSpawnUI(false)
        playSoundFrontEnd(41)
    end
end

-- =================================================================
-- Funkcja Pomocnicza
-- =================================================================

function isCursorInArea(x, y, w, h)
    if not isCursorShowing() then return false end
    local mx, my = getCursorPosition()
    mx, my = mx * sx, my * sy
    return (mx >= x and mx <= x + w and my >= y and my <= y + h)
end