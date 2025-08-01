local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Correct Place ID for "Steal a Brainrot" game
local PLACE_ID = 109983668079237

-- Script state
local scriptEnabled = false
local socket = nil
local reconnectAttempts = 0
local maxReconnectAttempts = 5

-- Mobile detection and configuration
local screenSize = workspace.CurrentCamera.ViewportSize
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

local Config = {
    GUI_NAME = "KontolHubAutojoiner",
    FRAME_SIZE = isMobile and {
        WIDTH = math.min(screenSize.X * 0.9, 360),
        HEIGHT = math.min(screenSize.Y * 0.6, 250)  -- Reduced height to remove empty space
    } or {
        WIDTH = 400,  -- Reduced width
        HEIGHT = 270  -- Reduced height to remove empty space
    },
    TEXT_SIZES = isMobile and {
        TITLE = 16,
        BUTTON = 12,
        INPUT = 10,
        STATUS = 10
    } or {
        TITLE = 18,  -- Slightly smaller
        BUTTON = 13,
        INPUT = 11,
        STATUS = 11
    },
    COLORS = {
        PRIMARY = Color3.fromRGB(15, 15, 25),
        SECONDARY = Color3.fromRGB(25, 25, 40),
        ACCENT = Color3.fromRGB(255, 50, 50),
        SUCCESS = Color3.fromRGB(50, 200, 100),
        DANGER = Color3.fromRGB(255, 80, 80),
        TEXT = Color3.fromRGB(240, 240, 250),
        TEXT_DIM = Color3.fromRGB(180, 180, 200)
    }
}

-- Auto-detect local IP addresses
local function getLocalIPs()
    local addresses = {
        "ws://127.0.0.1:8765",
        "ws://localhost:8765",
        "ws://10.66.6.16:8765"  -- Add the detected IP from server
    }
    
    return addresses
end

local addressList = getLocalIPs()

-- Clean up existing GUI
pcall(function() 
    if CoreGui:FindFirstChild(Config.GUI_NAME) then
        CoreGui:FindFirstChild(Config.GUI_NAME):Destroy() 
    end
end)

-- Create GUI
local gui = Instance.new("ScreenGui", CoreGui)
gui.Name = Config.GUI_NAME
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- 🪟 Main Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, Config.FRAME_SIZE.WIDTH, 0, Config.FRAME_SIZE.HEIGHT)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
frame.BackgroundTransparency = 0.3
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ZIndex = 1

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, isMobile and 12 or 16)

-- Add solid red border effect
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(255, 0, 0)
frameStroke.Transparency = 0.2
frameStroke.Thickness = 4

-- Simple red glow pulse (no RGB)
spawn(function()
    local cycle = 0
    while frameStroke.Parent do
        cycle = cycle + 1
        
        -- Simple red pulse effect
        local pulseIntensity = (math.sin(math.rad(cycle * 4)) + 1) * 0.1 + 0.15
        frameStroke.Transparency = pulseIntensity
        
        -- Keep consistent red color
        frameStroke.Color = Color3.fromRGB(255, 0, 0)
        
        wait(0.05) -- Smooth animation
    end
end)

-- 🔝 Top Bar
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, isMobile and 35 or 40)
topBar.BackgroundTransparency = 1  -- Fully transparent - no background
topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topBar.ZIndex = 4
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, isMobile and 12 or 16)

-- 🏷️ Expert Simple Title Design
-- Add full unified background for title extending to edges
local titleBackground = Instance.new("Frame", frame)  -- Parent to frame instead of topBar
titleBackground.AnchorPoint = Vector2.new(0, 0)
titleBackground.Position = UDim2.new(0, 0, 0, 0)  -- Start from top-left corner
titleBackground.Size = UDim2.new(1, 0, 0, isMobile and 35 or 40)  -- Full width, same height as topBar
titleBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  -- Dark black base (same as hop server)
titleBackground.BackgroundTransparency = 0.5  -- More transparent like hop server
titleBackground.BorderSizePixel = 0
titleBackground.ZIndex = 3  -- Behind topBar elements

