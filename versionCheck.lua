--[[local socket = require("socket")
local http = require("socket.http")
local ltn12 = require("ltn12")
local json = require("json")

local githubRepo = "https://api.github.com/repos/2Luna/MythicKey/releases/latest"

local function getVersionFromGitHub()
    local response = {}
    local _, status = http.request{
        url = githubRepo,
        headers = {
            ["User-Agent"] = "Mozilla/5.0",  -- Setze einen User-Agent, um GitHub-Anfragen zu ermöglichen
            ["Accept"] = "application/vnd.github.v3+json"
        },
        sink = ltn12.sink.table(response)
    }

    if status == 200 then
        local jsonStr = table.concat(response)
        local data = json.decode(jsonStr)
        local version = data.tag_name
        return version
    else
        return nil
    end
end

local function compareVersions(localVersion, githubVersion)
    -- Führe deinen Versionsvergleich durch und gib entsprechende Meldungen aus
    if localVersion == githubVersion then
        print("Deine Version ist aktuell.")
    elseif localVersion < githubVersion then
        print("Es ist eine neue Version verfügbar. Bitte aktualisiere dein Addon.")
    elseif localVersion > githubVersion then
        print("Deine Version ist neuer als die auf GitHub verfügbare Version.")
    else
        print("Versionsvergleich fehlgeschlagen.")
    end
end

-- Beispielhafter Aufruf des Versionsvergleichs
local localVersion = "1.0" -- Passe deine lokale Version an
local githubVersion = getVersionFromGitHub()

if githubVersion then
    compareVersions(localVersion, githubVersion)
else
    print("Fehler beim Abrufen der Version von GitHub.")
end
]]