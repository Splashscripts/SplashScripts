-- SPLASH SCRIPTS v6.0 - German Voice Edition
-- Rayfield Classic (kompatibel mit Xeno)

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LP               = Players.LocalPlayer
local Camera           = workspace.CurrentCamera

local function getChar() return LP.Character end
local function getHRP()  local c = getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum()  local c = getChar() return c and c:FindFirstChild("Humanoid") end
local function getPlayerList()
    local t = {}
    for _, p in ipairs(Players:GetPlayers()) do if p ~= LP then table.insert(t, p.Name) end end
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

local function saveKey(k) pcall(function() writefile(KEY_FILE, k) end) end
local function loadKey()
    local ok, v = pcall(function() return readfile(KEY_FILE) end)
    return (ok and type(v) == "string") and v or ""
end

local function showKeyPanel(onSuccess)
    local sg = Instance.new("ScreenGui")
    sg.Name = "SplashKey"; sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true; sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LP:WaitForChild("PlayerGui")

    local blur = Instance.new("BlurEffect"); blur.Size = 18; blur.Parent = Lighting

    local dim = Instance.new("Frame", sg)
    dim.Size = UDim2.fromScale(1,1); dim.BackgroundColor3 = Color3.fromRGB(0,0,0)
    dim.BackgroundTransparency = 0.45; dim.BorderSizePixel = 0; dim.ZIndex = 1

    local card = Instance.new("Frame", sg)
    card.Size = UDim2.fromOffset(480,340); card.AnchorPoint = Vector2.new(0.5,0.5)
    card.Position = UDim2.new(0.5,0,1.5,0); card.BackgroundColor3 = Color3.fromRGB(6,10,28)
    card.BorderSizePixel = 0; card.ZIndex = 2
    Instance.new("UICorner", card).CornerRadius = UDim.new(0,18)
    local cg = Instance.new("UIGradient", card); cg.Rotation = 130
    cg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(9,18,55)),ColorSequenceKeypoint.new(1,Color3.fromRGB(4,8,22))})
    local cs = Instance.new("UIStroke", card); cs.Color = Color3.fromRGB(40,90,210); cs.Thickness = 1.8

    local topBar = Instance.new("Frame", card)
    topBar.Size = UDim2.new(1,0,0,3); topBar.BackgroundColor3 = Color3.fromRGB(50,120,255)
    topBar.BorderSizePixel = 0; topBar.ZIndex = 3
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0,18)
    local tg = Instance.new("UIGradient", topBar)
    tg.Color = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(20,70,255)),ColorSequenceKeypoint.new(0.5,Color3.fromRGB(100,170,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(20,70,255))})

    local titleLbl = Instance.new("TextLabel", card)
    titleLbl.Size = UDim2.new(1,0,0,44); titleLbl.Position = UDim2.fromOffset(0,20)
    titleLbl.BackgroundTransparency = 1; titleLbl.Text = "SPLASH SCRIPTS"
    titleLbl.TextColor3 = Color3.fromRGB(240,248,255); titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextSize = 24; titleLbl.ZIndex = 3

    local subLbl = Instance.new("TextLabel", card)
    subLbl.Size = UDim2.new(1,0,0,18); subLbl.Position = UDim2.fromOffset(0,62)
    subLbl.BackgroundTransparency = 1; subLbl.Text = "German Voice  ·  Key System"
    subLbl.TextColor3 = Color3.fromRGB(85,125,210); subLbl.Font = Enum.Font.Gotham
    subLbl.TextSize = 13; subLbl.ZIndex = 3

    local div = Instance.new("Frame", card)
    div.Size = UDim2.new(0.86,0,0,1); div.Position = UDim2.new(0.07,0,0,90)
    div.BackgroundColor3 = Color3.fromRGB(35,70,170); div.BorderSizePixel=0; div.ZIndex=3

    local discLbl = Instance.new("TextLabel", card)
    discLbl.Size = UDim2.new(0.86,0,0,18); discLbl.Position = UDim2.new(0.07,0,0,104)
    discLbl.BackgroundTransparency = 1; discLbl.Text = "Key holen → Trete dem Discord bei:"
    discLbl.TextColor3 = Color3.fromRGB(130,170,240); discLbl.Font = Enum.Font.GothamBold
    discLbl.TextSize = 12; discLbl.TextXAlignment = Enum.TextXAlignment.Left; discLbl.ZIndex = 3

    local discRow = Instance.new("Frame", card)
    discRow.Size = UDim2.new(0.86,0,0,36); discRow.Position = UDim2.new(0.07,0,0,126)
    discRow.BackgroundColor3 = Color3.fromRGB(8,14,44); discRow.BorderSizePixel=0; discRow.ZIndex=3
    Instance.new("UICorner",discRow).CornerRadius=UDim.new(0,9)
    local ds=Instance.new("UIStroke",discRow); ds.Color=Color3.fromRGB(30,70,180); ds.Thickness=1
    local dtxt=Instance.new("TextLabel",discRow); dtxt.Size=UDim2.new(1,-100,1,0); dtxt.Position=UDim2.fromOffset(12,0)
    dtxt.BackgroundTransparency=1; dtxt.Text=DISCORD_LINK; dtxt.TextColor3=Color3.fromRGB(85,150,255)
    dtxt.Font=Enum.Font.Gotham; dtxt.TextSize=12; dtxt.TextXAlignment=Enum.TextXAlignment.Left; dtxt.ZIndex=4
    local copyBtn=Instance.new("TextButton",discRow); copyBtn.Size=UDim2.fromOffset(80,26)
    copyBtn.Position=UDim2.new(1,-88,0.5,-13); copyBtn.BackgroundColor3=Color3.fromRGB(30,85,210)
    copyBtn.Text="Kopieren"; copyBtn.TextColor3=Color3.fromRGB(255,255,255); copyBtn.Font=Enum.Font.GothamBold
    copyBtn.TextSize=11; copyBtn.BorderSizePixel=0; copyBtn.ZIndex=5
    Instance.new("UICorner",copyBtn).CornerRadius=UDim.new(0,7)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        copyBtn.Text="✓ Kopiert"; copyBtn.BackgroundColor3=Color3.fromRGB(18,155,75)
        task.delay(2.5,function() copyBtn.Text="Kopieren"; copyBtn.BackgroundColor3=Color3.fromRGB(30,85,210) end)
    end)

    local keyLbl = Instance.new("TextLabel", card)
    keyLbl.Size = UDim2.new(0.86,0,0,18); keyLbl.Position = UDim2.new(0.07,0,0,174)
    keyLbl.BackgroundTransparency = 1; keyLbl.Text = "Key eingeben:"
    keyLbl.TextColor3 = Color3.fromRGB(130,170,240); keyLbl.Font = Enum.Font.GothamBold
    keyLbl.TextSize = 12; keyLbl.TextXAlignment = Enum.TextXAlignment.Left; keyLbl.ZIndex = 3

    local inputFrame=Instance.new("Frame",card); inputFrame.Size=UDim2.new(0.86,0,0,38)
    inputFrame.Position=UDim2.new(0.07,0,0,196); inputFrame.BackgroundColor3=Color3.fromRGB(8,14,44)
    inputFrame.BorderSizePixel=0; inputFrame.ZIndex=3
    Instance.new("UICorner",inputFrame).CornerRadius=UDim.new(0,9)
    local ist=Instance.new("UIStroke",inputFrame); ist.Color=Color3.fromRGB(30,70,180); ist.Thickness=1
    local keyBox=Instance.new("TextBox",inputFrame); keyBox.Size=UDim2.new(1,-16,1,0)
    keyBox.Position=UDim2.fromOffset(12,0); keyBox.BackgroundTransparency=1
    keyBox.PlaceholderText="Key hier eingeben..."; keyBox.PlaceholderColor3=Color3.fromRGB(55,85,145)
    keyBox.Text=""; keyBox.TextColor3=Color3.fromRGB(210,230,255); keyBox.Font=Enum.Font.Gotham
    keyBox.TextSize=13; keyBox.TextXAlignment=Enum.TextXAlignment.Left; keyBox.ClearTextOnFocus=false; keyBox.ZIndex=4
    keyBox.Focused:Connect(function() TweenService:Create(ist,TweenInfo.new(0.2),{Color=Color3.fromRGB(55,135,255),Thickness=2}):Play() end)
    keyBox.FocusLost:Connect(function() TweenService:Create(ist,TweenInfo.new(0.2),{Color=Color3.fromRGB(30,70,180),Thickness=1}):Play() end)

    local statusLbl=Instance.new("TextLabel",card); statusLbl.Size=UDim2.new(1,0,0,16)
    statusLbl.Position=UDim2.fromOffset(0,242); statusLbl.BackgroundTransparency=1; statusLbl.Text=""
    statusLbl.Font=Enum.Font.Gotham; statusLbl.TextSize=11; statusLbl.TextColor3=Color3.fromRGB(255,75,75)
    statusLbl.TextXAlignment=Enum.TextXAlignment.Center; statusLbl.ZIndex=3

    local confBtn=Instance.new("TextButton",card); confBtn.Size=UDim2.new(0.86,0,0,40)
    confBtn.Position=UDim2.new(0.07,0,0,262); confBtn.BackgroundColor3=Color3.fromRGB(32,95,230)
    confBtn.Text="Bestätigen"; confBtn.TextColor3=Color3.fromRGB(255,255,255); confBtn.Font=Enum.Font.GothamBold
    confBtn.TextSize=14; confBtn.BorderSizePixel=0; confBtn.ZIndex=3
    Instance.new("UICorner",confBtn).CornerRadius=UDim.new(0,11)
    Instance.new("UIGradient",confBtn).Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(50,125,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(18,60,200))})
    confBtn.MouseEnter:Connect(function() TweenService:Create(confBtn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(55,135,255)}):Play() end)
    confBtn.MouseLeave:Connect(function() TweenService:Create(confBtn,TweenInfo.new(0.12),{BackgroundColor3=Color3.fromRGB(32,95,230)}):Play() end)

    TweenService:Create(card,TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=UDim2.fromScale(0.5,0.5)}):Play()

    local function checkKey()
        if keyBox.Text == VALID_KEY then
            saveKey(keyBox.Text)
            confBtn.Text="Zugang gewährt!"; confBtn.BackgroundColor3=Color3.fromRGB(18,155,75)
            statusLbl.TextColor3=Color3.fromRGB(55,215,95); statusLbl.Text="Willkommen bei Splash Scripts!"
            task.delay(1.3, function()
                TweenService:Create(card,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Position=UDim2.new(0.5,0,-0.7,0)}):Play()
                task.wait(0.4)
                pcall(function() blur:Destroy() end)
                sg:Destroy()
                onSuccess()
            end)
        else
            statusLbl.Text="Falscher Key!  →  discord.gg/eyzfsAjpSr"
            TweenService:Create(ist,TweenInfo.new(0.1),{Color=Color3.fromRGB(255,55,55)}):Play()
            task.delay(1.5,function() TweenService:Create(ist,TweenInfo.new(0.25),{Color=Color3.fromRGB(30,70,180)}):Play() end)
        end
    end

    confBtn.MouseButton1Click:Connect(checkKey)
    keyBox.FocusLost:Connect(function(enter) if enter then checkKey() end end)
