local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- ===== THEME PRESETS =====
local Presets = {
	Dark = {
		Background = Color3.fromRGB(30, 30, 35),
		Sidebar = Color3.fromRGB(20, 20, 25),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(45, 45, 50),
		Accent = Color3.fromRGB(85, 170, 255),
		ToggleOff = Color3.fromRGB(85, 85, 90),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(85, 85, 90),
		InputBackground = Color3.fromRGB(55, 55, 60),
	},
	Purple = {
		Background = Color3.fromRGB(30, 25, 40),
		Sidebar = Color3.fromRGB(20, 15, 30),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(45, 40, 55),
		Accent = Color3.fromRGB(170, 85, 255),
		ToggleOff = Color3.fromRGB(85, 80, 90),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(85, 80, 90),
		InputBackground = Color3.fromRGB(55, 50, 60),
	},
	Red = {
		Background = Color3.fromRGB(40, 25, 25),
		Sidebar = Color3.fromRGB(30, 15, 15),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(55, 40, 40),
		Accent = Color3.fromRGB(255, 70, 70),
		ToggleOff = Color3.fromRGB(90, 80, 80),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(90, 80, 80),
		InputBackground = Color3.fromRGB(60, 50, 50),
	},
	Blue = {
		Background = Color3.fromRGB(25, 30, 40),
		Sidebar = Color3.fromRGB(15, 20, 30),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(40, 45, 55),
		Accent = Color3.fromRGB(70, 130, 255),
		ToggleOff = Color3.fromRGB(80, 85, 90),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(80, 85, 90),
		InputBackground = Color3.fromRGB(50, 55, 60),
	},
	Green = {
		Background = Color3.fromRGB(25, 40, 25),
		Sidebar = Color3.fromRGB(15, 30, 15),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(40, 55, 40),
		Accent = Color3.fromRGB(70, 255, 70),
		ToggleOff = Color3.fromRGB(80, 90, 80),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(80, 90, 80),
		InputBackground = Color3.fromRGB(50, 60, 50),
	},
	Orange = {
		Background = Color3.fromRGB(40, 30, 20),
		Sidebar = Color3.fromRGB(30, 20, 10),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(55, 45, 35),
		Accent = Color3.fromRGB(255, 150, 50),
		ToggleOff = Color3.fromRGB(90, 85, 80),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(90, 85, 80),
		InputBackground = Color3.fromRGB(60, 55, 50),
	},
}

