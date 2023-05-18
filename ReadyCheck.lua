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
    MythicKeyRdyFrame:Show()
end

-- Befehl zum Öffnen des MythicKey-Ready-Check-Fensters
SLASH_MythicKeyRdy1 = "/mkrdy"
SLASH_MythicKeyRdy2 = "/rdy"

SlashCmdList["MythicKeyRdy"] = function()
    OpenMythicKeyRdyFrame()
end

-- Verstecke das MythicKey-Ready-Check-Fenster beim Laden des Addons oder nach einem Reload
local function HideMythicKeyRdyFrame()
    if MythicKeyRdyFrame:IsShown() then
        MythicKeyRdyFrame:Hide()
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, addon)
    if addon == "MythicKey" then
        HideMythicKeyRdyFrame()
    end
end)