end

local function loadMain()
    -- Rayfield Classic laden
    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    local Window = Rayfield:CreateWindow({
        Name = "Splash Scripts",
        Icon = 0,
        LoadingTitle = "Splash Scripts",
        LoadingSubtitle = "German Voice Edition",
        Theme = "Ocean",
        ToggleUIKeybind = "K",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "SplashScripts",
            FileName = "SplashV6"
        },
        Discord = { Enabled = false },
        KeySystem = false
    })

    -- ── FLY TAB ─────────────────────────────────
    local FlyTab = Window:CreateTab("Fly", 0)
    local flyActive = false
    local flySpeed  = 80
    local flyConn, bv, bg

    local function cleanFly()
        flyActive = false
        if flyConn then flyConn:Disconnect(); flyConn = nil end
        if bv then bv:Destroy(); bv = nil end
        if bg then bg:Destroy(); bg = nil end
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
            if UserInputService:IsKeyDown(Enum.KeyCode.W)         then dir += cf.LookVector      end
            if UserInputService:IsKeyDown(Enum.KeyCode.S)         then dir -= cf.LookVector      end
            if UserInputService:IsKeyDown(Enum.KeyCode.A)         then dir -= cf.RightVector     end
            if UserInputService:IsKeyDown(Enum.KeyCode.D)         then dir += cf.RightVector     end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then dir += Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0) end
            local boost = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 4 or 1
            bv.Velocity = dir.Magnitude > 0 and dir.Unit*(flySpeed*boost) or Vector3.zero
            bg.CFrame = cf
        end)
    end

    FlyTab:CreateToggle({ Name = "Fly aktivieren", CurrentValue = false, Flag = "Fly",
        Callback = function(v) if v then startFly() else cleanFly() end end })
    FlyTab:CreateSlider({ Name = "Fly Speed", Range = {10,600}, Increment = 5, CurrentValue = 80, Flag = "FlySpd",
        Callback = function(v) flySpeed = v end })
    FlyTab:CreateParagraph({ Title = "Steuerung", Content = "W/A/S/D · Space = hoch · Shift = runter · Strg = 4x Speed · K = UI toggle" })

    -- ── FUN TAB ─────────────────────────────────
    local FunTab = Window:CreateTab("Fun", 0)
    local selP = getPlayerList()[1] or ""

    FunTab:CreateDropdown({ Name = "Spieler auswählen", Options = getPlayerList(), CurrentOption = selP, Flag = "SelP",
        Callback = function(v) selP = v end })
    FunTab:CreateButton({ Name = "Liste neu laden", Callback = function()
        selP = getPlayerList()[1] or ""
        Rayfield:Notify({ Title = "OK", Content = "Liste aktualisiert.", Duration = 2, Image = 4483362458 })
    end })

    FunTab:CreateSection("Fling & Teleport")

    FunTab:CreateButton({ Name = "Spieler flingen", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for i = 1, 10 do task.delay(i*0.01, function()
            local f = Instance.new("BodyVelocity"); f.MaxForce = Vector3.new(1e9,1e9,1e9)
            f.Velocity = Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent = hrp
            game:GetService("Debris"):AddItem(f, 0.1)
        end) end
        Rayfield:Notify({ Title = "Fling", Content = selP.." geflingt!", Duration = 2, Image = 4483362458 })
    end })

    FunTab:CreateButton({ Name = "Alle flingen", Callback = function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local hrp = p.Character:FindFirstChild("HumanoidRootPart"); if not hrp then continue end
                local f = Instance.new("BodyVelocity"); f.MaxForce = Vector3.new(1e9,1e9,1e9)
                f.Velocity = Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent = hrp
                game:GetService("Debris"):AddItem(f, 0.1)
            end
        end
    end })

    FunTab:CreateButton({ Name = "Zu Spieler TP", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local th, mh = tc:FindFirstChild("HumanoidRootPart"), getHRP()
        if th and mh then mh.CFrame = th.CFrame * CFrame.new(3,0,0) end
    end })

    FunTab:CreateButton({ Name = "Spieler zu mir TP", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local th, mh = tc:FindFirstChild("HumanoidRootPart"), getHRP()
        if th and mh then th.CFrame = mh.CFrame * CFrame.new(3,0,0) end
    end })

    FunTab:CreateButton({ Name = "Auf Kopf setzen", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local head, mh = tc:FindFirstChild("Head"), getHRP()
        if head and mh then mh.CFrame = CFrame.new(head.Position + Vector3.new(0,3.5,0)) end
    end })

    FunTab:CreateButton({ Name = "Hochkatapultieren", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local bv2 = Instance.new("BodyVelocity"); bv2.MaxForce = Vector3.new(0,1e9,0)
        bv2.Velocity = Vector3.new(0,2500,0); bv2.Parent = hrp
        game:GetService("Debris"):AddItem(bv2, 0.25)
    end })

    FunTab:CreateButton({ Name = "Einfrieren", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local hum = tc:FindFirstChild("Humanoid"); if not hum then return end
        local frozen = hum.WalkSpeed == 0
        hum.WalkSpeed = frozen and 16 or 0; hum.JumpPower = frozen and 50 or 0
        Rayfield:Notify({ Title = "Freeze", Content = selP..(frozen and " frei" or " eingefroren"), Duration = 2, Image = 4483362458 })
    end })

    FunTab:CreateButton({ Name = "Spin", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        task.spawn(function() for i=1,100 do hrp.CFrame = hrp.CFrame * CFrame.Angles(0,math.rad(20),0) task.wait(0.01) end end)
    end })

    FunTab:CreateButton({ Name = "Alle zu mir TP", Callback = function()
        local mh = getHRP(); if not mh then return end
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local h = p.Character:FindFirstChild("HumanoidRootPart")
                if h then h.CFrame = mh.CFrame * CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
            end
        end
    end })

    FunTab:CreateSection("Speed & Movement")

    FunTab:CreateToggle({ Name = "Super Speed", CurrentValue = false, Flag = "SSpd",
        Callback = function(v) local h = getHum(); if h then h.WalkSpeed = v and 120 or 16 end end })
    FunTab:CreateSlider({ Name = "Walk Speed", Range = {16,500}, Increment = 1, CurrentValue = 16, Flag = "WSpd",
        Callback = function(v) local h = getHum(); if h then h.WalkSpeed = v end end })
    FunTab:CreateToggle({ Name = "Inf Jump", CurrentValue = false, Flag = "InfJ",
        Callback = function(v)
            if v then UserInputService.JumpRequest:Connect(function()
                local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end) end
        end })
    FunTab:CreateSlider({ Name = "Jump Power", Range = {50,500}, Increment = 5, CurrentValue = 50, Flag = "JmpPow",
        Callback = function(v) local h = getHum(); if h then h.JumpPower = v end end })
    FunTab:CreateToggle({ Name = "Noclip", CurrentValue = false, Flag = "Noclip",
        Callback = function(v)
            if v then RunService.Stepped:Connect(function()
                local c = getChar(); if not c then return end
                for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end
            end) end
        end })
    FunTab:CreateToggle({ Name = "Unsichtbar", CurrentValue = false, Flag = "Invis",
        Callback = function(v)
            local c = getChar(); if not c then return end
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = v and 1 or 0 end
            end
        end })

    FunTab:CreateSection("Outfit")

    FunTab:CreateButton({ Name = "Outfit klauen", Callback = function()
        local tp = getTarget(selP); if not tp then return end
        local h = getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(tp.UserId)) end
        Rayfield:Notify({ Title = "Outfit", Content = "Outfit von "..selP.." geklaut!", Duration = 3, Image = 4483362458 })
    end })
    FunTab:CreateButton({ Name = "Eigenes Outfit zurück", Callback = function()
        local h = getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LP.UserId)) end
    end })
    FunTab:CreateButton({ Name = "Riesenkopf", Callback = function()
        local _, tc = getTarget(selP); if not tc then return end
        local head = tc:FindFirstChild("Head"); if head then head.Size = Vector3.new(6,6,6) end
    end })

    -- ── ESP TAB ─────────────────────────────────
    local EspTab = Window:CreateTab("ESP", 0)
    local espOn = false; local espHL = {}
    local espColor = Color3.fromRGB(40,120,255); local espFill = 0.5; local espWalls = true

    local function removeESP() for _,h in pairs(espHL) do pcall(function() h:Destroy() end) end espHL = {} end
    local function addESP(char, name)
        local h = Instance.new("Highlight"); h.FillColor = espColor; h.OutlineColor = Color3.fromRGB(255,255,255)
        h.FillTransparency = espFill; h.OutlineTransparency = 0
        h.DepthMode = espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        h.Parent = char; espHL[name] = h
    end
    local function buildESP() removeESP() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then addESP(p.Character,p.Name) end end end

    EspTab:CreateToggle({ Name = "ESP aktivieren", CurrentValue = false, Flag = "ESP",
        Callback = function(v) espOn=v; if v then buildESP() else removeESP() end end })
    EspTab:CreateColorPicker({ Name = "ESP Farbe", Color = espColor, Flag = "ESPCol",
        Callback = function(v) espColor=v; for _,h in pairs(espHL) do if h then h.FillColor=v end end end })
    EspTab:CreateSlider({ Name = "Transparenz", Range={0,10}, Increment=1, CurrentValue=5, Flag="ESPAlp",
        Callback = function(v) espFill=v/10; for _,h in pairs(espHL) do if h then h.FillTransparency=espFill end end end })
    EspTab:CreateToggle({ Name = "Durch Wände", CurrentValue=true, Flag="ESPWall",
        Callback = function(v) espWalls=v; for _,h in pairs(espHL) do if h then
            h.DepthMode=v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        end end end })
    EspTab:CreateButton({ Name = "ESP aktualisieren", Callback = function() if espOn then buildESP() end end })

    Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if espOn then task.wait(1); addESP(c,p.Name) end end) end)
    Players.PlayerRemoving:Connect(function(p) if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end); espHL[p.Name]=nil end end)

    -- ── WORLD TAB ───────────────────────────────
    local WorldTab = Window:CreateTab("World", 0)
    WorldTab:CreateToggle({ Name = "Fullbright", CurrentValue=false, Flag="Fullbright",
        Callback = function(v) Lighting.Brightness=v and 10 or 2; Lighting.GlobalShadows=not v; Lighting.FogEnd=v and 1e9 or 1e5 end })
    WorldTab:CreateSlider({ Name = "Helligkeit", Range={0,10}, Increment=1, CurrentValue=2, Flag="Bright",
        Callback = function(v) Lighting.Brightness=v end })
    WorldTab:CreateSlider({ Name = "Uhrzeit", Range={0,24}, Increment=1, CurrentValue=14, Flag="Clock",
        Callback = function(v) Lighting.ClockTime=v end })
    WorldTab:CreateToggle({ Name = "Fog entfernen", CurrentValue=false, Flag="NoFog",
        Callback = function(v) Lighting.FogEnd=v and 1e9 or 1e5; Lighting.FogStart=v and 1e9 or 0 end })
    WorldTab:CreateSlider({ Name = "Gravity", Range={0,400}, Increment=1, CurrentValue=196, Flag="Grav",
        Callback = function(v) workspace.Gravity=v end })
    WorldTab:CreateToggle({ Name = "Anti-Gravity", CurrentValue=false, Flag="NoGrav",
        Callback = function(v) workspace.Gravity=v and 0 or 196 end })

    -- ── PLAYER TAB ──────────────────────────────
    local PlayerTab = Window:CreateTab("Player", 0)
    PlayerTab:CreateToggle({ Name = "God Mode", CurrentValue=false, Flag="God",
        Callback = function(v) local h=getHum(); if h then h.MaxHealth=v and math.huge or 100; h.Health=v and math.huge or 100 end end })
    PlayerTab:CreateToggle({ Name = "Auto-Heal", CurrentValue=false, Flag="AHeal",
        Callback = function(v) if v then task.spawn(function() while v do local h=getHum(); if h then h.Health=h.MaxHealth end task.wait(0.1) end end) end end })
    PlayerTab:CreateSlider({ Name = "HP setzen", Range={1,1000}, Increment=1, CurrentValue=100, Flag="SetHP",
        Callback = function(v) local h=getHum(); if h then h.Health=v end end })
    PlayerTab:CreateButton({ Name = "Respawn", Callback = function() LP:LoadCharacter() end })
    PlayerTab:CreateSlider({ Name = "FOV", Range={30,120}, Increment=1, CurrentValue=70, Flag="FOV",
        Callback = function(v) Camera.FieldOfView=v end })

    -- ── SETTINGS TAB ────────────────────────────
    local SettingsTab = Window:CreateTab("Settings", 0)
    SettingsTab:CreateParagraph({ Title = "Splash Scripts v6.0", Content = "German Voice Edition\nDiscord: discord.gg/eyzfsAjpSr\nKey wird lokal gespeichert." })
    SettingsTab:CreateButton({ Name = "Key zurücksetzen", Callback = function()
        pcall(function() delfile(KEY_FILE) end)
        Rayfield:Notify({ Title = "Key", Content = "Key gelöscht. Nächster Start fragt neu.", Duration = 3, Image = 4483362458 })
    end })

    Rayfield:LoadConfiguration()
    Rayfield:Notify({ Title = "Splash Scripts", Content = "Geladen! Viel Spaß.", Duration = 4, Image = 4483362458 })
end

-- ════════════════════════════════════════
-- START
-- ════════════════════════════════════════

if loadKey() == VALID_KEY then
    task.spawn(loadMain)
else
    task.spawn(function() showKeyPanel(loadMain) end)
end
