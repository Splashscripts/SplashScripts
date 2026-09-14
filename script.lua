ly() r-- ╔══════════════════════════════════════════════════════════╗
-- ║          S P L A S H   S C R I P T S                    ║
-- ║          German Voice Edition  |  v4.0                  ║
-- ╚══════════════════════════════════════════════════════════╝

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

-- ── Services ─────────────────────────────────────────────────
local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LP               = Players.LocalPlayer
local Camera           = workspace.CurrentCamera

-- ── Helpers ──────────────────────────────────────────────────
local function getChar() return LP.Character end
local function getHRP()  local c = getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum()  local c = getChar() return c and c:FindFirstChild("Humanoid") end

local function getPlayerList()
    local t = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(t, p.Name) end
    end
    if #t == 0 then table.insert(t, "(Niemand im Server)") end
    return t
end

local function getTarget(name)
    local p = Players:FindFirstChild(name)
    if p and p.Character then return p, p.Character end
    return nil, nil
end

-- ════════════════════════════════════════════════════════════
--  CUSTOM THEME  —  Midnight Blue Premium
-- ════════════════════════════════════════════════════════════

local THEME = {
    -- ── Fenster ──────────────────────────────────────────
    -- Sehr tiefer, fast schwarzer Navy-Hintergrund mit leichtem Blau-Schimmer
    WindowColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(4,   7,  22)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(6,  11,  30)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(4,   8,  25)),
    }),
    ShadowColor   = Color3.fromRGB(0, 2, 8),
    LiveAnimation = true,   -- sanfter Gradient-Drift

    -- ── Schriften & Text ─────────────────────────────────
    TitleFont             = Enum.Font.GothamBold,
    Font                  = Enum.Font.Gotham,
    TitlingColor          = Color3.fromRGB(230, 242, 255),
    ContentColor          = Color3.fromRGB(155, 185, 235),
    ElementTextHoverColor = Color3.fromRGB(255, 255, 255),
    ActionColor           = Color3.fromRGB(120, 170, 255),

    -- ── Oberfläche ───────────────────────────────────────
    SurfaceStroke      = Color3.fromRGB(18, 38, 100),
    CornerRoundness    = UDim.new(0, 14),
    PillCornerRadius   = UDim.new(0, 12),
    ElementCornerRadius= UDim.new(0, 10),

    -- ── Tabs (Sidebar) ───────────────────────────────────
    -- Aktiver Tab leuchtet in sattem Blau, inaktive sind dezent
    TabBackgroundColor = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 45, 115)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(14, 30,  85)),
    }),
    TabColor           = Color3.fromRGB(170, 210, 255),
    TabStroke          = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(55,  110, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25,   60, 180)),
    }),

    -- ── Elemente (Buttons, Toggles, etc.) ────────────────
    -- Dunkler Element-Hintergrund mit subtiler Tiefe
    ElementGradient = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 18, 50)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(13, 23, 62)),
    }),
    ElementStroke             = Color3.fromRGB(24, 50, 130),
    ElementStrokeGradient     = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 90, 200)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 40, 120)),
    }),
    ElementStrokeHover        = Color3.fromRGB(65, 140, 255),
    ElementStrokeHoverTransparency = 0,
    ElementTransparency       = 0,
    ElementStrokeTransparency = 0,
    StatBackground            = Color3.fromRGB(8, 14, 40),

    -- ── Akzent — leuchtendes Elektrisch-Blau ─────────────
    AccentColor  = Color3.fromRGB(45, 120, 255),
    AccentStroke = Color3.fromRGB(80, 160, 255),
    AccentGlow   = 0.35,   -- 0 = voll sichtbar, 1 = unsichtbar

    -- ── Slider ───────────────────────────────────────────
    SliderBackground      = Color3.fromRGB(7,  13, 38),
    SliderBackgroundHover = Color3.fromRGB(11, 20, 55),
    SliderProgressColor   = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 120, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 180, 255)),
    }),
    SliderStroke  = Color3.fromRGB(25, 60, 155),
    SliderHandle  = Color3.fromRGB(130, 190, 255),

    -- ── Toggle ───────────────────────────────────────────
    ToggleTrackColor          = Color3.fromRGB(7, 13, 38),
    ToggleTrackTransparency   = 0,
    ToggleKnobOffColor        = Color3.fromRGB(65, 95, 160),
    ToggleKnobOffTransparency = 0,
    DarkToggleOverlay         = false,

    -- ── Felder & Dropdown ────────────────────────────────
    FieldBackground   = Color3.fromRGB(6, 11, 34),
    FieldTransparency = 0,
    FieldGlow         = Color3.fromRGB(35, 90, 230),
    PlaceholderColor  = Color3.fromRGB(65, 95, 165),
    DropdownHighlight = Color3.fromRGB(22, 55, 150),

    -- ── Popup Buttons ────────────────────────────────────
    NeutralButton      = Color3.fromRGB(14, 24, 65),
    NeutralButtonHover = Color3.fromRGB(20, 38, 95),
    NeutralButtonStroke= Color3.fromRGB(30, 65, 160),
    ErrorColor         = Color3.fromRGB(255, 65, 65),
    ErrorStrokeColor   = Color3.fromRGB(200, 40, 40),
}

