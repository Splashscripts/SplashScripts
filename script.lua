-- SPLASH SCRIPTS v5.0
-- German Voice Edition

-- Services
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LP               = Players.LocalPlayer
local Camera           = workspace.CurrentCamera

-- Helpers
local function getChar() return LP.Character end
local function getHRP()  local c = getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum()  local c = getChar() return c and c:FindFirstChild("Humanoid") end
local function getPlayerList()
    local t = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(t, p.Name) end
    end
    if #t == 0 then table.insert(t, "(Niemand)") end
    return t
end
local function getTarget(name)
    local p = Players:FindFirstChild(name)
    if p and p.Character then return p, p.Character end
    return nil, nil
end

-- ════════════════════════════════════════
-- KEY SYSTEM
-- ════════════════════════════════════════

local VALID_KEY    = "SplashScripts2026!"
local DISCORD_LINK = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE     = "SplashKey.txt"

local function saveKey(k)  pcall(function() writefile(KEY_FILE, k) end) end
local function loadKey()
    local ok, v = pcall(function() return readfile(KEY_FILE) end)
    return (ok and type(v) == "string") and v or ""
end

if loadKey() ~= VALID_KEY then
    local keyDone = false

    -- Screen
    local sg = Instance.new("ScreenGui")
    sg.Name = "SplashKey"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LP:WaitForChild("PlayerGui")

    -- Blur
    local blur = Instance.new("BlurEffect")
    blur.Size = 18
    blur.Parent = Lighting

    -- Background dim
    local bg = Instance.new("Frame", sg)
    bg.Size = UDim2.fromScale(1, 1)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.45
    bg.BorderSizePixel = 0
    bg.ZIndex = 1

    -- Glow image behind card
    local glowImg = Instance.new("ImageLabel", sg)
    glowImg.Size = UDim2.fromOffset(580, 460)
    glowImg.AnchorPoint = Vector2.new(0.5, 0.5)
    glowImg.Position = UDim2.fromScale(0.5, 0.5)
    glowImg.BackgroundTransparency = 1
    glowImg.Image = "rbxassetid://5028857084"
    glowImg.ImageColor3 = Color3.fromRGB(15, 60, 255)
    glowImg.ImageTransparency = 0.6
    glowImg.ZIndex = 1

    -- Card
    local card = Instance.new("Frame", sg)
    card.Size = UDim2.fromOffset(480, 350)
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.Position = UDim2.new(0.5, 0, 1.5, 0) -- starts off screen
    card.BackgroundColor3 = Color3.fromRGB(6, 10, 28)
    card.BorderSizePixel = 0
    card.ZIndex = 2
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 18)

    -- Card gradient
    local cgrad = Instance.new("UIGradient", card)
    cgrad.Rotation = 130
    cgrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(9,  18, 55)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(4,  8,  22)),
    })

    -- Card border
    local cstroke = Instance.new("UIStroke", card)
    cstroke.Color = Color3.fromRGB(40, 90, 210)
    cstroke.Thickness = 1.8
    cstroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    -- Top color bar
    local topBar = Instance.new("Frame", card)
    topBar.Size = UDim2.new(1, 0, 0, 3)
    topBar.Position = UDim2.fromOffset(0, 0)
    topBar.BackgroundColor3 = Color3.fromRGB(50, 120, 255)
    topBar.BorderSizePixel = 0
    topBar.ZIndex = 3
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 18)
    local tgrad = Instance.new("UIGradient", topBar)
    tgrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(20,  70, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100,170, 255)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(20,  70, 255)),
    })

    -- Title
    local titleLbl = Instance.new("TextLabel", card)
    titleLbl.Size = UDim2.new(1, 0, 0, 44)
    titleLbl.Position = UDim2.fromOffset(0, 22)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "SPLASH SCRIPTS"
    titleLbl.TextColor3 = Color3.fromRGB(240, 248, 255)
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 24
    titleLbl.ZIndex = 3

    -- Subtitle
    local subLbl = Instance.new("TextLabel", card)
    subLbl.Size = UDim2.new(1, 0, 0, 18)
    subLbl.Position = UDim2.fromOffset(0, 64)
    subLbl.BackgroundTransparency = 1
    subLbl.Text = "German Voice  ·  Key System"
    subLbl.TextColor3 = Color3.fromRGB(85, 125, 210)
    subLbl.Font = Enum.Font.Gotham
    subLbl.TextSize = 13
    subLbl.ZIndex = 3

    -- Divider
    local divLine = Instance.new("Frame", card)
    divLine.Size = UDim2.new(0.86, 0, 0, 1)
    divLine.Position = UDim2.new(0.07, 0, 0, 94)
    divLine.BackgroundColor3 = Color3.fromRGB(35, 70, 170)
    divLine.BorderSizePixel = 0
    divLine.ZIndex = 3

    -- Discord label
    local discLbl = Instance.new("TextLabel", card)
    discLbl.Size = UDim2.new(0.86, 0, 0, 18)
    discLbl.Position = UDim2.new(0.07, 0, 0, 108)
    discLbl.BackgroundTransparency = 1
    discLbl.Text = "Key holen → Trete dem Discord bei:"
    discLbl.TextColor3 = Color3.fromRGB(130, 170, 240)
    discLbl.Font = Enum.Font.GothamBold
    discLbl.TextSize = 12
    discLbl.TextXAlignment = Enum.TextXAlignment.Left
    discLbl.ZIndex = 3

    -- Discord row
    local discRow = Instance.new("Frame", card)
    discRow.Size = UDim2.new(0.86, 0, 0, 38)
    discRow.Position = UDim2.new(0.07, 0, 0, 130)
    discRow.BackgroundColor3 = Color3.fromRGB(8, 14, 44)
    discRow.BorderSizePixel = 0
    discRow.ZIndex = 3
    Instance.new("UICorner", discRow).CornerRadius = UDim.new(0, 9)
    local dstroke = Instance.new("UIStroke", discRow)
    dstroke.Color = Color3.fromRGB(30, 70, 180)
    dstroke.Thickness = 1

    local discTxt = Instance.new("TextLabel", discRow)
    discTxt.Size = UDim2.new(1, -100, 1, 0)
    discTxt.Position = UDim2.fromOffset(12, 0)
    discTxt.BackgroundTransparency = 1
    discTxt.Text = DISCORD_LINK
    discTxt.TextColor3 = Color3.fromRGB(85, 150, 255)
    discTxt.Font = Enum.Font.Gotham
    discTxt.TextSize = 12
    discTxt.TextXAlignment = Enum.TextXAlignment.Left
    discTxt.ZIndex = 4

    local copyBtn = Instance.new("TextButton", discRow)
    copyBtn.Size = UDim2.fromOffset(82, 28)
    copyBtn.Position = UDim2.new(1, -90, 0.5, -14)
    copyBtn.BackgroundColor3 = Color3.fromRGB(30, 85, 210)
    copyBtn.Text = "Kopieren"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.TextSize = 11
    copyBtn.BorderSizePixel = 0
    copyBtn.ZIndex = 5
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 7)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        copyBtn.Text = "✓ Kopiert"
        copyBtn.BackgroundColor3 = Color3.fromRGB(18, 155, 75)
        task.delay(2.5, function()
            copyBtn.Text = "Kopieren"
            copyBtn.BackgroundColor3 = Color3.fromRGB(30, 85, 210)
        end)
    end)

    -- Key label
    local keyLbl = Instance.new("TextLabel", card)
    keyLbl.Size = UDim2.new(0.86, 0, 0, 18)
    keyLbl.Position = UDim2.new(0.07, 0, 0, 182)
    keyLbl.BackgroundTransparency = 1
    keyLbl.Text = "Key eingeben:"
    keyLbl.TextColor3 = Color3.fromRGB(130, 170, 240)
    keyLbl.Font = Enum.Font.GothamBold
    keyLbl.TextSize = 12
    keyLbl.TextXAlignment = Enum.TextXAlignment.Left
    keyLbl.ZIndex = 3

    -- Key input frame
    local inputFrame = Instance.new("Frame", card)
    inputFrame.Size = UDim2.new(0.86, 0, 0, 40)
    inputFrame.Position = UDim2.new(0.07, 0, 0, 204)
    inputFrame.BackgroundColor3 = Color3.fromRGB(8, 14, 44)
    inputFrame.BorderSizePixel = 0
    inputFrame.ZIndex = 3
    Instance.new("UICorner", inputFrame).CornerRadius = UDim.new(0, 9)
    local istroke = Instance.new("UIStroke", inputFrame)
    istroke.Color = Color3.fromRGB(30, 70, 180)
    istroke.Thickness = 1

    local keyBox = Instance.new("TextBox", inputFrame)
    keyBox.Size = UDim2.new(1, -16, 1, 0)
    keyBox.Position = UDim2.fromOffset(12, 0)
    keyBox.BackgroundTransparency = 1
    keyBox.PlaceholderText = "Key hier eingeben..."
    keyBox.PlaceholderColor3 = Color3.fromRGB(55, 85, 145)
    keyBox.Text = ""
    keyBox.TextColor3 = Color3.fromRGB(210, 230, 255)
    keyBox.Font = Enum.Font.Gotham
    keyBox.TextSize = 13
    keyBox.TextXAlignment = Enum.TextXAlignment.Left
    keyBox.ClearTextOnFocus = false
    keyBox.ZIndex = 4

    keyBox.Focused:Connect(function()
        TweenService:Create(istroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(55,135,255), Thickness = 2}):Play()
    end)
    keyBox.FocusLost:Connect(function()
        TweenService:Create(istroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(30,70,180), Thickness = 1}):Play()
    end)

    -- Status label
    local statusLbl = Instance.new("TextLabel", card)
    statusLbl.Size = UDim2.new(1, 0, 0, 18)
    statusLbl.Position = UDim2.fromOffset(0, 252)
    statusLbl.BackgroundTransparency = 1
    statusLbl.Text = ""
    statusLbl.Font = Enum.Font.Gotham
    statusLbl.TextSize = 11
    statusLbl.TextColor3 = Color3.fromRGB(255, 75, 75)
    statusLbl.TextXAlignment = Enum.TextXAlignment.Center
    statusLbl.ZIndex = 3

    -- Confirm button
    local confBtn = Instance.new("TextButton", card)
    confBtn.Size = UDim2.new(0.86, 0, 0, 42)
    confBtn.Position = UDim2.new(0.07, 0, 0, 274)
    confBtn.BackgroundColor3 = Color3.fromRGB(32, 95, 230)
    confBtn.Text = "Bestätigen"
    confBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    confBtn.Font = Enum.Font.GothamBold
    confBtn.TextSize = 14
    confBtn.BorderSizePixel = 0
    confBtn.ZIndex = 3
    Instance.new("UICorner", confBtn).CornerRadius = UDim.new(0, 11)
    local btnGrad = Instance.new("UIGradient", confBtn)
    btnGrad.Rotation = 90
    btnGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 125, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(18,  60, 200)),
    })
    confBtn.MouseEnter:Connect(function()
        TweenService:Create(confBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(55,135,255)}):Play()
    end)
    confBtn.MouseLeave:Connect(function()
        TweenService:Create(confBtn, TweenInfo.new(0.12), {BackgroundColor3 = Color3.fromRGB(32,95,230)}):Play()
    end)

    -- Animate card in
    TweenService:Create(card, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play()

    -- Key check function
    local function checkKey()
        local v = keyBox.Text
        if v == VALID_KEY then
            saveKey(v)
            confBtn.Text = "Zugang gewährt!"
            confBtn.BackgroundColor3 = Color3.fromRGB(18, 155, 75)
            statusLbl.TextColor3 = Color3.fromRGB(55, 215, 95)
            statusLbl.Text = "Willkommen bei Splash Scripts!"
            task.delay(1.3, function()
                TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5, 0, -0.7, 0)
                }):Play()
                task.wait(0.4)
                pcall(function() blur:Destroy() end)
                sg:Destroy()
                keyDone = true
            end)
        else
            statusLbl.Text = "Falscher Key!  →  discord.gg/eyzfsAjpSr"
            statusLbl.TextColor3 = Color3.fromRGB(255, 75, 75)
            TweenService:Create(istroke, TweenInfo.new(0.1), {Color = Color3.fromRGB(255,55,55)}):Play()
            task.delay(1.5, function()
                TweenService:Create(istroke, TweenInfo.new(0.25), {Color = Color3.fromRGB(30,70,180)}):Play()
            end)
        end
    end

    confBtn.MouseButton1Click:Connect(checkKey)
    keyBox.FocusLost:Connect(function(enter) if enter then checkKey() end end)

    -- Block until key is entered correctly
    while not keyDone do task.wait(0.05) end
