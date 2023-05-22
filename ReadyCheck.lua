-- Erstelle das Hauptframe
local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate")
MythicKeyRdyFrame:SetSize(150, 80)
MythicKeyRdyFrame:SetPoint("CENTER")
MythicKeyRdyFrame:SetMovable(true)
MythicKeyRdyFrame:EnableMouse(true)
MythicKeyRdyFrame:SetClampedToScreen(true)
MythicKeyRdyFrame:RegisterForDrag("LeftButton")
MythicKeyRdyFrame:SetScript("OnDragStart", MythicKeyRdyFrame.StartMoving)
MythicKeyRdyFrame:SetScript("OnDragStop", MythicKeyRdyFrame.StopMovingOrSizing)
MythicKeyRdyFrame:SetScript("OnShow", function(self)
    self:SetBackdropBorderColor(0, 0, 0) -- Setze die Rahmenfarbe auf Schwarz
end)

-- Erstelle den Ready Check Button
local StartButton = CreateFrame("Button", "MythicKeyRdyStartButton", MythicKeyRdyFrame, "UIPanelButtonTemplate")
StartButton:SetSize(120, 25)
StartButton:SetPoint("TOP", 0, -30)
StartButton:SetText("Start Ready Check")
StartButton:SetScript("OnClick", function()
    print("MythicKey: Ready check initiated. Please accept.")
    DoReadyCheck()
    MythicKeyRdyFrame:Hide()
end)

-- Erstelle den Close Button
local CloseButton = CreateFrame("Button", "MythicKeyRdyCloseButton", MythicKeyRdyFrame, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", -5, -5)
CloseButton:SetScript("OnClick", function()
    MythicKeyRdyFrame:Hide()
end)

-- Funktion zum Öffnen des MythicKey-Ready-Check-Fensters
local function OpenMythicKeyRdyFrame()
    if IsInGroup() then
        MythicKeyRdyFrame:Show()
    end
end

-- Überwache die Events, um das MythicKey-Ready-Check-Fenster zu öffnen
local frame = CreateFrame("Frame")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("CHALLENGE_MODE_START")
frame:RegisterEvent("BAG_UPDATE_DELAYED")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
        OpenMythicKeyRdyFrame()
    elseif event == "CHALLENGE_MODE_START" or event == "BAG_UPDATE_DELAYED" then
        if IsInGroup() and ChallengesKeystoneFrame and ChallengesKeystoneFrame:IsVisible() then
            OpenMythicKeyRdyFrame()
        end
    end
end)

-- Befehl zum Öffnen des MythicKey-Ready-Check-Fensters
SLASH_MythicKeyRdy1 = "/mkrdy"
SlashCmdList["MythicKeyRdy"] = function()
    OpenMythicKeyRdyFrame()
end

-- Countdown-Fenster
local CountdownFrame = CreateFrame("Frame", "MythicKeyCountdownFrame", UIParent, "BackdropTemplate")
CountdownFrame:SetSize(200, 100)
CountdownFrame:SetPoint("CENTER")
CountdownFrame:SetBackdrop({
    bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
    edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    tile = true,
    tileSize = 16,
    edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
CountdownFrame:SetBackdropColor(0, 0, 0, 0.8)
CountdownFrame:Hide()

local CountdownText = CountdownFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
CountdownText:SetPoint("CENTER")
CountdownText:SetText("")
CountdownText:SetTextColor(1, 1, 1)

local CountdownDuration = 10 -- Dauer des Countdowns in Sekunden

local function StartCountdown()
    local startTime = GetTime()
    
    CountdownFrame:SetScript("OnUpdate", function()
        local elapsedTime = GetTime() - startTime
        local remainingTime = CountdownDuration - elapsedTime
        
        if remainingTime > 0 then
            CountdownText:SetText(string.format("%.0f", remainingTime))
        else
            CountdownText:SetText("0")
            CountdownFrame:SetScript("OnUpdate", nil)
            CountdownFrame:Hide()
        end
    end)
    
    CountdownFrame:Show()
end

-- Verwende diese Funktion, um den Countdown zu starten
function StartReadyCheckCountdown()
    if IsAddOnLoaded("MythicKey") then
        StartCountdown()
    else
        local playerGUID = UnitGUID("player")
        C_ChatInfo.SendAddonMessage("MythicKey", "StartCountdown", "WHISPER", playerGUID)
    end
end

-- Überwache die Addon-Nachrichten, um den Countdown zu starten
frame:RegisterEvent("CHAT_MSG_ADDON")
frame:SetScript("OnEvent", function(self, event, prefix, message, channel, sender)
    if prefix == "MythicKey" and message == "StartCountdown" then
        StartCountdown()
    end
end)