-- ════════════════════════════════════════════════════════════
--  KEY SYSTEM  —  Custom GUI
-- ════════════════════════════════════════════════════════════

local VALID_KEY    = "SplashScripts2026!"
local DISCORD_LINK = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE     = "SplashKey.txt"

local function saveKey(k)  pcall(function() writefile(KEY_FILE, k) end) end
local function loadKey()   local ok,v = pcall(function() return readfile(KEY_FILE) end) return ok and v or nil end

local VALID_KEY    = "SplashScripts2026!"
local DISCORD_LINK = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE     = "SplashKey.txt"

local function saveKey(k)
    pcall(function() writefile(KEY_FILE, k) end)
end

local function loadKey()
    local ok, v = pcall(function() return readfile(KEY_FILE) end)
    if ok and type(v) == "string" then return v end
    return nil
end

-- Wenn Key schon gespeichert ist, direkt weiter
local keyValid = loadKey() == VALID_KEY

if not keyValid then
    local keyDone = false

    local sg = Instance.new("ScreenGui")
    sg.Name = "SplashKeyUI"
    sg.ResetOnSpawn = false
    sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    sg.IgnoreGuiInset = true
    pcall(function() sg.Parent = LP:WaitForChild("PlayerGui") end)

    local blur = Instance.new("BlurEffect")
    blur.Size = 20
    pcall(function() blur.Parent = Lighting end)

    local dim = Instance.new("Frame", sg)
    dim.Size = UDim2.fromScale(1, 1)
    dim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    dim.BackgroundTransparency = 0.4
    dim.BorderSizePixel = 0
    dim.ZIndex = 1

    local card = Instance.new("Frame", sg)
    card.Size = UDim2.fromOffset(500, 360)
    card.Position = UDim2.new(0.5, 0, 1.5, 0)
    card.AnchorPoint = Vector2.new(0.5, 0.5)
    card.BackgroundColor3 = Color3.fromRGB(6, 11, 30)
    card.BorderSizePixel = 0
    card.ZIndex = 2
    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 20)
    local cs = Instance.new("UIStroke", card)
    cs.Color = Color3.fromRGB(45, 95, 210); cs.Thickness = 2
    local cg = Instance.new("UIGradient", card)
    cg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(10, 20, 58)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(7,  13, 40)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(5,  9,  28)),
    })
    cg.Rotation = 145

    -- Glow
    local glow = Instance.new("ImageLabel", sg)
    glow.Size = UDim2.fromOffset(600, 480)
    glow.Position = UDim2.fromScale(0.5, 0.5)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857084"
    glow.ImageColor3 = Color3.fromRGB(20, 70, 255)
    glow.ImageTransparency = 0.65
    glow.ZIndex = 1

    -- Top accent bar
    local topBar = Instance.new("Frame", card)
    topBar.Size = UDim2.new(1, 0, 0, 4)
    topBar.BackgroundColor3 = Color3.fromRGB(45, 120, 255)
    topBar.BorderSizePixel = 0; topBar.ZIndex = 4
    Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 20)
    Instance.new("UIGradient", topBar).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(20,  80, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100,180, 255)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(20,  80, 255)),
    })

    -- Titel
    local title = Instance.new("TextLabel", card)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Position = UDim2.fromOffset(0, 24)
    title.BackgroundTransparency = 1
    title.Text = "SPLASH SCRIPTS"
    title.TextColor3 = Color3.fromRGB(245, 250, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 26; title.ZIndex = 3

    local sub = Instance.new("TextLabel", card)
    sub.Size = UDim2.new(1, 0, 0, 20)
    sub.Position = UDim2.fromOffset(0, 72)
    sub.BackgroundTransparency = 1
    sub.Text = "German Voice Edition  ·  Key System"
    sub.TextColor3 = Color3.fromRGB(90, 130, 215)
    sub.Font = Enum.Font.Gotham; sub.TextSize = 13; sub.ZIndex = 3

    -- Divider
    local div = Instance.new("Frame", card)
    div.Size = UDim2.new(0.88, 0, 0, 1)
    div.Position = UDim2.new(0.06, 0, 0, 104)
    div.BackgroundColor3 = Color3.fromRGB(30, 60, 150)
    div.BorderSizePixel = 0; div.ZIndex = 3
    Instance.new("UIGradient", div).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(5,  10, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50,100,220)),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(5,  10, 40)),
    })

    -- Discord Label
    local discLabel = Instance.new("TextLabel", card)
    discLabel.Size = UDim2.new(1, -40, 0, 20)
    discLabel.Position = UDim2.fromOffset(30, 118)
    discLabel.BackgroundTransparency = 1
    discLabel.Text = "Key holen  →  Trete unserem Discord bei:"
    discLabel.TextColor3 = Color3.fromRGB(140, 175, 240)
    discLabel.Font = Enum.Font.GothamBold; discLabel.TextSize = 13
    discLabel.TextXAlignment = Enum.TextXAlignment.Left; discLabel.ZIndex = 3

    -- Discord Box
    local discBox = Instance.new("Frame", card)
    discBox.Size = UDim2.new(0.88, 0, 0, 42)
    discBox.Position = UDim2.new(0.06, 0, 0, 144)
    discBox.BackgroundColor3 = Color3.fromRGB(8, 16, 50)
    discBox.BorderSizePixel = 0; discBox.ZIndex = 3
    Instance.new("UICorner", discBox).CornerRadius = UDim.new(0, 10)
    local dbs = Instance.new("UIStroke", discBox)
    dbs.Color = Color3.fromRGB(35, 75, 190); dbs.Thickness = 1.2

    local discText = Instance.new("TextLabel", discBox)
    discText.Size = UDim2.new(1, -110, 1, 0)
    discText.Position = UDim2.fromOffset(14, 0)
    discText.BackgroundTransparency = 1
    discText.Text = DISCORD_LINK
    discText.TextColor3 = Color3.fromRGB(90, 155, 255)
    discText.Font = Enum.Font.Gotham; discText.TextSize = 13
    discText.TextXAlignment = Enum.TextXAlignment.Left; discText.ZIndex = 4

    local copyBtn = Instance.new("TextButton", discBox)
    copyBtn.Size = UDim2.fromOffset(88, 30)
    copyBtn.Position = UDim2.new(1, -96, 0.5, -15)
    copyBtn.BackgroundColor3 = Color3.fromRGB(35, 90, 210)
    copyBtn.Text = "Kopieren"; copyBtn.TextColor3 = Color3.fromRGB(255,255,255)
    copyBtn.Font = Enum.Font.GothamBold; copyBtn.TextSize = 12
    copyBtn.BorderSizePixel = 0; copyBtn.ZIndex = 5
    Instance.new("UICorner", copyBtn).CornerRadius = UDim.new(0, 8)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        copyBtn.Text = "✓ Kopiert"
        copyBtn.BackgroundColor3 = Color3.fromRGB(20, 160, 80)
        task.delay(2.5, function()
            copyBtn.Text = "Kopieren"
            copyBtn.BackgroundColor3 = Color3.fromRGB(35, 90, 210)
        end)
    end)

    -- Key Label
    local keyLabel = Instance.new("TextLabel", card)
    keyLabel.Size = UDim2.new(1, -40, 0, 20)
    keyLabel.Position = UDim2.fromOffset(30, 202)
    keyLabel.BackgroundTransparency = 1
    keyLabel.Text = "Key eingeben:"
    keyLabel.TextColor3 = Color3.fromRGB(140, 175, 240)
    keyLabel.Font = Enum.Font.GothamBold; keyLabel.TextSize = 13
    keyLabel.TextXAlignment = Enum.TextXAlignment.Left; keyLabel.ZIndex = 3

    -- Key Input
    local inputBox = Instance.new("Frame", card)
    inputBox.Size = UDim2.new(0.88, 0, 0, 44)
    inputBox.Position = UDim2.new(0.06, 0, 0, 228)
    inputBox.BackgroundColor3 = Color3.fromRGB(8, 16, 50)
    inputBox.BorderSizePixel = 0; inputBox.ZIndex = 3
    Instance.new("UICorner", inputBox).CornerRadius = UDim.new(0, 10)
    local iStroke = Instance.new("UIStroke", inputBox)
    iStroke.Color = Color3.fromRGB(35, 75, 190); iStroke.Thickness = 1.2

    local keyInput = Instance.new("TextBox", inputBox)
    keyInput.Size = UDim2.new(1, -20, 1, 0)
    keyInput.Position = UDim2.fromOffset(14, 0)
    keyInput.BackgroundTransparency = 1
    keyInput.PlaceholderText = "Key hier eingeben..."
    keyInput.PlaceholderColor3 = Color3.fromRGB(60, 90, 150)
    keyInput.Text = ""
    keyInput.TextColor3 = Color3.fromRGB(215, 235, 255)
    keyInput.Font = Enum.Font.Gotham; keyInput.TextSize = 14
    keyInput.TextXAlignment = Enum.TextXAlignment.Left
    keyInput.ClearTextOnFocus = false; keyInput.ZIndex = 4

    keyInput.Focused:Connect(function()
        TweenService:Create(iStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(60,140,255), Thickness = 2 }):Play()
    end)
    keyInput.FocusLost:Connect(function()
        TweenService:Create(iStroke, TweenInfo.new(0.2), { Color = Color3.fromRGB(35,75,190), Thickness = 1.2 }):Play()
    end)

    -- Status
    local statusLabel = Instance.new("TextLabel", card)
    statusLabel.Size = UDim2.new(1, 0, 0, 20)
    statusLabel.Position = UDim2.fromOffset(0, 280)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""; statusLabel.Font = Enum.Font.Gotham; statusLabel.TextSize = 12
    statusLabel.TextColor3 = Color3.fromRGB(255, 80, 80); statusLabel.ZIndex = 3
    statusLabel.TextXAlignment = Enum.TextXAlignment.Center

    -- Confirm Button
    local confirmBtn = Instance.new("TextButton", card)
    confirmBtn.Size = UDim2.new(0.88, 0, 0, 46)
    confirmBtn.Position = UDim2.new(0.06, 0, 0, 302)
    confirmBtn.BackgroundColor3 = Color3.fromRGB(35, 100, 235)
    confirmBtn.Text = "Bestätigen"
    confirmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    confirmBtn.Font = Enum.Font.GothamBold; confirmBtn.TextSize = 15
    confirmBtn.BorderSizePixel = 0; confirmBtn.ZIndex = 3
    Instance.new("UICorner", confirmBtn).CornerRadius = UDim.new(0, 12)
    Instance.new("UIGradient", confirmBtn).Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(55,130,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 65,200)),
    })
    confirmBtn.MouseEnter:Connect(function()
        TweenService:Create(confirmBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(60,140,255) }):Play()
    end)
    confirmBtn.MouseLeave:Connect(function()
        TweenService:Create(confirmBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(35,100,235) }):Play()
    end)

    -- Slide-in
    TweenService:Create(card, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.fromScale(0.5, 0.5)
    }):Play()

    -- Confirm Logic
    local function tryKey()
        local entered = keyInput.Text
        if entered == VALID_KEY then
            saveKey(entered)
            confirmBtn.Text = "Zugang gewährt!"
            confirmBtn.BackgroundColor3 = Color3.fromRGB(20, 160, 80)
            statusLabel.Text = "Willkommen bei Splash Scripts!"
            statusLabel.TextColor3 = Color3.fromRGB(60, 220, 100)
            task.delay(1.2, function()
                TweenService:Create(card, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                    Position = UDim2.new(0.5, 0, -0.8, 0)
                }):Play()
                task.wait(0.5)
                pcall(function() blur:Destroy() end)
                sg:Destroy()
                keyDone = true
            end)
        else
            statusLabel.Text = "Falscher Key!  Discord: discord.gg/eyzfsAjpSr"
            TweenService:Create(iStroke, TweenInfo.new(0.1), { Color = Color3.fromRGB(255,60,60) }):Play()
            task.delay(1.5, function()
                TweenService:Create(iStroke, TweenInfo.new(0.3), { Color = Color3.fromRGB(35,75,190) }):Play()
            end)
        end
    end

    confirmBtn.MouseButton1Click:Connect(tryKey)
    keyInput.FocusLost:Connect(function(enter) if enter then tryKey() end end)

    -- Warten bis Key korrekt
    while not keyDone do task.wait(0.05) end
