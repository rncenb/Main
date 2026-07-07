local Library = {}

function Library:CreateWindow(config)
    -- 1. Setup the Colors
    local colors = config.Colors or {}
    local bgCol = colors.Background or Color3.fromRGB(30, 30, 35)
    local sidebarCol = colors.Sidebar or Color3.fromRGB(20, 20, 25)
    local textCol = colors.Text or Color3.fromRGB(255, 255, 255)
    local buttonCol = colors.Button or Color3.fromRGB(45, 45, 50)
    local accentCol = colors.Accent or Color3.fromRGB(85, 170, 255)

    -- 2. Build the Main UI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ProCustomLibrary"
    screenGui.Parent = game.CoreGui 
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 450, 0, 280)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -140)
    mainFrame.BackgroundColor3 = bgCol
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 8) -- Rounded edges
    
    -- ==========================================
    -- SMOOTH DRAGGING LOGIC
    -- ==========================================
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    mainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    -- ==========================================
    
    -- 3. Build the Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 130, 1, 0)
    sidebar.BackgroundColor3 = sidebarCol
    sidebar.BorderSizePixel = 0
    sidebar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 50)
    title.BackgroundTransparency = 1
    title.Text = config.Title or "Pro Hub"
    title.TextColor3 = accentCol
    title.Font = Enum.Font.GothamBold -- Professional Font
    title.TextSize = 16
    title.Parent = sidebar

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = sidebar
    
    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabContainer

    -- 4. Container for the buttons
    local pagesFolder = Instance.new("Folder")
    pagesFolder.Name = "Pages"
    pagesFolder.Parent = mainFrame

    local Window = {}
    local firstTab = true
    
    -- 5. The Tab Creation Function
    function Window:CreateTab(tabName)
        -- The button in the sidebar
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, 0, 0, 35)
        tabBtn.BackgroundTransparency = 1
        tabBtn.Text = tabName
        tabBtn.TextColor3 = firstTab and accentCol or textCol
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 14
        tabBtn.Parent = tabContainer
        
        -- The invisible page that holds the buttons
        local page = Instance.new("ScrollingFrame")
        page.Size = UDim2.new(1, -130, 1, 0)
        page.Position = UDim2.new(0, 130, 0, 0)
        page.BackgroundTransparency = 1
        page.ScrollBarThickness = 4
        page.Visible = firstTab
        page.Parent = pagesFolder
        
        local pageLayout = Instance.new("UIListLayout")
        pageLayout.Padding = UDim.new(0, 5)
        pageLayout.Parent = page
        
        local pagePadding = Instance.new("UIPadding")
        pagePadding.PaddingTop = UDim.new(0, 10)
        pagePadding.PaddingLeft = UDim.new(0, 10)
        pagePadding.Parent = page

        -- Logic to switch tabs when clicked
        tabBtn.MouseButton1Click:Connect(function()
            for _, child in pairs(pagesFolder:GetChildren()) do child.Visible = false end
            for _, child in pairs(tabContainer:GetChildren()) do
                if child:IsA("TextButton") then child.TextColor3 = textCol end
            end
            page.Visible = true
            tabBtn.TextColor3 = accentCol
        end)

        firstTab = false
        local TabInfo = {}
        
        -- 6. The Button Creation Function
        function TabInfo:CreateButton(btnText, callback)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -20, 0, 35)
            btn.BackgroundColor3 = buttonCol
            btn.TextColor3 = textCol
            btn.Text = btnText
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.Parent = page
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6) -- Rounded buttons
            
            btn.MouseButton1Click:Connect(callback)
        end

        function TabInfo:CreateToggle(toggleText, callback)
            local container = Instance.new("Frame")
            container.Size = UDim2.new(1, -20, 0, 35)
            container.BackgroundColor3 = buttonCol
            container.Parent = page
            Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -55, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = toggleText
            label.TextColor3 = textCol
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.Parent = container

            local track = Instance.new("Frame")
            track.Size = UDim2.new(0, 42, 0, 22)
            track.Position = UDim2.new(1, -52, 0.5, -11)
            track.BackgroundColor3 = Color3.fromRGB(85, 85, 90)
            track.BorderSizePixel = 0
            track.Parent = container
            Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 18, 0, 18)
            knob.Position = UDim2.new(0, 2, 0.5, -9)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            knob.BorderSizePixel = 0
            knob.Parent = track
            Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

            local toggled = false
            local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

            local function updateToggle()
                if toggled then
                    TweenService:Create(track, tweenInfo, {BackgroundColor3 = accentCol}):Play()
                    knob:TweenPosition(UDim2.new(0, 22, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                else
                    TweenService:Create(track, tweenInfo, {BackgroundColor3 = Color3.fromRGB(85, 85, 90)}):Play()
                    knob:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                end
                callback(toggled)
            end

            container.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    toggled = not toggled
                    updateToggle()
                end
            end)
        end
        
        return TabInfo
    end
    
    return Window
end

return Library

