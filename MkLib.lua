MkLib = {}

-- Funktion zur Vereinfachung der Farbcodierung
function MkLib.c(color, text)
    return "|cFF" .. color .. text .. "|r"
end
-- Vereinfachung
-- code beispele: local myText = c("000000", "MK: ") .. c("FFA500", "Dein Text hier")

function MkLib.mkt()
    return MkLib.c("00beef", "MythicKey")
end