end



-- ════════════════════════════════════════════════════════════
--  HAUPT-FENSTER
-- ════════════════════════════════════════════════════════════

local window = Rayfield:CreateWindow({
    name          = "Splash Scripts",
    subtitle      = "German Voice  ·  v4.0",
    sidebarLayout  = true,
    theme          = THEME,
    collapsedLabel = "Splash Scripts",
    configuration = {
        autoSave = true,
        autoLoad = true,
        fileName = "SplashV4",
    },
})

-- ════════════════════════════════════════════════════════════
--  TAB: FLY
-- ════════════════════════════════════════════════════════════

local flyTab    = window:CreateTab({ name = "Fly",     icon = 0 })
local flyActive = false
local flySpeed  = 80
local flyConn, bv, bg

local function cleanFly()
    flyActive = false
    if flyConn then flyConn:Disconnect(); flyConn = nil end
    if bv      then bv:Destroy();        bv      = nil end
    if bg      then bg:Destroy();        bg      = nil end
    local h = getHum()
    if h then h.PlatformStand = false end
end

local function startFly()
    local hrp = getHRP(); local hum = getHum()
    if not hrp or not hum then return end
    cleanFly(); flyActive = true
    hum.PlatformStand = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.Velocity = Vector3.zero; bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e9,1e9,1e9); bg.D = 50; bg.P = 1200; bg.Parent = hrp

    flyConn = RunService.Heartbeat:Connect(function()
        if not flyActive then cleanFly() return end
        local h2 = getHRP(); if not h2 then cleanFeturn end
        local dir = Vector3.zero; local cf = Camera.CFrame
        if UserInputService:IsKeyDown(Enum.KeyCode.W)         then dir += cf.LookVector          end
        if UserInputService:IsKeyDown(Enum.KeyCode.S)         then dir -= cf.LookVector          end
        if UserInputService:IsKeyDown(Enum.KeyCode.A)         then dir -= cf.RightVector         end
        if UserInputService:IsKeyDown(Enum.KeyCode.D)         then dir += cf.RightVector         end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space)     then dir += Vector3.new(0,1,0)     end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir -= Vector3.new(0,1,0)     end
        local boost = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 4 or 1
        bv.Velocity = dir.Magnitude > 0 and dir.Unit*(flySpeed*boost) or Vector3.zero
        bg.CFrame   = cf
    end)
