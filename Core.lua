local c = MkLib.c
local cc = MkLib.cc
local mkt = MkLib.mkt

local SpacerText        = c("50ff45", "====================")
local MkCommandListHelp = c("50ff45", "SlashCmdList / Hilfe:")
local MkHelp            = cc("00beef", "/mk", "FFFFFF", " - Befehlsliste anzeigen")
local MyRdy             = cc("00beef", "/mkrdy", "FFFFFF", " - Öffnet das Fenster für ReadyCheck von MythicKeyRdy + Pull Timer")

-- Registriert einen Slash-Befehl für dein Addon
SLASH_MythicKey1 = "/mk"

-- Funktion, die aufgerufen wird, wenn der Slash-Befehl verwendet wird
function SlashCmdList.MythicKey(msg, editbox)
    msg = msg or ""      -- Fallback, falls msg nil ist
    msg = msg:trim()     -- Überflüssige Leerzeichen entfernen

    if msg == "" then
        -- Zeige die Standardbefehlsliste an
        print(SpacerText)
        print(mkt())
        print(SpacerText)
        print(MkCommandListHelp)
        print(SpacerText)
        print(MkHelp)
        print(MyRdy)
        print(SpacerText)
    elseif msg:lower() == "help" then
        print(SpacerText)
        -- Zeige spezifische Hilfe an
        print("Test Hilfe:")
        print("/mk help - Zeigt diese Hilfe an.")
        print(MkHelp)
        print(MyRdy)
        print(SpacerText)
    else
        -- Unbekannter Befehl
        print(SpacerText)
        print(c("ff0000", "Unbekannter Befehl: ") .. msg)
        print("Verwende '/mk help' für eine Liste der verfügbaren Befehle.")
        print(SpacerText)
    end
end

----------------------------------------------------------------------
-- MythicKey Addon-Optionen in den Einstellungen registrieren
----------------------------------------------------------------------

do
    local interPanel = CreateFrame("FRAME")
    interPanel.name = "MythicKey"

    -- Haupttitel
    local mainTitle = interPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    mainTitle:SetPoint("TOP", 0, -72)
    mainTitle:SetText(c("00beef", "MythicKey"))
    mainTitle:SetFont(mainTitle:GetFont(), 72)

    -- Erweiterungstitel (Optional, falls du angeben willst, für welche Expansion das Addon entwickelt wurde)
    local expTitle = interPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    expTitle:SetPoint("TOP", 0, -152)
    expTitle:SetText("TWW Season 1")
    expTitle:SetFont(expTitle:GetFont(), 32)

    -- URL oder Beschreibung
    local subTitle = interPanel:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    subTitle:SetPoint("BOTTOM", 0, 72)
    subTitle:SetText("github.com/2luna/MythicKey")
    subTitle:SetFont(subTitle:GetFont(), 20)

    -- Slash-Befehl als klickbarer Button
    local slashTitle = interPanel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    slashTitle:SetPoint("BOTTOM", subTitle, "TOP", 0, 40)
    slashTitle:SetText(c("00beef", "/mk"))
    slashTitle:SetFont(slashTitle:GetFont(), 72)

    -- Beim Klicken den Slash-Befehl ausführen
    slashTitle:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" then
            -- Zeige die Standardbefehlsliste an
            print(SpacerText)
            print(mkt())  -- Funktionsaufruf, um den Rückgabewert zu erhalten
            print(SpacerText)
            print(MkCommandListHelp)
            print(SpacerText)
            print(MkHelp)
            print(MyRdy)
            print(SpacerText)
        end
    end)
    -- Farbeffekt beim Mouseover
    slashTitle:SetScript("OnEnter", function()
        slashTitle.r,  slashTitle.g, slashTitle.b = slashTitle:GetTextColor()
        slashTitle:SetTextColor(1, 1, 0)
    end)
    slashTitle:SetScript("OnLeave", function()
        slashTitle:SetTextColor(slashTitle.r, slashTitle.g, slashTitle.b)
    end)

    -- Hintergrund-Textur für das Panel (Optional)
    local pTex = interPanel:CreateTexture(nil, "BACKGROUND")
    pTex:SetAllPoints()
    pTex:SetTexture("Interface\\GLUES\\Models\\UI_MainMenu\\swordgradient2")
    pTex:SetAlpha(0.3)
    pTex:SetTexCoord(0, 1, 1, 0)

    -- Panel in die WoW-Addons-Einstellungen einfügen
    local category = Settings.RegisterCanvasLayoutCategory(interPanel, "MythicKey")
    Settings.RegisterAddOnCategory(category)
end
