local Library = {
    Objects = {}, -- Keeps track of all created UI elements
    CurrentTheme = {
        Background = Color3.fromRGB(30, 30, 35),
        TitleBar = Color3.fromRGB(20, 20, 25),
        Button = Color3.fromRGB(50, 50, 55),
        Text = Color3.fromRGB(255, 255, 255)
    }
}

-- Function to update colors dynamically at any time
function Library:UpdateColor(elementTypeName, newColor)
    self.CurrentTheme[elementTypeName] = newColor
    
    -- Loop through all active objects and change their color instantly
    for _, item in ipairs(self.Objects) do
        if item.Type == "MainFrame" and elementTypeName == "Background" then
            item.Instance.BackgroundColor3 = newColor
        elseif item.Type == "TitleBar" and elementTypeName == "TitleBar" then
            item.Instance.BackgroundColor3 = newColor
        elseif item.Type == "Button" then
            if elementTypeName == "Button" then
                item.Instance.BackgroundColor3 = newColor
            elseif elementTypeName == "Text" then
                item.Instance.TextColor3 = newColor
            end
        elseif item.Type == "TextLabel" and elementTypeName == "Text" then
            item.Instance.TextColor3 = newColor
        end
    end
end

function Library:CreateWindow(config)
    -- Load initial custom colors if provided
    if config.Colors then
        for k, v in pairs(config.Colors) do
            self.CurrentTheme[k] = v
        end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "PublicCustomLibrary"
    screenGui.Parent = game.CoreGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 250)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -125)
    mainFrame.BackgroundColor3 = self.CurrentTheme.Background
    mainFrame.Parent = screenGui
    -- Track this frame
    table.insert(self.Objects, {Instance = mainFrame, Type = "MainFrame"})
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Text = config.Title or "Universal Hub"
    title.TextColor3 = self.CurrentTheme.Text
    title.BackgroundColor3 = self.CurrentTheme.TitleBar
    title.Parent = mainFrame
    table.insert(self.Objects, {Instance = title, Type = "TitleBar"})
    
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -30)
    tabContainer.Position = UDim2.new(0, 0, 0, 30)
    tabContainer.BackgroundTransparency = 1
    tabContainer.Parent = mainFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 5)
    layout.Parent = tabContainer

    local Window = {}
    
    function Window:CreateButton(buttonText, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 35)
        btn.Text = buttonText
        btn.BackgroundColor3 = Library.CurrentTheme.Button
        btn.TextColor3 = Library.CurrentTheme.Text
        btn.Parent = tabContainer
        table.insert(Library.Objects, {Instance = btn, Type = "Button"})
        
        btn.MouseButton1Click:Connect(callback)
    end
    
    return Window
end

return Library