end

-- ════════════════════════════════════════
-- LOAD RAYFIELD
-- ════════════════════════════════════════

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

-- ════════════════════════════════════════
-- THEME
-- ════════════════════════════════════════

local THEME = {
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(4,  7, 22)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(6, 11, 30)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(4,  8, 24)),
    }),
    ShadowColor            = Color3.fromRGB(0, 2, 8),
    LiveAnimation          = true,
    TitleFont              = Enum.Font.GothamBold,
    Font                   = Enum.Font.Gotham,
    TitlingColor           = Color3.fromRGB(230, 242, 255),
    ContentColor           = Color3.fromRGB(155, 185, 235),
    ElementTextHoverColor  = Color3.fromRGB(255, 255, 255),
    ActionColor            = Color3.fromRGB(120, 170, 255),
    SurfaceStroke          = Color3.fromRGB(18, 38, 100),
    CornerRoundness        = UDim.new(0, 14),
    PillCornerRadius       = UDim.new(0, 12),
    ElementCornerRadius    = UDim.new(0, 10),
    TabBackgroundColor     = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 45, 115)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 30,  85)),
    }),
    TabColor               = Color3.fromRGB(170, 210, 255),
    ElementGradient        = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 18, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 23, 62)),
    }),
    ElementStroke          = Color3.fromRGB(24, 50, 130),
    ElementStrokeHover     = Color3.fromRGB(65, 140, 255),
    ElementTransparency    = 0,
    AccentColor            = Color3.fromRGB(45, 120, 255),
    AccentStroke           = Color3.fromRGB(80, 160, 255),
    AccentGlow             = 0.35,
    SliderBackground       = Color3.fromRGB(7,  13, 38),
    SliderBackgroundHover  = Color3.fromRGB(11, 20, 55),
    SliderProgressColor    = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100,180, 255)),
    }),
    SliderHandle           = Color3.fromRGB(130, 190, 255),
    SliderStroke           = Color3.fromRGB(25, 60, 155),
    ToggleTrackColor       = Color3.fromRGB(7, 13, 38),
    ToggleTrackTransparency= 0,
    ToggleKnobOffColor     = Color3.fromRGB(65, 95, 160),
    FieldBackground        = Color3.fromRGB(6, 11, 34),
    FieldGlow              = Color3.fromRGB(35, 90, 230),
    PlaceholderColor       = Color3.fromRGB(65, 95, 165),
    DropdownHighlight      = Color3.fromRGB(22, 55, 150),
}