-- Add black gradient to title background (same as hop server)
local titleGradient = Instance.new("UIGradient", titleBackground)
titleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),   -- Dark black
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)), -- Medium black
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))    -- Light black/gray
}
titleGradient.Rotation = 45  -- Diagonal gradient for dynamic effect

-- Add rounded corners only for top to match main frame
local titleCorner = Instance.new("UICorner", titleBackground)
titleCorner.CornerRadius = UDim.new(0, isMobile and 12 or 16)

-- Add bottom border line only
local titleBottomBorder = Instance.new("Frame", titleBackground)
titleBottomBorder.AnchorPoint = Vector2.new(0, 1)
titleBottomBorder.Position = UDim2.new(0, 0, 1, 0)  -- Full width from left edge
titleBottomBorder.Size = UDim2.new(1, 0, 0, 2)  -- 2 pixel height bottom line
titleBottomBorder.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
titleBottomBorder.BackgroundTransparency = 0.4
titleBottomBorder.BorderSizePixel = 0
titleBottomBorder.ZIndex = 4

local title = Instance.new("TextLabel", topBar)
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.Position = UDim2.new(0.5, 0, 0.5, 0)
title.Size = UDim2.new(0.6, 0, 0.8, 0)
title.Text = isMobile and "☠️ AUTO JOINER ☠️" or "☠️ AUTO JOINER ☠️"
title.TextColor3 = Color3.fromRGB(255, 0, 0)  -- Pure red text
title.Font = Enum.Font.GothamBold
title.TextSize = Config.TEXT_SIZES.TITLE
title.BackgroundTransparency = 1
title.ZIndex = 5
title.TextScaled = isMobile
title.TextXAlignment = Enum.TextXAlignment.Center

-- No stroke effect - just clean red text

-- ❌ Close Button
local closeBtn = Instance.new("TextButton", topBar)
closeBtn.Text = "✖"
closeBtn.Size = UDim2.new(0, isMobile and 30 or 35, 0, isMobile and 30 or 35)
closeBtn.Position = UDim2.new(1, isMobile and -35 or -40, 0, 2.5)
closeBtn.BackgroundColor3 = Config.COLORS.DANGER
closeBtn.TextColor3 = Config.COLORS.TEXT
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = isMobile and 14 or 16
closeBtn.ZIndex = 5
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, isMobile and 6 or 8)

-- 📊 Status Display
local statusLabel = Instance.new("TextLabel", frame)
statusLabel.Size = UDim2.new(1, -20, 0, isMobile and 24 or 28)
statusLabel.Position = UDim2.new(0, 10, 0, isMobile and 45 or 50)
statusLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
statusLabel.BackgroundTransparency = 0.3
statusLabel.Text = "Ready to connect"
statusLabel.TextColor3 = Config.COLORS.TEXT_DIM
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = Config.TEXT_SIZES.STATUS
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.TextScaled = true
statusLabel.ZIndex = 2
Instance.new("UICorner", statusLabel).CornerRadius = UDim.new(0, isMobile and 6 or 8)

-- 📦 Job ID Input Box
local jobBox = Instance.new("TextBox", frame)
jobBox.PlaceholderText = "Current Server ID: " .. game.JobId
jobBox.Size = UDim2.new(1, -20, 0, isMobile and 30 or 35)
jobBox.Position = UDim2.new(0, 10, 0, isMobile and 78 or 88)
jobBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
jobBox.BackgroundTransparency = 0.3
jobBox.TextColor3 = Config.COLORS.TEXT
jobBox.PlaceholderColor3 = Config.COLORS.TEXT_DIM
jobBox.ClearTextOnFocus = false
jobBox.Text = ""
jobBox.Font = Enum.Font.Gotham
jobBox.TextSize = Config.TEXT_SIZES.INPUT
jobBox.TextXAlignment = Enum.TextXAlignment.Center
jobBox.TextScaled = true
jobBox.ZIndex = 2
Instance.new("UICorner", jobBox).CornerRadius = UDim.new(0, isMobile and 6 or 8)

