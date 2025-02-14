local addonName, _ = ...

-- Erstellt das Hauptframe für das Addon
local frame = CreateFrame("Frame", "CountdownTestFrame", UIParent, "UIPanelDialogTemplate")
frame:SetSize(200, 100)
frame:SetPoint("CENTER")
frame:SetMovable(true)
frame:EnableMouse(true)
frame:RegisterForDrag("LeftButton")
frame:SetScript("OnDragStart", frame.StartMoving)
frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
frame:SetFrameStrata("HIGH")

-- Erstellt den Countdown-Button
local button = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
button:SetSize(120, 30)
button:SetPoint("CENTER", 0, 0)
button:SetText("Start Countdown")

local timerRunning = false
local countdownTimer

button:SetScript("OnClick", function(self)
    if not IsInGroup() then
        print("|cffff0000[Countdown]:|r Du bist nicht in einer Gruppe!")
        return
    end

    if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
        if not timerRunning then
            -- Startet den Blizzard-Countdown
            C_PartyInfo.DoCountdown(5)
            button:SetText("Stop Countdown")
            timerRunning = true

            -- Fallback: Falls Blizzard-Countdown nicht funktioniert, machen wir einen eigenen Timer
            local counter = 5
            countdownTimer = C_Timer.NewTicker(1, function()
                if counter > 0 then
                    SendChatMessage(tostring(counter) .. "...", IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
                    counter = counter - 1
                else
                    SendChatMessage("Los geht’s!", IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
                    countdownTimer:Cancel()
                    countdownTimer = nil
                    timerRunning = false
                    button:SetText("Start Countdown")
                end
            end, 5)
        else
            -- Bricht den Countdown richtig ab
            C_PartyInfo.CancelCountdown()
            button:SetText("Start Countdown")
            timerRunning = false

            -- Falls unser eigener Timer läuft, stoppen wir ihn auch
            if countdownTimer then
                countdownTimer:Cancel()
                countdownTimer = nil
                SendChatMessage("Countdown abgebrochen!", IsInGroup(LE_PARTY_CATEGORY_HOME) and "PARTY" or "SAY")
            end
        end
    else
        print("|cffff0000[Countdown]:|r Nur der Gruppenleiter kann den Countdown starten oder stoppen!")
    end
end)

-- Zeigt das Fenster nur, wenn du in einer Gruppe bist
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:SetScript("OnEvent", function(self, event)
    if IsInGroup() then
        frame:Show()
    else
        frame:Hide()
    end
end)

-- Standardmäßig das Fenster ausblenden
frame:Hide()

-- Slash-Befehl für einfaches Öffnen/Schließen
SLASH_COUNTDOWNTEST1 = "/tcountdown"
SLASH_COUNTDOWNTEST2 = "/tcdt"

SlashCmdList["COUNTDOWNTEST"] = function()
    if CountdownTestFrame:IsShown() then
        CountdownTestFrame:Hide()
    else
        CountdownTestFrame:Show()
    end
end

