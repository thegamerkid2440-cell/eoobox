--========================================================--
-- DIDOD POWER FORMS
-- MAIN ENTRY POINT
--========================================================--

local BASE =
	"https://raw.githubusercontent.com/thegamerkid2440-cell/eoobox/main/"

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

local Effects = LoadModule("effects.lua")

local GUI = LoadModule("gui.lua")

local Flight = LoadModule("flight.lua")

local Void = LoadModule("void.lua")

local IronMan = LoadModule("ironman.lua")

local Rick = LoadModule("rick.lua")

print("[DIDOD] Power Forms loaded.")
