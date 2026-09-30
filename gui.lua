--========================================================--
-- GUI.lua
-- SMALL MOBILE SCROLLING POWER FORMS GUI
--========================================================--

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local old = PlayerGui:FindFirstChild("DIDODPowerForms")

if old then
	old:Destroy()
end

local GUI = {}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DIDODPowerForms"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

GUI.ScreenGui = ScreenGui

--========================================================--
-- MAIN
--========================================================--

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(245, 300)
Main.Position = UDim2.new(1, -260, 0, 100)
Main.BackgroundColor3 = Color3.fromRGB(17,18,24)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,14)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Transparency = .35
MainStroke.Parent = Main

GUI.Main = Main

--========================================================--
-- HEADER
--========================================================--

local Header = Instance.new("Frame")
Header.Size = UDim2.new(1,0,0,42)
Header.BackgroundColor3 = Color3.fromRGB(27,29,38)
Header.BorderSizePixel = 0
Header.Parent = Main

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0,14)
HeaderCorner.Parent = Header

local HeaderBottom = Instance.new("Frame")
HeaderBottom.Size = UDim2.new(1,0,0,14)
HeaderBottom.Position = UDim2.new(0,0,1,-14)
HeaderBottom.BackgroundColor3 = Header.BackgroundColor3
HeaderBottom.BorderSizePixel = 0
HeaderBottom.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-75,1,0)
Title.Position = UDim2.fromOffset(12,0)
Title.BackgroundTransparency = 1
Title.Text = "⚡ POWER FORMS"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

--========================================================--
-- CLOSE
--========================================================--

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30,30)
Close.Position = UDim2.new(1,-36,0,6)
Close.BackgroundColor3 = Color3.fromRGB(45,46,56)
Close.Text = "×"
Close.TextColor3 = Color3.new(1,1,1)
Close.TextSize = 20
Close.Font = Enum.Font.GothamBold
Close.BorderSizePixel = 0
Close.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0,8)
CloseCorner.Parent = Close

--========================================================--
-- SCROLLING AREA
--========================================================--

local Scroll = Instance.new("ScrollingFrame")
Scroll.Name = "Scroll"
Scroll.Size = UDim2.new(1,-10,1,-48)
Scroll.Position = UDim2.fromOffset(5,46)
Scroll.BackgroundTransparency = 1
Scroll.BorderSizePixel = 0
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageTransparency = .25
Scroll.CanvasSize = UDim2.new(0,0,0,0)
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.ScrollingDirection = Enum.ScrollingDirection.Y
Scroll.Parent = Main

GUI.Scroll = Scroll

local Padding = Instance.new("UIPadding")
Padding.PaddingLeft = UDim.new(0,6)
Padding.PaddingRight = UDim.new(0,6)
Padding.PaddingTop = UDim.new(0,3)
Padding.PaddingBottom = UDim.new(0,8)
Padding.Parent = Scroll

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,6)
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Scroll

--========================================================--
-- BUTTON CREATOR
--========================================================--

local function MakeButton(text, order)

	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1,0,0,39)
	Button.BackgroundColor3 = Color3.fromRGB(29,31,40)
	Button.BorderSizePixel = 0
	Button.Text = text
	Button.TextColor3 = Color3.new(1,1,1)
	Button.TextSize = 13
	Button.Font = Enum.Font.GothamBold
	Button.LayoutOrder = order
	Button.AutoButtonColor = true

	Button.Parent = Scroll

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,9)
	Corner.Parent = Button

	return Button
end

GUI.Buttons = {}

GUI.Buttons.Void = MakeButton("◈  VOID",1)
GUI.Buttons.IronMan = MakeButton("◉  IRON MAN",2)
GUI.Buttons.Rick = MakeButton("◆  RICK",3)
GUI.Buttons.Flight = MakeButton("✈  FLIGHT",4)
GUI.Buttons.Speed = MakeButton("⚡  SUPER SPEED",5)
GUI.Buttons.Suit = MakeButton("◈  BUILD SUIT",6)
GUI.Buttons.Target = MakeButton("◎  TARGET",7)
GUI.Buttons.Special = MakeButton("★  SPECIAL",8)
GUI.Buttons.VoidPortal = MakeButton("●  VOID PORTAL",9)
GUI.Buttons.MinIg = MakeButton("▣  MINIGUN",10)

--========================================================--
-- DRAG ONLY HEADER
--========================================================--

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = true
		dragStart = input.Position
		startPosition = Main.Position

	end

end)

Header.InputEnded:Connect(function(input)

	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then

		dragging = false

	end

end)

UserInputService.InputChanged:Connect(function(input)

	if not dragging then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.MouseMovement
		and input.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	local delta = input.Position - dragStart

	Main.Position = UDim2.new(
		startPosition.X.Scale,
		startPosition.X.Offset + delta.X,
		startPosition.Y.Scale,
		startPosition.Y.Offset + delta.Y
	)

end)

--========================================================--
-- RESTORE
--========================================================--

local Restore = Instance.new("TextButton")

Restore.Size = UDim2.fromOffset(52,52)
Restore.Position = UDim2.new(1,-68,0,90)
Restore.BackgroundColor3 = Color3.fromRGB(20,22,29)
Restore.Text = "⚡"
Restore.TextSize = 23
Restore.TextColor3 = Color3.new(1,1,1)
Restore.Visible = false
Restore.BorderSizePixel = 0
Restore.Parent = ScreenGui

local RestoreCorner = Instance.new("UICorner")
RestoreCorner.CornerRadius = UDim.new(0,14)
RestoreCorner.Parent = Restore

Close.Activated:Connect(function()

	Main.Visible = false
	Restore.Visible = true

end)

Restore.Activated:Connect(function()

	Main.Visible = true
	Restore.Visible = false

end)

GUI.Restore = Restore

return GUI