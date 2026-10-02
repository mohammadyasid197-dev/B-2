-- [[ ZAB PRO LITE - by zab ]] --
-- Loadstring Edition

if getgenv and getgenv().ZabLite then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "ZAB PRO", Text = "Sudah loaded!", Duration = 3
    })
    return
end
getgenv().ZabLite = true

local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local SG = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local Lighting = game:GetService("Lighting")

local function notify(title, text)
    pcall(function()
        SG:SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
    end)
end

-- Watermark
local wmGui = Instance.new("ScreenGui")
wmGui.ResetOnSpawn = false
pcall(function() wmGui.Parent = CoreGui end)
if not wmGui.Parent then wmGui.Parent = LP:WaitForChild("PlayerGui") end

local wm = Instance.new("TextLabel", wmGui)
wm.Size = UDim2.new(0, 300, 0, 40)
wm.Position = UDim2.new(0, 10, 0, 10)
wm.BackgroundTransparency = 1
wm.Text = "🔥 ZAB PRO"
wm.TextColor3 = Color3.fromRGB(255, 30, 30)
wm.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
wm.TextStrokeTransparency = 0
wm.Font = Enum.Font.GothamBlack
wm.TextSize = 26
wm.TextXAlignment = Enum.TextXAlignment.Left

task.spawn(function()
    local hue = 0
    while wmGui.Parent do
        hue = (hue + 0.005) % 1
        wm.TextColor3 = Color3.fromHSV(hue, 1, 1)
        task.wait(0.05)
    end
end)

-- GUI
local sg = Instance.new("ScreenGui")
sg.Name = "ZabLite"
sg.ResetOnSpawn = false
pcall(function() sg.Parent = CoreGui end)
if not sg.Parent then sg.Parent = LP:WaitForChild("PlayerGui") end

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 260, 0, 420)
main.Position = UDim2.new(0.05, 0, 0.15, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 5, 10)
main.BorderSizePixel = 0
main.ClipsDescendants = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(255, 50, 50)

local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 32)
titleBar.BackgroundColor3 = Color3.fromRGB(80, 10, 10)
titleBar.BorderSizePixel = 0
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleTxt = Instance.new("TextLabel", titleBar)
titleTxt.Size = UDim2.new(1, -10, 1, 0)
titleTxt.Position = UDim2.new(0, 10, 0, 0)
titleTxt.BackgroundTransparency = 1
titleTxt.Text = "🔥 ZAB PRO | by zab"
titleTxt.TextColor3 = Color3.fromRGB(255, 255, 255)
titleTxt.Font = Enum.Font.GothamBlack
titleTxt.TextSize = 13
titleTxt.TextXAlignment = Enum.TextXAlignment.Left

local scroll = Instance.new("ScrollingFrame", main)
scroll.Size = UDim2.new(1, 0, 1, -32)
scroll.Position = UDim2.new(0, 0, 0, 32)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = Color3.fromRGB(255, 50, 50)
scroll.CanvasSize = UDim2.new(0, 0, 0, 600)

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)

local pad = Instance.new("UIPadding", scroll)
pad.PaddingTop = UDim.new(0, 5)
pad.PaddingLeft = UDim.new(0, 5)
pad.PaddingRight = UDim.new(0, 5)

-- Drag
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = main.Position
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local d = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local function makeBtn(text, callback, color)
    local b = Instance.new("TextButton", scroll)
    b.Size = UDim2.new(1, 0, 0, 30)
    b.BackgroundColor3 = Color3.fromRGB(30, 10, 15)
    b.BorderSizePixel = 0
    b.Text = text
    b.TextColor3 = color or Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.AutoButtonColor = false
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)
    local s = Instance.new("UIStroke", b)
    s.Thickness = 1
    s.Color = Color3.fromRGB(150, 20, 20)
    b.MouseEnter:Connect(function() b.BackgroundColor3 = Color3.fromRGB(60, 15, 20) end)
    b.MouseLeave:Connect(function() b.BackgroundColor3 = Color3.fromRGB(30, 10, 15) end)
    b.MouseButton1Click:Connect(callback)
    return b
end

local function makeSection(t)
    local l = Instance.new("TextLabel", scroll)
    l.Size = UDim2.new(1, 0, 0, 20)
    l.BackgroundTransparency = 1
    l.Text = "═══ " .. t .. " ═══"
    l.TextColor3 = Color3.fromRGB(255, 100, 100)
    l.Font = Enum.Font.GothamBold
    l.TextSize = 10
end