end

flyTab:CreateToggle({ name = "Fly aktivieren", currentValue = false, flag = "Fly",
    callback = function(v) if v then startFly() else cleanFly() end end })

flyTab:CreateSlider({ name = "Fly Speed", min = 10, max = 600, default = 80, flag = "FlySpd",
    callback = function(v) flySpeed = v end })

flyTab:CreateKeybind({ name = "Fly Keybind", currentKeybind = "F", flag = "FlyKey",
    callback = function() if flyActive then cleanFly() else startFly() end end })

flyTab:CreateLabel({ text = "W/A/S/D  ·  Space = hoch  ·  Shift = runter  ·  Strg = 4× Speed" })

-- ════════════════════════════════════════════════════════════
--  TAB: FUN
-- ════════════════════════════════════════════════════════════

local funTab   = window:CreateTab({ name = "Fun",     icon = 0 })
local selP     = getPlayerList()[1] or ""

local pDrop = funTab:CreateDropdown({ name = "Spieler auswählen",
    options = getPlayerList(), currentOption = selP, flag = "SelP",
    callback = function(v) selP = v end })

funTab:CreateButton({ name = "Liste neu laden", callback = function()
    selP = getPlayerList()[1] or ""
    window:Notify({ title = "Aktualisiert", content = "Spielerliste neu geladen." })
end })