function Library:Notify(config)
	config = config or {}
	local text = config.Text or ""
	local duration = config.Duration or 4
	local icon = config.Icon or ""

	local notifGui = Instance.new("ScreenGui")
	notifGui.Name = "ProLibraryNotification"
	notifGui.Parent = game.CoreGui

	local holder = Instance.new("Frame")
	holder.Size = UDim2.new(0, 320, 0, 50)
	holder.Position = UDim2.new(0.5, -160, 0, -60)
	holder.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	holder.BorderSizePixel = 0
	holder.ClipsDescendants = true
	holder.Parent = notifGui
	Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

	local stroke = Instance.new("UIStroke", holder)
	stroke.Color = Color3.fromRGB(85, 170, 255)
	stroke.Thickness = 1.5

	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, -20, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Text = (icon ~= "" and icon .. "  " or "") .. text
	lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
	lbl.Font = Enum.Font.Gotham
	lbl.TextSize = 14
	lbl.TextXAlignment = Enum.TextXAlignment.Center
	lbl.Parent = holder

	holder:TweenPosition(UDim2.new(0.5, -160, 0, 20), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	task.wait(duration)
	holder:TweenPosition(UDim2.new(0.5, -160, 0, -60), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.5, true)
	task.wait(0.5)
	notifGui:Destroy()
end

function Library:CreateWindow(config)
	local C = setmetatable({
		Background = Color3.fromRGB(30, 30, 35),
		Sidebar = Color3.fromRGB(20, 20, 25),
		Text = Color3.fromRGB(255, 255, 255),
		Button = Color3.fromRGB(45, 45, 50),
		Accent = Color3.fromRGB(85, 170, 255),
		ToggleOff = Color3.fromRGB(85, 85, 90),
		ToggleKnob = Color3.fromRGB(255, 255, 255),
		ScrollBar = Color3.fromRGB(85, 85, 90),
		InputBackground = Color3.fromRGB(55, 55, 60),
	}, {__index = function(_, k) return config.Colors and config.Colors[k] end})

	local function mergeColors(src)
		for k, v in pairs(src) do C[k] = v end
	end
	if config.Colors then mergeColors(config.Colors) end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ProCustomLibrary"
	screenGui.Parent = game.CoreGui

	local mainFrame = Instance.new("Frame")
	mainFrame.Size = UDim2.new(0, 480, 0, 340)
	mainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
	mainFrame.BackgroundColor3 = C.Background
	mainFrame.BorderSizePixel = 0
	mainFrame.ClipsDescendants = true
	mainFrame.Parent = screenGui
	Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8)

	local sidebar = Instance.new("Frame")
	sidebar.Size = UDim2.new(0, 130, 1, 0)
	sidebar.BackgroundColor3 = C.Sidebar
	sidebar.BorderSizePixel = 0
	sidebar.Parent = mainFrame

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, 0, 0, 35)
	title.BackgroundTransparency = 1
	title.Text = config.Title or "Pro Hub"
	title.TextColor3 = C.Accent
	title.Font = Enum.Font.GothamBold
	title.TextSize = 16
	title.Parent = sidebar

	local tabContainer = Instance.new("Frame")
	tabContainer.Size = UDim2.new(1, 0, 1, -35)
	tabContainer.Position = UDim2.new(0, 0, 0, 35)
	tabContainer.BackgroundTransparency = 1
	tabContainer.Parent = sidebar
	Instance.new("UIListLayout", tabContainer).SortOrder = Enum.SortOrder.LayoutOrder

	local contentArea = Instance.new("Frame")
	contentArea.Size = UDim2.new(1, -130, 1, 0)
	contentArea.Position = UDim2.new(0, 130, 0, 0)
	contentArea.BackgroundTransparency = 1
	contentArea.Parent = mainFrame

	local pagesFolder = Instance.new("Folder")
	pagesFolder.Name = "Pages"
	pagesFolder.Parent = contentArea

	-- Minimize
	local minimizeBtn = Instance.new("TextButton")
	minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
	minimizeBtn.Position = UDim2.new(0, -24, 0, 0)
	minimizeBtn.BackgroundTransparency = 1
	minimizeBtn.Text = "-"
	minimizeBtn.TextColor3 = C.Text
	minimizeBtn.Font = Enum.Font.GothamBold
	minimizeBtn.TextSize = 18
	minimizeBtn.Parent = contentArea

	-- Dragging
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	mainFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = mainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	mainFrame.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then update(input) end
	end)

	local minimized = false
	local originalSize = mainFrame.Size

	-- === ELEMENT REGISTRY ===
	local elements = {}
	local function register(el)
		table.insert(elements, el)
	end

	-- === KEYBIND TRACKER ===
	local keybinds = {}

	local function onKeybindPressed(key)
		for _, kb in pairs(keybinds) do
			if kb.key == key then
				pcall(kb.callback)
			end
		end
	end

	UserInputService.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.UserInputType == Enum.UserInputType.Keyboard then
			onKeybindPressed(input.KeyCode)
		end
	end)

	-- === CANVAS RESIZE HELPER ===
	local function autoCanvas(page, layout)
		local function upd()
			page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
		end
		layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(upd)
		task.spawn(upd)
	end

	-- === WINDOW ===
	local Window = {}
	local firstTab = true
	local activeTabBtn = nil

	-- Minimize toggle
	minimizeBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		local targetSize = minimized and UDim2.new(0, 480, 0, 35) or originalSize
		TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = targetSize}):Play()
		contentArea.Visible = not minimized
		minimizeBtn.Text = minimized and "+" or "-"
	end)

	function Window:SetColors(newColors)
		mergeColors(newColors)
		mainFrame.BackgroundColor3 = C.Background
		sidebar.BackgroundColor3 = C.Sidebar
		title.TextColor3 = C.Accent
		minimizeBtn.TextColor3 = C.Text

		for _, tb in pairs(tabContainer:GetChildren()) do
			if tb:IsA("TextButton") then
				tb.TextColor3 = (tb == activeTabBtn) and C.Accent or C.Text
			end
		end

		for _, el in pairs(elements) do
			local t = el.type
			if t == "Button" then
				el.cont.BackgroundColor3 = C.Button
				el.cont.TextColor3 = C.Text
			elseif t == "Toggle" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
			elseif t == "Label" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
			elseif t == "Section" then
				el.header.BackgroundColor3 = C.Sidebar
				el.header.TextColor3 = C.Accent
			elseif t == "Textbox" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
				if el.box then
					el.box.BackgroundColor3 = C.InputBackground
					el.box.TextColor3 = C.Text
				end
			elseif t == "Slider" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
				el.valLabel.TextColor3 = C.Text
				el.fill.BackgroundColor3 = C.Accent
			elseif t == "Dropdown" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
				el.selLabel.TextColor3 = C.Text
				if el.dropdown then el.dropdown.BackgroundColor3 = C.Button end
			elseif t == "ColorPicker" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
			elseif t == "Keybind" then
				el.cont.BackgroundColor3 = C.Button
				el.label.TextColor3 = C.Text
				el.keyBtn.BackgroundColor3 = C.InputBackground
				el.keyBtn.TextColor3 = C.Text
			end
		end

		for _, page in pairs(pagesFolder:GetChildren()) do
			if page:IsA("ScrollingFrame") then
				page.ScrollBarImageColor3 = C.ScrollBar
			end
		end
	end

	function Window:SelectPreset(name)
		local preset = Presets[name]
		if preset then
			self:SetColors(preset)
		end
	end

	function Window:SaveTheme(name)
		local data = {}
		for k, v in pairs(C) do
			if type(v) == "Color3" then
				data[k] = {R = v.R, G = v.G, B = v.B}
			end
		end
		local ok, err = pcall(function()
			writefile("ProTheme_" .. name .. ".json", HttpService:JSONEncode(data))
		end)
		if ok then
			Library:Notify({Text = "Theme saved as '" .. name .. "'", Duration = 2, Icon = "✓"})
		end
	end

	function Window:LoadTheme(name)
		local ok, data = pcall(function()
			return HttpService:JSONDecode(readfile("ProTheme_" .. name .. ".json"))
		end)
		if ok then
			local colors = {}
			for k, v in pairs(data) do
				colors[k] = Color3.new(v.R, v.G, v.B)
			end
			self:SetColors(colors)
			Library:Notify({Text = "Theme loaded: '" .. name .. "'", Duration = 2, Icon = "✓"})
		else
			Library:Notify({Text = "Theme '" .. name .. "' not found", Duration = 3, Icon = "✗"})
		end
	end

	-- === RAINBOW ===
	local rainbowRunning = false
	local rainbowConn = nil
	function Window:SetRainbow(enabled)
		if rainbowConn then rainbowConn:Disconnect(); rainbowConn = nil end
		rainbowRunning = enabled
		if not enabled then return end
		local hue = 0
		rainbowConn = RunService.Heartbeat:Connect(function(dt)
			if not rainbowRunning then rainbowConn:Disconnect(); rainbowConn = nil; return end
			hue = (hue + dt * 0.3) % 1
			Window:SetColors({Accent = Color3.fromHSV(hue, 1, 1)})
		end)
	end

	-- === NOTIFICATION FROM WINDOW ===
	function Window:Notify(config)
		Library:Notify(config)
	end

	-- === CREATE PAGE HELPER ===
	local function makePage(parentObj)
		local page = Instance.new("ScrollingFrame")
		page.Size = UDim2.new(1, 0, 1, 0)
		page.BackgroundTransparency = 1
		page.ScrollBarThickness = 4
		page.ScrollBarImageColor3 = C.ScrollBar
		page.Visible = false
		page.Parent = parentObj

		local layout = Instance.new("UIListLayout", page)
		layout.Padding = UDim.new(0, 5)
		layout.SortOrder = Enum.SortOrder.LayoutOrder

		local padding = Instance.new("UIPadding", page)
		padding.PaddingTop = UDim.new(0, 10)
		padding.PaddingLeft = UDim.new(0, 10)
		padding.PaddingRight = UDim.new(0, 10)
		padding.PaddingBottom = UDim.new(0, 10)

		autoCanvas(page, layout)

		-- Search bar
		local searchBox = Instance.new("TextBox")
		searchBox.Name = "SearchBar"
		searchBox.Size = UDim2.new(1, 0, 0, 28)
		searchBox.BackgroundColor3 = C.InputBackground
		searchBox.TextColor3 = Color3.fromRGB(150, 150, 150)
		searchBox.Font = Enum.Font.Gotham
		searchBox.TextSize = 13
		searchBox.PlaceholderText = "🔍  search controls..."
		searchBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
		searchBox.Parent = page
		searchBox.LayoutOrder = -9999
		Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 4)

		local searchActive = false
		local function filterControls(text)
			if text == "" then
				searchActive = false
				for _, child in pairs(page:GetChildren()) do
					if child ~= searchBox and child:IsA("Frame") then
						child.Visible = true
					end
				end
				return
			end
			searchActive = true
			for _, child in pairs(page:GetChildren()) do
				if child ~= searchBox and child:IsA("Frame") then
					local label = child:FindFirstChild("Label")
					local txt = label and label.Text or ""
					if txt == "" then
						local header = child:FindFirstChild("Header")
						txt = header and header.Text or ""
					end
					child.Visible = txt:lower():find(text:lower()) ~= nil
				end
			end
		end
		searchBox.FocusLost:Connect(function()
			filterControls(searchBox.Text)
		end)
		searchBox:GetPropertyChangedSignal("Text"):Connect(function()
			if searchBox.Text == "" then
				filterControls("")
			end
		end)

		return page, layout, searchBox
	end

	-- === TAB CREATION ===
	function Window:CreateTab(tabName)
		local tabBtn = Instance.new("TextButton")
		tabBtn.Size = UDim2.new(1, 0, 0, 32)
		tabBtn.BackgroundTransparency = 1
		tabBtn.Text = tabName
		tabBtn.TextColor3 = firstTab and C.Accent or C.Text
		tabBtn.Font = Enum.Font.GothamSemibold
		tabBtn.TextSize = 14
		tabBtn.Parent = tabContainer

		local page, layout, searchBox = makePage(pagesFolder)
		page.Visible = firstTab

		tabBtn.MouseButton1Click:Connect(function()
			for _, child in pairs(pagesFolder:GetChildren()) do child.Visible = false end
			for _, child in pairs(tabContainer:GetChildren()) do
				if child:IsA("TextButton") then child.TextColor3 = C.Text end
			end
			page.Visible = true
			tabBtn.TextColor3 = C.Accent
			activeTabBtn = tabBtn
		end)

		if firstTab then activeTabBtn = tabBtn end

		firstTab = false

		-- === TABINFO (element builders) ===
		local TabInfo = {}

		local function createEl(pageRef)
			local info = {}

			function info:CreateButton(btnText, callback)
				local btn = Instance.new("TextButton")
				btn.Size = UDim2.new(1, 0, 0, 35)
				btn.BackgroundColor3 = C.Button
				btn.TextColor3 = C.Text
				btn.Text = btnText
				btn.Font = Enum.Font.Gotham
				btn.TextSize = 14
				btn.Parent = pageRef
				Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
				btn.MouseButton1Click:Connect(callback)
				register({type = "Button", cont = btn})
			end

			function info:CreateToggle(toggleText, callback)
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 35)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(1, -55, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1
				label.Text = toggleText
				label.TextColor3 = C.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local track = Instance.new("Frame")
				track.Name = "Track"
				track.Size = UDim2.new(0, 42, 0, 22)
				track.Position = UDim2.new(1, -52, 0.5, -11)
				track.BackgroundColor3 = C.ToggleOff
				track.BorderSizePixel = 0
				track.Parent = container
				Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

				local knob = Instance.new("Frame")
				knob.Name = "Knob"
				knob.Size = UDim2.new(0, 18, 0, 18)
				knob.Position = UDim2.new(0, 2, 0.5, -9)
				knob.BackgroundColor3 = C.ToggleKnob
				knob.BorderSizePixel = 0
				knob.Parent = track
				Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

				local toggled = false
				local ti = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				local function upd()
					if toggled then
						TweenService:Create(track, ti, {BackgroundColor3 = C.Accent}):Play()
						knob:TweenPosition(UDim2.new(0, 22, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
					else
						TweenService:Create(track, ti, {BackgroundColor3 = C.ToggleOff}):Play()
						knob:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
					end
					callback(toggled)
				end
				container.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then toggled = not toggled; upd() end
				end)
				register({type = "Toggle", cont = container, label = label})
			end

			function info:CreateLabel(text)
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 30)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(1, -20, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = C.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container
				register({type = "Label", cont = container, label = label})
			end

			function info:CreateTextbox(placeholder, callback)
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 35)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(1, -170, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1
				label.Text = placeholder
				label.TextColor3 = C.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local box = Instance.new("TextBox")
				box.Name = "Box"
				box.Size = UDim2.new(0, 140, 0, 26)
				box.Position = UDim2.new(1, -150, 0.5, -13)
				box.BackgroundColor3 = C.InputBackground
				box.TextColor3 = C.Text
				box.Font = Enum.Font.Gotham
				box.TextSize = 13
				box.PlaceholderText = "..."
				box.PlaceholderColor3 = Color3.fromRGB(130, 130, 130)
				box.Parent = container
				Instance.new("UICorner", box).CornerRadius = UDim.new(0, 4)
				box.FocusLost:Connect(function(enter)
					if enter then callback(box.Text) end
				end)
				register({type = "Textbox", cont = container, label = label, box = box})
			end

			function info:CreateSlider(text, min, max, default, callback)
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 50)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(1, -80, 0, 20)
				label.Position = UDim2.new(0, 10, 0, 5)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = C.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local valLabel = Instance.new("TextLabel")
				valLabel.Name = "Value"
				valLabel.Size = UDim2.new(0, 60, 0, 20)
				valLabel.Position = UDim2.new(1, -70, 0, 5)
				valLabel.BackgroundTransparency = 1
				valLabel.Text = tostring(default or min)
				valLabel.TextColor3 = C.Accent
				valLabel.Font = Enum.Font.GothamSemibold
				valLabel.TextSize = 13
				valLabel.TextXAlignment = Enum.TextXAlignment.Right
				valLabel.Parent = container

				local track = Instance.new("Frame")
				track.Name = "Track"
				track.Size = UDim2.new(1, -20, 0, 6)
				track.Position = UDim2.new(0, 10, 0, 32)
				track.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
				track.BorderSizePixel = 0
				track.Parent = container
				Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

				local fill = Instance.new("Frame")
				fill.Name = "Fill"
				fill.Size = UDim2.new(0, 0, 1, 0)
				fill.BackgroundColor3 = C.Accent
				fill.BorderSizePixel = 0
				fill.Parent = track
				Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

				local knob = Instance.new("Frame")
				knob.Name = "Knob"
				knob.Size = UDim2.new(0, 14, 0, 14)
				knob.Position = UDim2.new(0, -7, 0.5, -7)
				knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				knob.BorderSizePixel = 0
				knob.Parent = fill
				Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

				local current = default or min
				local draggingSlider = false
				local function setValue(val)
					current = math.clamp(val, min, max)
					local ratio = (current - min) / (max - min)
					fill.Size = UDim2.new(ratio, 0, 1, 0)
					valLabel.Text = tostring(math.floor(current * 100) / 100)
					callback(current)
				end
				local function slide(input)
					local pos = input.Position
					local absPos = track.AbsolutePosition
					local absSize = track.AbsoluteSize.X
					local rel = (pos.X - absPos.X) / absSize
					setValue(min + rel * (max - min))
				end
				container.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = true; slide(input) end
				end)
				container.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
				end)
				UserInputService.InputChanged:Connect(function(input)
					if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						slide(input)
					end
				end)
				setValue(current)
				register({type = "Slider", cont = container, label = label, valLabel = valLabel, fill = fill})
			end

			function info:CreateDropdown(text, options, callback)
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 35)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				container.ClipsDescendants = true
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
				local uiStroke = Instance.new("UIStroke", container)
				uiStroke.Color = C.Sidebar
				uiStroke.Transparency = 0.8

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(0, 0, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = C.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local selLabel = Instance.new("TextLabel")
				selLabel.Name = "Selection"
				selLabel.Size = UDim2.new(1, -80, 1, 0)
				selLabel.Position = UDim2.new(0, 10, 0, 0)
				selLabel.BackgroundTransparency = 1
				selLabel.Text = "none"
				selLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
				selLabel.Font = Enum.Font.Gotham
				selLabel.TextSize = 14
				selLabel.TextXAlignment = Enum.TextXAlignment.Right
				selLabel.Parent = container

				local arrow = Instance.new("TextLabel")
				arrow.Size = UDim2.new(0, 20, 1, 0)
				arrow.Position = UDim2.new(1, -25, 0, 0)
				arrow.BackgroundTransparency = 1
				arrow.Text = ">"
				arrow.TextColor3 = C.Text
				arrow.Font = Enum.Font.Gotham
				arrow.TextSize = 14
				arrow.Parent = container

				local open = false
				local dropdownFrame = Instance.new("Frame")
				dropdownFrame.Name = "Dropdown"
				dropdownFrame.Size = UDim2.new(1, 0, 0, 0)
				dropdownFrame.Position = UDim2.new(0, 0, 0, 35)
				dropdownFrame.BackgroundColor3 = C.Button
				dropdownFrame.BorderSizePixel = 0
				dropdownFrame.Visible = false
				dropdownFrame.Parent = container
				Instance.new("UICorner", dropdownFrame).CornerRadius = UDim.new(0, 6)
				Instance.new("UIListLayout", dropdownFrame).Padding = UDim.new(0, 2)
				local pad = Instance.new("UIPadding", dropdownFrame)
				pad.PaddingTop = UDim.new(0, 5)
				pad.PaddingBottom = UDim.new(0, 5)

				for _, opt in pairs(options) do
					local btn = Instance.new("TextButton")
					btn.Size = UDim2.new(1, -10, 0, 28)
					btn.Position = UDim2.new(0, 5, 0, 0)
					btn.BackgroundTransparency = 0.9
					btn.Text = opt
					btn.TextColor3 = C.Text
					btn.Font = Enum.Font.Gotham
					btn.TextSize = 13
					btn.Parent = dropdownFrame
					Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
					btn.MouseButton1Click:Connect(function()
						selLabel.Text = opt
						selLabel.TextColor3 = C.Text
						open = false; dropdownFrame.Visible = false; arrow.Text = ">"
						container.Size = UDim2.new(1, 0, 0, 35)
						callback(opt)
					end)
					btn.MouseEnter:Connect(function()
						btn.BackgroundColor3 = C.Accent; btn.BackgroundTransparency = 0.5
					end)
					btn.MouseLeave:Connect(function()
						btn.BackgroundTransparency = 0.9
					end)
				end

				container.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						open = not open; dropdownFrame.Visible = open; arrow.Text = open and "v" or ">"
						local h = #options * 30 + 10
						container.Size = open and UDim2.new(1, 0, 0, 35 + h) or UDim2.new(1, 0, 0, 35)
					end
				end)
				register({type = "Dropdown", cont = container, label = label, selLabel = selLabel, dropdown = dropdownFrame})
			end

			function info:CreateColorPicker(text, default, callback)
				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 40)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				container.ClipsDescendants = true
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(1, -60, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1
				label.Text = text
				label.TextColor3 = C.Text
				label.Font = Enum.Font.Gotham
				label.TextSize = 14
				label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local preview = Instance.new("Frame")
				preview.Name = "Preview"
				preview.Size = UDim2.new(0, 28, 0, 28)
				preview.Position = UDim2.new(1, -38, 0.5, -14)
				preview.BackgroundColor3 = default or Color3.fromRGB(255, 255, 255)
				preview.BorderSizePixel = 0
				preview.Parent = container
				Instance.new("UICorner", preview).CornerRadius = UDim.new(0, 4)

				local pickerOpen = false
				local pickerFrame = Instance.new("Frame")
				pickerFrame.Name = "Picker"
				pickerFrame.Size = UDim2.new(1, 0, 0, 130)
				pickerFrame.Position = UDim2.new(0, 0, 0, 40)
				pickerFrame.BackgroundColor3 = C.Button
				pickerFrame.BorderSizePixel = 0
				pickerFrame.Visible = false
				pickerFrame.Parent = container
				Instance.new("UICorner", pickerFrame).CornerRadius = UDim.new(0, 6)

				local currentColor = default or Color3.fromRGB(255, 255, 255)
				local function updatePreview()
					preview.BackgroundColor3 = currentColor; callback(currentColor)
				end

				local labels = {}
				local tracks = {}
				local fills = {}
				local vals = {}
				local channels = {"R", "G", "B"}
				local chanColors = {
					R = Color3.fromRGB(255, 80, 80),
					G = Color3.fromRGB(80, 255, 80),
					B = Color3.fromRGB(80, 80, 255),
				}

				for i, ch in pairs(channels) do
					local yOff = 8 + (i - 1) * 30
					local lbl = Instance.new("TextLabel")
					lbl.Size = UDim2.new(0, 15, 0, 20)
					lbl.Position = UDim2.new(0, 8, 0, yOff)
					lbl.BackgroundTransparency = 1; lbl.Text = ch
					lbl.TextColor3 = chanColors[ch]; lbl.Font = Enum.Font.GothamBold
					lbl.TextSize = 13; lbl.Parent = pickerFrame
					labels[ch] = lbl

					local tr = Instance.new("Frame")
					tr.Size = UDim2.new(1, -100, 0, 4)
					tr.Position = UDim2.new(0, 28, 0, yOff + 8)
					tr.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
					tr.BorderSizePixel = 0; tr.Parent = pickerFrame
					Instance.new("UICorner", tr).CornerRadius = UDim.new(1, 0)
					tracks[ch] = tr

					local fl = Instance.new("Frame")
					fl.Size = UDim2.new(0, 0, 1, 0)
					fl.BackgroundColor3 = chanColors[ch]
					fl.BorderSizePixel = 0; fl.Parent = tr
					Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)
					fills[ch] = fl

					local vl = Instance.new("TextLabel")
					vl.Size = UDim2.new(0, 35, 0, 20)
					vl.Position = UDim2.new(1, -40, 0, yOff)
					vl.BackgroundTransparency = 1
					vl.Text = tostring(math.floor(currentColor[ch:lower()] * 255))
					vl.TextColor3 = C.Text; vl.Font = Enum.Font.Gotham
					vl.TextSize = 12; vl.Parent = pickerFrame
					vals[ch] = vl
				end

				local draggingChannel = false
				local activeCh = nil
				local function setFromSliders()
					local r = tonumber(vals.R.Text) or 0
					local g = tonumber(vals.G.Text) or 0
					local b = tonumber(vals.B.Text) or 0
					currentColor = Color3.fromRGB(math.clamp(r, 0, 255), math.clamp(g, 0, 255), math.clamp(b, 0, 255))
					for _, ch in pairs(channels) do
						fills[ch].Size = UDim2.new((tonumber(vals[ch].Text) or 0) / 255, 0, 1, 0)
					end
					updatePreview()
				end

				for _, ch in pairs(channels) do
					tracks[ch].InputBegan:Connect(function(i)
						if i.UserInputType == Enum.UserInputType.MouseButton1 then
							draggingChannel = true; activeCh = ch
							local pos = i.Position
							local absPos = tracks[ch].AbsolutePosition
							local absSize = tracks[ch].AbsoluteSize.X
							local rel = math.clamp((pos.X - absPos.X) / absSize, 0, 1)
							vals[ch].Text = tostring(math.floor(rel * 255))
							fills[ch].Size = UDim2.new(rel, 0, 1, 0)
							setFromSliders()
						end
					end)
				end

				UserInputService.InputChanged:Connect(function(input)
					if draggingChannel and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
						local tr = tracks[activeCh]
						local absPos = tr.AbsolutePosition; local absSize = tr.AbsoluteSize.X
						local rel = math.clamp((input.Position.X - absPos.X) / absSize, 0, 1)
						vals[activeCh].Text = tostring(math.floor(rel * 255))
						fills[activeCh].Size = UDim2.new(rel, 0, 1, 0)
						setFromSliders()
					end
				end)
				UserInputService.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingChannel = false end
				end)

				container.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						pickerOpen = not pickerOpen; pickerFrame.Visible = pickerOpen
						container.Size = pickerOpen and UDim2.new(1, 0, 0, 40 + 130) or UDim2.new(1, 0, 0, 40)
					end
				end)
				register({type = "ColorPicker", cont = container, label = label, preview = preview})
			end

			function info:CreateKeybind(text, default, callback)
				local key = default or Enum.KeyCode.F
				local listening = false

				local container = Instance.new("Frame")
				container.Size = UDim2.new(1, 0, 0, 35)
				container.BackgroundColor3 = C.Button
				container.Parent = pageRef
				Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

				local label = Instance.new("TextLabel")
				label.Name = "Label"
				label.Size = UDim2.new(1, -100, 1, 0)
				label.Position = UDim2.new(0, 10, 0, 0)
				label.BackgroundTransparency = 1; label.Text = text
				label.TextColor3 = C.Text; label.Font = Enum.Font.Gotham
				label.TextSize = 14; label.TextXAlignment = Enum.TextXAlignment.Left
				label.Parent = container

				local keyBtn = Instance.new("TextButton")
				keyBtn.Name = "KeyBtn"
				keyBtn.Size = UDim2.new(0, 70, 0, 26)
				keyBtn.Position = UDim2.new(1, -80, 0.5, -13)
				keyBtn.BackgroundColor3 = C.InputBackground
				keyBtn.TextColor3 = C.Text
				keyBtn.Font = Enum.Font.GothamSemibold
				keyBtn.TextSize = 12
				keyBtn.Text = key.Name
				keyBtn.Parent = container
				Instance.new("UICorner", keyBtn).CornerRadius = UDim.new(0, 4)

				local conn
				keyBtn.MouseButton1Click:Connect(function()
					listening = true
					keyBtn.Text = "..."
					keyBtn.TextColor3 = C.Accent
					conn = UserInputService.InputBegan:Connect(function(input, gpe)
						if gpe then return end
						if input.UserInputType == Enum.UserInputType.Keyboard then
							key = input.KeyCode
							keyBtn.Text = key.Name
							keyBtn.TextColor3 = C.Text
							listening = false
							conn:Disconnect()
						end
					end)
				end)

				table.insert(keybinds, {
					key = key,
					callback = callback,
				})

				register({type = "Keybind", cont = container, label = label, keyBtn = keyBtn})
			end

			function info:CreateSection(text)
				local container = Instance.new("Frame")
				container.BackgroundTransparency = 1
				container.Parent = pageRef

				local header = Instance.new("TextButton")
				header.Name = "Header"
				header.Size = UDim2.new(1, 0, 0, 30)
				header.BackgroundColor3 = C.Sidebar
				header.Text = "  " .. text .. "  ▼"
				header.TextColor3 = C.Accent
				header.Font = Enum.Font.GothamBold
				header.TextSize = 13
				header.TextXAlignment = Enum.TextXAlignment.Left
				header.Parent = container
				Instance.new("UICorner", header).CornerRadius = UDim.new(0, 6)

				local content = Instance.new("Frame")
				content.Name = "Content"
				content.Size = UDim2.new(1, 0, 0, 0)
				content.Position = UDim2.new(0, 0, 0, 30)
				content.BackgroundTransparency = 1
				content.ClipsDescendants = true
				content.Parent = container

				local contentLayout = Instance.new("UIListLayout", content)
				contentLayout.Padding = UDim.new(0, 5)
				contentLayout.SortOrder = Enum.SortOrder.LayoutOrder

				local contentPad = Instance.new("UIPadding", content)
				contentPad.PaddingLeft = UDim.new(0, 10)

				local collapsed = false
				local contentH = 0

				local function resizeContainer()
					contentH = contentLayout.AbsoluteContentSize.Y + 10
					local totalH = 30 + (collapsed and 0 or contentH)
					container.Size = UDim2.new(1, 0, 0, totalH)
					if not collapsed then
						content.Size = UDim2.new(1, 0, 0, contentH)
					end
				end
				contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(resizeContainer)
				header.MouseButton1Click:Connect(function()
					collapsed = not collapsed
					if collapsed then
						content:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
						container:TweenSize(UDim2.new(1, 0, 0, 30), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
						header.Text = "  " .. text .. "  ▶"
					else
						content:TweenSize(UDim2.new(1, 0, 0, contentH), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
						container:TweenSize(UDim2.new(1, 0, 0, 30 + contentH), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.2, true)
						header.Text = "  " .. text .. "  ▼"
					end
				end)

				register({type = "Section", header = header})
				task.spawn(resizeContainer)

				return createEl(content)
			end

			return info
		end

		-- Attach all element builders to TabInfo
		local elBuilder = createEl(page)
		for k, v in pairs(elBuilder) do
			TabInfo[k] = v
		end

		return TabInfo
	end

	return Window
end

return Library