-- 🔘 Professional Button Container
local buttonContainer = Instance.new("Frame", frame)
buttonContainer.Size = UDim2.new(1, -20, 0, isMobile and 40 or 45)
buttonContainer.Position = UDim2.new(0, 10, 0, isMobile and 118 or 133)
buttonContainer.BackgroundTransparency = 1
buttonContainer.ZIndex = 2

-- Helper function to create professional buttons
local function createProfessionalButton(text, position, gradientColors, textColor, icon)
    local button = Instance.new("TextButton", buttonContainer)
    button.Text = ""
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = position
    button.BackgroundColor3 = gradientColors[1]
    button.BackgroundTransparency = 0.1
    button.BorderSizePixel = 0
    button.ZIndex = 3
    
    -- Professional rounded corners
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    
    -- Gradient effect
    local gradient = Instance.new("UIGradient", button)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, gradientColors[1]),
        ColorSequenceKeypoint.new(0.5, gradientColors[2]),
        ColorSequenceKeypoint.new(1, gradientColors[3])
    }
    gradient.Rotation = 45
    
    -- Professional glow stroke
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = gradientColors[2]
    stroke.Transparency = 0.3
    stroke.Thickness = 3
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    
    -- Button content container
    local contentFrame = Instance.new("Frame", button)
    contentFrame.Size = UDim2.new(1, 0, 1, 0)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ZIndex = 4
    
    -- Icon
    local iconLabel = Instance.new("TextLabel", contentFrame)
    iconLabel.Size = UDim2.new(0, isMobile and 20 or 24, 1, 0)
    iconLabel.Position = UDim2.new(0, 10, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = textColor
    iconLabel.TextSize = isMobile and 16 or 18
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.TextYAlignment = Enum.TextYAlignment.Center
    iconLabel.ZIndex = 5
    
    -- Text label
    local textLabel = Instance.new("TextLabel", contentFrame)
    textLabel.Size = UDim2.new(1, -40, 1, 0)
    textLabel.Position = UDim2.new(0, 35, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = textColor
    textLabel.TextSize = Config.TEXT_SIZES.BUTTON + 1
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.TextScaled = true
    textLabel.ZIndex = 5
    
    -- Professional hover effects
    local function createHoverEffect()
        spawn(function()
            local originalTransparency = button.BackgroundTransparency
            local originalStrokeTransparency = stroke.Transparency
            
            -- Pulse animation
            local pulseInfo = TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true)
            local pulseTween = TweenService:Create(stroke, pulseInfo, {
                Transparency = 0.1
            })
            pulseTween:Play()
            
            button.MouseEnter:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = 0.05
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Transparency = 0.1,
                    Thickness = 4
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(button, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    BackgroundTransparency = originalTransparency
                }):Play()
                TweenService:Create(stroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
                    Transparency = originalStrokeTransparency,
                    Thickness = 3
                }):Play()
            end)
            
            button.MouseButton1Down:Connect(function()
                -- Removed size animation for Discord button stability
                -- Original: Size = UDim2.new(0.98, 0, 0.95, 0)
            end)
            
            button.MouseButton1Up:Connect(function()
                -- Removed size animation for Discord button stability  
                -- Original: Size = UDim2.new(1, 0, 1, 0)
            end)
        end)
    end
    
    createHoverEffect()
    return button
end

-- Create professional manual hop button (left side)
local manualHopBtn = createProfessionalButton(
    "Hop Server", 
    UDim2.new(0, 0, 0, 0), 
    {
        Color3.fromRGB(20, 20, 20),   -- Dark black
        Color3.fromRGB(40, 40, 40),   -- Medium black  
        Color3.fromRGB(60, 60, 60)    -- Light black/gray
    },
    Color3.fromRGB(255, 255, 255),
    "🌐"
)
-- Resize hop button to take left half
manualHopBtn.Size = UDim2.new(0.48, 0, 1, 0)
manualHopBtn.Position = UDim2.new(0, 0, 0, 0)
-- Make hop button more transparent for black gradient
manualHopBtn.BackgroundTransparency = 0.5