-- Fling & TP
funTab:CreateSection({ name = "Fling & Teleport" })

funTab:CreateButton({ name = "Spieler flingen", callback = function()
    local _, tc = getTarget(selP)
    if not tc then window:Notify({ title = "Fehler", content = "Spieler nicht gefunden." }) return end
    local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    for i = 1, 10 do
        task.delay(i*0.012, function()
            local f = Instance.new("BodyVelocity")
            f.MaxForce = Vector3.new(1e9,1e9,1e9)
            f.Velocity = Vector3.new(math.random(-600,600), 1000, math.random(-600,600))
            f.Parent = hrp
            game:GetService("Debris"):AddItem(f, 0.1)
        end)
    end
    window:Notify({ title = "Fling", content = selP.." wurde geflingt!" })
end })

funTab:CreateButton({ name = "Alle Spieler flingen", callback = function()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local f = Instance.new("BodyVelocity")
                f.MaxForce = Vector3.new(1e9,1e9,1e9)
                f.Velocity = Vector3.new(math.random(-600,600), 1000, math.random(-600,600))
                f.Parent = hrp
                game:GetService("Debris"):AddItem(f, 0.1)
            end
        end
    end
    window:Notify({ title = "Fling", content = "Alle Spieler geflingt!" })
end })

funTab:CreateButton({ name = "Zu Spieler teleportieren", callback = function()
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
    local bv2 = Instance.new("BodyVelocity")
    bv2.MaxForce = Vector3.new(0,1e9,0); bv2.Velocity = Vector3.new(0,2500,0); bv2.Parent = hrp
    game:GetService("Debris"):AddItem(bv2, 0.25)
end })

