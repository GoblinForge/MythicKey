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
MythicKeyRdyFrame:Hide() -- Initial versteckt

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
CloseButton:SetScript("OnClick", function() MythicKeyRdyFrame:Hide() end)

-- Funktion zum Öffnen des MythicKey-Ready-Check-Fensters
local function OpenMythicKeyRdyFrame()
    if IsInGroup() and not ChallengesKeystoneFrame:IsVisible() then
        MythicKeyRdyFrame:Show()
    else
        MythicKeyRdyFrame:Hide()
    end
end

-- Zentrales Event-Handling
local eventHandler = CreateFrame("Frame")
local events = {
    "GROUP_ROSTER_UPDATE",
    "PLAYER_ENTERING_WORLD",
    "CHALLENGE_MODE_START",
    "BAG_UPDATE_DELAYED",
    "CHAT_MSG_ADDON"
}

for _, event in ipairs(events) do
    eventHandler:RegisterEvent(event)
end

eventHandler:SetScript("OnEvent", function(self, event, ...)
    if event == "CHAT_MSG_ADDON" then
        local prefix, message, channel, sender = ...
        if prefix == "MythicKey" and message == "StartCountdown" then
            StartCountdown()
        end
    else
        OpenMythicKeyRdyFrame()
    end
end)

-- Slash-Befehl
SLASH_MythicKeyRdy1 = "/mkrdy"
SlashCmdList["MythicKeyRdy"] = OpenMythicKeyRdyFrame

-- Countdown-Fenster
local CountdownFrame = CreateFrame("Frame", "MythicKeyCountdownFrame", UIParent, "BackdropTemplate")
CountdownFrame:SetSize(200, 100)
CountdownFrame:SetPoint("CENTER")
CountdownFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true, tileSize = 32, edgeSize = 32,
    insets = { left = 8, right = 8, top = 8, bottom = 8 }
})
CountdownFrame:SetBackdropColor(0, 0, 0, 0.8)
CountdownFrame:Hide()

local CountdownText = CountdownFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
CountdownText:SetPoint("CENTER")
CountdownText:SetText("")
CountdownText:SetTextColor(1, 1, 1)

local CountdownDuration = 10 -- Dauer des Countdowns in Sekunden

local function StartCountdown()
    local endTime = GetTime() + CountdownDuration
    CountdownFrame:Show()
    CountdownFrame:SetScript("OnUpdate", function()
        local remainingTime = endTime - GetTime()
        if remainingTime > 0 then
            CountdownText:SetText(math.ceil(remainingTime))
        else
            CountdownText:SetText("Go!")
            C_Timer.After(1, function() CountdownFrame:Hide() end)
            CountdownFrame:SetScript("OnUpdate", nil)
        end
    end)
end

-- Verwende diese Funktion, um den Countdown zu starten
function StartReadyCheckCountdown()
    StartCountdown()
end
