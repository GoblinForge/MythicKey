local IDs = {[138019] = 1, [151086] = 1, [158923] = 1, [180653] = 1}

local AK = CreateFrame("Frame")
AK:RegisterEvent("ADDON_LOADED")
AK:SetScript("OnEvent", function(self, event, addon)
    -- Überprüfe, ob das geladene Addon nicht "Blizzard_ChallengesUI" ist, und beende das Skript in diesem Fall
    if (addon ~= "Blizzard_ChallengesUI") then
        return
    end

    if ChallengesKeystoneFrame then
        local Frame = ChallengesKeystoneFrame

        -- Hänge ein Skript an das OnShow-Event von ChallengesKeystoneFrame
        Frame:HookScript("OnShow", function()
            -- Deklariere Variablen
            local ID, Class, SubClass
            local foundKeystone = false

            -- Iteriere über die Taschen des Spielers
            for bag = 0, NUM_BAG_FRAMES do
                -- Iteriere über die Slots in der aktuellen Tasche
                for slot = 1, C_Container.GetContainerNumSlots(bag) do
                    -- Erhalte die ID des Gegenstands im aktuellen Slot
                    ID = C_Container.GetContainerItemID(bag, slot)

                    -- Überprüfe, ob eine ID vorhanden ist
                    if ID then
                        -- Erhalte die Klassen- und Unterklasseinformationen des Gegenstands
                        Class, SubClass = select(12, GetItemInfo(ID))

                        -- Überprüfe, ob die ID in der Tabelle vorhanden ist oder der Gegenstand eine Waffe ist
                        if (IDs[ID] or (Class == 5 and SubClass == 1)) then
                            -- Verwende den Gegenstand aus der Tasche
                            C_Container.UseContainerItem(bag, slot)

                            -- Lege den Schlüssel automatisch in den Schlüsselslot
                            if ChallengesKeystoneFrame.SlotContainer.slot then
                                ChallengesKeystoneFrame.SlotContainer.slot.keyStoneID = ID
                                ChallengesKeystoneFrame.SlotContainer.slot:SetAttribute("type", "macro")
                                ChallengesKeystoneFrame.SlotContainer.slot:SetAttribute("macrotext", "/use item:" .. ID .. "\n/use [@player] " .. ID)
                            end

                            -- Markiere den gefundenen Schlüsselstein
                            foundKeystone = true

                            break
                        end
                    end
                end

                -- Beende die Schleife, wenn ein Schlüsselstein gefunden wurde
                if foundKeystone then
                    break
                end
            end
        end)

        -- Überprüfe, ob das Frame nicht beweglich ist
        if (not Frame:IsMovable()) then
            -- Mache das Frame beweglich und klemme es am Bildschirmrand fest
            Frame:SetMovable(true)
            Frame:SetClampedToScreen(true)
            -- Erlaube das Ziehen des Frames mit der linken Maustaste
            Frame:RegisterForDrag("LeftButton")
            Frame:SetScript("OnDragStart", Frame.StartMoving)
            Frame:SetScript("OnDragStop", Frame.StopMovingOrSizing)
        end

        -- Entregistriere das Event, da das Addon erfolgreich geladen wurde
        self:UnregisterEvent(event)
    end
end)