funTab:CreateButton({ name = "Spieler einfrieren", callback = function()
    local _, tc = getTarget(selP)
    if not tc then window:Notify({ title = "Fehler", content = "Spieler nicht gefunden." }) return end
    local hum = tc:FindFirstChild("Humanoid"); if not hum then return end
    local frozen = hum.WalkSpeed == 0
    hum.WalkSpeed = frozen and 16 or 0
    hum.JumpPower = frozen and 50 or 0
    window:Notify({ title = "Freeze", content = selP..(frozen and " freigegeben" or " eingefroren") })
end })

funTab:CreateButton({ name = "Spieler drehen (Spin)", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local hrp = tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    task.spawn(function()
        for i = 1, 100 do hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(20), 0) task.wait(0.01) end
    end)
end })

funTab:CreateButton({ name = "Spieler verfolgen (10 Sek)", callback = function()
    task.spawn(function()
        for i = 1, 34 do
            local _, tc = getTarget(selP)
            if tc then
                local th, mh = tc:FindFirstChild("HumanoidRootPart"), getHRP()
                if th and mh then mh.CFrame = th.CFrame * CFrame.new(2,0,0) end
            end
            task.wait(0.3)
        end
    end)
    window:Notify({ title = "Stalk", content = "Verfolge "..selP.." für 10 Sek." })
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

-- Speed & Movement
funTab:CreateSection({ name = "Speed & Movement" })

funTab:CreateToggle({ name = "Super Speed", currentValue = false, flag = "SSpd",
    callback = function(v) local h = getHum() if h then h.WalkSpeed = v and 120 or 16 end end })

funTab:CreateSlider({ name = "Walk Speed", min = 16, max = 500, default = 120, flag = "WSpd",
    callback = function(v) local h = getHum() if h then h.WalkSpeed = v end end })

funTab:CreateToggle({ name = "Inf Jump", currentValue = false, flag = "InfJ",
    callback = function(v)
        if v then UserInputService.JumpRequest:Connect(function()
            local h = getHum() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
        end) end
    end })

funTab:CreateSlider({ name = "Jump Power", min = 50, max = 500, default = 50, flag = "JmpPow",
    callback = function(v) local h = getHum() if h then h.JumpPower = v end end })

funTab:CreateToggle({ name = "Noclip", currentValue = false, flag = "Noclip",
    callback = function(v)
        if v then RunService.Stepped:Connect(function()
            local c = getChar() if not c then return end
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end) end
    end })

funTab:CreateToggle({ name = "Unsichtbar", currentValue = false, flag = "Invis",
    callback = function(v)
        local c = getChar(); if not c then return end
        for _, p in ipairs(c:GetDescendants()) do
            if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency = v and 1 or 0 end
        end
    end })

-- Outfit
funTab:CreateSection({ name = "Outfit & Charakter" })

funTab:CreateButton({ name = "Outfit klauen", callback = function()
    local tp = getTarget(selP)
    if not tp then window:Notify({ title = "Fehler", content = "Spieler nicht gefunden." }) return end
    local desc = Players:GetHumanoidDescriptionFromUserId(tp.UserId)
    local h = getHum()
    if h then h:ApplyDescription(desc) window:Notify({ title = "Outfit", content = "Outfit von "..selP.." geklaut!" }) end
end })

funTab:CreateButton({ name = "Eigenes Outfit zurück", callback = function()
    local desc = Players:GetHumanoidDescriptionFromUserId(LP.UserId)
    local h = getHum(); if h then h:ApplyDescription(desc) end
end })

funTab:CreateButton({ name = "Riesenkopf (Spieler)", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local head = tc:FindFirstChild("Head"); if head then head.Size = Vector3.new(6,6,6) end
end })

funTab:CreateButton({ name = "Spieler in Boden TP", callback = function()
    local _, tc = getTarget(selP); if not tc then return end
    local hrp = tc:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.CFrame = hrp.CFrame - Vector3.new(0, 50, 0) end
end })

-- ════════════════════════════════════════════════════════════
--  TAB: ESP
-- ════════════════════════════════════════════════════════════

local espTab   = window:CreateTab({ name = "ESP",     icon = 0 })
local espOn    = false
local espHL    = {}
local espColor = Color3.fromRGB(40, 120, 255)
local espFill  = 0.5
local espWalls = true

local function removeESP()
    for _, h in pairs(espHL) do pcall(function() h:Destroy() end) end; espHL = {}
end

local function addESP(char, name)
    local h = Instance.new("Highlight")
    h.FillColor = espColor; h.OutlineColor = Color3.fromRGB(255,255,255)
    h.FillTransparency = espFill; h.OutlineTransparency = 0
    h.DepthMode = espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
    h.Parent = char; espHL[name] = h
end

local function buildESP()
    removeESP()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP and p.Character then addESP(p.Character, p.Name) end
    end
end

espTab:CreateToggle({ name = "ESP aktivieren", currentValue = false, flag = "ESP",
    callback = function(v) espOn = v if v then buildESP() else removeESP() end end })

espTab:CreateColorPicker({ name = "ESP Farbe", color = espColor, flag = "ESPCol",
    callback = function(v) espColor = v for _, h in pairs(espHL) do if h then h.FillColor = v end end end })

espTab:CreateSlider({ name = "ESP Transparenz", min = 0, max = 10, default = 5, flag = "ESPAlp",
    callback = function(v) espFill = v/10 for _, h in pairs(espHL) do if h then h.FillTransparency = espFill end end end })

espTab:CreateToggle({ name = "Durch Wände", currentValue = true, flag = "ESPWall",
    callback = function(v)
        espWalls = v
        for _, h in pairs(espHL) do if h then
            h.DepthMode = v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        end end
    end })

espTab:CreateButton({ name = "ESP aktualisieren", callback = function()
    if espOn then buildESP() end
    window:Notify({ title = "ESP", content = "Aktualisiert." })
end })

Players.PlayerAdded:Connect(function(p)
    p.CharacterAdded:Connect(function(char)
        if not espOn then return end; task.wait(1); addESP(char, p.Name)
    end)
end)
Players.PlayerRemoving:Connect(function(p)
    if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end); espHL[p.Name] = nil end
end)

-- ════════════════════════════════════════════════════════════
--  TAB: WORLD
-- ════════════════════════════════════════════════════════════

local worldTab = window:CreateTab({ name = "World",   icon = 0 })

worldTab:CreateSection({ name = "Licht & Atmosphäre" })

worldTab:CreateToggle({ name = "Fullbright", currentValue = false, flag = "Fullbright",
    callback = function(v)
        Lighting.Brightness = v and 10 or 2; Lighting.GlobalShadows = not v
        Lighting.FogEnd = v and 1e9 or 100000
    end })

worldTab:CreateSlider({ name = "Helligkeit", min = 0, max = 10, default = 2, flag = "Bright",
    callback = function(v) Lighting.Brightness = v end })

worldTab:CreateSlider({ name = "Uhrzeit (0–24)", min = 0, max = 24, default = 14, flag = "Clock",
    callback = function(v) Lighting.ClockTime = v end })

worldTab:CreateToggle({ name = "Fog entfernen", currentValue = false, flag = "NoFog",
    callback = function(v)
        Lighting.FogEnd = v and 1e9 or 100000; Lighting.FogStart = v and 1e9 or 0
    end })

worldTab:CreateSection({ name = "Physik & Map" })

worldTab:CreateSlider({ name = "Gravity", min = 0, max = 400, default = 196, flag = "Grav",
    callback = function(v) workspace.Gravity = v end })

worldTab:CreateToggle({ name = "Anti-Gravity", currentValue = false, flag = "NoGrav",
    callback = function(v) workspace.Gravity = v and 0 or 196 end })

worldTab:CreateButton({ name = "Alle NPCs entfernen", callback = function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and not Players:GetPlayerFromCharacter(obj) then
            obj:Destroy()
        end
    end
    window:Notify({ title = "World", content = "Alle NPCs entfernt." })
end })

-- ════════════════════════════════════════════════════════════
--  TAB: PLAYER
-- ════════════════════════════════════════════════════════════

local playerTab = window:CreateTab({ name = "Player",  icon = 0 })

playerTab:CreateSection({ name = "Gesundheit" })

playerTab:CreateToggle({ name = "God Mode", currentValue = false, flag = "God",
    callback = function(v)
        local h = getHum(); if h then h.MaxHealth = v and math.huge or 100; h.Health = v and math.huge or 100 end
    end })

playerTab:CreateToggle({ name = "Auto-Heal", currentValue = false, flag = "AHeal",
    callback = function(v)
        if v then task.spawn(function()
            while v do local h = getHum() if h then h.Health = h.MaxHealth end task.wait(0.1) end
        end) end
    end })

playerTab:CreateSlider({ name = "HP setzen", min = 1, max = 1000, default = 100, flag = "SetHP",
    callback = function(v) local h = getHum() if h then h.Health = v end end })

playerTab:CreateButton({ name = "Respawn", callback = function() LP:LoadCharacter() end })

playerTab:CreateSection({ name = "Kamera & Sicht" })

playerTab:CreateSlider({ name = "FOV", min = 30, max = 120, default = 70, flag = "FOV",
    callback = function(v) Camera.FieldOfView = v end })

playerTab:CreateButton({ name = "Kamera zurücksetzen", callback = function()
    Camera.FieldOfView = 70; Camera.CameraType = Enum.CameraType.Custom
end })

playerTab:CreateSection({ name = "Chat" })

playerTab:CreateInput({ name = "Chat Nachricht", placeholder = "Nachricht eingeben...", flag = "Chat",
    callback = function(v)
        local rs = game:GetService("ReplicatedStorage")
        local ce = rs:FindFirstChild("DefaultChatSystemChatEvents")
        if ce then local sm = ce:FindFirstChild("SayMessageRequest") if sm then sm:FireServer(v, "All") end end
    end })

-- ════════════════════════════════════════════════════════════
--  TAB: SETTINGS
-- ════════════════════════════════════════════════════════════

local settingsTab = window:CreateTab({ name = "Settings", icon = 0 })

settingsTab:CreateSection({ name = "Theme wechseln" })

settingsTab:CreateDropdown({ name = "Theme",
    options = { "Midnight Blue", "Cobalt", "Amethyst", "Ember", "Frost", "Rose" },
    currentOption = "Midnight Blue", flag = "Theme",
    callback = function(v)
        local map = { ["Midnight Blue"] = THEME, Cobalt = "cobalt", Amethyst = "amethyst",
                      Ember = "ember", Frost = "frost", Rose = "rose" }
        window:ChangeTheme(map[v] or "cobalt")
    end })

settingsTab:CreateSection({ name = "Info" })
settingsTab:CreateLabel({ text = "Splash Scripts v4.0  —  German Voice Edition" })
settingsTab:CreateLabel({ text = "Discord: discord.gg/eyzfsAjpSr" })
settingsTab:CreateLabel({ text = "Key wird lokal gespeichert — einmal eingeben reicht." })
settingsTab:CreateLabel({ text = "Fly: W/A/S/D · Space · Shift · Strg = 4× Speed" })

settingsTab:CreateButton({ name = "Key zurücksetzen (Logout)", callback = function()
    pcall(function() delfile(KEY_FILE) end)
    window:Notify({ title = "Key", content = "Key gelöscht. Beim nächsten Start wird er neu abgefragt." })
end })

-- ════════════════════════════════════════════════════════════
--  Start Notification
-- ════════════════════════════════════════════════════════════

window:Notify({
    title   = "Splash Scripts v4.0",
    content = "Geladen! Viel Spaß auf German Voice.",
})
