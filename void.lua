--========================================================--
-- Void.lua
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local Player = Players.LocalPlayer

local Void = {}

local function GetCharacter()

	local character = Player.Character

	if not character then
		return nil
	end

	local root = character:FindFirstChild("HumanoidRootPart")

	if not root then
		return nil
	end

	return character,root

end

function Void.Transform()

	local character,root = GetCharacter()

	if not character then
		return
	end

	for _,part in ipairs(character:GetDescendants()) do

		if part:IsA("BasePart") then

			TweenService:Create(
				part,
				TweenInfo.new(.35),
				{
					Color = Color3.fromRGB(2,2,2)
				}
			):Play()

		end

	end

end

function Void.Portal()

	local character,root = GetCharacter()

	if not character then
		return
	end

	local portal = Instance.new("Part")

	portal.Name = "VoidPortal"
	portal.Shape = Enum.PartType.Cylinder
	portal.Size = Vector3.new(.4,18,18)
	portal.Material = Enum.Material.Neon
	portal.Color = Color3.fromRGB(0,0,0)
	portal.Transparency = .1
	portal.Anchored = true
	portal.CanCollide = false

	portal.CFrame =
		CFrame.new(
			root.Position - Vector3.new(0,3,0)
		)
		* CFrame.Angles(0,0,math.rad(90))

	portal.Parent = workspace

	TweenService:Create(
		portal,
		TweenInfo.new(.5),
		{
			Size = Vector3.new(.5,35,35)
		}
	):Play()

	task.delay(4,function()

		if portal then

			TweenService:Create(
				portal,
				TweenInfo.new(.5),
				{
					Transparency = 1
				}
			):Play()

			Debris:AddItem(portal,.6)

		end

	end)

	return portal

end

return Void