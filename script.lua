local Rayfield = loadstring(game:HttpGet("https://sirius.menu/gen2"))()

local window = Rayfield:CreateWindow({
    name = "Splash Scripts",
    subtitle = "Willkommen zurück!",
    sidebarLayout = true,
    theme = "cobalt",

    configuration = {
        autoSave = true,
        autoLoad = true,
        fileName = "SplashConfig",
    },
})

-- ══════════════════════════════════════
--              HOME TAB
-- ══════════════════════════════════════

local homeTab = window:CreateTab({ name = "Home", icon = 0 })

homeTab:CreateButton({
    name = "Script ausführen",
    callback = function()
        window:Notify({
            title = "Splash Scripts",
            content = "Script wurde ausgeführt!",
        })
    end,
})

-- ══════════════════════════════════════
--              PLAYER TAB
-- ══════════════════════════════════════

local playerTab = window:CreateTab({ name = "Player", icon = 0 })

playerTab:CreateToggle({
    name = "Speed Hack",
    callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value and 50 or 16
        end
    end,
})

playerTab:CreateSlider({
    name = "Walk Speed",
    min = 16,
    max = 150,
    default = 16,
    callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end,
})

playerTab:CreateToggle({
    name = "Inf Jump",
    callback = function(value)
        local UIS = game:GetService("UserInputService")
        if value then
            UIS.JumpRequest:Connect(function()
                local player = game.Players.LocalPlayer
                if player.Character and player.Character:FindFirstChild("Humanoid") then
                    player.Character.Humanoid:ChangeState("Jumping")
                end
            end)
        end
    end,
})

playerTab:CreateSlider({
    name = "Jump Power",
    min = 50,
    max = 300,
    default = 50,
    callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end,
})

-- ══════════════════════════════════════
--              SETTINGS TAB
-- ══════════════════════════════════════

local settingsTab = window:CreateTab({ name = "Settings", icon = 0 })

settingsTab:CreateButton({
    name = "UI verstecken  (K)",
    callback = function()
        window:Destroy()
    end,
})

-- ══════════════════════════════════════

window:Notify({
    title = "Splash Scripts",
    content = "Script geladen!",
})
