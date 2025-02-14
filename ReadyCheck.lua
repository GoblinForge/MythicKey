<<<<<<< Updated upstream
-- Initialisiere benötigte Bibliotheken und Variablen
local c = MkLib.c
local mkt = MkLib.mkt()

-- Erstelle das Hauptframe für den Ready Check
local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate")
=======
-- Erstelle das Hauptframe mit BackdropTemplate
local MythicKeyRdyFrame = CreateFrame("Frame", "MythicKeyRdyFrame", UIParent, "UIPanelDialogTemplate, BackdropTemplate")
>>>>>>> Stashed changes
MythicKeyRdyFrame:SetSize(200, 120)
MythicKeyRdyFrame:SetPoint("CENTER")
MythicKeyRdyFrame:SetMovable(true)
MythicKeyRdyFrame:EnableMouse(true)
MythicKeyRdyFrame:SetClampedToScreen(true)
MythicKeyRdyFrame:RegisterForDrag("LeftButton")
MythicKeyRdyFrame:SetScript("OnDragStart", MythicKeyRdyFrame.StartMoving)
MythicKeyRdyFrame:SetScript("OnDragStop", MythicKeyRdyFrame.StopMovingOrSizing)

<<<<<<< Updated upstream
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
=======
-- Setze das Backdrop für den Frame (neu notwendig in WoW 10.0+)
MythicKeyRdyFrame:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
    tile = true, tileSize = 16, edgeSize = 16,
    insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
MythicKeyRdyFrame:SetBackdropColor(0, 0, 0, 0.8)  -- Hintergrund auf schwarz setzen
MythicKeyRdyFrame:SetBackdropBorderColor(1, 1, 1, 1) -- Weiße Rahmenfarbe
>>>>>>> Stashed changes

-- Erstelle den Ready Check Button
local StartButton = CreateFrame("Button", "MythicKeyRdyStartButton", MythicKeyRdyFrame, "UIPanelButtonTemplate")
StartButton:SetSize(120, 25)
StartButton:SetPoint("TOP", 0, -30)
StartButton:SetText("Start Ready Check")
StartButton:SetScript("OnClick", function()
<<<<<<< Updated upstream
    print("MythicKey: Ready Check Button geklickt.")
    
    -- Überprüfe, ob der Spieler der Gruppenleiter ist
    if UnitIsGroupLeader("player") or UnitIsRaidLeader("player") then
        print("MythicKey: Du bist der Gruppenleiter. Ready Check wird gestartet.")
        DoReadyCheck()
        MythicKeyRdyFrame:Hide()
    else
        print("MythicKey: Du bist nicht der Gruppenleiter. Ready Check kann nicht gestartet werden.")
    end
=======
    print("MythicKey: Ready check initiated. Please accept.")
    DoReadyCheck()
    MythicKeyRdyFrame:Hide()
>>>>>>> Stashed changes
end)

-- Erstelle den Close Button
local CloseButton = CreateFrame("Button", "MythicKeyRdyCloseButton", MythicKeyRdyFrame, "UIPanelCloseButton")
CloseButton:SetPoint("TOPRIGHT", -5, -5)
<<<<<<< Updated upstream
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
=======
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
>>>>>>> Stashed changes