-- 🔄 Professional Main Toggle Button (right side)
local toggleButton = Instance.new("TextButton", buttonContainer)
toggleButton.Text = ""
toggleButton.Size = UDim2.new(0.48, 0, 1, 0)
toggleButton.Position = UDim2.new(0.52, 0, 0, 0)
toggleButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)  -- Dark black for disconnected state
toggleButton.BackgroundTransparency = 0.5  -- More transparent like hop button
toggleButton.BorderSizePixel = 0
toggleButton.ZIndex = 3

-- Professional rounded corners for main button
local toggleCorner = Instance.new("UICorner", toggleButton)
toggleCorner.CornerRadius = UDim.new(0, isMobile and 15 or 18)

-- Dynamic gradient for main button
local toggleGradient = Instance.new("UIGradient", toggleButton)
toggleGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),   -- Dark black
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)), -- Medium black  
    ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))    -- Light black/gray
}
toggleGradient.Rotation = 45

-- Professional glow effect for main button
local toggleStroke = Instance.new("UIStroke", toggleButton)
toggleStroke.Color = Color3.fromRGB(40, 40, 40)  -- Match hop server stroke color
toggleStroke.Transparency = 0.2
toggleStroke.Thickness = 4
toggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

-- Main button content container
local toggleContent = Instance.new("Frame", toggleButton)
toggleContent.Size = UDim2.new(1, 0, 1, 0)
toggleContent.BackgroundTransparency = 1
toggleContent.ZIndex = 4

-- Main button icon
local toggleIcon = Instance.new("TextLabel", toggleContent)
toggleIcon.Size = UDim2.new(0, isMobile and 28 or 32, 1, 0)
toggleIcon.Position = UDim2.new(0, 15, 0, 0)
toggleIcon.BackgroundTransparency = 1
toggleIcon.Text = "⚡"
toggleIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleIcon.TextSize = isMobile and 20 or 24
toggleIcon.Font = Enum.Font.GothamBold
toggleIcon.TextXAlignment = Enum.TextXAlignment.Center
toggleIcon.TextYAlignment = Enum.TextYAlignment.Center
toggleIcon.ZIndex = 5

-- Main button text
local toggleText = Instance.new("TextLabel", toggleContent)
toggleText.Size = UDim2.new(1, -60, 1, 0)
toggleText.Position = UDim2.new(0, 50, 0, 0)
toggleText.BackgroundTransparency = 1
toggleText.Text = "CONNECT"
toggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleText.TextSize = Config.TEXT_SIZES.BUTTON + 2
toggleText.Font = Enum.Font.GothamBold
toggleText.TextXAlignment = Enum.TextXAlignment.Left
toggleText.TextYAlignment = Enum.TextYAlignment.Center
toggleText.TextScaled = true
toggleText.ZIndex = 5

-- Professional main button animations
spawn(function()
    while toggleButton.Parent do
        -- Dynamic gradient rotation
        for i = 0, 360, 2 do
            if not toggleButton.Parent then break end
            toggleGradient.Rotation = i
            wait(0.05)
        end
    end
end)

-- Function to update button appearance based on connection state
local function updateButtonState()
    if not isConnected then
        -- Disconnected state - black transparent gradient (same as hop server)
        toggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),   -- Dark black
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)), -- Medium black
            ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))    -- Light black/gray
        }
        toggleStroke.Color = Color3.fromRGB(40, 40, 40)  -- Match hop server stroke
        toggleButton.BackgroundTransparency = 0.5  -- Transparent
        toggleIcon.Text = "⚡"
        toggleText.Text = "CONNECT"
    else
        -- Connected state - green gradient
        toggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 255, 85)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(65, 255, 105)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 125))
        }
        toggleStroke.Color = Color3.fromRGB(50, 255, 100)
        toggleButton.BackgroundTransparency = 0.05  -- Less transparent when connected
        toggleIcon.Text = "❌"
        toggleText.Text = "DISCONNECT"
    end
