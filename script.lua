-- SPLASH SCRIPTS v7.0 - German Voice Edition
-- 100% Custom UI - Deep Blue Theme

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
-- FARBEN & STYLE
-- ════════════════════════════════════════
local C = {
    bg        = Color3.fromRGB(5, 8, 22),
    sidebar   = Color3.fromRGB(7, 12, 32),
    card      = Color3.fromRGB(10, 17, 45),
    cardHover = Color3.fromRGB(14, 24, 62),
    accent    = Color3.fromRGB(45, 120, 255),
    accentDim = Color3.fromRGB(25, 70, 180),
    accentGlow= Color3.fromRGB(80, 160, 255),
    text      = Color3.fromRGB(220, 235, 255),
    textDim   = Color3.fromRGB(120, 155, 210),
    textMuted = Color3.fromRGB(70, 100, 165),
    success   = Color3.fromRGB(40, 200, 100),
    error     = Color3.fromRGB(255, 70, 70),
    stroke    = Color3.fromRGB(28, 55, 140),
    strokeHov = Color3.fromRGB(55, 120, 255),
    toggle_on = Color3.fromRGB(45, 120, 255),
    toggle_off= Color3.fromRGB(20, 35, 80),
    slider_bg = Color3.fromRGB(8, 14, 40),
    black     = Color3.fromRGB(0, 0, 0),
}

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

-- ════════════════════════════════════════
-- UI HELPER FUNCTIONS
-- ════════════════════════════════════════
local function mkCorner(parent, r)
    local c = Instance.new("UICorner", parent)
    c.CornerRadius = UDim.new(0, r or 8)
    return c
end
local function mkStroke(parent, color, thick)
    local s = Instance.new("UIStroke", parent)
    s.Color = color or C.stroke; s.Thickness = thick or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    return s
end
local function mkGrad(parent, c0, c1, rot)
    local g = Instance.new("UIGradient", parent)
    g.Color = ColorSequence.new(c0, c1)
    g.Rotation = rot or 90
    return g
end
local function mkLabel(parent, text, size, color, font, xa, ya)
    local l = Instance.new("TextLabel", parent)
    l.BackgroundTransparency = 1; l.Text = text
    l.TextSize = size or 13; l.TextColor3 = color or C.text
    l.Font = font or Enum.Font.Gotham
    l.TextXAlignment = xa or Enum.TextXAlignment.Left
    l.TextYAlignment = ya or Enum.TextYAlignment.Center
    l.Size = UDim2.new(1, 0, 1, 0)
    return l
end
local function tween(obj, props, t, style, dir)
    TweenService:Create(obj, TweenInfo.new(t or 0.15, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out), props):Play()
end
local function notify(title, content, color)
    -- Custom notification
    local ng = LP:WaitForChild("PlayerGui"):FindFirstChild("SplashNotif")
    if not ng then return end
    local nf = ng:FindFirstChild("Frame")
    if not nf then return end
    local nt = nf:FindFirstChild("Title")
    local nc = nf:FindFirstChild("Content")
    if nt then nt.Text = title end
    if nc then nc.Text = content end
    nf.BackgroundColor3 = color or C.card
    nf.Position = UDim2.new(1, -320, 1, -10)
    tween(nf, {Position = UDim2.new(1, -320, 1, -80)}, 0.4, Enum.EasingStyle.Back)
    task.delay(3, function()
        tween(nf, {Position = UDim2.new(1, -320, 1, 10)}, 0.3)
    end)
end

