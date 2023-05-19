local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate")
MythicKeyRdyFrame:SetSize(220, 150)
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

local BackgroundTexture = MythicKeyRdyFrame:CreateTexture(nil, "BACKGROUND")
BackgroundTexture:SetAllPoints()
BackgroundTexture:SetColorTexture(0.1, 0.1, 0.1, 0.8) -- Dunkelgraue Hintergrundfarbe

local TitleText = MythicKeyRdyFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
TitleText:SetPoint("TOP", 0, -10)
TitleText:SetText("MythicKey Ready Check")

local StartButton = CreateFrame("Button", "MythicKeyRdyStartButton", MythicKeyRdyFrame, "UIPanelButtonTemplate")
StartButton:SetSize(160, 30)
StartButton:SetPoint("TOP", 0, -40)
StartButton:SetText("Start Ready Check")
StartButton:SetScript("OnClick", function()
    print("MythicKey: Ready check initiated. Please accept.")
    DoReadyCheck()
    MythicKeyRdyFrame:Hide()
end)

local CloseButton = CreateFrame("Button", "MythicKeyRdyCloseButton", MythicKeyRdyFrame, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", -5, -5)
CloseButton:SetScript("OnClick", function()
    MythicKeyRdyFrame:Hide()
end)

local function HideMythicKeyRdyFrame()
    MythicKeyRdyFrame:Hide()
end

function OpenMythicKeyRdyFrame()
    MythicKeyRdyFrame:Show()
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "Blizzard_ChallengesUI" then
            hooksecurefunc("ChallengesKeystoneFrame_OnShow", function()
                OpenMythicKeyRdyFrame()
            end)
            print("MythicKey: Addon loaded")
        elseif addonName == "MythicKey" then
            HideMythicKeyRdyFrame()
            print("MythicKey: Addon loaded")
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(1, function()
            if ChallengesKeystoneFrame and ChallengesKeystoneFrame:IsVisible() then
                OpenMythicKeyRdyFrame()
            end
        end)
        print("MythicKey: Event 'PLAYER_ENTERING_WORLD' ausgelöst")
    end
end)

SLASH_MythicKeyRdy1 = "/mkrdy"
SlashCmdList["MythicKeyRdy"] = function()
    OpenMythicKeyRdyFrame()
end
