--========================================================--
-- Flight.lua
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer

local Flight = {}

local flying = false
local connection

local function GetCharacter()

	local character = Player.Character

	if not character then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not root then
		return nil
	end

	return character,humanoid,root

end

function Flight.Stop()

	flying = false

	if connection then
		connection:Disconnect()
		connection = nil
	end

	local character,humanoid,root = GetCharacter()

	if not character then
		return
	end

	local attachment = root:FindFirstChild("PowerFlightAttachment")
	local velocity = root:FindFirstChild("PowerFlightVelocity")

	if velocity then
		velocity:Destroy()
	end

	if attachment then
		attachment:Destroy()
	end

	humanoid.PlatformStand = false

end

function Flight.Start()

	if flying then
		Flight.Stop()
		return false
	end

	local character,humanoid,root = GetCharacter()

	if not character then
		return false
	end

	flying = true

	local attachment = Instance.new("Attachment")
	attachment.Name = "PowerFlightAttachment"
	attachment.Parent = root

	local velocity = Instance.new("LinearVelocity")

	velocity.Name = "PowerFlightVelocity"
	velocity.Attachment0 = attachment
	velocity.RelativeTo = Enum.ActuatorRelativeTo.World
	velocity.MaxForce = math.huge
	velocity.VectorVelocity = Vector3.zero
	velocity.Parent = root

	humanoid.PlatformStand = true

	connection = RunService.RenderStepped:Connect(function()

		if not flying then
			return
		end

		if not root.Parent then
			Flight.Stop()
			return
		end

		local camera = workspace.CurrentCamera

		local direction = Vector3.zero

		if UserInputService:IsKeyDown(Enum.KeyCode.W) then
			direction += camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.S) then
			direction -= camera.CFrame.LookVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.A) then
			direction -= camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.D) then
			direction += camera.CFrame.RightVector
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
			direction += Vector3.new(0,1,0)
		end

		if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
			direction -= Vector3.new(0,1,0)
		end

		local speed = 85

		if direction.Magnitude > 0 then
			direction = direction.Unit * speed
		end

		velocity.VectorVelocity = direction

	end)

	return true

end

function Flight.IsFlying()

	return flying

end

return Flight