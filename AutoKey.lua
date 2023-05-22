local IDs = {[138019] = 1, [151086] = 1, [158923] = 1, [180653] = 1}
local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
    if addon ~= "Blizzard_ChallengesUI" then
        return
    end

    if ChallengesKeystoneFrame then
        local Frame = ChallengesKeystoneFrame
        Frame:HookScript("OnShow", function()
            local ID, Class, SubClass
            for bag = 0, NUM_BAG_FRAMES do
                for slot = 1, C_Container.GetContainerNumSlots(bag) do
                    ID = C_Container.GetContainerItemID(bag, slot)

                    if ID then
                        Class, SubClass = select(12, GetItemInfo(ID))

                        if IDs[ID] or (Class == 5 and SubClass == 1) then
                            C_Container.UseContainerItem(bag, slot)
                            -- Warte 0.5 Sekunden, bevor das Ready-Check-Fenster geöffnet wird
                            C_Timer.After(0.5, function()
                                -- Sende eine Chat-Nachricht, dass der Schlüsselstein eingelegt wurde
                                print("MythicKey: Keystone inserted and ready for start!")
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
end)