-- IMAGE INPUT
makeSection("📷 GAMBAR")
local imgBox = Instance.new("TextBox", scroll)
imgBox.Size = UDim2.new(1, 0, 0, 28)
imgBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
imgBox.BorderSizePixel = 0
imgBox.PlaceholderText = "Paste ID Gambar"
imgBox.TextColor3 = Color3.fromRGB(255, 255, 255)
imgBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
imgBox.Font = Enum.Font.Code
imgBox.TextSize = 11
Instance.new("UICorner", imgBox).CornerRadius = UDim.new(0, 4)

-- WALL TEXTURE
makeSection("🧱 TEKSTUR")
local wallOn = false
local wallBtn = makeBtn("🧱 Dinding → Gambar: OFF", function()
    local id = imgBox.Text:gsub("%D", "")
    if id == "" then notify("⚠️ Error", "Isi ID dulu!") return end
    wallOn = not wallOn
    if wallOn then
        local c = 0
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Name ~= "HumanoidRootPart" then
                if obj.Size.X > 3 or obj.Size.Y > 3 or obj.Size.Z > 3 then
                    for _, ch in ipairs(obj:GetChildren()) do
                        if ch:IsA("Texture") or ch:IsA("Decal") then ch:Destroy() end
                    end
                    local tex = Instance.new("Texture")
                    tex.Texture = "rbxassetid://" .. id
                    tex.Face = Enum.NormalId.Top
                    tex.StudsPerTileU = 10
                    tex.StudsPerTileV = 10
                    tex.Parent = obj
                    c = c + 1
                end
            end
        end
        wallBtn.Text = "🧱 Dinding: ON (" .. c .. ")"
        wallBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Texture") then obj:Destroy() end
        end
        wallBtn.Text = "🧱 Dinding → Gambar: OFF"
        wallBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end, Color3.fromRGB(200, 100, 100))

-- SKYBOX
makeSection("🌌 LANGIT")
local skyOn = false
local skyBtn = makeBtn("🌌 Langit → Gambar: OFF", function()
    local id = imgBox.Text:gsub("%D", "")
    if id == "" then notify("⚠️ Error", "Isi ID dulu!") return end
    skyOn = not skyOn
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    local sky = Instance.new("Sky")
    if skyOn then
        sky.SkyboxBk = "rbxassetid://" .. id
        sky.SkyboxDn = "rbxassetid://" .. id
        sky.SkyboxFt = "rbxassetid://" .. id
        sky.SkyboxLf = "rbxassetid://" .. id
        sky.SkyboxRt = "rbxassetid://" .. id
        sky.SkyboxUp = "rbxassetid://" .. id
    end
    sky.Parent = Lighting
    skyBtn.Text = skyOn and "🌌 Langit: ON" or "🌌 Langit → Gambar: OFF"
    skyBtn.TextColor3 = skyOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(100, 150, 255))

-- FIRE SELF
makeSection("🔥 API")
local fireOn = false
local fireBtn = makeBtn("🔥 Fire Self: OFF", function()
    fireOn = not fireOn
    local char = LP.Character
    if not char then return end
    if fireOn then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                local f = Instance.new("Fire")
                f.Size = 20
                f.Parent = p
                local l = Instance.new("PointLight")
                l.Brightness = 3
                l.Range = 30
                l.Parent = p
            end
        end
        fireBtn.Text = "🔥 Fire Self: ON"
        fireBtn.TextColor3 = Color3.fromRGB(255, 100, 0)
    else
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                for _, ch in ipairs(p:GetChildren()) do
                    if ch:IsA("Fire") or ch:IsA("PointLight") then ch:Destroy() end
                end
            end
        end
        fireBtn.Text = "🔥 Fire Self: OFF"
        fireBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end, Color3.fromRGB(255, 100, 0))

-- RGB
makeSection("🎨 KARAKTER")
local rgbOn = false
local hue = 0
RS.Heartbeat:Connect(function()
    if not rgbOn then return end
    hue = (hue + 0.01) % 1
    local char = LP.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.Color = Color3.fromHSV(hue, 1, 1) end
    end
end)
local rgbBtn = makeBtn("🌈 RGB: OFF", function()
    rgbOn = not rgbOn
    rgbBtn.Text = rgbOn and "🌈 RGB: ON" or "🌈 RGB: OFF"
    rgbBtn.TextColor3 = rgbOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(255, 100, 200))

-- MOVEMENT
makeSection("⚡ MOVEMENT")
local spdOn = false
local spdBtn = makeBtn("⚡ Speed: OFF", function()
    spdOn = not spdOn
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.WalkSpeed = spdOn and 100 or 16 end
    spdBtn.Text = spdOn and "⚡ Speed: ON" or "⚡ Speed: OFF"
    spdBtn.TextColor3 = spdOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(255, 255, 100))

local jumpOn = false
local jumpBtn = makeBtn("🦘 Jump: OFF", function()
    jumpOn = not jumpOn
    local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = jumpOn and 150 or 50
    end
    jumpBtn.Text = jumpOn and "🦘 Jump: ON" or "🦘 Jump: OFF"
    jumpBtn.TextColor3 = jumpOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(255, 200, 100))

