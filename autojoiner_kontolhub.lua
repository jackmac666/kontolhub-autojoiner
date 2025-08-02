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
        HEIGHT = math.min(screenSize.Y * 0.6, 250)
    } or {
        WIDTH = 400,
        HEIGHT = 270
    },
    TEXT_SIZES = isMobile and {
        TITLE = 16,
        BUTTON = 12,
        INPUT = 10,
        STATUS = 10
    } or {
        TITLE = 18,
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

-- Main Frame
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

-- Simplified border (no animation to prevent lag)
local frameStroke = Instance.new("UIStroke", frame)
frameStroke.Color = Color3.fromRGB(255, 0, 0)
frameStroke.Transparency = 0.3
frameStroke.Thickness = 3

-- Top Bar
local topBar = Instance.new("Frame", frame)
topBar.Size = UDim2.new(1, 0, 0, isMobile and 35 or 40)
topBar.BackgroundTransparency = 1
topBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
topBar.ZIndex = 4
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, isMobile and 12 or 16)

-- Title Background
local titleBackground = Instance.new("Frame", frame)
titleBackground.AnchorPoint = Vector2.new(0, 0)
titleBackground.Position = UDim2.new(0, 0, 0, 0)
titleBackground.Size = UDim2.new(1, 0, 0, isMobile and 35 or 40)
titleBackground.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBackground.BackgroundTransparency = 0.5
titleBackground.BorderSizePixel = 0
titleBackground.ZIndex = 3

local titleCorner = Instance.new("UICorner", titleBackground)
titleCorner.CornerRadius = UDim.new(0, isMobile and 12 or 16)

-- Title
local title = Instance.new("TextLabel", topBar)
title.AnchorPoint = Vector2.new(0.5, 0.5)
title.Position = UDim2.new(0.5, 0, 0.5, 0)
title.Size = UDim2.new(0.6, 0, 0.8, 0)
title.Text = "☠️ AUTO JOINER ☠️"
title.TextColor3 = Color3.fromRGB(255, 0, 0)
title.Font = Enum.Font.GothamBold
title.TextSize = Config.TEXT_SIZES.TITLE
title.BackgroundTransparency = 1
title.ZIndex = 5
title.TextScaled = isMobile
title.TextXAlignment = Enum.TextXAlignment.Center

-- Close Button
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

-- Status Display
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

-- Job ID Input Box
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

-- Button Container
local buttonContainer = Instance.new("Frame", frame)
buttonContainer.Size = UDim2.new(1, -20, 0, isMobile and 40 or 45)
buttonContainer.Position = UDim2.new(0, 10, 0, isMobile and 118 or 133)
buttonContainer.BackgroundTransparency = 1
buttonContainer.ZIndex = 2

