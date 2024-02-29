local IDs = {[138019] = true, [151086] = true, [158923] = true, [180653] = true}
local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:RegisterEvent("BAG_UPDATE")

local function insertKeystone()
    local found = false
    for bag = 0, NUM_BAG_FRAMES do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local ID = C_Container.GetContainerItemID(bag, slot)
            if ID and IDs[ID] then
                C_Container.UseContainerItem(bag, slot)
                C_Timer.After(0.5, function()
                    print("MythicKey: Keystone inserted and ready for start!")
                end)
                found = true
                break
            end
        end
        if found then break end
    end

    if not found then
        print("MythicKey: No valid Mythic Keystone found in bags.")
    end
end

local function onEvent(self, event, addon)
    if event == "ADDON_LOADED" and addon == "Blizzard_ChallengesUI" and ChallengesKeystoneFrame then
        ChallengesKeystoneFrame:HookScript("OnShow", insertKeystone)
        if not ChallengesKeystoneFrame:IsMovable() then
            ChallengesKeystoneFrame:SetMovable(true)
            ChallengesKeystoneFrame:SetClampedToScreen(true)
            ChallengesKeystoneFrame:RegisterForDrag("LeftButton")
            ChallengesKeystoneFrame:SetScript("OnDragStart", ChallengesKeystoneFrame.StartMoving)
            ChallengesKeystoneFrame:SetScript("OnDragStop", ChallengesKeystoneFrame.StopMovingOrSizing)
        end
    elseif event == "BAG_UPDATE" then
        -- Automatisches Einfügen versuchen, wenn sich der Tascheninhalt ändert
        -- Dies könnte optimiert werden, um nur bei Bedarf zu prüfen.
        insertKeystone()
    end
end

AK:SetScript("OnEvent", onEvent)