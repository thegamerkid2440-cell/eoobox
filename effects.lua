--========================================================--
-- Effects.lua
--========================================================--

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")

local Effects = {}

function Effects.Burst(position,color,amount)

	local holder = Instance.new("Part")

	holder.Anchored = true
	holder.CanCollide = false
	holder.Transparency = 1
	holder.Size = Vector3.new(1,1,1)
	holder.Position = position
	holder.Parent = workspace

	local emitter = Instance.new("ParticleEmitter")

	emitter.Color = ColorSequence.new(color)
	emitter.LightEmission = 1
	emitter.Rate = 0
	emitter.Speed = NumberRange.new(5,18)
	emitter.Lifetime = NumberRange.new(.3,.8)
	emitter.SpreadAngle = Vector2.new(180,180)
	emitter.Parent = holder

	emitter:Emit(amount or 30)

	Debris:AddItem(holder,2)

end

function Effects.Beam(fromPosition,toPosition,color)

	local distance = (toPosition-fromPosition).Magnitude

	local beam = Instance.new("Part")

	beam.Anchored = true
	beam.CanCollide = false
	beam.Material = Enum.Material.Neon
	beam.Color = color
	beam.Size = Vector3.new(.2,.2,distance)

	beam.CFrame = CFrame.lookAt(
		(fromPosition+toPosition)/2,
		toPosition
	)

	beam.Parent = workspace

	Debris:AddItem(beam,.15)

end

function Effects.Flash(character,color)

	local highlight = Instance.new("Highlight")

	highlight.FillColor = color
	highlight.OutlineColor = Color3.new(1,1,1)
	highlight.FillTransparency = .15
	highlight.OutlineTransparency = .15
	highlight.Parent = character

	TweenService:Create(
		highlight,
		TweenInfo.new(.7),
		{
			FillTransparency = 1,
			OutlineTransparency = 1
		}
	):Play()

	Debris:AddItem(highlight,1)

end

return Effects