-- Simplified button creation (no complex animations)
local function createSimpleButton(text, position, color, textColor, icon)
    local button = Instance.new("TextButton", buttonContainer)
    button.Text = ""
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = position
    button.BackgroundColor3 = color
    button.BackgroundTransparency = 0.3
    button.BorderSizePixel = 0
    button.ZIndex = 3
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, isMobile and 12 or 15)
    
    local stroke = Instance.new("UIStroke", button)
    stroke.Color = color
    stroke.Transparency = 0.5
    stroke.Thickness = 2
    
    local iconLabel = Instance.new("TextLabel", button)
    iconLabel.Size = UDim2.new(0, isMobile and 20 or 24, 1, 0)
    iconLabel.Position = UDim2.new(0, 10, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = textColor
    iconLabel.TextSize = isMobile and 16 or 18
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.TextYAlignment = Enum.TextYAlignment.Center
    iconLabel.ZIndex = 4
    
    local textLabel = Instance.new("TextLabel", button)
    textLabel.Size = UDim2.new(1, -40, 1, 0)
    textLabel.Position = UDim2.new(0, 35, 0, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = textColor
    textLabel.TextSize = Config.TEXT_SIZES.BUTTON
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.TextYAlignment = Enum.TextYAlignment.Center
    textLabel.TextScaled = true
    textLabel.ZIndex = 4
    
    return button, iconLabel, textLabel, stroke
end

-- Create manual hop button
local manualHopBtn, hopIcon, hopText = createSimpleButton(
    "Hop Server", 
    UDim2.new(0, 0, 0, 0), 
    Color3.fromRGB(40, 40, 40),
    Color3.fromRGB(255, 255, 255),
    "🌐"
)
manualHopBtn.Size = UDim2.new(0.48, 0, 1, 0)

-- Create main toggle button
local toggleButton, toggleIcon, toggleText, toggleStroke = createSimpleButton(
    "CONNECT", 
    UDim2.new(0.52, 0, 0, 0), 
    Color3.fromRGB(40, 40, 40),
    Color3.fromRGB(255, 255, 255),
    "⚡"
)
toggleButton.Size = UDim2.new(0.48, 0, 1, 0)

-- Discord Button
local discordButton = createSimpleButton(
    "discord.gg/kontolhub", 
    UDim2.new(0, 10, 0, isMobile and 168 or 188), 
    Color3.fromRGB(40, 40, 40),
    Color3.fromRGB(255, 255, 255),
    "💬"
)
discordButton.Size = UDim2.new(1, -20, 0, isMobile and 38 or 42)
discordButton.Parent = frame

-- Credit Text
local creditText = Instance.new("TextLabel", frame)
creditText.Size = UDim2.new(0.6, 0, 0, isMobile and 20 or 22)
creditText.Position = UDim2.new(0, 10, 0, isMobile and 215 or 240)
creditText.BackgroundTransparency = 1
creditText.Text = "Made By KONTOL HUB ☠️"
creditText.TextColor3 = Color3.fromRGB(150, 150, 150)
creditText.Font = Enum.Font.Gotham
creditText.TextSize = isMobile and 11 or 13
creditText.TextXAlignment = Enum.TextXAlignment.Left
creditText.TextYAlignment = Enum.TextYAlignment.Center
creditText.ZIndex = 5

-- Variables for autojoiner functionality
local isConnected = false
local isAutojoinerEnabled = false
local httpPolling = false

-- Function to update status display
local function updateStatus(message)
    statusLabel.Text = message
end

-- Optimized HTTP polling (slower interval to prevent lag)
local function startHttpPolling()
    httpPolling = true
    print("⚡ KONTOL HUB: Starting optimized HTTP polling...")
    spawn(function()
        updateStatus("⚡ Real-time clipboard mode active!")
        local lastClipboard = ""
        
        while httpPolling and isConnected do
            local success, clipboard = pcall(function()
                if getclipboard then
                    return getclipboard()
                elseif Clipboard and Clipboard.get then
                    return Clipboard.get()
                else
                    return ""
                end
            end)
            
            if success and clipboard and clipboard ~= lastClipboard and clipboard ~= "" then
                local jobId = string.match(clipboard, "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x")
                if jobId then
                    lastClipboard = clipboard
                    jobBox.Text = jobId
                    print("📋 KONTOL HUB: Job ID detected - " .. jobId)
                    updateStatus("⚡ Job ID detected: " .. jobId:sub(1,8) .. "...")
                    
                    if isAutojoinerEnabled then
                        updateStatus("🚀 Teleporting NOW!")
                        print("🚀 KONTOL HUB: Teleporting to: " .. jobId)
                        
                        spawn(function()
                            local teleportSuccess, teleportErr = pcall(function()
                                TeleportService:TeleportToPlaceInstance(PLACE_ID, jobId, Players.LocalPlayer)
                            end)
                            
                            if not teleportSuccess then
                                print("❌ Teleport failed: " .. tostring(teleportErr))
                                updateStatus("❌ Server full! Waiting for next Job ID...")
                                
                                spawn(function()
                                    wait(3)
                                    if isConnected then
                                        updateStatus("⚡ Ready for next Job ID!")
                                        jobBox.Text = ""
                                    end
                                end)
                            else
                                updateStatus("✅ Joining server...")
                                print("✅ Successfully teleporting!")
                            end
                        end)
                    end
                end
            end
            
            wait(0.2) -- Slower polling to prevent lag (200ms instead of 50ms)
        end
        print("⚪ HTTP polling stopped")
    end)
end

-- Function to connect to server
local function connectToServer()
    httpPolling = false
    
    spawn(function()
        local success, err = pcall(function()
            updateStatus("🔄 Connecting...")
            
            -- Always use HTTP polling mode for stability
            isConnected = true
            updateStatus("⚡ Connected! Ready for Job IDs!")
            startHttpPolling()
            
            -- Update button appearance
            toggleIcon.Text = "❌"
            toggleText.Text = "DISCONNECT"
            toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
            toggleStroke.Color = Color3.fromRGB(50, 200, 100)
        end)
        
        if not success then
            print("❌ Connection failed: " .. tostring(err))
            isConnected = false
            httpPolling = false
            toggleIcon.Text = "⚡"
            toggleText.Text = "CONNECT"
            toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            toggleStroke.Color = Color3.fromRGB(40, 40, 40)
            updateStatus("❌ Connection failed!")
        end
    end)
end

-- Function to disconnect from server
local function disconnectFromServer()
    print("🔌 Disconnecting...")
    httpPolling = false
    isConnected = false
    isAutojoinerEnabled = false
    
    toggleIcon.Text = "⚡"
    toggleText.Text = "CONNECT"
    toggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleStroke.Color = Color3.fromRGB(40, 40, 40)
    updateStatus("⚪ Disconnected")
    print("⚪ Disconnected successfully!")
end

-- Event Handlers
closeBtn.MouseButton1Click:Connect(function()
    disconnectFromServer()
    gui:Destroy()
end)

toggleButton.MouseButton1Click:Connect(function()
    if not isConnected then
        toggleIcon.Text = "🔄"
        toggleText.Text = "CONNECTING..."
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 165, 0)
        toggleStroke.Color = Color3.fromRGB(255, 165, 0)
        
        isAutojoinerEnabled = true
        connectToServer()
    else
        disconnectFromServer()
    end
end)

manualHopBtn.MouseButton1Click:Connect(function()
    updateStatus("🔄 Manual server hopping...")
    print("🌐 Manual server hop initiated...")
    
    local success, err = pcall(function()
        TeleportService:Teleport(PLACE_ID, Players.LocalPlayer)
    end)
    
    if not success then
        print("❌ Manual hop failed: " .. tostring(err))
        updateStatus("❌ Manual hop failed!")
        
        spawn(function()
            wait(3)
            updateStatus("🚀 Ready for connections!")
        end)
    else
        updateStatus("✅ Server hopping...")
        print("✅ Manual hop successful!")
    end
end)

-- Discord button functionality
discordButton.MouseButton1Click:Connect(function()
    print("💬 Discord button clicked!")
    
    local discordInvite = "https://discord.gg/kontolhub"
    statusLabel.Text = "💬 Copying Discord link..."
    
    local copySuccess = false
    pcall(function()
        if setclipboard then
            setclipboard(discordInvite)
            copySuccess = true
        elseif toclipboard then
            toclipboard(discordInvite)
            copySuccess = true
        elseif writeclipboard then
            writeclipboard(discordInvite)
            copySuccess = true
        end
    end)
    
    if copySuccess then
        statusLabel.Text = "✅ Discord link copied!"
        jobBox.Text = "✅ COPIED: " .. discordInvite
    else
        statusLabel.Text = "💬 Manual: discord.gg/kontolhub"
        jobBox.Text = "Manual copy: " .. discordInvite
    end
    
    spawn(function()
        wait(4)
        statusLabel.Text = "🚀 Ready for connections!"
        jobBox.Text = ""
    end)
end)

-- Initialize
updateStatus("🚀 KONTOL HUB - Ready!")
print("🎯 KONTOL HUB AUTOJOINER - Optimized Edition Loaded!")
