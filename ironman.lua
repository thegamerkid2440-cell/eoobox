--========================================================--
-- IronMan.lua
--========================================================--

local Players = game:GetService("Players")

local Player = Players.LocalPlayer

local IronMan = {}

local active = false

local function Character()

	return Player.Character

end

function IronMan.Remove()

	local character = Character()

	if not character then
		return
	end

	for _,object in ipairs(character:GetChildren()) do

		if object:GetAttribute("IronManPart") then
			object:Destroy()
		end

	end

	active = false

end

local function ArmorPart(name,size,color,offset)

	local character = Character()

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
	part.Color = color
	part.Material = Enum.Material.Metal
	part.CanCollide = false
	part.Massless = true
	part:SetAttribute("IronManPart",true)
	part.Parent = character

	local weld = Instance.new("Weld")

	weld.Part0 = root
	weld.Part1 = part
	weld.C0 = CFrame.new(offset)
	weld.Parent = part

	return part

end

function IronMan.Build()

	IronMan.Remove()

	active = true

	local metal = Color3.fromRGB(55,60,70)

	ArmorPart(
		"ChestArmor",
		Vector3.new(3.4,2.5,1.8),
		metal,
		Vector3.new(0,.6,0)
	)

	ArmorPart(
		"LegArmor",
		Vector3.new(3,2.4,1.7),
		metal,
		Vector3.new(0,-1.5,0)
	)

	ArmorPart(
		"BootArmor",
		Vector3.new(3,.4,1.8),
		metal,
		Vector3.new(0,-2.8,0)
	)

	for _,side in ipairs({-1,1}) do

		ArmorPart(
			"ArmArmor",
			Vector3.new(.8,2.5,1),
			metal,
			Vector3.new(side*2,0,0)
		)

	end

end

function IronMan.IsActive()

	return active

end

return IronMan