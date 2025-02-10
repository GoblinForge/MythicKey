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
