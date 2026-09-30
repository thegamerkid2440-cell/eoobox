--========================================================--
-- DIDOD POWER FORMS
-- MAIN ENTRY POINT
--========================================================--

local BASE =
	"https://raw.githubusercontent.com/thegamerkid2440-cell/didod/main/"

local function LoadModule(fileName)
	local url = BASE .. fileName

	local success, result = pcall(function()
		return loadstring(game:HttpGet(url))()
	end)

	if not success then
		warn("[DIDOD] Failed to load:", fileName)
		warn(result)
		return nil
	end

	print("[DIDOD] Loaded:", fileName)

	return result
end

local Effects = LoadModule("Effects.lua")

local GUI = LoadModule("GUI.lua")

local Flight = LoadModule("Flight.lua")

local Void = LoadModule("Void.lua")

local IronMan = LoadModule("IronMan.lua")

local Rick = LoadModule("Rick.lua")

print("[DIDOD] Power Forms loaded.")