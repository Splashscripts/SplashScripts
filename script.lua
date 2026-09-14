local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local window = Rayfield:CreateWindow({
    name = "Splash Scripts",
    subtitle = "German Voice Edition",
    sidebarLayout = true,
    theme = "cobalt",
    configuration = {
        autoSave = true,
        autoLoad = true,
        fileName = "SplashConfig",
    },
})

-- Hilfsfunktion: Spielerliste
local function getPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    return names
end

local function getPlayerByName(name)
    return Players:FindFirstChild(name)
end

-- ══════════════════════════════════════
--              FLY TAB
-- ══════════════════════════════════════

local flyTab = window:CreateTab({ name = "Fly", icon = 0 })

local flySpeed = 50
local flyEnabled = false
local flyConnection = nil
local bodyVelocity = nil
local bodyGyro = nil

local function stopFly()
    flyEnabled = false
    if flyConnection then flyConnection:Disconnect() flyConnection = nil end
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = false end
    end
end

local function startFly()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    flyEnabled = true
    hum.PlatformStand = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVelocity.Parent = hrp

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    bodyGyro.D = 100
    bodyGyro.Parent = hrp

    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyEnabled then return end
        local char2 = LocalPlayer.Character
        if not char2 then stopFly() return end
        local hrp2 = char2:FindFirstChild("HumanoidRootPart")
        if not hrp2 then stopFly() return end

        local cam = workspace.CurrentCamera
        local direction = Vector3.new(0, 0, 0)

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - cam.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + cam.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0, 1, 0) end

        if direction.Magnitude > 0 then
            bodyVelocity.Velocity = direction.Unit * flySpeed
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end

        bodyGyro.CFrame = cam.CFrame
    end)
end

flyTab:CreateToggle({
    name = "Fly aktivieren",
    currentValue = false,
    flag = "FlyToggle",
    callback = function(value)
        if value then startFly() else stopFly() end
    end,
})

flyTab:CreateSlider({
    name = "Fly Speed",
    min = 10,
    max = 300,
    default = 50,
    flag = "FlySpeed",
    callback = function(value)
        flySpeed = value
    end,
})

flyTab:CreateKeybind({
    name = "Fly Keybind",
    currentKeybind = "F",
    flag = "FlyKeybind",
    callback = function()
        if flyEnabled then
            stopFly()
        else
            startFly()
        end
    end,
})

-- ══════════════════════════════════════
--              FUN TAB
-- ══════════════════════════════════════

local funTab = window:CreateTab({ name = "Fun", icon = 0 })

-- Spieler Dropdown
local selectedFunPlayer = ""

funTab:CreateDropdown({
    name = "Spieler auswählen",
    options = getPlayerNames(),
    currentOption = "",
    flag = "FunPlayer",
    callback = function(value)
        selectedFunPlayer = value
    end,
})

funTab:CreateButton({
    name = "Liste aktualisieren",
    callback = function()
        window:Notify({ title = "Info", content = "Bitte Script neu laden um Liste zu aktualisieren." })
    end,
})

-- Spieler flingen
funTab:CreateButton({
    name = "Spieler flingen",
    callback = function()
        if selectedFunPlayer == "" then
            window:Notify({ title = "Fehler", content = "Kein Spieler ausgewählt!" })
            return
        end
        local target = getPlayerByName(selectedFunPlayer)
        if not target or not target.Character then return end
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP or not myHRP then return end

        local bv = Instance.new("BodyVelocity")
        bv.Velocity = (targetHRP.Position - myHRP.Position).Unit * 200 + Vector3.new(0, 100, 0)
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Parent = targetHRP
        game:GetService("Debris"):AddItem(bv, 0.2)
    end,
})

-- Auf Kopf setzen
funTab:CreateButton({
    name = "Auf Kopf setzen",
    callback = function()
        if selectedFunPlayer == "" then
            window:Notify({ title = "Fehler", content = "Kein Spieler ausgewählt!" })
            return
        end
        local target = getPlayerByName(selectedFunPlayer)
        if not target or not target.Character then return end
        local head = target.Character:FindFirstChild("Head")
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not head or not myHRP then return end
        myHRP.CFrame = CFrame.new(head.Position + Vector3.new(0, 3, 0))
    end,
})

-- Zu Spieler teleportieren
funTab:CreateButton({
    name = "Zu Spieler teleportieren",
    callback = function()
        if selectedFunPlayer == "" then
            window:Notify({ title = "Fehler", content = "Kein Spieler ausgewählt!" })
            return
        end
        local target = getPlayerByName(selectedFunPlayer)
        if not target or not target.Character then return end
        local targetHRP = target.Character:FindFirstChild("HumanoidRootPart")
        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not targetHRP or not myHRP then return end
        myHRP.CFrame = targetHRP.CFrame + Vector3.new(3, 0, 0)
    end,
})

