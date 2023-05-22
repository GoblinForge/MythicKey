-- Erstelle das Hauptframe für den Timer
local MythicTimerFrame = CreateFrame("Frame", "MythicTimerFrame", UIParent)
MythicTimerFrame:SetSize(200, 30)
MythicTimerFrame:SetPoint("CENTER")

-- Erstelle den Text, der die Upgrade-Stufen anzeigt
local UpgradeText = MythicTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
UpgradeText:SetAllPoints()
UpgradeText:SetText("")

-- Funktion zum Aktualisieren des Upgrade-Texts basierend auf dem aktuellen Timer-Wert
local function UpdateUpgradeText(timerValue)
    local upgradeLevel = 0
    
    -- Überprüfe den Timer-Wert und setze die Upgrade-Stufe entsprechend
    if timerValue >= 1800 then
        upgradeLevel = 3
    elseif timerValue >= 1500 then
        upgradeLevel = 2
    elseif timerValue >= 1200 then
        upgradeLevel = 1
    end
    
    UpgradeText:SetText("Upgrade Level: " .. upgradeLevel)
end

-- Überwache das OnUpdate-Event für den Timer
local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function(self, elapsed)
    local _, _, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
    
    -- Überprüfe, ob der Spieler sich in einem Mythic+ Dungeon befindet
    if instanceMapID and instanceMapID > 0 then
        local _, _, _, _, timeRemaining = GetWorldElapsedTime(instanceMapID)
        
        -- Überprüfe, ob ein Timer-Wert vorhanden ist und aktualisiere den Upgrade-Text
        if timeRemaining then
            UpdateUpgradeText(timeRemaining)
        end
    end
end)