end

-- Professional button state management
spawn(function()
    local cycle = 0
    while toggleButton.Parent do
        cycle = cycle + 1
        
        if not isConnected then
            -- Pulse effect for disconnected state
            local pulseIntensity = (math.sin(math.rad(cycle * 8)) + 1) * 0.1 + 0.1
            toggleStroke.Transparency = pulseIntensity
        else
            -- Green pulse when connected
            local greenPulse = (math.sin(math.rad(cycle * 6)) + 1) * 0.05 + 0.15
            toggleStroke.Transparency = greenPulse
        end
        
        wait(0.04) -- Smooth 25fps animation
    end
end)

-- Professional hover effects for main button
toggleButton.MouseEnter:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.3
    }):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Thickness = 5
    }):Play()
end)

toggleButton.MouseLeave:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        BackgroundTransparency = 0.5
    }):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
        Thickness = 4
    }):Play()
end)

toggleButton.MouseButton1Down:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Quad), {
        Size = UDim2.new(0.47, 0, 0.95, 0)
    }):Play()
end)

toggleButton.MouseButton1Up:Connect(function()
    TweenService:Create(toggleButton, TweenInfo.new(0.1, Enum.EasingStyle.Back), {
        Size = UDim2.new(0.48, 0, 1, 0)
    }):Play()
end)

-- ✨ Entrance Animation
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)

TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, Config.FRAME_SIZE.WIDTH, 0, Config.FRAME_SIZE.HEIGHT),
    Position = UDim2.new(0.5, -Config.FRAME_SIZE.WIDTH/2, 0.5, -Config.FRAME_SIZE.HEIGHT/2)
}):Play()

-- 💬 Discord Button (centered at bottom)
local discordButton = createProfessionalButton(
    "discord.gg/kontolhub", 
    UDim2.new(0, 0, 0, 0), 
    {
        Color3.fromRGB(20, 20, 20),   -- Dark black (same as hop server)
        Color3.fromRGB(40, 40, 40),   -- Medium black (same as hop server)
        Color3.fromRGB(60, 60, 60)    -- Light black/gray (same as hop server)
    },
    Color3.fromRGB(255, 255, 255),
    "💬"
)

-- Position Discord button below the main buttons
discordButton.Size = UDim2.new(1, -20, 0, isMobile and 38 or 42)
discordButton.Position = UDim2.new(0, 10, 0, isMobile and 168 or 188)
discordButton.Parent = frame
discordButton.ZIndex = 3
-- Make Discord button more transparent like hop button
discordButton.BackgroundTransparency = 0.5

-- 📝 Credit Text (bottom left corner) - positioned closer to Discord button
local creditText = Instance.new("TextLabel", frame)
creditText.Size = UDim2.new(0.6, 0, 0, isMobile and 20 or 22)
creditText.Position = UDim2.new(0, 10, 0, isMobile and 215 or 240)
creditText.BackgroundTransparency = 1
creditText.Text = "Made By KONTOL HUB ☠️"
creditText.TextColor3 = Color3.fromRGB(150, 150, 150)  -- Gray color
creditText.Font = Enum.Font.Gotham
creditText.TextSize = isMobile and 11 or 13  -- Increased font size for better readability
creditText.TextXAlignment = Enum.TextXAlignment.Left
creditText.TextYAlignment = Enum.TextYAlignment.Center
creditText.ZIndex = 5

