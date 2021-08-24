-- please use the original repository, as it still gonna get a lot of updates
-- https://github.com/loglizzy/script-debugger

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local scroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local new = Instance.new("TextButton")
local drop = Instance.new("ImageButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(34, 34, 42)
Frame.BorderSizePixel = 0
Frame.Position = UDim2.new(0.322554559, 0, 0.205342233, 0)
Frame.Size = UDim2.new(0, 320, 0, 387)

scroll.Name = "scroll"
scroll.Parent = Frame
scroll.Active = true
scroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
scroll.BackgroundTransparency = 1.000
scroll.BorderSizePixel = 0
scroll.Position = UDim2.new(-0.0187500007, 0, 0.0180878546, 0)
scroll.Size = UDim2.new(0, 318, 0, 338)
scroll.ScrollBarThickness = 4
scroll.ClipsDescendants = true

UIListLayout.Parent = scroll
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

new.Name = "new"
new.Parent = UIListLayout
new.BackgroundColor3 = Color3.fromRGB(76, 84, 120)
new.BackgroundTransparency = 1.000
new.BorderSizePixel = 0
new.Position = UDim2.new(0.0503144637, 0, 0, 0)
new.Size = UDim2.new(0, 292, 0, 24)
new.Visible = false
new.AutoButtonColor = false
new.Font = Enum.Font.Arial
new.Text = "        function"
new.TextColor3 = Color3.fromRGB(202, 202, 202)
new.TextSize = 14.000
new.TextXAlignment = Enum.TextXAlignment.Left
new.RichText = true

drop.Name = "drop"
drop.Parent = new
drop.BackgroundTransparency = 1.000
drop.Position = UDim2.new(0, 0, -0.0416666865, 0)
drop.Rotation = -90.000
drop.Size = UDim2.new(0, 25, 0, 25)
drop.ZIndex = 2
drop.Image = "rbxassetid://3926307971"
drop.ImageRectOffset = Vector2.new(324, 524)
drop.ImageRectSize = Vector2.new(36, 36)

local TextButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(41, 74, 122)
TextButton.BorderSizePixel = 0
TextButton.Position = UDim2.new(0.71875, 0, 0.90956074, 0)
TextButton.Size = UDim2.new(0, 81, 0, 26)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Close"
TextButton.TextColor3 = Color3.fromRGB(226, 226, 226)
TextButton.TextSize = 14.000
TextButton.MouseButton1Click:Connect(function()
    Frame.Visible = not Frame.Visible
end)

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = TextButton

local TextBox = Instance.new("TextBox")
local UICorner = Instance.new("UICorner")

TextBox.Parent = Frame
TextBox.BackgroundColor3 = Color3.fromRGB(36, 66, 108)
TextBox.Position = UDim2.new(0.0304441452, 0, 0.90956074, 0)
TextBox.Size = UDim2.new(0, 214, 0, 26)
TextBox.Font = Enum.Font.SourceSans
TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
TextBox.PlaceholderText = "Script path here"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(226, 226, 226)
TextBox.TextSize = 14.000
TextBox.ClipsDescendants = true

UICorner.CornerRadius = UDim.new(0, 4)
UICorner.Parent = TextBox

local UserInputService = game:GetService("UserInputService")

local gui = Frame
local dragging
local dragInput
local dragStart
local startPos
local function update(input)
	local delta = input.Position - dragStart
	gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
gui.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = gui.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)
gui.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local a,ca,ht = scroll,{},game:GetService("HttpService")

local function ad(v,f)
	local e = new:Clone()
	e.Text = '        '..v
	e.drop.Visible = f
	e.MouseEnter:Connect(function()
		e.BackgroundTransparency = 0.8
	end)
	e.MouseLeave:Connect(function()
		e.BackgroundTransparency = 1
	end)
	e.Parent = a
	
	local ef = (#scroll:GetChildren())*new.Size.Y.Offset
	scroll.CanvasSize = UDim2.new(0,0,0,ef)

	return e
end

local function re(e)
	local r = e.drop.Rotation
	e.drop.Rotation = (r == 0 and -90) or 0
	e.BackgroundTransparency = 1
	wait()
	e.BackgroundTransparency = 0.8
end

local function rt(e,f)
	for i,v in pairs(a:GetChildren()) do
		local r = ca[v]
		
		if e ~= v and r and r == e then
			v.Visible = (f or e).drop.Rotation == -90
			if v.drop.Rotation == 0 then
				rt(v,e)
			end
		end
	end
end

local function st(r)
    local tbl = {}
    local function gt(e,f)
        for i,v in pairs(f or e) do
            local t = type(v)
            if t == 'function' then
                (f or e)[i] = getupvalues(v)
                gt(getprotos(v),e)
            elseif t == 'table' then
                gt(v)
            elseif i ~= 'script' then
                (f or e)[i] = v
            end
        end
    end
    
    gt(tbl,r)
    for i,v in pairs(r) do
        tbl[i] = v
    end

    return tbl
end

local siz = new.Size
local function lp(i,v,g)
	local t = type(v)
	local n = (t == 'table' and t) or ((t == 'number' or t == 'string') and v) or (t == 'function' and t) or tostring(v)
	local e,l = ad('<b>'..i..'</b>     '..n,true),nil
	ca[e] = g
	
	e.drop.Visible = (t == 'table' and #v > 0) or t == 'function'
	e.Size = siz

	if e.drop.Visible then
		e.MouseButton1Click:Connect(function()
			if l and (tick()-l) < 0.2 then
				rt(e)
				re(e)
			end
			l = tick()
		end)

		e.drop.MouseButton1Click:Connect(function()
			rt(e)
			re(e)
		end)

		siz = siz - UDim2.new(0,30,0,0)
		for i,v in pairs(v) do
			lp(i,v,e)
		end
		siz = siz + UDim2.new(0,30,0,0)
	end
	return e
end

local function ex(v)
    local tbl = st(getsenv(v))
    ca = {}
    for i,v in pairs(tbl) do
    	local f = lp(i,v)
    	if f then f.Visible = true end
    end
end

local ol
TextBox:GetPropertyChangedSignal('Text'):Connect(function()
    local r = TextBox.Text
    local e,f = pcall(loadstring('return '..r))
    if e and f and ol ~= f then
        ol = f
        wait(.1)
        
        for i,v in pairs(scroll:GetChildren()) do
            if v:IsA('TextButton') then
                v:Remove()
            end
        end
        
        ex(f)
    end
end)
end))
