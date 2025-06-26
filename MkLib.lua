MkLib = {}

-- Funktion zur Vereinfachung der Farbcodierung
function MkLib.c(color, text)
    return "|cFF" .. color .. text .. "|r"
end

-- Funktion für zwei farbige Segmente (als Beispiel)
function MkLib.cc(color1, text1, color2, text2)
    return "|cFF" .. color1 .. text1 .. "|r" .. "|cFF" .. color2 .. text2 .. "|r"
 end

 -- Allgemeine Funktion für beliebig viele Farbsegmente
function MkLib.coloredText(...)
    local args = {...}
    local result = ""
    for i = 1, #args, 2 do
        local color = args[i]
        local text = args[i+1] or ""
        result = result .. "|cFF" .. color .. text .. "|r"
    end
    return result
end
-- Vereinfachung
-- code beispele: local myText = c("000000", "MK: ") .. c("FFA500", "Dein Text hier")

function MkLib.mkt()
    return MkLib.c("00beef", "MythicKey")
end