-- ════════════════════════════════════════
-- WINDOW
-- ════════════════════════════════════════

local window = Rayfield:CreateWindow({
    name           = "Splash Scripts",
    subtitle       = "German Voice  ·  v5.0",
    sidebarLayout  = true,
    theme          = THEME,
    collapsedLabel = "Splash Scripts",
    configuration  = { autoSave = true, autoLoad = true, fileName = "SplashV5" },
})

-- ════════════════════════════════════════
-- TAB: FLY
-- ════════════════════════════════════════

local flyTab    = window:CreateTab({ name = "Fly", icon = 0 })
local flyActive = false
local flySpeed  = 80
local flyConn, bv, bg

local function cleanFly()
    flyActive = false
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    if bv      then bv:Destroy();        bv      = nil end
    if bg      then bg:Destroy();        bg      = nil end
    local h = getHum(); if h then h.PlatformStand = false end
end

local function startFly()
    local hrp = getHRP(); local hum = getHum()
    if not hrp or not hum then return end
    cleanFly(); flyActive = true; hum.PlatformStand = true
    bv = Instance.new("BodyVelocity"); bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.Velocity = Vector3.zero; bv.Parent = hrp
    bg = Instance.new("BodyGyro"); bg.MaxTorque = Vector3.new(1e9,1e9,1e9); bg.D = 50; bg.P = 1200; bg.Parent = hrp
    flyConn = RunService.Heartbeat:Connect(function()
        if not flyActive then cleanFly() return end
        local h2 = getHRP(); if not h2 then cleanFly() return end
        local dir = Vector3.zero; local cf = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W)         then dir += cf.LookVector        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S)         then dir -= cf.LookVector        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A)         then dir -= cf.RightVector       end
        if UserInputService:IsKeyDown(Enum.KeyCode.D)         then dir += cf.RightVector       end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then dir += Vector3.new(0,1,0)   end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0)   end
        local boost = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 4 or 1
        bv.Velocity = dir.Magnitude > 0 and dir.Unit*(flySpeed*boost) or Vector3.zero
        bg.CFrame = cf
    end)