-- ════════════════════════════════════════
-- SHOW KEY PANEL
-- ════════════════════════════════════════
local function showKeyPanel(onSuccess)
    local sg = Instance.new("ScreenGui")
    sg.Name = "SplashKey"; sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true; sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LP:WaitForChild("PlayerGui")

    local blur = Instance.new("BlurEffect"); blur.Size = 20; blur.Parent = Lighting

    local dim = Instance.new("Frame", sg)
    dim.Size = UDim2.fromScale(1,1); dim.BackgroundColor3 = C.black
    dim.BackgroundTransparency = 0.4; dim.BorderSizePixel = 0; dim.ZIndex = 1

    local glow = Instance.new("ImageLabel", sg)
    glow.Size = UDim2.fromOffset(600,480); glow.AnchorPoint = Vector2.new(0.5,0.5)
    glow.Position = UDim2.fromScale(0.5,0.5); glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Color3.fromRGB(15,60,255); glow.ImageTransparency = 0.6; glow.ZIndex = 1

    local card = Instance.new("Frame", sg)
    card.Size = UDim2.fromOffset(480,345); card.AnchorPoint = Vector2.new(0.5,0.5)
    card.Position = UDim2.new(0.5,0,1.5,0); card.BorderSizePixel = 0; card.ZIndex = 2
    card.BackgroundColor3 = Color3.fromRGB(7,12,32)
    mkCorner(card, 18); mkStroke(card, C.accent, 1.5)
    mkGrad(card, Color3.fromRGB(9,18,55), Color3.fromRGB(4,8,22), 135)

    local topBar = Instance.new("Frame", card)
    topBar.Size = UDim2.new(1,0,0,3); topBar.BackgroundColor3 = C.accent
    topBar.BorderSizePixel = 0; topBar.ZIndex = 4; mkCorner(topBar, 18)
    mkGrad(topBar, Color3.fromRGB(20,70,255), Color3.fromRGB(100,170,255), 0)

    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1,0,0,46); title.Position = UDim2.fromOffset(0,18)
    title.BackgroundTransparency = 1; title.Text = "SPLASH SCRIPTS"
    title.TextColor3 = Color3.fromRGB(240,248,255); title.Font = Enum.Font.GothamBold
    title.TextSize = 25; title.ZIndex = 3; title.TextXAlignment = Enum.TextXAlignment.Center

    local sub = Instance.new("TextLabel", card)
    sub.Size = UDim2.new(1,0,0,18); sub.Position = UDim2.fromOffset(0,62)
    sub.BackgroundTransparency = 1; sub.Text = "German Voice  ·  Key System"
    sub.TextColor3 = C.textDim; sub.Font = Enum.Font.Gotham
    sub.TextSize = 13; sub.ZIndex = 3; sub.TextXAlignment = Enum.TextXAlignment.Center

    local div = Instance.new("Frame", card)
    div.Size = UDim2.new(0.88,0,0,1); div.Position = UDim2.new(0.06,0,0,90)
    div.BackgroundColor3 = C.stroke; div.BorderSizePixel=0; div.ZIndex=3
    mkGrad(div, Color3.fromRGB(4,8,30), C.accent, 0)

    local discLbl = Instance.new("TextLabel", card)
    discLbl.Size = UDim2.new(0.88,0,0,18); discLbl.Position = UDim2.new(0.06,0,0,104)
    discLbl.BackgroundTransparency=1; discLbl.Text="Key holen  →  Trete dem Discord bei:"
    discLbl.TextColor3=C.textDim; discLbl.Font=Enum.Font.GothamBold
    discLbl.TextSize=12; discLbl.TextXAlignment=Enum.TextXAlignment.Left; discLbl.ZIndex=3

    local discRow = Instance.new("Frame", card)
    discRow.Size=UDim2.new(0.88,0,0,36); discRow.Position=UDim2.new(0.06,0,0,126)
    discRow.BackgroundColor3=Color3.fromRGB(8,14,44); discRow.BorderSizePixel=0; discRow.ZIndex=3
    mkCorner(discRow,9); mkStroke(discRow, C.stroke, 1)

    local dtxt=Instance.new("TextLabel",discRow); dtxt.Size=UDim2.new(1,-100,1,0)
    dtxt.Position=UDim2.fromOffset(12,0); dtxt.BackgroundTransparency=1; dtxt.Text=DISCORD_LINK
    dtxt.TextColor3=C.accent; dtxt.Font=Enum.Font.Gotham; dtxt.TextSize=12
    dtxt.TextXAlignment=Enum.TextXAlignment.Left; dtxt.ZIndex=4

    local copyBtn=Instance.new("TextButton",discRow); copyBtn.Size=UDim2.fromOffset(80,26)
    copyBtn.Position=UDim2.new(1,-88,0.5,-13); copyBtn.BackgroundColor3=C.accentDim
    copyBtn.Text="Kopieren"; copyBtn.TextColor3=Color3.fromRGB(255,255,255)
    copyBtn.Font=Enum.Font.GothamBold; copyBtn.TextSize=11; copyBtn.BorderSizePixel=0; copyBtn.ZIndex=5
    mkCorner(copyBtn,7)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        copyBtn.Text="✓ Kopiert"; copyBtn.BackgroundColor3=C.success
        task.delay(2.5,function() copyBtn.Text="Kopieren"; copyBtn.BackgroundColor3=C.accentDim end)
    end)

    local keyLbl=Instance.new("TextLabel",card); keyLbl.Size=UDim2.new(0.88,0,0,18)
    keyLbl.Position=UDim2.new(0.06,0,0,174); keyLbl.BackgroundTransparency=1; keyLbl.Text="Key eingeben:"
    keyLbl.TextColor3=C.textDim; keyLbl.Font=Enum.Font.GothamBold; keyLbl.TextSize=12
    keyLbl.TextXAlignment=Enum.TextXAlignment.Left; keyLbl.ZIndex=3

    local inputFrame=Instance.new("Frame",card); inputFrame.Size=UDim2.new(0.88,0,0,38)
    inputFrame.Position=UDim2.new(0.06,0,0,196); inputFrame.BackgroundColor3=Color3.fromRGB(8,14,44)
    inputFrame.BorderSizePixel=0; inputFrame.ZIndex=3; mkCorner(inputFrame,9)
    local ist=mkStroke(inputFrame,C.stroke,1)

    local keyBox=Instance.new("TextBox",inputFrame); keyBox.Size=UDim2.new(1,-16,1,0)
    keyBox.Position=UDim2.fromOffset(12,0); keyBox.BackgroundTransparency=1
    keyBox.PlaceholderText="Key hier eingeben..."; keyBox.PlaceholderColor3=C.textMuted
    keyBox.Text=""; keyBox.TextColor3=C.text; keyBox.Font=Enum.Font.Gotham
    keyBox.TextSize=13; keyBox.TextXAlignment=Enum.TextXAlignment.Left
    keyBox.ClearTextOnFocus=false; keyBox.ZIndex=4
    keyBox.Focused:Connect(function() tween(ist,{Color=C.accentGlow,Thickness=2}) end)
    keyBox.FocusLost:Connect(function() tween(ist,{Color=C.stroke,Thickness=1}) end)

    local statusLbl=Instance.new("TextLabel",card); statusLbl.Size=UDim2.new(1,0,0,16)
    statusLbl.Position=UDim2.fromOffset(0,242); statusLbl.BackgroundTransparency=1; statusLbl.Text=""
    statusLbl.Font=Enum.Font.Gotham; statusLbl.TextSize=11; statusLbl.TextColor3=C.error
    statusLbl.TextXAlignment=Enum.TextXAlignment.Center; statusLbl.ZIndex=3

    local confBtn=Instance.new("TextButton",card); confBtn.Size=UDim2.new(0.88,0,0,42)
    confBtn.Position=UDim2.new(0.06,0,0,262); confBtn.BackgroundColor3=C.accent
    confBtn.Text="Bestätigen"; confBtn.TextColor3=Color3.fromRGB(255,255,255)
    confBtn.Font=Enum.Font.GothamBold; confBtn.TextSize=14; confBtn.BorderSizePixel=0; confBtn.ZIndex=3
    mkCorner(confBtn,11); mkGrad(confBtn,C.accentGlow,C.accentDim,90)
    confBtn.MouseEnter:Connect(function() tween(confBtn,{BackgroundColor3=C.accentGlow}) end)
    confBtn.MouseLeave:Connect(function() tween(confBtn,{BackgroundColor3=C.accent}) end)

    tween(card,{Position=UDim2.fromScale(0.5,0.5)},0.5,Enum.EasingStyle.Back)

    local function checkKey()
        if keyBox.Text==VALID_KEY then
            saveKey(keyBox.Text)
            confBtn.Text="Zugang gewährt!"; confBtn.BackgroundColor3=C.success
            statusLbl.TextColor3=C.success; statusLbl.Text="Willkommen bei Splash Scripts!"
            task.delay(1.3,function()
                tween(card,{Position=UDim2.new(0.5,0,-0.7,0)},0.35,Enum.EasingStyle.Back)
                task.wait(0.4); pcall(function() blur:Destroy() end); sg:Destroy(); onSuccess()
            end)
        else
            statusLbl.Text="Falscher Key!  →  discord.gg/eyzfsAjpSr"
            tween(ist,{Color=C.error},0.1)
            task.delay(1.5,function() tween(ist,{Color=C.stroke},0.25) end)
        end
    end
    confBtn.MouseButton1Click:Connect(checkKey)
    keyBox.FocusLost:Connect(function(e) if e then checkKey() end end)
