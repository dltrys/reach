local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local currentKey = nil

local function setupCharacter(character)
    local humanoid = character:WaitForChild("Humanoid")
    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://88818114188382"
    local animator = humanoid:FindFirstChildOfClass("Animator") or Instance.new("Animator", humanoid)
    local animTrack = animator:LoadAnimation(animation)

    screenGui:ClearAllChildren()

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 100)
    frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    frame.Active = true
    frame.Draggable = true

    local playBtn = Instance.new("TextButton")
    playBtn.Size = UDim2.new(0, 180, 0, 40)
    playBtn.Position = UDim2.new(0, 10, 0, 10)
    playBtn.Text = "Play Animation"
    playBtn.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
    playBtn.TextColor3 = Color3.new(1, 1, 1)
    playBtn.Parent = frame

    playBtn.MouseButton1Click:Connect(function()
        animTrack:Play()
    end)

    local keybindBtn = Instance.new("TextButton")
    keybindBtn.Size = UDim2.new(0, 180, 0, 40)
    keybindBtn.Position = UDim2.new(0, 10, 0, 50)
    keybindBtn.Text = currentKey and ("Set Keybind (Current: " .. tostring(currentKey) .. ")") or "Set Keybind (Current: none)"
    keybindBtn.BackgroundColor3 = Color3.fromRGB(100, 50, 150)
    keybindBtn.TextColor3 = Color3.new(1, 1, 1)
    keybindBtn.TextScaled = true
    keybindBtn.Parent = frame

    local waitingForKey = false

    keybindBtn.MouseButton1Click:Connect(function()
        keybindBtn.Text = "Press a key..."
        waitingForKey = true
    end)

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if waitingForKey and input.UserInputType == Enum.UserInputType.Keyboard then
            currentKey = input.KeyCode
            keybindBtn.Text = "Set Keybind (Current: " .. tostring(currentKey) .. ")"
            waitingForKey = false
        elseif currentKey and input.KeyCode == currentKey and not gameProcessed then
            animTrack:Play()
        end
    end)
end

if player.Character then
    setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(char)
    setupCharacter(char)
end)
