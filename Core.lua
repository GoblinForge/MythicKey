local c = MkLib.c
local mkt = MkLib.mkt
-- Registriert einen Slash-Befehl für dein Addon
SLASH_MythicKey1 = "/mk"

-- Funktion, die aufgerufen wird, wenn der Slash-Befehl verwendet wird
function SlashCmdList.MythicKey(msg, editbox)
    -- msg enthält den Text, der nach dem Befehl eingegeben wurde.
    -- Hier könntest du unterschiedliche Aktionen basierend auf 'msg' implementieren.
    local SpacerText = c("50ff45", "====================")
    local MkCmmandlistHelp = c("00beef", "MythicKey SlashCmdList / Help:")
    -- Beispiel: Zeige eine Liste von Befehlen, wenn keine spezifischen Argumente gegeben sind.
    if msg == "" then
        print(mkt)
        print(SpacerText)
        print(MkCmmandlistHelp)
        print(SpacerText)
        print("/mk - commandlist ")
        print("/mkrdy - Open window for start ReadyCheck form MythicKeyRdy + Pull timer")
        print(SpacerText)
        -- Füge hier weitere Befehle hinzu
    elseif msg == "help" then
        print("Test1 Help:")
        print("/mk help - Zeigt diese Hilfe an.")
        -- Füge hier Hilfe für spezifische Befehle hinzu
    end
end