end

flyTab:CreateToggle({ name = "Fly aktivieren", currentValue = false, flag = "Fly",
    callback = function(v) if v then startFly() else cleanFly() end end })
flyTab:CreateSlider({ name = "Fly Speed", min = 10, max = 600, default = 80, flag = "FlySpd",
    callback = function(v) flySpeed = v end })
flyTab:CreateKeybind({ name = "Fly Keybind", currentKeybind = "F", flag = "FlyKey",
    callback = function() if flyActive then cleanFly() else startFly() end end })
flyTab:CreateLabel({ text = "W/A/S/D · Space = hoch · Shift = runter · Strg = 4x Speed" })

-- ════════════════════════════════════════
-- TAB: FUN
-- ════════════════════════════════════════

local funTab = window:CreateTab({ name = "Fun", icon = 0 })
local selP = getPlayerList()[1] or ""

funTab:CreateDropdown({ name = "Spieler auswählen", options = getPlayerList(),
    currentOption = selP, flag = "SelP", callback = function(v) selP = v end })
funTab:CreateButton({ name = "Liste neu laden", callback = function()
    selP = getPlayerList()[1] or ""
    window:Notify({ title = "OK", content = "Spielerliste aktualisiert." })
end })

funTab:CreateSection({ name = "Fling & Teleport" })

