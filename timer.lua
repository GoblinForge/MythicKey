-- Initialisiere das Hauptframe für den Timer
local MythicTimerFrame = CreateFrame("Frame", "MythicTimerFrame", UIParent)
MythicTimerFrame:SetSize(200, 30)
MythicTimerFrame:SetPoint("CENTER")
MythicTimerFrame:Hide() -- Verstecke es zunächst

-- Erstelle den Text für die Upgrade-Stufen
local UpgradeText = MythicTimerFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
UpgradeText:SetAllPoints()

-- Funktion zum Aktualisieren des Upgrade-Texts
local function UpdateUpgradeText(timerValue)
    local upgradeLevel
    if timerValue >= 1800 then
        upgradeLevel = 3
    elseif timerValue >= 1500 then
        upgradeLevel = 2
    elseif timerValue >= 1200 then
        upgradeLevel = 1
    else
        upgradeLevel = 0
    end
    
    UpgradeText:SetText("Upgrade Level: " .. upgradeLevel)
end

-- Event-Handling für effizientere Überprüfungen
MythicTimerFrame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" or event == "CHALLENGE_MODE_START" then
        self:Show()
        self.timeSinceLastUpdate = 0
    elseif event == "CHALLENGE_MODE_COMPLETED" or event == "PLAYER_LEAVING_WORLD" then
        self:Hide()
    end
end)
MythicTimerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
MythicTimerFrame:RegisterEvent("CHALLENGE_MODE_START")
MythicTimerFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
MythicTimerFrame:RegisterEvent("PLAYER_LEAVING_WORLD")

-- OnUpdate mit Debouncing
MythicTimerFrame:SetScript("OnUpdate", function(self, elapsed)
    self.timeSinceLastUpdate = (self.timeSinceLastUpdate or 0) + elapsed
    if self.timeSinceLastUpdate >= 1 then -- Update jede Sekunde
        local _, _, _, _, _, _, _, instanceMapID = GetInstanceInfo()
        
        if instanceMapID and instanceMapID > 0 then
            local _, _, _, _, timeRemaining = GetWorldElapsedTime(1) -- Erste Timer-ID verwenden
            if timeRemaining and timeRemaining > 0 then
                UpdateUpgradeText(timeRemaining)
            end
        end
        
        self.timeSinceLastUpdate = 0
    end
end)