local flyOn = false
local flyBV, flyBG
RS.RenderStepped:Connect(function(dt)
    if not flyOn then return end
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end
    if not flyBV then
        flyBV = Instance.new("BodyVelocity", hrp)
        flyBV.MaxForce = Vector3.new(1e6,1e6,1e6)
        flyBG = Instance.new("BodyGyro", hrp)
        flyBG.MaxTorque = Vector3.new(1e6,1e6,1e6)
        flyBG.P = 10000
        hum.PlatformStand = true
    end
    local cam = workspace.CurrentCamera
    local v = hum.MoveDirection * 100
    if UIS:IsKeyDown(Enum.KeyCode.Space) then v = v + Vector3.new(0, 80, 0) end
    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then v = v - Vector3.new(0, 80, 0) end
    flyBV.Velocity = v
    flyBG.CFrame = cam.CFrame
end)
local flyBtn = makeBtn("🦅 Fly: OFF", function()
    flyOn = not flyOn
    if not flyOn then
        if flyBV then flyBV:Destroy() flyBV = nil end
        if flyBG then flyBG:Destroy() flyBG = nil end
        local hum = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
    end
    flyBtn.Text = flyOn and "🦅 Fly: ON" or "🦅 Fly: OFF"
    flyBtn.TextColor3 = flyOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(100, 200, 255))

local noclipOn = false
RS.Stepped:Connect(function()
    if not noclipOn then return end
    local char = LP.Character
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)
local noclipBtn = makeBtn("💫 Noclip: OFF", function()
    noclipOn = not noclipOn
    noclipBtn.Text = noclipOn and "💫 Noclip: ON" or "💫 Noclip: OFF"
    noclipBtn.TextColor3 = noclipOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(200, 150, 255))

-- ESP
makeSection("👁️ VISUAL")
local espOn = false
local espFolder = Instance.new("Folder", sg)
espFolder.Name = "ESP"
local function makeESP(p)
    if p == LP or not p.Character then return end
    local hl = Instance.new("Highlight")
    hl.Name = "HL_" .. p.Name
    hl.Adornee = p.Character
    hl.FillColor = Color3.fromRGB(255, 50, 50)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.5
    hl.Parent = espFolder
end
local espBtn = makeBtn("👁️ ESP: OFF", function()
    espOn = not espOn
    if espOn then
        for _, p in ipairs(Players:GetPlayers()) do makeESP(p) end
    else
        espFolder:ClearAllChildren()
    end
    espBtn.Text = espOn and "👁️ ESP: ON" or "👁️ ESP: OFF"
    espBtn.TextColor3 = espOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(255, 200, 0))
Players.PlayerAdded:Connect(function(p) if espOn then makeESP(p) end end)

-- FULLBRIGHT
local fbOn = false
local fbBtn = makeBtn("💡 Fullbright: OFF", function()
    fbOn = not fbOn
    if fbOn then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 5
        Lighting.ClockTime = 12
    else
        Lighting.Ambient = Color3.fromRGB(70, 70, 70)
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        Lighting.Brightness = 2
    end
    fbBtn.Text = fbOn and "💡 Fullbright: ON" or "💡 Fullbright: OFF"
    fbBtn.TextColor3 = fbOn and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 255, 255)
end, Color3.fromRGB(255, 255, 200))

-- RESET
makeSection("🔄 RESET")
local resetBtn = makeBtn("🔄 RESET SEMUA", function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") then obj:Destroy() end
    end
    for _, obj in ipairs(Lighting:GetChildren()) do
        if obj:IsA("Sky") then obj:Destroy() end
    end
    local sky = Instance.new("Sky")
    sky.Parent = Lighting
    local char = LP.Character
    if char then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                for _, ch in ipairs(p:GetChildren()) do
                    if ch:IsA("Fire") or ch:IsA("PointLight") then ch:Destroy() end
                end
            end
        end
    end
    notify("🔄 Reset", "Beres!")
end, Color3.fromRGB(200, 200, 200))

-- Footer
local foot = Instance.new("TextLabel", scroll)
foot.Size = UDim2.new(1, 0, 0, 30)
foot.BackgroundTransparency = 1
foot.Text = "🔥 ZAB PRO | by zab\nLite Edition"
foot.TextColor3 = Color3.fromRGB(255, 100, 100)
foot.Font = Enum.Font.Code
foot.TextSize = 9
foot.TextWrapped = true

task.spawn(function()
    while sg.Parent do
        scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
        task.wait(0.5)
    end
end)

notify("🔥 ZAB PRO", "Loaded! by zab")
print("=== ZAB PRO LITE LOADED ===")
