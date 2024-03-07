local c = MkLib.c
local mkt = MkLib.mkt()

-- Erstelle das Hauptframe
local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate")
MythicKeyRdyFrame:SetSize(200, 120)
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
StartButton:SetSize(120, 25)
StartButton:SetPoint("TOP", 0, -30)
StartButton:SetText("Start Ready Check")
StartButton:SetScript("OnClick", function()
    print("MythicKey: Ready check initiated. Please accept.")
    DoReadyCheck()
    MythicKeyRdyFrame:Hide()
end)

-- Erstelle den Close Button
-- Erstelle den Close Button
local CloseButton = CreateFrame("Button", "MythicKeyRdyCloseButton", MythicKeyRdyFrame, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", -5, -5)
CloseButton:SetScript("OnClick", function() MythicKeyRdyFrame:Hide() end)

-- Funktion zum Öffnen des MythicKey-Ready-Check-Fensters
local function OpenMythicKeyRdyFrame()
    MythicKeyRdyFrame:Show()
end

-- Überwache das OnShow-Event des Mythic+ Schlüsselstein-Fensters
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(1, function()
            if ChallengesKeystoneFrame and ChallengesKeystoneFrame:IsVisible() then
                OpenMythicKeyRdyFrame()
            end
        end)
        local TrigerEvenTPlayerPrint = c("50ff45", ": Event 'PLAYER_ENTERING_WORLD' ausgelöst") 
        print(mkt, TrigerEvenTPlayerPrint)
    end
end)

-- Befehl zum Öffnen des MythicKey-Ready-Check-Fensters
SLASH_MythicKeyRdy1 = "/mkrdy"
SlashCmdList["MythicKeyRdy"] = function()
    OpenMythicKeyRdyFrame()
end
print("Slash-Befehl /mkrdy wurde registriert.")
--

print(mkt, ":rdy wurde geladen.")
