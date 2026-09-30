--========================================================--
-- Rick.lua
--========================================================--

local Players = game:GetService("Players")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer

local Rick = {}

local active = false
local guns = {}

local function GetCharacter()

	return Player.Character

end

function Rick.Remove()

	for _,gun in ipairs(guns) do

		if gun then
			gun:Destroy()
		end

	end

	guns = {}
	active = false

end

local function CreatePart(name,size,offset)

	local character = GetCharacter()

	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")

	if not root then
		return
	end

	local part = Instance.new("Part")

	part.Name = name
	part.Size = size
	part.Color = Color3.fromRGB(65,70,80)
	part.Material = Enum.Material.Metal
	part.CanCollide = false
	part.Massless = true
	part.Parent = character

	local weld = Instance.new("Weld")

	weld.Part0 = root
	weld.Part1 = part
	weld.C0 = CFrame.new(offset)
	weld.Parent = part

	table.insert(guns,part)

end

function Rick.Build()

	Rick.Remove()

	active = true

	CreatePart(
		"RickNanoChest",
		Vector3.new(3.4,2.5,1.8),
		Vector3.new(0,.6,0)
	)

	CreatePart(
		"RickNanoLegs",
		Vector3.new(3,2.4,1.7),
		Vector3.new(0,-1.5,0)
	)

end

function Rick.ToggleMinigun()

	if not active then
		return
	end

	if #guns > 2 then

		Rick.Remove()

		Rick.Build()

		return

	end

	for _,side in ipairs({-1,1}) do

		for i=1,3 do

			CreatePart(
				"RickMinigun",
				Vector3.new(.4,.4,2.4),
				Vector3.new(
					side*(1.3+i*.25),
					0,
					-1.2
				)
			)

		end

	end

end

function Rick.Simulate()

	local character = GetCharacter()

	if not character then
		return
	end

	local root = character:FindFirstChild("HumanoidRootPart")

	if not root then
		return
	end

	local effect = Instance.new("Part")

	effect.Shape = Enum.PartType.Ball
	effect.Size = Vector3.new(2,2,2)
	effect.Material = Enum.Material.Neon
	effect.Color = Color3.fromRGB(180,220,255)
	effect.Anchored = true
	effect.CanCollide = false
	effect.Position =
		root.Position +
		root.CFrame.LookVector*5

	effect.Parent = workspace

	task.delay(1,function()

		if effect then
			effect:Destroy()
		end

	end)

end

return Rick