-- Discord button click handler - Simple copy to clipboard only
discordButton.MouseButton1Click:Connect(function()
    -- KONTOL HUB Discord link for copying
    local discordText = "discord.gg/kontolhub"
    local discordInvite = "https://discord.gg/kontolhub"
    
    updateStatus("💬 Copying Discord link...")
    
    -- Try to copy to clipboard using different methods
    local copySuccess = false
    
    pcall(function()
        -- Try different clipboard methods
        if setclipboard then
            setclipboard(discordInvite)
            copySuccess = true
        elseif toclipboard then
            toclipboard(discordInvite)
            copySuccess = true
        elseif Clipboard and Clipboard.set then
            Clipboard.set(discordInvite)
            copySuccess = true
        elseif writeclipboard then
            writeclipboard(discordInvite)
            copySuccess = true
        end
    end)
    
    if copySuccess then
        updateStatus("✅ Discord link copied!")
        jobBox.Text = "✅ COPIED: " .. discordText
    else
        updateStatus("💬 Manual: " .. discordText)
        jobBox.Text = "Manual copy: " .. discordInvite
    end
    
    -- Clear message after 4 seconds
    spawn(function()
        wait(4)
        updateStatus("Ready to connect")
        jobBox.Text = ""
    end)
end)

-- Variables for autojoiner functionality
local isConnected = false
local socket = nil
local isAutojoinerEnabled = false
local httpPolling = false

-- Function to update status display
local function updateStatus(message)
    statusLabel.Text = message
end

-- BACKUP: Ultra-fast HTTP polling system for real-time Job ID detection
local function startHttpPolling()
    httpPolling = true
    spawn(function()
        updateStatus("⚡ REAL-TIME clipboard mode active!")
        local lastClipboard = ""
        
        while httpPolling and isConnected do
            local success, clipboard = pcall(function()
                -- Try multiple clipboard methods for compatibility
                if getclipboard then
                    return getclipboard()
                elseif Clipboard and Clipboard.get then
                    return Clipboard.get()
                elseif setclipboard then
                    -- If we have setclipboard, we likely have getclipboard too
                    return ""
                else
                    return ""
                end
            end)
            
            if success and clipboard and clipboard ~= lastClipboard and clipboard ~= "" then
                -- Check if it's a valid Job ID (UUID format)
                local jobId = string.match(clipboard, "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x")
                if jobId then
                    lastClipboard = clipboard
                    jobBox.Text = jobId
                    updateStatus("⚡ INSTANT Job ID detected: " .. jobId:sub(1,8) .. "...")
                    
                    if isAutojoinerEnabled then
                        updateStatus("🚀 ZERO DELAY - Teleporting NOW!")
                        
                        spawn(function()
                            local teleportSuccess, teleportErr = pcall(function()
                                TeleportService:TeleportToPlaceInstance(PLACE_ID, jobId, Players.LocalPlayer)
                            end)
                            
                            if not teleportSuccess then
                                updateStatus("❌ Teleport failed: " .. tostring(teleportErr))
                            else
                                updateStatus("✅ REAL-TIME joining server...")
                            end
                        end)
                    end
                end
            end
            
            wait(0.05) -- 50ms polling - ULTRA FAST for zero delay
        end
    end)
end

