<<<<<<< Updated upstream
local ReagentClass = Enum.ItemClass.Reagent
local KeystoneClass = Enum.ItemClass.Keystone

local GetContainerItemID = C_Container.GetContainerItemID
local GetContainerNumSlots = C_Container.GetContainerNumSlots

local function AutoInsertKeystone()
    for bag = 0, NUM_BAG_FRAMES do
        for slot = 1, GetContainerNumSlots(bag) do
            local itemID = GetContainerItemID(bag, slot)

            if itemID then
                local itemClass, itemSubClass = select(12, GetItemInfo(itemID))

                if (itemClass == ReagentClass and itemSubClass == KeystoneClass) then
                    C_Container.UseContainerItem(bag, slot)
                    C_Timer.After(0.5, function()
                        print("MythicKey: Keystone inserted and ready for start!")
                        DoReadyCheck()
                    end)
                    return
                end
            end
        end
    end
end

local function OnEvent(self, event, addon)
    if addon ~= "Blizzard_ChallengesUI" then
        return
    end

    local frame = ChallengesKeystoneFrame

    if not frame then
        return
    end

    frame:HookScript("OnShow", AutoInsertKeystone)

    if not frame:IsMovable() then
        frame:SetMovable(true)
        frame:SetClampedToScreen(true)
        frame:RegisterForDrag("LeftButton")
        frame:SetScript("OnDragStart", frame.StartMoving)
        frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
    end

    self:UnregisterEvent(event)
end

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", OnEvent)
=======
local c = MkLib.c
local cc = MkLib.cc
local coloredText = MkLib.coloredText
local mkt = MkLib.mkt()
local IDs = {[138019] = 1, [151086] = 1, [158923] = 1, [180653] = 1}
local AK = CreateFrame("Frame")

AK:RegisterEvent("ADDON_LOADED")
AK:RegisterEvent("PLAYER_LOGIN")

AK:SetScript("OnEvent", function(self, event, addon)
    if event == "ADDON_LOADED" and addon == "Blizzard_ChallengesUI" then
        -- Wenn das Challenges UI geladen wurde, den Frame Hook setzten
        if ChallengesKeystoneFrame then
            AK:HookKeystoneFrame()
        else
            print("Fehler: ChallengesKeystoneFrame nicht gefunden!")
        end
    elseif event == "PLAYER_LOGIN" then
        -- Nach Login prüfen, ob das Ui geladen wurde
        if IsAddOnLoaded("Blizzard_ChallengesUI") then
            AK:HookKeystoneFrame()
        end
    end
end)

function AK:HookKeystoneFrame()
    local Frame = ChallengesKeystoneFrame
    print("ChallengesKeystoneFrame gefunden und Hook gesetzt!") -- Debugging

    Frame:HookScript("OnShow", function()
        local ID, Class, SubClass
        for bag = 0, NUM_BAG_FRAMES do
            for slot = 1, C_Container.GetContainerNumSlots(bag) do
                ID = C_Container.GetContainerItemID(bag, slot)

                if ID then
                    --print("Gefundenes Item:", ID)
                    Class, SubClass = select(12, GetItemInfo(ID))

                    if IDs[ID] or (Class == 5 and SubClass == 1) then
                        print("Versuche, Keystone zu benutzen:", ID)
                        C_Container.UseContainerItem(bag, slot)

                        -- Warte 0.5 Sekunden, befor das Ready-Check-Fenster geöffnet wird
                        C_Timer.After(0.5, function ()
                            -- Sende eine Chat-Nachricht, das der Keystone eingelegt wurde
                            print(mkt,": Keystone inserted and ready for start!")
                            -- Startet den Rdy Check
                            DoReadyCheck()
                        end)
                        return
                    end
                end
            end
        end
    end)

    if not Frame:IsMovable() then
        Frame:SetMovable(true)
        Frame:SetClampedToScreen(true)
        Frame:RegisterForDrag("LeftButton")
        Frame:SetScript("OnDragStart", Frame.StartMoving)
        Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
    end
end  

print(mkt,":autokey wurde geladen.")
>>>>>>> Stashed changes