funTab:CreateButton({ name = "Spieler flingen", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    for i = 1, 10 do task.delay(i*0.01, function()
        local f = Instance.new("BodyVelocity"); f.MaxForce = Vector3.new(1e9,1e9,1e9)
        f.Velocity = Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent = hrp
        game:GetService("Debris"):AddItem(f, 0.1)
    end) end
    window:Notify({ title = "Fling", content = selP.." geflingt!" })
end })

funTab:CreateButton({ name = "Alle flingen", callback = function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart"); if not hrp then continue end
            local f = Instance.new("BodyVelocity"); f.MaxForce = Vector3.new(1e9,1e9,1e9)
            f.Velocity = Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent = hrp
            game:GetService("Debris"):AddItem(f, 0.1)
        end
    end
end })

funTab:CreateButton({ name = "Zu Spieler TP", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local th, mh = tc:FindFirstChild("HumanoidRootPart"), getHRP()
    if th and mh then mh.CFrame = th.CFrame * CFrame.new(3,0,0) end
end })

funTab:CreateButton({ name = "Spieler zu mir TP", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local th, mh = tc:FindFirstChild("HumanoidRootPart"), getHRP()
    if th and mh then th.CFrame = mh.CFrame * CFrame.new(3,0,0) end
end })

funTab:CreateButton({ name = "Auf Kopf setzen", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local head, mh = tc:FindFirstChild("Head"), getHRP()
    if head and mh then mh.CFrame = CFrame.new(head.Position + Vector3.new(0,3.5,0)) end
end })

funTab:CreateButton({ name = "Hochkatapultieren", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local bv2 = Instance.new("BodyVelocity"); bv2.MaxForce = Vector3.new(0,1e9,0)
    bv2.Velocity = Vector3.new(0,2500,0); bv2.Parent = hrp
    game:GetService("Debris"):AddItem(bv2, 0.25)
end })

funTab:CreateButton({ name = "Einfrieren", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local hum = tc:FindFirstChild("Humanoid"); if not hum then return end
    local frozen = hum.WalkSpeed == 0
    hum.WalkSpeed = frozen and 16 or 0; hum.JumpPower = frozen and 50 or 0
    window:Notify({ title = "Freeze", content = selP..(frozen and " frei" or " eingefroren") })
end })