-- Outfit klauen
funTab:CreateButton({
    name = "Outfit klauen",
    callback = function()
        if selectedFunPlayer == "" then
            window:Notify({ title = "Fehler", content = "Kein Spieler ausgewählt!" })
            return
        end
        local target = getPlayerByName(selectedFunPlayer)
        if not target then return end
        local userId = target.UserId
        local url = "https://avatar.roblox.com/v1/users/" .. userId .. "/avatar"
        window:Notify({ title = "Outfit", content = "Outfit von " .. selectedFunPlayer .. " wird angewendet..." })
        -- Charakter neu laden mit dem Aussehen des Ziels
        local humanoidDescription = Players:GetHumanoidDescriptionFromUserId(userId)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid:ApplyDescription(humanoidDescription)
        end
    end,
})

-- Super Speed
funTab:CreateToggle({
    name = "Super Speed",
    currentValue = false,
    flag = "SuperSpeed",
    callback = function(value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value and 150 or 16
        end
    end,
})

funTab:CreateSlider({
    name = "Speed Wert",
    min = 16,
    max = 500,
    default = 150,
    flag = "FunSpeed",
    callback = function(value)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end,
})

-- Inf Jump
funTab:CreateToggle({
    name = "Inf Jump",
    currentValue = false,
    flag = "InfJump",
    callback = function(value)
        if value then
            UserInputService.JumpRequest:Connect(function()
                local char = LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid:ChangeState("Jumping")
                end
            end)
        end
    end,
})

-- Noclip
local noclipEnabled = false
local noclipConn = nil

funTab:CreateToggle({
    name = "Noclip",
    currentValue = false,
    flag = "Noclip",
    callback = function(value)
        noclipEnabled = value
        if value then
            noclipConn = RunService.Stepped:Connect(function()
                if not noclipEnabled then
                    noclipConn:Disconnect()
                    return
                end
                local char = LocalPlayer.Character
                if not char then return end
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
        end
    end,
})

-- Fake Lag (Freeze)
funTab:CreateButton({
    name = "Freeze Spieler",
    callback = function()
        if selectedFunPlayer == "" then
            window:Notify({ title = "Fehler", content = "Kein Spieler ausgewählt!" })
            return
        end
        local target = getPlayerByName(selectedFunPlayer)
        if not target or not target.Character then return end
        local hrp = target.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local anchor = hrp.Anchored
        hrp.Anchored = not anchor
        window:Notify({ title = "Fun", content = selectedFunPlayer .. " ist jetzt " .. (hrp.Anchored and "eingefroren" or "frei") })
    end,
})

-- ══════════════════════════════════════
--              ESP TAB
-- ══════════════════════════════════════

local espTab = window:CreateTab({ name = "ESP", icon = 0 })

local espEnabled = false
local espBoxes = {}
local espConn = nil

local function removeESP()
    for _, v in pairs(espBoxes) do
        if v then v:Destroy() end
    end
    espBoxes = {}
end

local function createESP()
    removeESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(0, 120, 255)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
            highlight.Parent = player.Character
            espBoxes[player.Name] = highlight
        end
    end
end

espTab:CreateToggle({
    name = "ESP aktivieren",
    currentValue = false,
    flag = "ESPToggle",
    callback = function(value)
        espEnabled = value
        if value then
            createESP()
            espConn = Players.PlayerAdded:Connect(function(p)
                p.CharacterAdded:Connect(function(char)
                    if espEnabled then
                        local h = Instance.new("Highlight")
                        h.FillColor = Color3.fromRGB(0, 120, 255)
                        h.OutlineColor = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.5
                        h.Parent = char
                        espBoxes[p.Name] = h
                    end
                end)
            end)
        else
            removeESP()
            if espConn then espConn:Disconnect() espConn = nil end
        end
    end,
})

espTab:CreateColorPicker({
    name = "ESP Farbe",
    color = Color3.fromRGB(0, 120, 255),
    flag = "ESPColor",
    callback = function(value)
        for _, h in pairs(espBoxes) do
            if h then h.FillColor = value end
        end
    end,
})

espTab:CreateSlider({
    name = "ESP Transparenz",
    min = 0,
    max = 10,
    default = 5,
    flag = "ESPTransparency",
    callback = function(value)
        for _, h in pairs(espBoxes) do
            if h then h.FillTransparency = value / 10 end
        end
    end,
})

espTab:CreateToggle({
    name = "Skeleton ESP",
    currentValue = false,
    flag = "SkeletonESP",
    callback = function(value)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local h = espBoxes[player.Name]
                if h then
                    h.DepthMode = value and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
                end
            end
        end
    end,
})

-- ══════════════════════════════════════

window:Notify({
    title = "Splash Scripts",
    content = "Script geladen! Viel Spaß.",
})
