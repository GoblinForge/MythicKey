local c = MkLib.c
local cc = MkLib.cc
local mkt = MkLib.mkt()

local KA = CreateFrame("Frame")
local KEY_IDS = {[138019] = true, [151086] = true, [158923] = true, [180653] = true}
local lastKeyID

local function FindKeystone()
    for bag = 0, NUM_BAG_FRAMES do
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            local id = C_Container.GetContainerItemID(bag, slot)
            if id and KEY_IDS[id] then
                return id, C_Container.GetContainerItemLink(bag, slot)
            end
        end
    end
end

local function Announce(id, link)
    if link then
        SendChatMessage(mkt .. ": " .. link, "PARTY")
    else
        SendChatMessage(mkt .. ": Keystone acquired", "PARTY")
    end
end

KA:SetScript("OnEvent", function(self, event)
    MythicKeyDB = MythicKeyDB or {keyAnnouncerEnabled = true}
    if not MythicKeyDB.keyAnnouncerEnabled then return end

    local id, link = FindKeystone()
    if id and id ~= lastKeyID then
        Announce(id, link)
        lastKeyID = id
    end
end)

KA:RegisterEvent("PLAYER_LOGIN")
KA:RegisterEvent("BAG_UPDATE_DELAYED")

SLASH_MythicKeyAnnouncer1 = "/mkann"
SlashCmdList["MythicKeyAnnouncer"] = function()
    MythicKeyDB = MythicKeyDB or {keyAnnouncerEnabled = true}
    MythicKeyDB.keyAnnouncerEnabled = not MythicKeyDB.keyAnnouncerEnabled
    local state = MythicKeyDB.keyAnnouncerEnabled and c("00ff00", "aktiviert") or c("ff0000", "deaktiviert")
    print(mkt .. ": Key Announcer " .. state .. ".")
end

print(mkt .. ": Key Announcer geladen.")