funTab:CreateButton({ name = "Spin", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    task.spawn(function() for i=1,100 do hrp.CFrame = hrp.CFrame * CFrame.Angles(0,math.rad(20),0) task.wait(0.01) end end)
end })

funTab:CreateButton({ name = "Alle zu mir TP", callback = function()
    local mh = getHRP(); if not mh then return end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local h = p.Character:FindFirstChild("HumanoidRootPart")
            if h then h.CFrame = mh.CFrame * CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
        end
    end
end })

funTab:CreateSection({ name = "Speed & Movement" })

funTab:CreateToggle({ name = "Super Speed", currentValue = false, flag = "SSpd",
    callback = function(v) local h = getHum(); if h then h.WalkSpeed = v and 120 or 16 end end })
funTab:CreateSlider({ name = "Walk Speed", min = 16, max = 500, default = 120, flag = "WSpd",
    callback = function(v) local h = getHum(); if h then h.WalkSpeed = v end end })
funTab:CreateToggle({ name = "Inf Jump", currentValue = false, flag = "InfJ",
    callback = function(v)
        if v then UserInputService.JumpRequest:Connect(function()
            local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end) end
    end })
funTab:CreateSlider({ name = "Jump Power", min = 50, max = 500, default = 50, flag = "JmpPow",
    callback = function(v) local h = getHum(); if h then h.JumpPower = v end end })
funTab:CreateToggle({ name = "Noclip", currentValue = false, flag = "Noclip",
    callback = function(v)
        if v then RunService.Stepped:Connect(function()
            local c = getChar(); if not c then return end
            for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
        end) end
    end })
funTab:CreateToggle({ name = "Unsichtbar", currentValue = false, flag = "Invis",
    callback = function(v)
        local c = getChar(); if not c then return end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = v and 1 or 0 end
        end
    end })

funTab:CreateSection({ name = "Outfit" })

funTab:CreateButton({ name = "Outfit klauen", callback = function()
    local tp = getTarget(selP); if not tp then return end
    local desc = Players:GetHumanoidDescriptionFromUserId(tp.UserId)
    local h = getHum(); if h then h:ApplyDescription(desc) end
    window:Notify({ title = "Outfit", content = "Outfit von "..selP.." geklaut!" })
end })
funTab:CreateButton({ name = "Eigenes Outfit zurück", callback = function()
    local h = getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LP.UserId)) end
end })
funTab:CreateButton({ name = "Riesenkopf", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local head = tc:FindFirstChild("Head"); if head then head.Size = Vector3.new(6,6,6) end
end })

-- ════════════════════════════════════════
-- TAB: ESP
-- ════════════════════════════════════════

local espTab   = window:CreateTab({ name = "ESP", icon = 0 })
local espOn    = false
local espHL    = {}
local espColor = Color3.fromRGB(40, 120, 255)
local espFill  = 0.5
local espWalls = true

local function removeESP() for _, h in pairs(espHL) do pcall(function() h:Destroy() end) end espHL = {} end
local function addESP(char, name)
    local h = Instance.new("Highlight"); h.FillColor = espColor; h.OutlineColor = Color3.fromRGB(255,255,255)
    h.FillTransparency = espFill; h.OutlineTransparency = 0
    h.DepthMode = espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    h.Parent = char; espHL[name] = h
end
local function buildESP() removeESP() for _, p in ipairs(Players:GetPlayers()) do if p ~= LP and p.Character then addESP(p.Character, p.Name) end end end

espTab:CreateToggle({ name = "ESP aktivieren", currentValue = false, flag = "ESP",
    callback = function(v) espOn = v; if v then buildESP() else removeESP() end end })
espTab:CreateColorPicker({ name = "ESP Farbe", color = espColor, flag = "ESPCol",
    callback = function(v) espColor = v; for _, h in pairs(espHL) do if h then h.FillColor = v end end end })
espTab:CreateSlider({ name = "ESP Transparenz", min = 0, max = 10, default = 5, flag = "ESPAlp",
    callback = function(v) espFill = v/10; for _, h in pairs(espHL) do if h then h.FillTransparency = espFill end end end })
espTab:CreateToggle({ name = "Durch Wände", currentValue = true, flag = "ESPWall",
    callback = function(v) espWalls = v; for _, h in pairs(espHL) do if h then
        h.DepthMode = v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    end end end })
