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
                            -- Sende eine Nachricht im Chat, dass der Schlüsselstein eingelegt wurde
                            print("Keystone inserted and ready for start!")
                            -- Führe einen Ready-Check mit einer Verzögerung von 0,5 Sekunden aus
                            C_Timer.After(0.5, function()
                                -- Sende eine Nachricht im Chat, dass der Ready-Check gesendet wurde
                                SendChatMessage("Ready check initiated. Please accept.", "PARTY")
                                -- Führe den Ready-Check aus
                                DoReadyCheck()
                                -- Warte auf die READY_CHECK_FINISHED-Nachricht, um festzustellen, ob alle bereit sind
                                AK:RegisterEvent("READY_CHECK_FINISHED")
                            end)
                            return
                        end
                    end
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

        -- Hänge ein Skript an das READY_CHECK_FINISHED
        AK:RegisterEvent("READY_CHECK_FINISHED")
    end
end)

-- Erstelle ein Skript, das auf das READY_CHECK_FINISHED-Event reagiert
AK:SetScript("OnEvent", function(self, event)
    -- Überprüfe, ob das Event READY_CHECK_FINISHED ausgelöst wurde
    if event == "READY_CHECK_FINISHED" then
        -- Überprüfe, ob alle Spieler bereit sind
        local allReady = true
        for i = 1, GetNumGroupMembers() do
            local _, _, _, _, _, readyStatus = GetRaidRosterInfo(i)
            if readyStatus == nil or readyStatus == 0 then
                allReady = false
                break
            end
        end

        -- Sende eine Nachricht im Chat, ob alle Spieler bereit sind oder nicht
        if allReady then
            print("Everyone is ready!")
        else
            print("Not everyone is ready!")
        end

        -- Unregister das READY_CHECK_FINISHED-Event, um eine erneute Registrierung zu vermeiden
        AK:UnregisterEvent("READY_CHECK_FINISHED")
    end
end)