end

-- ════════════════════════════════════════
-- MAIN UI
-- ════════════════════════════════════════
local function loadMain()
    local sg = Instance.new("ScreenGui")
    sg.Name = "SplashUI"; sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true; sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.Parent = LP:WaitForChild("PlayerGui")

    -- Notification system
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "SplashNotif"; notifGui.ResetOnSpawn = false
    notifGui.IgnoreGuiInset = true; notifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    notifGui.Parent = LP.PlayerGui

    local notifFrame = Instance.new("Frame", notifGui)
    notifFrame.Name = "Frame"; notifFrame.Size = UDim2.fromOffset(290,65)
    notifFrame.Position = UDim2.new(1,-320,1,10)
    notifFrame.BackgroundColor3 = C.card; notifFrame.BorderSizePixel=0; notifFrame.ZIndex=100
    mkCorner(notifFrame,10); mkStroke(notifFrame,C.accent,1)
    mkGrad(notifFrame,Color3.fromRGB(12,22,60),Color3.fromRGB(7,12,35),135)
    local nTitle=Instance.new("TextLabel",notifFrame); nTitle.Name="Title"
    nTitle.Size=UDim2.new(1,-16,0,22); nTitle.Position=UDim2.fromOffset(12,8)
    nTitle.BackgroundTransparency=1; nTitle.Text=""; nTitle.TextColor3=C.text
    nTitle.Font=Enum.Font.GothamBold; nTitle.TextSize=13; nTitle.TextXAlignment=Enum.TextXAlignment.Left
    local nContent=Instance.new("TextLabel",notifFrame); nContent.Name="Content"
    nContent.Size=UDim2.new(1,-16,0,20); nContent.Position=UDim2.fromOffset(12,30)
    nContent.BackgroundTransparency=1; nContent.Text=""; nContent.TextColor3=C.textDim
    nContent.Font=Enum.Font.Gotham; nContent.TextSize=11; nContent.TextXAlignment=Enum.TextXAlignment.Left

    -- Main frame
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.fromOffset(680,440); main.AnchorPoint = Vector2.new(0.5,0.5)
    main.Position = UDim2.fromScale(0.5,0.5); main.BackgroundColor3 = C.bg
    main.BorderSizePixel=0; mkCorner(main,14); mkStroke(main,C.accent,1.5)
    mkGrad(main,Color3.fromRGB(5,9,26),Color3.fromRGB(4,7,20),135)

    -- Shadow glow behind window
    local glowBg = Instance.new("ImageLabel", sg)
    glowBg.Size=UDim2.fromOffset(750,510); glowBg.AnchorPoint=Vector2.new(0.5,0.5)
    glowBg.Position=UDim2.fromScale(0.5,0.5); glowBg.BackgroundTransparency=1
    glowBg.Image="rbxassetid://5028857084"
    glowBg.ImageColor3=Color3.fromRGB(20,60,200); glowBg.ImageTransparency=0.75; glowBg.ZIndex=0

    -- Top bar
    local topBar = Instance.new("Frame", main)
    topBar.Size=UDim2.new(1,0,0,44); topBar.BackgroundColor3=Color3.fromRGB(6,10,28)
    topBar.BorderSizePixel=0; topBar.ZIndex=3
    mkGrad(topBar,Color3.fromRGB(8,16,50),Color3.fromRGB(5,9,28),90)

    local topLine = Instance.new("Frame", main)
    topLine.Size=UDim2.new(1,0,0,2); topLine.Position=UDim2.fromOffset(0,44)
    topLine.BackgroundColor3=C.accent; topLine.BorderSizePixel=0; topLine.ZIndex=4
    mkGrad(topLine,Color3.fromRGB(15,50,200),C.accentGlow,0)

    local logoLbl = Instance.new("TextLabel", topBar)
    logoLbl.Size=UDim2.new(0,200,1,0); logoLbl.Position=UDim2.fromOffset(16,0)
    logoLbl.BackgroundTransparency=1; logoLbl.Text="SPLASH SCRIPTS"
    logoLbl.TextColor3=Color3.fromRGB(240,248,255); logoLbl.Font=Enum.Font.GothamBold
    logoLbl.TextSize=16; logoLbl.TextXAlignment=Enum.TextXAlignment.Left; logoLbl.ZIndex=4

    local versionLbl = Instance.new("TextLabel", topBar)
    versionLbl.Size=UDim2.new(0,100,1,0); versionLbl.Position=UDim2.fromOffset(220,0)
    versionLbl.BackgroundTransparency=1; versionLbl.Text="v7.0"
    versionLbl.TextColor3=C.textMuted; versionLbl.Font=Enum.Font.Gotham
    versionLbl.TextSize=12; versionLbl.TextXAlignment=Enum.TextXAlignment.Left; versionLbl.ZIndex=4

    -- Toggle UI button
    local toggleBtn=Instance.new("TextButton",topBar); toggleBtn.Size=UDim2.fromOffset(28,28)
    toggleBtn.Position=UDim2.new(1,-38,0.5,-14); toggleBtn.BackgroundColor3=C.card
    toggleBtn.Text="—"; toggleBtn.TextColor3=C.textDim; toggleBtn.Font=Enum.Font.GothamBold
    toggleBtn.TextSize=14; toggleBtn.BorderSizePixel=0; toggleBtn.ZIndex=5; mkCorner(toggleBtn,6)
    local uiVisible = true
    local contentArea = Instance.new("Frame", main)
    toggleBtn.MouseButton1Click:Connect(function()
        uiVisible = not uiVisible
        contentArea.Visible = uiVisible
        toggleBtn.Text = uiVisible and "—" or "+"
    end)
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.K then
            uiVisible = not uiVisible
            contentArea.Visible = uiVisible
            toggleBtn.Text = uiVisible and "—" or "+"
        end
    end)

    -- Content area (below top bar)
    contentArea.Size=UDim2.new(1,0,1,-46); contentArea.Position=UDim2.fromOffset(0,46)
    contentArea.BackgroundTransparency=1; contentArea.BorderSizePixel=0; contentArea.ZIndex=2

    -- Sidebar
    local sidebar=Instance.new("Frame",contentArea); sidebar.Size=UDim2.fromOffset(140,394)
    sidebar.BackgroundColor3=C.sidebar; sidebar.BorderSizePixel=0; sidebar.ZIndex=3
    mkGrad(sidebar,Color3.fromRGB(7,12,35),Color3.fromRGB(5,9,26),90)
    local sideStroke=Instance.new("Frame",sidebar); sideStroke.Size=UDim2.new(0,1,1,0)
    sideStroke.Position=UDim2.new(1,-1,0,0); sideStroke.BackgroundColor3=C.stroke
    sideStroke.BorderSizePixel=0; sideStroke.ZIndex=4

    -- Content panel
    local panel=Instance.new("Frame",contentArea); panel.Size=UDim2.new(1,-140,1,0)
    panel.Position=UDim2.fromOffset(140,0); panel.BackgroundTransparency=1
    panel.BorderSizePixel=0; panel.ZIndex=2

    -- Tab system
    local tabs = {}
    local activeTab = nil
    local tabButtons = {}

    local function createTab(name)
        -- Sidebar button
        local btn=Instance.new("TextButton",sidebar); btn.Size=UDim2.new(1,0,0,40)
        btn.BackgroundColor3=C.sidebar; btn.Text=""; btn.BorderSizePixel=0; btn.ZIndex=4
        local btnLabel=Instance.new("TextLabel",btn); btnLabel.Size=UDim2.new(1,-16,1,0)
        btnLabel.Position=UDim2.fromOffset(16,0); btnLabel.BackgroundTransparency=1
        btnLabel.Text=name; btnLabel.TextColor3=C.textDim; btnLabel.Font=Enum.Font.GothamBold
        btnLabel.TextSize=13; btnLabel.TextXAlignment=Enum.TextXAlignment.Left; btnLabel.ZIndex=5
        local activeBar=Instance.new("Frame",btn); activeBar.Size=UDim2.fromOffset(3,24)
        activeBar.Position=UDim2.new(0,0,0.5,-12); activeBar.BackgroundColor3=C.accent
        activeBar.BorderSizePixel=0; activeBar.ZIndex=5; mkCorner(activeBar,2)
        activeBar.BackgroundTransparency=1

        -- Content frame
        local content=Instance.new("ScrollingFrame",panel); content.Size=UDim2.fromScale(1,1)
        content.BackgroundTransparency=1; content.BorderSizePixel=0; content.ZIndex=3
        content.ScrollBarThickness=3; content.ScrollBarImageColor3=C.accent
        content.CanvasSize=UDim2.new(0,0,0,0); content.Visible=false
        local layout=Instance.new("UIListLayout",content); layout.Padding=UDim.new(0,6)
        layout.SortOrder=Enum.SortOrder.LayoutOrder
        local padding=Instance.new("UIPadding",content); padding.PaddingLeft=UDim.new(0,10)
        padding.PaddingRight=UDim.new(0,10); padding.PaddingTop=UDim.new(0,10)

        layout.Changed:Connect(function()
            content.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+20)
        end)

        local tab = {content=content, btn=btn, label=btnLabel, bar=activeBar, order=#tabs+1}
        tabs[name] = tab

        btn.MouseButton1Click:Connect(function()
            if activeTab then
                tabs[activeTab].content.Visible=false
                tabs[activeTab].label.TextColor3=C.textDim
                tabs[activeTab].bar.BackgroundTransparency=1
                tabs[activeTab].btn.BackgroundColor3=C.sidebar
            end
            activeTab=name
            content.Visible=true
            btnLabel.TextColor3=C.text
            activeBar.BackgroundTransparency=0
            btn.BackgroundColor3=C.cardHover
        end)
        btn.MouseEnter:Connect(function() if activeTab~=name then tween(btn,{BackgroundColor3=C.card}) end end)
        btn.MouseLeave:Connect(function() if activeTab~=name then tween(btn,{BackgroundColor3=C.sidebar}) end end)

        return tab
    end

    -- Element builders
    local function addSection(tab, text)
        local f=Instance.new("Frame",tab.content); f.Size=UDim2.new(1,0,0,24)
        f.BackgroundTransparency=1; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1
        local l=Instance.new("TextLabel",f); l.Size=UDim2.fromScale(1,1); l.BackgroundTransparency=1
        l.Text=text; l.TextColor3=C.accent; l.Font=Enum.Font.GothamBold; l.TextSize=11
        l.TextXAlignment=Enum.TextXAlignment.Left
        local line=Instance.new("Frame",f); line.Size=UDim2.new(1,0,0,1); line.Position=UDim2.new(0,0,1,-1)
        line.BackgroundColor3=C.stroke; line.BorderSizePixel=0
        mkGrad(line,C.stroke,Color3.fromRGB(4,8,22),0)
    end

    local function addButton(tab, name, cb)
        local f=Instance.new("TextButton",tab.content); f.Size=UDim2.new(1,0,0,36)
        f.BackgroundColor3=C.card; f.Text=""; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1
        mkCorner(f,8); mkStroke(f,C.stroke,1)
        mkGrad(f,Color3.fromRGB(12,22,60),Color3.fromRGB(8,15,42),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-16,1,0); l.Position=UDim2.fromOffset(12,0)
        l.BackgroundTransparency=1; l.Text=name; l.TextColor3=C.text; l.Font=Enum.Font.GothamBold
        l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        f.MouseEnter:Connect(function() tween(f,{BackgroundColor3=C.cardHover}); tween(f:FindFirstChildOfClass("UIStroke"),{Color=C.strokeHov}) end)
        f.MouseLeave:Connect(function() tween(f,{BackgroundColor3=C.card}); tween(f:FindFirstChildOfClass("UIStroke"),{Color=C.stroke}) end)
        f.MouseButton1Click:Connect(function()
            tween(f,{BackgroundColor3=C.accent},0.08)
            task.delay(0.15,function() tween(f,{BackgroundColor3=C.card},0.15) end)
            cb()
        end)
        return f
    end

    local function addToggle(tab, name, default, flag, cb)
        local f=Instance.new("Frame",tab.content); f.Size=UDim2.new(1,0,0,36)
        f.BackgroundColor3=C.card; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1
        mkCorner(f,8); mkStroke(f,C.stroke,1)
        mkGrad(f,Color3.fromRGB(12,22,60),Color3.fromRGB(8,15,42),90)
        local l=mkLabel(f,name,13,C.text,Enum.Font.GothamBold); l.Size=UDim2.new(1,-60,1,0); l.Position=UDim2.fromOffset(12,0)
        local val=default
        local knobBg=Instance.new("Frame",f); knobBg.Size=UDim2.fromOffset(36,20)
        knobBg.Position=UDim2.new(1,-48,0.5,-10); knobBg.BackgroundColor3=val and C.toggle_on or C.toggle_off
        knobBg.BorderSizePixel=0; mkCorner(knobBg,10)
        local knob=Instance.new("Frame",knobBg); knob.Size=UDim2.fromOffset(16,16)
        knob.Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)
        knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.BorderSizePixel=0; mkCorner(knob,8)
        local btn=Instance.new("TextButton",f); btn.Size=UDim2.fromScale(1,1); btn.BackgroundTransparency=1
        btn.Text=""; btn.ZIndex=5
        btn.MouseButton1Click:Connect(function()
            val=not val; cb(val)
            tween(knobBg,{BackgroundColor3=val and C.toggle_on or C.toggle_off})
            tween(knob,{Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)})
        end)
        return {getValue=function() return val end}
    end

    local function addSlider(tab, name, min, max, default, flag, cb)
        local f=Instance.new("Frame",tab.content); f.Size=UDim2.new(1,0,0,50)
        f.BackgroundColor3=C.card; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1
        mkCorner(f,8); mkStroke(f,C.stroke,1)
        mkGrad(f,Color3.fromRGB(12,22,60),Color3.fromRGB(8,15,42),90)
        local l=mkLabel(f,name,13,C.text,Enum.Font.GothamBold); l.Size=UDim2.new(1,-60,0,20); l.Position=UDim2.fromOffset(12,6)
        local valLbl=Instance.new("TextLabel",f); valLbl.Size=UDim2.fromOffset(50,20)
        valLbl.Position=UDim2.new(1,-58,0,6); valLbl.BackgroundTransparency=1
        valLbl.Text=tostring(default); valLbl.TextColor3=C.accent; valLbl.Font=Enum.Font.GothamBold
        valLbl.TextSize=12; valLbl.TextXAlignment=Enum.TextXAlignment.Right
        local track=Instance.new("Frame",f); track.Size=UDim2.new(1,-24,0,6)
        track.Position=UDim2.new(0,12,1,-14); track.BackgroundColor3=C.slider_bg
        track.BorderSizePixel=0; mkCorner(track,3); mkStroke(track,C.stroke,1)
        local fill=Instance.new("Frame",track); fill.Size=UDim2.new((default-min)/(max-min),0,1,0)
        fill.BackgroundColor3=C.accent; fill.BorderSizePixel=0; mkCorner(fill,3)
        mkGrad(fill,C.accent,C.accentGlow,0)
        local handle=Instance.new("Frame",track); handle.Size=UDim2.fromOffset(12,12)
        handle.Position=UDim2.new((default-min)/(max-min),0,0.5,-6)
        handle.BackgroundColor3=Color3.fromRGB(255,255,255); handle.BorderSizePixel=0; mkCorner(handle,6)
        local dragging=false
        local function updateSlider(x)
            local abs=track.AbsolutePosition.X; local sz=track.AbsoluteSize.X
            local pct=math.clamp((x-abs)/sz,0,1)
            local v=math.floor(min+(max-min)*pct)
            fill.Size=UDim2.new(pct,0,1,0); handle.Position=UDim2.new(pct,0,0.5,-6)
            valLbl.Text=tostring(v); cb(v)
        end
        track.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; updateSlider(i.Position.X) end end)
        UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then updateSlider(i.Position.X) end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    end

    local function addKeybind(tab, name, default, cb)
        local currentKey = Enum.KeyCode[default] or Enum.KeyCode.F
        local f=Instance.new("Frame",tab.content); f.Size=UDim2.new(1,0,0,36)
        f.BackgroundColor3=C.card; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1
        mkCorner(f,8); mkStroke(f,C.stroke,1)
        mkGrad(f,Color3.fromRGB(12,22,60),Color3.fromRGB(8,15,42),90)
        local l=mkLabel(f,name,13,C.text,Enum.Font.GothamBold); l.Size=UDim2.new(1,-90,1,0); l.Position=UDim2.fromOffset(12,0)
        local keyBtn=Instance.new("TextButton",f); keyBtn.Size=UDim2.fromOffset(70,24)
        keyBtn.Position=UDim2.new(1,-78,0.5,-12); keyBtn.BackgroundColor3=C.accentDim
        keyBtn.Text="["..default.."]"; keyBtn.TextColor3=C.text; keyBtn.Font=Enum.Font.GothamBold
        keyBtn.TextSize=12; keyBtn.BorderSizePixel=0; mkCorner(keyBtn,6)
        local listening=false
        keyBtn.MouseButton1Click:Connect(function()
            listening=true; keyBtn.Text="..."; keyBtn.BackgroundColor3=C.accent
        end)
        UserInputService.InputBegan:Connect(function(input, gpe)
            if gpe then return end
            if listening then
                listening=false; currentKey=input.KeyCode
                keyBtn.Text="["..input.KeyCode.Name.."]"; keyBtn.BackgroundColor3=C.accentDim
            elseif input.KeyCode==currentKey then cb() end
        end)
    end

    local function addDropdown(tab, name, options, cb)
        local val=options[1] or ""
        local f=Instance.new("Frame",tab.content); f.Size=UDim2.new(1,0,0,36)
        f.BackgroundColor3=C.card; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1
        mkCorner(f,8); mkStroke(f,C.stroke,1)
        mkGrad(f,Color3.fromRGB(12,22,60),Color3.fromRGB(8,15,42),90)
        local l=mkLabel(f,name,13,C.text,Enum.Font.GothamBold); l.Size=UDim2.new(1,-200,1,0); l.Position=UDim2.fromOffset(12,0)
        local dBtn=Instance.new("TextButton",f); dBtn.Size=UDim2.fromOffset(170,26)
        dBtn.Position=UDim2.new(1,-178,0.5,-13); dBtn.BackgroundColor3=C.slider_bg
        dBtn.Text=val; dBtn.TextColor3=C.text; dBtn.Font=Enum.Font.Gotham
        dBtn.TextSize=12; dBtn.BorderSizePixel=0; mkCorner(dBtn,6); mkStroke(dBtn,C.stroke,1)
        local open=false; local dropFrame
        dBtn.MouseButton1Click:Connect(function()
            open=not open
            if open then
                dropFrame=Instance.new("Frame",sg); dropFrame.ZIndex=100
                dropFrame.Size=UDim2.fromOffset(170,math.min(#options,6)*32+4)
                local abs=dBtn.AbsolutePosition
                dropFrame.Position=UDim2.fromOffset(abs.X,abs.Y+30)
                dropFrame.BackgroundColor3=Color3.fromRGB(8,14,44); dropFrame.BorderSizePixel=0
                mkCorner(dropFrame,8); mkStroke(dropFrame,C.accent,1)
                local dl=Instance.new("UIListLayout",dropFrame); dl.SortOrder=Enum.SortOrder.LayoutOrder
                for i,opt in ipairs(options) do
                    local ob=Instance.new("TextButton",dropFrame); ob.Size=UDim2.new(1,0,0,32)
                    ob.BackgroundColor3=Color3.fromRGB(8,14,44); ob.Text=opt
                    ob.TextColor3=opt==val and C.accent or C.text; ob.Font=Enum.Font.Gotham
                    ob.TextSize=12; ob.BorderSizePixel=0; ob.LayoutOrder=i
                    ob.MouseEnter:Connect(function() tween(ob,{BackgroundColor3=C.card}) end)
                    ob.MouseLeave:Connect(function() tween(ob,{BackgroundColor3=Color3.fromRGB(8,14,44)}) end)
                    ob.MouseButton1Click:Connect(function()
                        val=opt; dBtn.Text=opt; cb(opt)
                        if dropFrame then dropFrame:Destroy(); dropFrame=nil end; open=false
                    end)
                end
            else if dropFrame then dropFrame:Destroy(); dropFrame=nil end end
        end)
        return {getValue=function() return val end}
    end

    -- Position sidebar buttons
    local btnY = 10
    local function registerTabBtn(tab)
        tab.btn.Position = UDim2.fromOffset(0, btnY)
        btnY = btnY + 40
    end

    -- ════════════════════════════════════════
    -- TABS ERSTELLEN
    -- ════════════════════════════════════════

    -- FLY TAB
    local flyTab = createTab("Fly"); registerTabBtn(flyTab)
    local flyActive=false; local flySpeed=80; local flyConn,bv,bg

    local function cleanFly()
        flyActive=false
        if flyConn then flyConn:Disconnect(); flyConn=nil end
        if bv then bv:Destroy(); bv=nil end
        if bg then bg:Destroy(); bg=nil end
        local h=getHum(); if h then h.PlatformStand=false end
        -- Reset Motor6D Pose
        local c=getChar()
        if c then
            local torso=c:FindFirstChild("Torso"); if not torso then return end
            local rs=torso:FindFirstChild("Right Shoulder")
            local ls=torso:FindFirstChild("Left Shoulder")
            local rh=torso:FindFirstChild("Right Hip")
            local lh=torso:FindFirstChild("Left Hip")
            local neck=torso:FindFirstChild("Neck")
            if rs  then rs.C0  = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) end
            if ls  then ls.C0  = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) end
            if rh  then rh.C0  = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0) end
            if lh  then lh.C0  = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0) end
            if neck then neck.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(0, 0, 0) end
            -- Full reset after short delay via respawn trick
            task.delay(0.1, function()
                local hum2=getHum(); if hum2 then hum2:ChangeState(Enum.HumanoidStateType.GettingUp) end
            end)
        end
    end

    local function startFly()
        local hrp=getHRP(); local hum=getHum(); if not hrp or not hum then return end
        cleanFly(); flyActive=true; hum.PlatformStand=true
        bv=Instance.new("BodyVelocity"); bv.MaxForce=Vector3.new(1e9,1e9,1e9); bv.Velocity=Vector3.zero; bv.Parent=hrp
        bg=Instance.new("BodyGyro"); bg.MaxTorque=Vector3.new(1e9,1e9,1e9); bg.D=50; bg.P=1200; bg.Parent=hrp
        task.spawn(function()
            task.wait(0.1); local c=getChar(); if not c then return end
            local torso = c:FindFirstChild("Torso")
            if not torso then return end -- R15 wird nicht unterstützt
            local rs = torso:FindFirstChild("Right Shoulder")
            local ls = torso:FindFirstChild("Left Shoulder")
            local rh = torso:FindFirstChild("Right Hip")
            local lh = torso:FindFirstChild("Left Hip")
            local neck = torso:FindFirstChild("Neck")

            -- Rechter Arm: nach vorne oben gestreckt (Superman-Arm)
            if rs then
                rs.C0 = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
            end
            -- Linker Arm: am Körper angelegt nach hinten
            if ls then
                ls.C0 = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            end
            -- Beine gestreckt nach hinten
            if rh then
                rh.C0 = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, 0, -1, 0, 0)
            end
            if lh then
                lh.C0 = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
            end
            -- Kopf leicht nach vorne
            if neck then
                neck.C0 = CFrame.new(0, 1, 0) * CFrame.Angles(math.rad(20), 0, 0)
            end
        end)
        flyConn=RunService.Heartbeat:Connect(function()
            if not flyActive then cleanFly() return end
            local h2=getHRP(); if not h2 then cleanFly() return end
            local dir=Vector3.zero; local cf=Camera.CFrame
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir+=cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir-=cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir-=cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir+=cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir-=Vector3.new(0,1,0) end
            local boost=UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 4 or 1
            if dir.Magnitude>0 then
                bv.Velocity=dir.Unit*(flySpeed*boost)
                bg.CFrame=bg.CFrame:Lerp(CFrame.new(h2.Position,h2.Position+dir.Unit)*CFrame.Angles(-math.rad(72),0,0),0.12)
            else
                bv.Velocity=Vector3.zero
                bg.CFrame=bg.CFrame:Lerp(CFrame.new(h2.Position,h2.Position+cf.LookVector)*CFrame.Angles(-math.rad(15),0,0),0.08)
            end
        end)
    end

    local flyToggle=addToggle(flyTab,"Fly aktivieren",false,"Fly",function(v) if v then startFly() else cleanFly() end end)
    addSlider(flyTab,"Fly Speed",10,600,80,"FlySpd",function(v) flySpeed=v end)
    addKeybind(flyTab,"Fly Keybind","F",function() if flyActive then cleanFly() else startFly() end end)

    local infoF=Instance.new("Frame",flyTab.content); infoF.Size=UDim2.new(1,0,0,44)
    infoF.BackgroundColor3=Color3.fromRGB(8,14,40); infoF.BorderSizePixel=0; infoF.LayoutOrder=flyTab.order; flyTab.order=flyTab.order+1
    mkCorner(infoF,8); mkStroke(infoF,C.stroke,1)
    local infoL=mkLabel(infoF,"W/A/S/D · Space=hoch · Shift=runter · Strg=4x Speed\nUI Toggle: K",11,C.textDim)
    infoL.Size=UDim2.new(1,-16,1,0); infoL.Position=UDim2.fromOffset(10,0); infoL.TextWrapped=true

    -- FUN TAB
    local funTab=createTab("Fun"); registerTabBtn(funTab)
    local selP=getPlayerList()[1] or ""

    local playerDrop=addDropdown(funTab,"Spieler",getPlayerList(),function(v) selP=v end)
    addButton(funTab,"Liste neu laden",function()
        selP=getPlayerList()[1] or ""
        notify("OK","Spielerliste aktualisiert.")
    end)
    addSection(funTab,"Fling & Teleport")
    addButton(funTab,"Spieler flingen",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for i=1,10 do task.delay(i*0.01,function()
            local f=Instance.new("BodyVelocity"); f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent=hrp
            game:GetService("Debris"):AddItem(f,0.1)
        end) end
        notify("Fling",selP.." wurde geflingt!",C.success)
    end)
    addButton(funTab,"Alle flingen",function()
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local hrp=p.Character:FindFirstChild("HumanoidRootPart"); if not hrp then continue end
                local f=Instance.new("BodyVelocity"); f.MaxForce=Vector3.new(1e9,1e9,1e9)
                f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent=hrp
                game:GetService("Debris"):AddItem(f,0.1)
            end
        end
    end)
    addButton(funTab,"Zu Spieler TP",function()
        local _,tc=getTarget(selP); if not tc then return end
        local th,mh=tc:FindFirstChild("HumanoidRootPart"),getHRP()
        if th and mh then mh.CFrame=th.CFrame*CFrame.new(3,0,0) end
    end)
    addButton(funTab,"Spieler zu mir TP",function()
        local _,tc=getTarget(selP); if not tc then return end
        local th,mh=tc:FindFirstChild("HumanoidRootPart"),getHRP()
        if th and mh then th.CFrame=mh.CFrame*CFrame.new(3,0,0) end
    end)
    addButton(funTab,"Auf Kopf setzen",function()
        local _,tc=getTarget(selP); if not tc then return end
        local head,mh=tc:FindFirstChild("Head"),getHRP()
        if head and mh then mh.CFrame=CFrame.new(head.Position+Vector3.new(0,3.5,0)) end
    end)
    addButton(funTab,"Hochkatapultieren",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local bv2=Instance.new("BodyVelocity"); bv2.MaxForce=Vector3.new(0,1e9,0)
        bv2.Velocity=Vector3.new(0,2500,0); bv2.Parent=hrp
        game:GetService("Debris"):AddItem(bv2,0.25)
    end)
    addButton(funTab,"Einfrieren",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hum=tc:FindFirstChild("Humanoid"); if not hum then return end
        local frozen=hum.WalkSpeed==0
        hum.WalkSpeed=frozen and 16 or 0; hum.JumpPower=frozen and 50 or 0
        notify("Freeze",selP..(frozen and " freigegeben" or " eingefroren"))
    end)
    addButton(funTab,"Spin",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        task.spawn(function() for i=1,100 do hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(20),0) task.wait(0.01) end end)
    end)
    addButton(funTab,"Alle zu mir TP",function()
        local mh=getHRP(); if not mh then return end
        for _,p in ipairs(Players:GetPlayers()) do
            if p~=LP and p.Character then
                local h=p.Character:FindFirstChild("HumanoidRootPart")
                if h then h.CFrame=mh.CFrame*CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
            end
        end
    end)
    addSection(funTab,"Speed & Movement")
    addToggle(funTab,"Super Speed",false,"SSpd",function(v) local h=getHum(); if h then h.WalkSpeed=v and 120 or 16 end end)
    addSlider(funTab,"Walk Speed",16,500,16,"WSpd",function(v) local h=getHum(); if h then h.WalkSpeed=v end end)
    addToggle(funTab,"Inf Jump",false,"InfJ",function(v)
        if v then UserInputService.JumpRequest:Connect(function()
            local h=getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end) end
    end)
    addSlider(funTab,"Jump Power",50,500,50,"JmpPow",function(v) local h=getHum(); if h then h.JumpPower=v end end)
    addToggle(funTab,"Noclip",false,"Noclip",function(v)
        if v then RunService.Stepped:Connect(function()
            local c=getChar(); if not c then return end
            for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
        end) end
    end)
    addToggle(funTab,"Unsichtbar",false,"Invis",function(v)
        local c=getChar(); if not c then return end
        for _,p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=v and 1 or 0 end
        end
    end)
    addSection(funTab,"Outfit")
    addButton(funTab,"Outfit klauen",function()
        local tp=getTarget(selP); if not tp then return end
        local h=getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(tp.UserId)) end
        notify("Outfit","Outfit von "..selP.." geklaut!",C.success)
    end)
    addButton(funTab,"Eigenes Outfit zurück",function()
        local h=getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LP.UserId)) end
    end)
    addButton(funTab,"Riesenkopf",function()
        local _,tc=getTarget(selP); if not tc then return end
        local head=tc:FindFirstChild("Head"); if head then head.Size=Vector3.new(6,6,6) end
    end)

    -- ESP TAB
    local espTab=createTab("ESP"); registerTabBtn(espTab)
    local espOn=false; local espHL={}
    local espColor=Color3.fromRGB(40,120,255); local espFill=0.5; local espWalls=true
    local function removeESP() for _,h in pairs(espHL) do pcall(function() h:Destroy() end) end espHL={} end
    local function addESP(char,name)
        local h=Instance.new("Highlight"); h.FillColor=espColor; h.OutlineColor=Color3.fromRGB(255,255,255)
        h.FillTransparency=espFill; h.OutlineTransparency=0
        h.DepthMode=espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        h.Parent=char; espHL[name]=h
    end
    local function buildESP() removeESP() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then addESP(p.Character,p.Name) end end end
    addToggle(espTab,"ESP aktivieren",false,"ESP",function(v) espOn=v; if v then buildESP() else removeESP() end end)
    addSlider(espTab,"Transparenz",0,10,5,"ESPAlp",function(v) espFill=v/10; for _,h in pairs(espHL) do if h then h.FillTransparency=espFill end end end)
    addToggle(espTab,"Durch Wände",true,"ESPWall",function(v)
        espWalls=v; for _,h in pairs(espHL) do if h then
            h.DepthMode=v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        end end
    end)
    addButton(espTab,"ESP aktualisieren",function() if espOn then buildESP() end end)
    Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if espOn then task.wait(1); addESP(c,p.Name) end end) end)
    Players.PlayerRemoving:Connect(function(p) if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end); espHL[p.Name]=nil end end)

    -- WORLD TAB
    local worldTab=createTab("World"); registerTabBtn(worldTab)
    addToggle(worldTab,"Fullbright",false,"Fullbright",function(v) Lighting.Brightness=v and 10 or 2; Lighting.GlobalShadows=not v; Lighting.FogEnd=v and 1e9 or 1e5 end)
    addSlider(worldTab,"Helligkeit",0,10,2,"Bright",function(v) Lighting.Brightness=v end)
    addSlider(worldTab,"Uhrzeit",0,24,14,"Clock",function(v) Lighting.ClockTime=v end)
    addToggle(worldTab,"Fog entfernen",false,"NoFog",function(v) Lighting.FogEnd=v and 1e9 or 1e5; Lighting.FogStart=v and 1e9 or 0 end)
    addSlider(worldTab,"Gravity",0,400,196,"Grav",function(v) workspace.Gravity=v end)
    addToggle(worldTab,"Anti-Gravity",false,"NoGrav",function(v) workspace.Gravity=v and 0 or 196 end)

    -- PLAYER TAB
    local playerTab=createTab("Player"); registerTabBtn(playerTab)
    addToggle(playerTab,"God Mode",false,"God",function(v) local h=getHum(); if h then h.MaxHealth=v and math.huge or 100; h.Health=v and math.huge or 100 end end)
    addToggle(playerTab,"Auto-Heal",false,"AHeal",function(v) if v then task.spawn(function() while v do local h=getHum(); if h then h.Health=h.MaxHealth end task.wait(0.1) end end) end end)
    addSlider(playerTab,"HP setzen",1,1000,100,"SetHP",function(v) local h=getHum(); if h then h.Health=v end end)
    addButton(playerTab,"Respawn",function() LP:LoadCharacter() end)
    addSlider(playerTab,"FOV",30,120,70,"FOV",function(v) Camera.FieldOfView=v end)

    -- SETTINGS TAB
    local settTab=createTab("Settings"); registerTabBtn(settTab)
    local KEY_FILE_REF = KEY_FILE
    local infoBlock=Instance.new("Frame",settTab.content); infoBlock.Size=UDim2.new(1,0,0,80)
    infoBlock.BackgroundColor3=Color3.fromRGB(8,14,40); infoBlock.BorderSizePixel=0
    infoBlock.LayoutOrder=settTab.order; settTab.order=settTab.order+1; mkCorner(infoBlock,8); mkStroke(infoBlock,C.stroke,1)
    local il=mkLabel(infoBlock,"Splash Scripts v7.0\nGerman Voice Edition\nDiscord: discord.gg/eyzfsAjpSr\nKey wird lokal gespeichert.",11,C.textDim)
    il.Size=UDim2.new(1,-16,1,0); il.Position=UDim2.fromOffset(10,0); il.TextWrapped=true
    addButton(settTab,"Key zurücksetzen",function()
        pcall(function() delfile(KEY_FILE_REF) end)
        notify("Key","Key gelöscht. Nächster Start fragt neu.")
    end)

    -- Activate first tab
    flyTab.btn.MouseButton1Click:Fire()

    -- Slide in animation
    main.Position = UDim2.new(0.5,0,1.5,0)
    tween(main,{Position=UDim2.fromScale(0.5,0.5)},0.6,Enum.EasingStyle.Back)

    task.delay(0.8,function()
        notify("Splash Scripts","Script geladen! Viel Spaß.",C.success)
    end)
end

-- ════════════════════════════════════════
-- START
-- ════════════════════════════════════════
if loadKey()==VALID_KEY then
    task.spawn(loadMain)
else
    task.spawn(function() showKeyPanel(loadMain) end)
end
