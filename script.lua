-- ╔══════════════════════════════════════════════════════════╗
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
    -- Fenster
    WindowColor          = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(5,  10, 28)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8,  16, 42)),
    }),
    ShadowColor          = Color3.fromRGB(0, 3, 12),
    LiveAnimation        = true,

    -- Text
    TitlingColor         = Color3.fromRGB(235, 245, 255),
    ContentColor         = Color3.fromRGB(170, 195, 240),
    ElementTextHoverColor= Color3.fromRGB(255, 255, 255),

    -- Tabs
    TabBackgroundColor   = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 38, 95)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(24, 50, 120)),
    }),
    TabColor             = Color3.fromRGB(160, 200, 255),
    TabStroke            = ColorSequence.new(Color3.fromRGB(40, 80, 180)),

    -- Elemente
    ElementGradient      = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(12, 22, 58)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 30, 75)),
    }),
    ElementStroke        = Color3.fromRGB(28, 58, 145),
    ElementStrokeHover   = Color3.fromRGB(60, 130, 255),
    ElementTransparency  = 0,

    -- Akzent  (Toggles, Slider-Fill, Buttons aktiv)
    AccentColor          = Color3.fromRGB(40, 115, 255),
    AccentStroke         = Color3.fromRGB(70, 150, 255),
    AccentGlow           = 0.4,

    -- Slider
    SliderBackground     = Color3.fromRGB(8,  16, 45),
    SliderBackgroundHover= Color3.fromRGB(14, 26, 65),
    SliderProgressColor  = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 100, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 170, 255)),
    }),
    SliderHandle         = Color3.fromRGB(120, 180, 255),
    SliderStroke         = Color3.fromRGB(30, 70, 160),

    -- Toggle
    ToggleTrackColor     = Color3.fromRGB(8, 16, 45),
    ToggleTrackTransparency = 0,
    ToggleKnobOffColor   = Color3.fromRGB(80, 110, 170),

    -- Felder & Dropdowns
    FieldBackground      = Color3.fromRGB(8, 14, 40),
    FieldGlow            = Color3.fromRGB(30, 80, 220),
    PlaceholderColor     = Color3.fromRGB(80, 110, 180),
    DropdownHighlight    = Color3.fromRGB(25, 65, 160),

    -- Oberfläche
    SurfaceStroke        = Color3.fromRGB(22, 45, 110),
    CornerRoundness      = UDim.new(0, 12),
    PillCornerRadius     = UDim.new(0, 10),
    ElementCornerRadius  = UDim.new(0, 9),
}

-- ════════════════════════════════════════════════════════════
--  KEY SYSTEM
-- ════════════════════════════════════════════════════════════

local VALID_KEY     = "SplashScripts2026!"
local DISCORD_LINK  = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE      = "SplashKey.txt"

local function saveKey(key)
    pcall(function() writefile(KEY_FILE, key) end)
end

local function loadSavedKey()
    local ok, val = pcall(function() return readfile(KEY_FILE) end)
    return ok and val or nil
end

-- Prüfe gespeicherten Key
local savedKey = loadSavedKey()
if savedKey ~= VALID_KEY then
    -- Key Fenster bauen
    local keyWindow = Rayfield:CreateWindow({
        name          = "Splash Scripts",
        subtitle      = "Key System",
        sidebarLayout = false,
        theme         = THEME,
        pillLabel     = "Splash",
    })

    local keyTab = keyWindow:CreateTab({ name = "Key eingeben", icon = 0 })

    keyTab:CreateLabel({ text = "Splash Scripts ist key-geschützt." })
    keyTab:CreateLabel({ text = "Trete dem Discord bei um deinen Key zu erhalten:" })
    keyTab:CreateLabel({ text = DISCORD_LINK })
    keyTab:CreateDivider()

    local keyInput = keyTab:CreateInput({
        name        = "Key eingeben",
        placeholder = "SplashScripts...",
        flag        = "KeyInput",
        callback    = function() end,
    })

    keyTab:CreateButton({
        name = "Key bestätigen",
        callback = function()
            local entered = keyInput.value or ""
            if entered == VALID_KEY then
                saveKey(entered)
                keyWindow:Notify({
                    title   = "Zugang gewährt",
                    content = "Willkommen bei Splash Scripts!",
                })
                task.wait(1.5)
                keyWindow:Destroy()
                -- Script läuft weiter nach dem Destroy
            else
                keyWindow:Notify({
                    title   = "Falscher Key",
                    content = "Trete dem Discord bei: " .. DISCORD_LINK,
                })
            end
        end,
    })

    -- Warte bis Fenster zerstört (Key korrekt)
    repeat task.wait(0.2) until keyWindow.destroyed
end

-- ════════════════════════════════════════════════════════════
--  HAUPT-FENSTER
-- ════════════════════════════════════════════════════════════

local window = Rayfield:CreateWindow({
    name          = "Splash Scripts",
    subtitle      = "German Voice  ·  v4.0",
    sidebarLayout = true,
    theme         = THEME,
    pillLabel     = "Splash",
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
        local h2 = getHRP(); if not h2 then cleanFly() return end
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

