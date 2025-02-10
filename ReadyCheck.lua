-- Initialisiere benötigte Bibliotheken und Variablen
local c = MkLib.c
local mkt = MkLib.mkt()

-- Erstelle das Hauptframe für den Ready Check
local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate")
MythicKeyRdyFrame:SetSize(200, 120)
MythicKeyRdyFrame:SetPoint("CENTER")
MythicKeyRdyFrame:SetMovable(true)
MythicKeyRdyFrame:EnableMouse(true)
MythicKeyRdyFrame:SetClampedToScreen(true)
MythicKeyRdyFrame:RegisterForDrag("LeftButton")
MythicKeyRdyFrame:SetScript("OnDragStart", MythicKeyRdyFrame.StartMoving)
MythicKeyRdyFrame:SetScript("OnDragStop", MythicKeyRdyFrame.StopMovingOrSizing)

-- Optional: Setze die Rahmenfarbe
MythicKeyRdyFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
    tile = true,
    tileSize = 32,
    edgeSize = 32,
    insets = { left = 11, right = 12, top = 12, bottom = 11 },
})
MythicKeyRdyFrame:SetBackdropBorderColor(0, 0, 0)

-- Erstelle den Ready Check Button
local StartButton = CreateFrame("Button", "MythicKeyRdyStartButton", MythicKeyRdyFrame, "UIPanelButtonTemplate")
StartButton:SetSize(120, 25)
StartButton:SetPoint("TOP", 0, -30)
StartButton:SetText("Start Ready Check")
StartButton:SetScript("OnClick", function()
    print("MythicKey: Ready Check Button geklickt.")
    
    -- Überprüfe, ob der Spieler der Gruppenleiter ist
    if UnitIsGroupLeader("player") or UnitIsRaidLeader("player") then
        print("MythicKey: Du bist der Gruppenleiter. Ready Check wird gestartet.")
        DoReadyCheck()
        MythicKeyRdyFrame:Hide()
    else
        print("MythicKey: Du bist nicht der Gruppenleiter. Ready Check kann nicht gestartet werden.")
    end
end)

-- Erstelle den Close Button
local CloseButton = CreateFrame("Button", "MythicKeyRdyCloseButton", MythicKeyRdyFrame, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", -5, -5)
CloseButton:SetScript("OnClick", function()
    MythicKeyRdyFrame:Hide()
end)

-- Funktion zum Öffnen des MythicKey-Ready-Check-Fensters
local function OpenMythicKeyRdyFrame()
    print("MythicKey: Öffne Ready Check Fenster.")
    MythicKeyRdyFrame:Show()
end

-- Erstelle das Pull-Timer Frame
local PullTimerFrame = CreateFrame("Frame", "MythicKeyPullTimerFrame", UIParent, "UIPanelDialogTemplate")
PullTimerFrame:SetSize(200, 150)
PullTimerFrame:SetPoint("CENTER")
PullTimerFrame:SetMovable(true)
PullTimerFrame:EnableMouse(true)
PullTimerFrame:SetClampedToScreen(true)
PullTimerFrame:RegisterForDrag("LeftButton")
PullTimerFrame:SetScript("OnDragStart", PullTimerFrame.StartMoving)
PullTimerFrame:SetScript("OnDragStop", PullTimerFrame.StopMovingOrSizing)
PullTimerFrame:Hide()

-- Setze das Backdrop für den Pull-Timer Frame
PullTimerFrame:SetBackdrop({
    bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
    edgeFile = "Interface\\DialogFrame\\UI-Dia