espTab:CreateButton({ name = "ESP aktualisieren", callback = function() if espOn then buildESP() end end })

Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if espOn then task.wait(1); addESP(c, p.Name) end end) end)
Players.PlayerRemoving:Connect(function(p) if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end); espHL[p.Name] = nil end end)

-- ════════════════════════════════════════
-- TAB: WORLD
-- ════════════════════════════════════════

local worldTab = window:CreateTab({ name = "World", icon = 0 })

worldTab:CreateToggle({ name = "Fullbright", currentValue = false, flag = "Fullbright",
    callback = function(v) Lighting.Brightness = v and 10 or 2; Lighting.GlobalShadows = not v; Lighting.FogEnd = v and 1e9 or 1e5 end })
worldTab:CreateSlider({ name = "Helligkeit", min = 0, max = 10, default = 2, flag = "Bright",
    callback = function(v) Lighting.Brightness = v end })
worldTab:CreateSlider({ name = "Uhrzeit", min = 0, max = 24, default = 14, flag = "Clock",
    callback = function(v) Lighting.ClockTime = v end })
worldTab:CreateToggle({ name = "Fog entfernen", currentValue = false, flag = "NoFog",
    callback = function(v) Lighting.FogEnd = v and 1e9 or 1e5; Lighting.FogStart = v and 1e9 or 0 end })
worldTab:CreateSlider({ name = "Gravity", min = 0, max = 400, default = 196, flag = "Grav",
    callback = function(v) workspace.Gravity = v end })
worldTab:CreateToggle({ name = "Anti-Gravity", currentValue = false, flag = "NoGrav",
    callback = function(v) workspace.Gravity = v and 0 or 196 end })

-- ════════════════════════════════════════
-- TAB: PLAYER
-- ════════════════════════════════════════

local playerTab = window:CreateTab({ name = "Player", icon = 0 })

playerTab:CreateToggle({ name = "God Mode", currentValue = false, flag = "God",
    callback = function(v) local h = getHum(); if h then h.MaxHealth = v and math.huge or 100; h.Health = v and math.huge or 100 end end })
playerTab:CreateToggle({ name = "Auto-Heal", currentValue = false, flag = "AHeal",
    callback = function(v) if v then task.spawn(function() while v do local h = getHum(); if h then h.Health = h.MaxHealth end task.wait(0.1) end end) end end })
playerTab:CreateSlider({ name = "HP setzen", min = 1, max = 1000, default = 100, flag = "SetHP",
    callback = function(v) local h = getHum(); if h then h.Health = v end end })
playerTab:CreateButton({ name = "Respawn", callback = function() LP:LoadCharacter() end })
playerTab:CreateSlider({ name = "FOV", min = 30, max = 120, default = 70, flag = "FOV",
    callback = function(v) Camera.FieldOfView = v end })

-- ════════════════════════════════════════
-- TAB: SETTINGS
-- ════════════════════════════════════════

local settingsTab = window:CreateTab({ name = "Settings", icon = 0 })

settingsTab:CreateDropdown({ name = "Theme", flag = "Theme",
    options = { "Midnight Blue", "Cobalt", "Amethyst", "Ember", "Frost", "Rose" },
    currentOption = "Midnight Blue",
    callback = function(v)
        local map = { ["Midnight Blue"] = THEME, Cobalt = "cobalt", Amethyst = "amethyst", Ember = "ember", Frost = "frost", Rose = "rose" }
        window:ChangeTheme(map[v] or "cobalt")
    end })

settingsTab:CreateLabel({ text = "Splash Scripts v5.0  —  German Voice" })
settingsTab:CreateLabel({ text = "Discord: discord.gg/eyzfsAjpSr" })
settingsTab:CreateLabel({ text = "Fly: W/A/S/D · Space · Shift · Strg=4x" })

settingsTab:CreateButton({ name = "Key zurücksetzen", callback = function()
    pcall(function() delfile(KEY_FILE) end)
    window:Notify({ title = "Key", content = "Key gelöscht. Nächster Start fragt neu." })
end })

-- ════════════════════════════════════════
-- DONE
-- ════════════════════════════════════════

window:Notify({ title = "Splash Scripts", content = "Geladen! Viel Spaß." })
