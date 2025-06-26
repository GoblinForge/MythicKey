-- Initialisiere benötigte Bibliotheken und Variablen
local c = MkLib.c
local mkt = MkLib.mkt()

-- Erstelle das Hauptframe mit BackdropTemplate
local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate, BackdropTemplate")
MythicKeyRdyFrame:SetSize(200, 120)
MythicKeyRdyFrame:SetPoint("CENTER")
MythicKeyRdyFrame:SetMovable(true)
MythicKeyRdyFrame:EnableMouse(true)
MythicKeyRdyFrame:SetClampedToScreen(true)
MythicKeyRdyFrame:RegisterForDrag("LeftButton")
MythicKeyRdyFrame:SetScript("OnDragStart", MythicKeyRdyFrame.StartMoving)
MythicKeyRdyFrame:SetScript("OnDragStop", MythicKeyRdyFrame.StopMovingOrSizing)

-- Setze das Backdrop für den Frame (neu notwendig in WoW 10.0+)
MythicKeyRdyFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
MythicKeyRdyFrame:SetBackdropColor(0, 0, 0, 0.8)  -- Hintergrund auf schwarz setzen
MythicKeyRdyFrame:SetBackdropBorderColor(1, 1, 1, 1) -- Weiße Rahmenfarbe

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
    MythicKeyRdyFrame:Show()
end

-- Befehl zum Öffnen des MythicKey-Ready-Check-Fensters
SLASH_MythicKeyRdy1 = "/mkrdy"
SlashCmdList["MythicKeyRdy"] = function()
    OpenMythicKeyRdyFrame()
end

print("Slash-Befehl /mkrdy wurde registriert.")
MythicKeyRdyFrame:Hide()
print(":rdy wurde geladen.")