-- Function to connect to WebSocket server
local function connectToServer()
    if socket then
        pcall(function() socket:close() end)
        socket = nil
    end
    
    httpPolling = false
    
    spawn(function()
        local success, err = pcall(function()
            updateStatus("🔄 Connecting to server...")
            
            -- Try WebSocket connection using syn library or other methods
            local ws_url = "ws://localhost:8765"
            
            -- Check if syn.websocket is available (Synapse X)
            if syn and syn.websocket then
                socket = syn.websocket.connect(ws_url)
                updateStatus("✅ Synapse Connected! Waiting for Copy Job ID...")
            -- Check if WebSocket global is available
            elseif WebSocket then
                socket = WebSocket.connect(ws_url)
                updateStatus("✅ Connected! Waiting for Copy Job ID...")
            else
                -- Fallback to HTTP polling mode
                isConnected = true
                updateStatus("⚡ HTTP Real-time mode!")
                startHttpPolling()
                
                -- Update button state for HTTP mode
                toggleIcon.Text = "❌"
                toggleText.Text = "DISCONNECT"
                toggleGradient.Color = ColorSequence.new{
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 255, 85)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(65, 255, 105)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 125))
                }
                toggleStroke.Color = Color3.fromRGB(50, 255, 100)
                return -- Exit early for HTTP mode
            end
            
            isConnected = true
            
            -- Update button to show connected state for WebSocket mode
            toggleIcon.Text = "❌"
            toggleText.Text = "DISCONNECT"
            toggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 255, 85)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(65, 255, 105)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 255, 125))
            }
            toggleStroke.Color = Color3.fromRGB(50, 255, 100)
            
            -- REAL-TIME message handler for INSTANT Job ID processing
            socket.OnMessage:Connect(function(message)
                local jobId = message
                if jobId and jobId ~= "" then
                    jobBox.Text = jobId
                    updateStatus("⚡ INSTANT WebSocket Job ID!")
                    
                    if isAutojoinerEnabled then
                        updateStatus("🚀 ZERO DELAY - Joining NOW!")
                        
                        -- IMMEDIATE teleport with no delays
                        spawn(function()
                            local teleportSuccess, teleportErr = pcall(function()
                                TeleportService:TeleportToPlaceInstance(PLACE_ID, jobId, Players.LocalPlayer)
                            end)
                            
                            if not teleportSuccess then
                                updateStatus("❌ Join failed: " .. tostring(teleportErr))
                            else
                                updateStatus("✅ REAL-TIME joining server...")
                            end
                        end)
                    end
                end
            end)
            
            socket.OnClose:Connect(function()
                isConnected = false
                isAutojoinerEnabled = false
                httpPolling = false
                updateButtonState()
                updateStatus("❌ Connection lost!")
            end)
            
        end)
        
        if not success and not isConnected then
            isConnected = false
            httpPolling = false
            toggleIcon.Text = "⚡"
            toggleText.Text = "CONNECT"
            toggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
            }
            toggleStroke.Color = Color3.fromRGB(40, 40, 40)
            toggleButton.BackgroundTransparency = 0.5
            updateStatus("❌ Connection failed: " .. tostring(err))
        end
    end)
end

-- Function to disconnect from server
local function disconnectFromServer()
    if socket then
        pcall(function() socket:close() end)
        socket = nil
    end
    httpPolling = false
    isConnected = false
    isAutojoinerEnabled = false
    updateButtonState()
    updateStatus("⚪ Disconnected")
end

-- GUI Event Handlers
closeBtn.MouseButton1Click:Connect(function()
    disconnectFromServer()
    gui:Destroy()
end)

toggleButton.MouseButton1Click:Connect(function()
    if not isConnected then
        -- Immediately update visual state to show connecting
        toggleIcon.Text = "🔄"
        toggleText.Text = "CONNECTING..."
        toggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 165, 0)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 185, 20)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 205, 40))
        }
        toggleStroke.Color = Color3.fromRGB(255, 165, 0)
        
        isAutojoinerEnabled = true
        connectToServer()
    else
        -- Immediately update visual state to show disconnecting
        toggleIcon.Text = "⚡"
        toggleText.Text = "CONNECT"
        toggleGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),   -- Dark black
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(40, 40, 40)), -- Medium black
            ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))    -- Light black/gray
        }
        toggleStroke.Color = Color3.fromRGB(80, 80, 80)  -- Gray glow
        toggleButton.BackgroundTransparency = 0.5  -- Transparent
        
        disconnectFromServer()
    end
end)

manualHopBtn.MouseButton1Click:Connect(function()
    updateStatus("🔄 Manual server hopping...")
    local success, err = pcall(function()
        TeleportService:Teleport(109983668079237, Players.LocalPlayer)
    end)
    
    if not success then
        updateStatus("❌ Manual hop failed: " .. tostring(err))
    else
        updateStatus("✅ Server hopping...")
    end
end)

-- Initialize with improved status
updateStatus("🚀 KONTOL HUB - Ready for ZERO DELAY joining!")
print("🎯 KONTOL HUB AUTOJOINER - ULTRA FAST Edition Loaded!")
