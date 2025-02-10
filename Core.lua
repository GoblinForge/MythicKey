local c = MkLib.c
local mkt = MkLib.mkt

-- Registriert einen Slash-Befehl für dein Addon
SLASH_MythicKey1 = "/mk"

-- Funktion, die aufgerufen wird, wenn der Slash-Befehl verwendet wird
function SlashCmdList.MythicKey(msg, editbox)
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