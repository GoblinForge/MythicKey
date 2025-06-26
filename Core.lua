local c = MkLib.c
local cc = MkLib.cc
local mkt = MkLib.mkt

<<<<<<< Updated upstream
=======
local SpacerText        = c("50ff45", "====================")
local MkCommandListHelp = c("50ff45", "SlashCmdList / Hilfe:")
local MkHelp            = cc("00beef", "/mk", "FFFFFF", " - Befehlsliste anzeigen")
local MyRdy             = cc("00beef", "/mkrdy", "FFFFFF", " - Öffnet das Fenster für ReadyCheck von MythicKeyRdy + Pull Timer")

>>>>>>> Stashed changes
-- Registriert einen Slash-Befehl für dein Addon
SLASH_MythicKey1 = "/mk"

-- Funktion, die aufgerufen wird, wenn der Slash-Befehl verwendet wird
function SlashCmdList.MythicKey(msg, editbox)
<<<<<<< Updated upstream
    -- msg enthält den Text, der nach dem Befehl eingegeben wurde.
    local SpacerText = c("50ff45", "====================")
    local MkCommandListHelp = c("00beef", "MythicKey SlashCmdList / Hilfe:")

    if msg == "" then
        -- Zeige eine Liste von Befehlen, wenn keine spezifischen Argumente gegeben sind
        print(SpacerText)
        print(MkCommandListHelp)
        print(SpacerText)
        print("/mk - Befehlsliste anzeigen")
        print("/mkrdy - Öffnet das Fenster für ReadyCheck von MythicKeyRdy + Pull Timer")
        print(SpacerText)
    elseif msg == "help" then
        -- Zeige Hilfe für spezifische Befehle an
        print("Test1 Hilfe:")
        print("/mk help - Zeigt diese Hilfe an.")
        -- Weitere Hilfe für spezifische Befehle hinzufügen
    else
        -- Wenn ein unbekanntes Argument eingegeben wurde, zeige eine Fehlermeldung an
        print(c("ff0000", "Unbekannter Befehl: ") .. msg)
        print("Verwende '/mk help' für eine Liste der verfügbaren Befehle.")
    end
end
=======
    msg = msg or ""  -- Fallback, falls msg nil ist
    msg = msg:trim() -- Entfernt überflüssige Leerzeichen (falls vorhanden)

    -- Definiere die farbigen Textsegmente

    if msg == "" then
        -- Zeige die Standardbefehlsliste an
        print(SpacerText)
        print(mkt())  -- Funktionsaufruf, um den Rückgabewert zu erhalten
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
        -- Zeige die Standardbefehlsliste an
        print(MkHelp)
        print(MyRdy)
        print(SpacerText)
        -- Weitere Hilfe für spezifische Befehle hinzufügen
    else
        -- Unbekannter Befehl: Fehlermeldung
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
<<<<<<< Updated upstream
    expTitle:SetText("TWW Season 1")
=======
    expTitle:SetText("TWW Season 3")
>>>>>>> Stashed changes
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
>>>>>>> Stashed changes
