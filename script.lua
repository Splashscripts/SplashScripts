-- SPLASH SCRIPTS v8.0
-- German Voice Edition

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LP               = Players.LocalPlayer
local Camera           = workspace.CurrentCamera

local function getChar() return LP.Character end
local function getHRP()  local c=getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum()  local c=getChar() return c and c:FindFirstChild("Humanoid") end
local function getPlayerList()
    local t={}
    for _,p in ipairs(Players:GetPlayers()) do if p~=LP then table.insert(t,p.Name) end end
    if #t==0 then table.insert(t,"(Niemand)") end
    return t
end
local function getTarget(name)
    local p=Players:FindFirstChild(name)
    if p and p.Character then return p,p.Character end
    return nil,nil
end

-- ═══════════════════════════════
-- FARBEN
-- ═══════════════════════════════
-- Tiefes Mitternachtsblau mit lila Akzent
local C = {
    win      = Color3.fromRGB(18, 22, 48),      -- Fenster Hintergrund
    winB     = Color3.fromRGB(12, 16, 38),      -- Fenster unten
    topbar   = Color3.fromRGB(22, 28, 60),      -- Topbar
    side     = Color3.fromRGB(15, 20, 50),      -- Sidebar
    sideHov  = Color3.fromRGB(22, 30, 70),      -- Sidebar hover
    sideAct  = Color3.fromRGB(30, 40, 95),      -- Sidebar aktiv
    el       = Color3.fromRGB(22, 28, 65),      -- Element Hintergrund
    elHov    = Color3.fromRGB(30, 38, 85),      -- Element hover
    acc      = Color3.fromRGB(88, 130, 255),    -- Akzent Blau
    accB     = Color3.fromRGB(60, 100, 230),    -- Akzent dunkel
    accL     = Color3.fromRGB(130, 168, 255),   -- Akzent hell
    txt      = Color3.fromRGB(220, 228, 255),   -- Text weiß-blau
    txtD     = Color3.fromRGB(140, 158, 210),   -- Text gedimmt
    txtM     = Color3.fromRGB(80, 100, 165),    -- Text gemuted
    ok       = Color3.fromRGB(52, 211, 120),    -- Grün
    err      = Color3.fromRGB(248, 90, 90),     -- Rot
    tog_on   = Color3.fromRGB(88, 130, 255),
    tog_off  = Color3.fromRGB(35, 42, 90),
    sl_bg    = Color3.fromRGB(14, 18, 45),
}

-- ═══════════════════════════════
-- HELPERS
-- ═══════════════════════════════
local function corner(p,r) local c=Instance.new("UICorner",p); c.CornerRadius=UDim.new(0,r or 8); return c end
local function grad(p,a,b,r) local g=Instance.new("UIGradient",p); g.Color=ColorSequence.new(a,b); g.Rotation=r or 90; return g end
local function tw(o,props,t,s,d) TweenService:Create(o,TweenInfo.new(t or 0.15,s or Enum.EasingStyle.Quad,d or Enum.EasingDirection.Out),props):Play() end

local function mkBtn(parent, text, size, pos)
    local b=Instance.new("TextButton",parent)
    b.Size=size; b.Position=pos or UDim2.new(0,0,0,0)
    b.BackgroundColor3=C.el; b.BorderSizePixel=0
    b.Text=text; b.TextColor3=C.txt; b.Font=Enum.Font.GothamBold; b.TextSize=13
    b.AutoButtonColor=false; corner(b,8); grad(b,C.el,C.elHov,90)
    b.MouseEnter:Connect(function() tw(b,{BackgroundColor3=C.elHov}) end)
    b.MouseLeave:Connect(function() tw(b,{BackgroundColor3=C.el}) end)
    b.MouseButton1Click:Connect(function() tw(b,{BackgroundColor3=C.acc},0.08); task.delay(0.15,function() tw(b,{BackgroundColor3=C.el}) end) end)
    return b
end

-- Notification
local notifSg, notifF
local function notify(title, msg, col)
    if not notifF then return end
    local nt=notifF:FindFirstChild("T"); local nm=notifF:FindFirstChild("M")
    if nt then nt.Text=title end; if nm then nm.Text=msg end
    notifF.BackgroundColor3=col or C.el
    tw(notifF,{Position=UDim2.new(1,-310,1,-90)},0.4,Enum.EasingStyle.Back)
    task.delay(3.5,function() tw(notifF,{Position=UDim2.new(1,-310,1,10)},0.3) end)
end

-- ═══════════════════════════════
-- KEY SYSTEM
-- ═══════════════════════════════
local VALID_KEY    = "SplashScripts2026!"
local DISCORD_LINK = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE     = "SplashKey.txt"

local function saveKey(k) pcall(function() writefile(KEY_FILE,k) end) end
local function loadKey()
    local ok,v=pcall(function() return readfile(KEY_FILE) end)
    return (ok and type(v)=="string") and v or ""
end

local function showKey(onDone)
    local sg=Instance.new("ScreenGui"); sg.Name="SplashKey"; sg.ResetOnSpawn=false
    sg.IgnoreGuiInset=true; sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    sg.Parent=LP:WaitForChild("PlayerGui")

    local blur=Instance.new("BlurEffect"); blur.Size=22; blur.Parent=Lighting

    -- Dim
    local dim=Instance.new("Frame",sg); dim.Size=UDim2.fromScale(1,1)
    dim.BackgroundColor3=Color3.fromRGB(0,0,0); dim.BackgroundTransparency=0.5; dim.BorderSizePixel=0; dim.ZIndex=1

    -- Glow hinter Karte
    local gImg=Instance.new("ImageLabel",sg); gImg.Size=UDim2.fromOffset(560,460)
    gImg.AnchorPoint=Vector2.new(0.5,0.5); gImg.Position=UDim2.fromScale(0.5,0.5)
    gImg.BackgroundTransparency=1; gImg.Image="rbxassetid://5028857084"
    gImg.ImageColor3=Color3.fromRGB(70,100,255); gImg.ImageTransparency=0.72; gImg.ZIndex=1

    -- Karte
    local card=Instance.new("Frame",sg); card.Size=UDim2.fromOffset(470,360)
    card.AnchorPoint=Vector2.new(0.5,0.5); card.Position=UDim2.new(0.5,0,1.6,0)
    card.BackgroundColor3=C.win; card.BorderSizePixel=0; card.ZIndex=2
    corner(card,16); grad(card,Color3.fromRGB(22,28,62),Color3.fromRGB(12,16,40),140)

    -- Accent-Streifen oben
    local stripe=Instance.new("Frame",card); stripe.Size=UDim2.new(1,0,0,3)
    stripe.BackgroundColor3=C.acc; stripe.BorderSizePixel=0; stripe.ZIndex=4; corner(stripe,16)
    grad(stripe,C.accB,C.accL,0)

    -- Titel
    local tl=Instance.new("TextLabel",card); tl.Size=UDim2.new(1,0,0,48); tl.Position=UDim2.fromOffset(0,18)
    tl.BackgroundTransparency=1; tl.Text="SPLASH SCRIPTS"; tl.TextColor3=C.txt
    tl.Font=Enum.Font.GothamBlack; tl.TextSize=26; tl.ZIndex=3

    local sl=Instance.new("TextLabel",card); sl.Size=UDim2.new(1,0,0,20); sl.Position=UDim2.fromOffset(0,64)
    sl.BackgroundTransparency=1; sl.Text="German Voice Edition  ·  Key System"
    sl.TextColor3=C.txtD; sl.Font=Enum.Font.Gotham; sl.TextSize=13; sl.ZIndex=3

    -- Divider
    local dv=Instance.new("Frame",card); dv.Size=UDim2.new(0.88,0,0,1); dv.Position=UDim2.new(0.06,0,0,96)
    dv.BackgroundColor3=Color3.fromRGB(40,50,110); dv.BorderSizePixel=0; dv.ZIndex=3
    grad(dv,Color3.fromRGB(20,26,70),C.acc,0)

    -- Discord Label
    local dl=Instance.new("TextLabel",card); dl.Size=UDim2.new(0.88,0,0,18); dl.Position=UDim2.new(0.06,0,0,110)
    dl.BackgroundTransparency=1; dl.Text="Key holen → Trete unserem Discord bei:"
    dl.TextColor3=C.txtD; dl.Font=Enum.Font.GothamBold; dl.TextSize=12
    dl.TextXAlignment=Enum.TextXAlignment.Left; dl.ZIndex=3

    -- Discord Box
    local db=Instance.new("Frame",card); db.Size=UDim2.new(0.88,0,0,40); db.Position=UDim2.new(0.06,0,0,132)
    db.BackgroundColor3=Color3.fromRGB(15,20,52); db.BorderSizePixel=0; db.ZIndex=3; corner(db,9)
    grad(db,Color3.fromRGB(18,24,58),Color3.fromRGB(12,16,44),90)

    local dt=Instance.new("TextLabel",db); dt.Size=UDim2.new(1,-100,1,0); dt.Position=UDim2.fromOffset(12,0)
    dt.BackgroundTransparency=1; dt.Text=DISCORD_LINK; dt.TextColor3=C.accL
    dt.Font=Enum.Font.Gotham; dt.TextSize=12; dt.TextXAlignment=Enum.TextXAlignment.Left; dt.ZIndex=4

    local cb=Instance.new("TextButton",db); cb.Size=UDim2.fromOffset(84,28)
    cb.Position=UDim2.new(1,-92,0.5,-14); cb.BackgroundColor3=C.accB
    cb.Text="Kopieren"; cb.TextColor3=Color3.fromRGB(255,255,255)
    cb.Font=Enum.Font.GothamBold; cb.TextSize=12; cb.BorderSizePixel=0; cb.ZIndex=5; corner(cb,7)
    grad(cb,C.acc,C.accB,90)
    cb.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        cb.Text="✓ Kopiert!"; cb.BackgroundColor3=C.ok
        task.delay(2.5,function() cb.Text="Kopieren"; cb.BackgroundColor3=C.accB end)
    end)

    -- Key Label
    local kl=Instance.new("TextLabel",card); kl.Size=UDim2.new(0.88,0,0,18); kl.Position=UDim2.new(0.06,0,0,186)
    kl.BackgroundTransparency=1; kl.Text="Key eingeben:"; kl.TextColor3=C.txtD
    kl.Font=Enum.Font.GothamBold; kl.TextSize=12; kl.TextXAlignment=Enum.TextXAlignment.Left; kl.ZIndex=3

    -- Key Input
    local kf=Instance.new("Frame",card); kf.Size=UDim2.new(0.88,0,0,42); kf.Position=UDim2.new(0.06,0,0,208)
    kf.BackgroundColor3=Color3.fromRGB(15,20,52); kf.BorderSizePixel=0; kf.ZIndex=3; corner(kf,9)
    grad(kf,Color3.fromRGB(18,24,58),Color3.fromRGB(12,16,44),90)
    local ks=Instance.new("UIStroke",kf); ks.Color=Color3.fromRGB(50,65,140); ks.Thickness=1

    local kb=Instance.new("TextBox",kf); kb.Size=UDim2.new(1,-16,1,0); kb.Position=UDim2.fromOffset(12,0)
    kb.BackgroundTransparency=1; kb.PlaceholderText="Dein Key hier..."
    kb.PlaceholderColor3=C.txtM; kb.Text=""; kb.TextColor3=C.txt
    kb.Font=Enum.Font.Gotham; kb.TextSize=14; kb.TextXAlignment=Enum.TextXAlignment.Left
    kb.ClearTextOnFocus=false; kb.ZIndex=4
    kb.Focused:Connect(function() tw(ks,{Color=C.acc,Thickness=1.5}) end)
    kb.FocusLost:Connect(function() tw(ks,{Color=Color3.fromRGB(50,65,140),Thickness=1}) end)

    -- Status
    local st=Instance.new("TextLabel",card); st.Size=UDim2.new(1,0,0,18); st.Position=UDim2.fromOffset(0,258)
    st.BackgroundTransparency=1; st.Text=""; st.Font=Enum.Font.Gotham; st.TextSize=12
    st.TextColor3=C.err; st.TextXAlignment=Enum.TextXAlignment.Center; st.ZIndex=3

    -- Confirm
    local cf=Instance.new("TextButton",card); cf.Size=UDim2.new(0.88,0,0,44); cf.Position=UDim2.new(0.06,0,0,280)
    cf.BackgroundColor3=C.acc; cf.Text="Bestätigen"; cf.TextColor3=Color3.fromRGB(255,255,255)
    cf.Font=Enum.Font.GothamBlack; cf.TextSize=15; cf.BorderSizePixel=0; cf.ZIndex=3; corner(cf,11)
    grad(cf,C.accL,C.accB,90)
    cf.MouseEnter:Connect(function() tw(cf,{BackgroundColor3=C.accL}) end)
    cf.MouseLeave:Connect(function() tw(cf,{BackgroundColor3=C.acc}) end)

    -- Slide in
    tw(card,{Position=UDim2.fromScale(0.5,0.5)},0.55,Enum.EasingStyle.Back)

    local function tryKey()
        if kb.Text==VALID_KEY then
            saveKey(kb.Text); cf.Text="Zugang gewährt!"; cf.BackgroundColor3=C.ok
            st.TextColor3=C.ok; st.Text="Willkommen bei Splash Scripts!"
            task.delay(1.4,function()
                tw(card,{Position=UDim2.new(0.5,0,-0.8,0)},0.4,Enum.EasingStyle.Back)
                task.wait(0.45); pcall(function() blur:Destroy() end); sg:Destroy(); onDone()
            end)
        else
            st.Text="Falscher Key! → discord.gg/eyzfsAjpSr"
            tw(ks,{Color=C.err},0.1); task.delay(1.5,function() tw(ks,{Color=Color3.fromRGB(50,65,140)}) end)
        end
    end
    cf.MouseButton1Click:Connect(tryKey)
    kb.FocusLost:Connect(function(e) if e then tryKey() end end)
end

-- ═══════════════════════════════
-- MAIN UI
-- ═══════════════════════════════
local function loadMain()
    -- Notif GUI
    notifSg=Instance.new("ScreenGui"); notifSg.Name="SplashNotif"; notifSg.ResetOnSpawn=false
    notifSg.IgnoreGuiInset=true; notifSg.Parent=LP:WaitForChild("PlayerGui")
    notifF=Instance.new("Frame",notifSg); notifF.Name="F"; notifF.Size=UDim2.fromOffset(295,68)
    notifF.Position=UDim2.new(1,-310,1,10); notifF.BackgroundColor3=C.el; notifF.BorderSizePixel=0; notifF.ZIndex=200
    corner(notifF,10); grad(notifF,C.elHov,C.el,135)
    local nStroke=Instance.new("UIStroke",notifF); nStroke.Color=C.acc; nStroke.Thickness=1
    local nT=Instance.new("TextLabel",notifF); nT.Name="T"; nT.Size=UDim2.new(1,-16,0,24); nT.Position=UDim2.fromOffset(12,8)
    nT.BackgroundTransparency=1; nT.Text=""; nT.TextColor3=C.txt; nT.Font=Enum.Font.GothamBold; nT.TextSize=13; nT.TextXAlignment=Enum.TextXAlignment.Left
    local nM=Instance.new("TextLabel",notifF); nM.Name="M"; nM.Size=UDim2.new(1,-16,0,20); nM.Position=UDim2.fromOffset(12,32)
    nM.BackgroundTransparency=1; nM.Text=""; nM.TextColor3=C.txtD; nM.Font=Enum.Font.Gotham; nM.TextSize=11; nM.TextXAlignment=Enum.TextXAlignment.Left
    -- Accent bar links
    local nBar=Instance.new("Frame",notifF); nBar.Size=UDim2.fromOffset(3,48); nBar.Position=UDim2.fromOffset(0,10)
    nBar.BackgroundColor3=C.acc; nBar.BorderSizePixel=0; corner(nBar,2); grad(nBar,C.accL,C.accB,90)

    -- Haupt ScreenGui
    local sg=Instance.new("ScreenGui"); sg.Name="SplashUI"; sg.ResetOnSpawn=false
    sg.IgnoreGuiInset=true; sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    sg.Parent=LP:WaitForChild("PlayerGui")

    local W,H=570,385; local TH=40; local SW=138

    -- Glow
    local gImg=Instance.new("ImageLabel",sg); gImg.Size=UDim2.fromOffset(W+100,H+100)
    gImg.AnchorPoint=Vector2.new(0.5,0.5); gImg.Position=UDim2.fromScale(0.5,0.5)
    gImg.BackgroundTransparency=1; gImg.Image="rbxassetid://5028857084"
    gImg.ImageColor3=Color3.fromRGB(60,90,220); gImg.ImageTransparency=0.82; gImg.ZIndex=0

    -- Hauptfenster — KEIN UIStroke!
    local win=Instance.new("Frame",sg); win.Size=UDim2.fromOffset(W,H)
    win.AnchorPoint=Vector2.new(0.5,0.5); win.Position=UDim2.fromScale(0.5,0.5)
    win.BackgroundColor3=C.win; win.BorderSizePixel=0; corner(win,14)
    grad(win,Color3.fromRGB(22,28,60),Color3.fromRGB(12,16,40),140)

    -- Topbar
    local tb=Instance.new("Frame",win); tb.Size=UDim2.new(1,0,0,TH)
    tb.BackgroundColor3=C.topbar; tb.BorderSizePixel=0; corner(tb,14)
    grad(tb,Color3.fromRGB(26,33,72),Color3.fromRGB(16,22,54),90)

    -- Trennlinie unter Topbar
    local tl=Instance.new("Frame",win); tl.Size=UDim2.new(1,0,0,1); tl.Position=UDim2.fromOffset(0,TH)
    tl.BackgroundColor3=Color3.fromRGB(55,70,150); tl.BorderSizePixel=0
    grad(tl,Color3.fromRGB(40,55,140),C.acc,0)

    -- Logo
    local logo=Instance.new("TextLabel",tb); logo.Size=UDim2.new(0,220,1,0); logo.Position=UDim2.fromOffset(16,0)
    logo.BackgroundTransparency=1; logo.Text="SPLASH SCRIPTS"
    logo.TextColor3=C.txt; logo.Font=Enum.Font.GothamBlack; logo.TextSize=16
    logo.TextXAlignment=Enum.TextXAlignment.Left

    local ver=Instance.new("TextLabel",tb); ver.Size=UDim2.new(0,50,1,0); ver.Position=UDim2.fromOffset(225,0)
    ver.BackgroundTransparency=1; ver.Text="v8.0"; ver.TextColor3=C.txtM
    ver.Font=Enum.Font.Gotham; ver.TextSize=11; ver.TextXAlignment=Enum.TextXAlignment.Left

    -- Minimize Button
    local minBtn=Instance.new("TextButton",tb); minBtn.Size=UDim2.fromOffset(28,28)
    minBtn.Position=UDim2.new(1,-38,0.5,-14); minBtn.BackgroundColor3=Color3.fromRGB(30,38,85)
    minBtn.Text="—"; minBtn.TextColor3=C.txtD; minBtn.Font=Enum.Font.GothamBold; minBtn.TextSize=14
    minBtn.BorderSizePixel=0; corner(minBtn,6)
    minBtn.MouseEnter:Connect(function() tw(minBtn,{BackgroundColor3=Color3.fromRGB(45,55,115),TextColor3=C.txt}) end)
    minBtn.MouseLeave:Connect(function() tw(minBtn,{BackgroundColor3=Color3.fromRGB(30,38,85),TextColor3=C.txtD}) end)

    local content=Instance.new("Frame",win); content.Size=UDim2.new(1,0,1,-TH-1)
    content.Position=UDim2.fromOffset(0,TH+1); content.BackgroundTransparency=1; content.BorderSizePixel=0

    local minimized=false
    minBtn.MouseButton1Click:Connect(function()
        minimized=not minimized
        if minimized then
            content.Visible=false; minBtn.Text="+"
            tw(win,{Size=UDim2.fromOffset(W,TH)},0.2)
        else
            tw(win,{Size=UDim2.fromOffset(W,H)},0.2); minBtn.Text="—"
            task.delay(0.2,function() content.Visible=true end)
        end
    end)
    UserInputService.InputBegan:Connect(function(i,g) if not g and i.KeyCode==Enum.KeyCode.K then minBtn.MouseButton1Click:Fire() end end)

    -- Drag
    do
        local dr,ds,sp=false
        tb.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true; ds=i.Position; sp=win.Position end end)
        tb.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end)
        UserInputService.InputChanged:Connect(function(i)
            if dr and i.UserInputType==Enum.UserInputType.MouseMovement then
                local d=i.Position-ds
                win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
            end
        end)
    end

    -- Sidebar
    local sb=Instance.new("Frame",content); sb.Size=UDim2.new(0,SW,1,0)
    sb.BackgroundColor3=C.side; sb.BorderSizePixel=0
    grad(sb,Color3.fromRGB(18,24,56),Color3.fromRGB(12,16,42),90)
    -- Trennlinie rechts
    local sbLine=Instance.new("Frame",sb); sbLine.Size=UDim2.new(0,1,1,0); sbLine.Position=UDim2.new(1,-1,0,0)
    sbLine.BackgroundColor3=Color3.fromRGB(40,52,120); sbLine.BorderSizePixel=0

    -- Content Panel
    local panel=Instance.new("Frame",content); panel.Size=UDim2.new(1,-SW,1,0)
    panel.Position=UDim2.fromOffset(SW,0); panel.BackgroundTransparency=1; panel.BorderSizePixel=0

    -- Panel Hintergrund Gradient
    local panelBg=Instance.new("Frame",panel); panelBg.Size=UDim2.fromScale(1,1)
    panelBg.BackgroundColor3=C.win; panelBg.BorderSizePixel=0; panelBg.ZIndex=0
    grad(panelBg,Color3.fromRGB(20,26,58),Color3.fromRGB(14,18,46),135)

    -- ═══════════════════════════════
    -- TAB SYSTEM
    -- ═══════════════════════════════
    local tabs={}; local activeTab=nil; local tabY=12

    local function createTab(name)
        local btn=Instance.new("TextButton",sb); btn.Size=UDim2.new(1,0,0,38)
        btn.Position=UDim2.fromOffset(0,tabY); tabY=tabY+40
        btn.BackgroundColor3=C.side; btn.Text=""; btn.BorderSizePixel=0; btn.AutoButtonColor=false

        local actGlow=Instance.new("Frame",btn); actGlow.Size=UDim2.fromScale(1,1)
        actGlow.BackgroundColor3=C.sideAct; actGlow.BorderSizePixel=0; actGlow.BackgroundTransparency=1
        grad(actGlow,Color3.fromRGB(35,48,110),C.side,0)

        local actBar=Instance.new("Frame",btn); actBar.Size=UDim2.fromOffset(3,24)
        actBar.Position=UDim2.new(0,0,0.5,-12); actBar.BackgroundColor3=C.acc
        actBar.BorderSizePixel=0; corner(actBar,2); actBar.BackgroundTransparency=1
        grad(actBar,C.accL,C.accB,90)

        local lbl=Instance.new("TextLabel",btn); lbl.Size=UDim2.new(1,-16,1,0)
        lbl.Position=UDim2.fromOffset(14,0); lbl.BackgroundTransparency=1
        lbl.Text=string.upper(name); lbl.TextColor3=C.txtM
        lbl.Font=Enum.Font.GothamBlack; lbl.TextSize=12
        lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=5

        local scroll=Instance.new("ScrollingFrame",panel); scroll.Size=UDim2.fromScale(1,1)
        scroll.BackgroundTransparency=1; scroll.BorderSizePixel=0; scroll.Visible=false
        scroll.ScrollBarThickness=3; scroll.ScrollBarImageColor3=C.acc; scroll.ZIndex=2
        local layout=Instance.new("UIListLayout",scroll); layout.Padding=UDim.new(0,6)
        layout.SortOrder=Enum.SortOrder.LayoutOrder
        local pad=Instance.new("UIPadding",scroll); pad.PaddingLeft=UDim.new(0,12)
        pad.PaddingRight=UDim.new(0,12); pad.PaddingTop=UDim.new(0,12)
        layout.Changed:Connect(function() scroll.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+24) end)

        local tab={scroll=scroll,btn=btn,lbl=lbl,bar=actBar,glow=actGlow,order=1}
        tabs[name]=tab

        btn.MouseButton1Click:Connect(function()
            if activeTab then
                local at=tabs[activeTab]
                at.scroll.Visible=false; at.lbl.TextColor3=C.txtM
                tw(at.bar,{BackgroundTransparency=1}); tw(at.glow,{BackgroundTransparency=1})
                tw(at.btn,{BackgroundColor3=C.side})
            end
            activeTab=name; scroll.Visible=true
            tw(lbl,{TextColor3=C.txt}); tw(actBar,{BackgroundTransparency=0},0.15)
            tw(actGlow,{BackgroundTransparency=0.5},0.15); tw(btn,{BackgroundColor3=C.sideAct})
        end)
        btn.MouseEnter:Connect(function() if activeTab~=name then tw(btn,{BackgroundColor3=C.sideHov}); tw(lbl,{TextColor3=C.txtD}) end end)
        btn.MouseLeave:Connect(function() if activeTab~=name then tw(btn,{BackgroundColor3=C.side}); tw(lbl,{TextColor3=C.txtM}) end end)
        return tab
    end

    -- ═══════════════════════════════
    -- ELEMENT BUILDER
    -- ═══════════════════════════════
    local function section(tab, text)
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,24)
        f.BackgroundTransparency=1; f.LayoutOrder=tab.order; tab.order=tab.order+1
        local l=Instance.new("TextLabel",f); l.Size=UDim2.fromScale(1,1); l.BackgroundTransparency=1
        l.Text=string.upper(text); l.TextColor3=C.acc; l.Font=Enum.Font.GothamBlack; l.TextSize=11
        l.TextXAlignment=Enum.TextXAlignment.Left
        local ln=Instance.new("Frame",f); ln.Size=UDim2.new(1,0,0,1); ln.Position=UDim2.new(0,0,1,-1)
        ln.BackgroundColor3=Color3.fromRGB(40,52,120); ln.BorderSizePixel=0
        grad(ln,Color3.fromRGB(88,130,255),Color3.fromRGB(20,26,60),0)
    end

    local function button(tab, text, cb)
        local f=Instance.new("TextButton",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.Text=""; f.BorderSizePixel=0; f.AutoButtonColor=false
        f.LayoutOrder=tab.order; tab.order=tab.order+1; corner(f,8)
        grad(f,Color3.fromRGB(26,32,72),Color3.fromRGB(18,24,58),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-16,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.txt
        l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        f.MouseEnter:Connect(function() tw(f,{BackgroundColor3=C.elHov}) end)
        f.MouseLeave:Connect(function() tw(f,{BackgroundColor3=C.el}) end)
        f.MouseButton1Click:Connect(function()
            tw(f,{BackgroundColor3=C.acc},0.08); task.delay(0.15,function() tw(f,{BackgroundColor3=C.el}) end); cb()
        end)
    end

    local function toggle(tab, text, def, cb)
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; corner(f,8)
        grad(f,Color3.fromRGB(26,32,72),Color3.fromRGB(18,24,58),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-58,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local val=def
        local track=Instance.new("Frame",f); track.Size=UDim2.fromOffset(36,20)
        track.Position=UDim2.new(1,-46,0.5,-10); track.BackgroundColor3=val and C.tog_on or C.tog_off
        track.BorderSizePixel=0; corner(track,10)
        local knob=Instance.new("Frame",track); knob.Size=UDim2.fromOffset(16,16)
        knob.Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)
        knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.BorderSizePixel=0; corner(knob,8)
        local btn=Instance.new("TextButton",f); btn.Size=UDim2.fromScale(1,1)
        btn.BackgroundTransparency=1; btn.Text=""; btn.ZIndex=5
        btn.MouseButton1Click:Connect(function()
            val=not val; cb(val)
            tw(track,{BackgroundColor3=val and C.tog_on or C.tog_off})
            tw(knob,{Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)})
        end)
        return {get=function() return val end}
    end

    local function slider(tab, text, mn, mx, def, cb)
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,50)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; corner(f,8)
        grad(f,Color3.fromRGB(26,32,72),Color3.fromRGB(18,24,58),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-62,0,20); l.Position=UDim2.fromOffset(14,6)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local vl=Instance.new("TextLabel",f); vl.Size=UDim2.fromOffset(54,20); vl.Position=UDim2.new(1,-60,0,6)
        vl.BackgroundTransparency=1; vl.Text=tostring(def); vl.TextColor3=C.accL; vl.Font=Enum.Font.GothamBold; vl.TextSize=12; vl.TextXAlignment=Enum.TextXAlignment.Right
        local tr=Instance.new("Frame",f); tr.Size=UDim2.new(1,-24,0,5); tr.Position=UDim2.new(0,12,1,-14)
        tr.BackgroundColor3=C.sl_bg; tr.BorderSizePixel=0; corner(tr,3)
        local fi=Instance.new("Frame",tr); fi.Size=UDim2.new((def-mn)/(mx-mn),0,1,0)
        fi.BackgroundColor3=C.acc; fi.BorderSizePixel=0; corner(fi,3); grad(fi,C.acc,C.accL,0)
        local hd=Instance.new("Frame",tr); hd.Size=UDim2.fromOffset(12,12)
        hd.Position=UDim2.new((def-mn)/(mx-mn),0,0.5,-6)
        hd.BackgroundColor3=Color3.fromRGB(245,250,255); hd.BorderSizePixel=0; corner(hd,6)
        local drag=false
        local function upd(x)
            local pct=math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
            local v=math.floor(mn+(mx-mn)*pct)
            fi.Size=UDim2.new(pct,0,1,0); hd.Position=UDim2.new(pct,0,0.5,-6)
            vl.Text=tostring(v); cb(v)
        end
        tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true; upd(i.Position.X) end end)
        UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then upd(i.Position.X) end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    end

    local function keybind(tab, text, def, cb)
        local curKey=Enum.KeyCode[def] or Enum.KeyCode.F
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; corner(f,8)
        grad(f,Color3.fromRGB(26,32,72),Color3.fromRGB(18,24,58),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-90,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local kb=Instance.new("TextButton",f); kb.Size=UDim2.fromOffset(72,24)
        kb.Position=UDim2.new(1,-80,0.5,-12); kb.BackgroundColor3=C.accB
        kb.Text="["..def.."]"; kb.TextColor3=C.txt; kb.Font=Enum.Font.GothamBold; kb.TextSize=11; kb.BorderSizePixel=0; corner(kb,6)
        grad(kb,C.acc,C.accB,90)
        local listening=false
        kb.MouseButton1Click:Connect(function() listening=true; kb.Text="..."; kb.BackgroundColor3=C.acc end)
        UserInputService.InputBegan:Connect(function(i,g)
            if g then return end
            if listening then
                listening=false; curKey=i.KeyCode; kb.Text="["..i.KeyCode.Name.."]"; kb.BackgroundColor3=C.accB
            elseif i.KeyCode==curKey then cb() end
        end)
    end

    local function dropdown(tab, text, opts, cb)
        local val=opts[1] or ""
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; corner(f,8)
        grad(f,Color3.fromRGB(26,32,72),Color3.fromRGB(18,24,58),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-190,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=text; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local db=Instance.new("TextButton",f); db.Size=UDim2.fromOffset(168,24)
        db.Position=UDim2.new(1,-176,0.5,-12); db.BackgroundColor3=C.sl_bg
        db.Text=val; db.TextColor3=C.txt; db.Font=Enum.Font.Gotham; db.TextSize=12; db.BorderSizePixel=0; corner(db,6)
        local open=false; local dFrame
        db.MouseButton1Click:Connect(function()
            open=not open
            if open then
                dFrame=Instance.new("Frame",sg); dFrame.ZIndex=200
                dFrame.Size=UDim2.fromOffset(168,math.min(#opts,6)*30+4)
                local ap=db.AbsolutePosition; dFrame.Position=UDim2.fromOffset(ap.X,ap.Y+28)
                dFrame.BackgroundColor3=Color3.fromRGB(18,24,58); dFrame.BorderSizePixel=0; corner(dFrame,8)
                local stroke=Instance.new("UIStroke",dFrame); stroke.Color=C.acc; stroke.Thickness=1
                local dll=Instance.new("UIListLayout",dFrame); dll.SortOrder=Enum.SortOrder.LayoutOrder
                for i,o in ipairs(opts) do
                    local ob=Instance.new("TextButton",dFrame); ob.Size=UDim2.new(1,0,0,30)
                    ob.BackgroundColor3=Color3.fromRGB(18,24,58); ob.Text=o
                    ob.TextColor3=o==val and C.accL or C.txt; ob.Font=Enum.Font.Gotham; ob.TextSize=12; ob.BorderSizePixel=0; ob.LayoutOrder=i
                    ob.MouseEnter:Connect(function() tw(ob,{BackgroundColor3=C.elHov}) end)
                    ob.MouseLeave:Connect(function() tw(ob,{BackgroundColor3=Color3.fromRGB(18,24,58)}) end)
                    ob.MouseButton1Click:Connect(function()
                        val=o; db.Text=o; cb(o)
                        if dFrame then dFrame:Destroy(); dFrame=nil end; open=false
                    end)
                end
            else if dFrame then dFrame:Destroy(); dFrame=nil end end
        end)
        return {get=function() return val end}
    end

    -- ═══════════════════════════════
    -- TABS
    -- ═══════════════════════════════

    -- FLY TAB
    local flyTab=createTab("Fly")
    local flyActive=false; local flySpeed=80; local flyConn,bv,bg

    local function cleanFly()
        flyActive=false
        if flyConn then flyConn:Disconnect(); flyConn=nil end
        if bv then bv:Destroy(); bv=nil end
        if bg then bg:Destroy(); bg=nil end
        local h=getHum(); if h then h.PlatformStand=false end
        local c=getChar(); if not c then return end
        local torso=c:FindFirstChild("Torso")
        if torso then
            local rs=torso:FindFirstChild("Right Shoulder"); local ls=torso:FindFirstChild("Left Shoulder")
            local rh=torso:FindFirstChild("Right Hip"); local lh=torso:FindFirstChild("Left Hip")
            local nk=torso:FindFirstChild("Neck")
            if rs then rs.C0=CFrame.new(1,0.5,0,0,0,1,0,1,0,-1,0,0) end
            if ls then ls.C0=CFrame.new(-1,0.5,0,0,0,-1,0,1,0,1,0,0) end
            if rh then rh.C0=CFrame.new(1,-1,0,0,0,1,0,1,0,-1,0,0) end
            if lh then lh.C0=CFrame.new(-1,-1,0,0,0,-1,0,1,0,1,0,0) end
            if nk then nk.C0=CFrame.new(0,1,0) end
        end
        task.delay(0.1,function() local h2=getHum(); if h2 then h2:ChangeState(Enum.HumanoidStateType.GettingUp) end end)
    end

    local function startFly()
        local hrp=getHRP(); local hum=getHum(); if not hrp or not hum then return end
        cleanFly(); flyActive=true; hum.PlatformStand=true
        bv=Instance.new("BodyVelocity"); bv.MaxForce=Vector3.new(1e9,1e9,1e9); bv.Velocity=Vector3.zero; bv.Parent=hrp
        bg=Instance.new("BodyGyro"); bg.MaxTorque=Vector3.new(1e9,1e9,1e9); bg.D=50; bg.P=1200; bg.Parent=hrp
        task.spawn(function()
            task.wait(0.1); local c=getChar(); if not c then return end
            local torso=c:FindFirstChild("Torso"); local uTorso=c:FindFirstChild("UpperTorso")
            if torso then
                local rs=torso:FindFirstChild("Right Shoulder"); local ls=torso:FindFirstChild("Left Shoulder")
                local rh=torso:FindFirstChild("Right Hip"); local lh=torso:FindFirstChild("Left Hip"); local nk=torso:FindFirstChild("Neck")
                if rs then rs.C0=CFrame.new(1,0.5,0)*CFrame.Angles(0,math.rad(90),math.rad(-90)) end
                if ls then ls.C0=CFrame.new(-1,0.5,0)*CFrame.Angles(0,-math.rad(90),math.rad(90)) end
                if rh then rh.C0=CFrame.new(1,-1,0)*CFrame.Angles(0,math.rad(90),math.rad(90)) end
                if lh then lh.C0=CFrame.new(-1,-1,0)*CFrame.Angles(0,-math.rad(90),math.rad(-90)) end
                if nk then nk.C0=CFrame.new(0,1,0)*CFrame.Angles(math.rad(30),0,0) end
            elseif uTorso then
                local lt=c:FindFirstChild("LowerTorso")
                local function gm(p,n) if not p then return nil end for _,v in ipairs(p:GetDescendants()) do if v:IsA("Motor6D") and v.Name==n then return v end end end
                local rs=gm(uTorso,"RightShoulder"); local ls=gm(uTorso,"LeftShoulder")
                local rh=gm(lt,"RightHip"); local lh=gm(lt,"LeftHip"); local nk=gm(uTorso,"Neck")
                if rs then rs.C0=CFrame.Angles(math.rad(-90),0,0) end
                if ls then ls.C0=CFrame.Angles(math.rad(50),0,0) end
                if rh then rh.C0=CFrame.Angles(math.rad(15),0,0) end
                if lh then lh.C0=CFrame.Angles(math.rad(15),0,0) end
                if nk then nk.C0=CFrame.Angles(math.rad(25),0,0) end
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

    toggle(flyTab,"Fly aktivieren",false,"Fly",function(v) if v then startFly() else cleanFly() end end)
    slider(flyTab,"Fly Speed",10,600,80,"FlySpd",function(v) flySpeed=v end)
    keybind(flyTab,"Fly Keybind","F",function() if flyActive then cleanFly() else startFly() end end)

    local inf=Instance.new("Frame",flyTab.scroll); inf.Size=UDim2.new(1,0,0,46)
    inf.BackgroundColor3=C.el; inf.BorderSizePixel=0; inf.LayoutOrder=flyTab.order; flyTab.order=flyTab.order+1; corner(inf,8)
    grad(inf,Color3.fromRGB(22,28,65),Color3.fromRGB(16,22,52),90)
    local il=Instance.new("TextLabel",inf); il.Size=UDim2.new(1,-16,1,0); il.Position=UDim2.fromOffset(12,0)
    il.BackgroundTransparency=1; il.Text="W/A/S/D · Space=hoch · Shift=runter · Strg=4x\nK = UI toggle · Superman-Pose für R6 & R15"
    il.TextColor3=C.txtD; il.Font=Enum.Font.Gotham; il.TextSize=11; il.TextWrapped=true; il.TextXAlignment=Enum.TextXAlignment.Left

    -- FUN TAB
    local funTab=createTab("Fun"); local selP=getPlayerList()[1] or ""
    dropdown(funTab,"Spieler",getPlayerList(),function(v) selP=v end)
    button(funTab,"Liste neu laden",function() selP=getPlayerList()[1] or ""; notify("OK","Liste aktualisiert.") end)
    section(funTab,"Fling & Teleport")
    button(funTab,"Spieler flingen",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for i=1,10 do task.delay(i*0.01,function()
            local f=Instance.new("BodyVelocity"); f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent=hrp
            game:GetService("Debris"):AddItem(f,0.1)
        end) end; notify("Fling",selP.." geflingt!",C.ok)
    end)
    button(funTab,"Alle flingen",function()
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local h=p.Character:FindFirstChild("HumanoidRootPart"); if not h then continue end
            local f=Instance.new("BodyVelocity"); f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent=h
            game:GetService("Debris"):AddItem(f,0.1)
        end end
    end)
    button(funTab,"Zu Spieler TP",function() local _,tc=getTarget(selP); if not tc then return end local th,mh=tc:FindFirstChild("HumanoidRootPart"),getHRP(); if th and mh then mh.CFrame=th.CFrame*CFrame.new(3,0,0) end end)
    button(funTab,"Spieler zu mir TP",function() local _,tc=getTarget(selP); if not tc then return end local th,mh=tc:FindFirstChild("HumanoidRootPart"),getHRP(); if th and mh then th.CFrame=mh.CFrame*CFrame.new(3,0,0) end end)
    button(funTab,"Auf Kopf setzen",function() local _,tc=getTarget(selP); if not tc then return end local hd,mh=tc:FindFirstChild("Head"),getHRP(); if hd and mh then mh.CFrame=CFrame.new(hd.Position+Vector3.new(0,3.5,0)) end end)
    button(funTab,"Hochkatapultieren",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local bv2=Instance.new("BodyVelocity"); bv2.MaxForce=Vector3.new(0,1e9,0); bv2.Velocity=Vector3.new(0,2500,0); bv2.Parent=hrp
        game:GetService("Debris"):AddItem(bv2,0.25)
    end)
    button(funTab,"Einfrieren",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hm=tc:FindFirstChild("Humanoid"); if not hm then return end
        local fr=hm.WalkSpeed==0; hm.WalkSpeed=fr and 16 or 0; hm.JumpPower=fr and 50 or 0
        notify("Freeze",selP..(fr and " freigegeben" or " eingefroren"))
    end)
    button(funTab,"Spin",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        task.spawn(function() for i=1,100 do hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(20),0); task.wait(0.01) end end)
    end)
    button(funTab,"Alle zu mir TP",function()
        local mh=getHRP(); if not mh then return end
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local h=p.Character:FindFirstChild("HumanoidRootPart")
            if h then h.CFrame=mh.CFrame*CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
        end end
    end)
    section(funTab,"Speed & Movement")
    toggle(funTab,"Super Speed",false,"SS",function(v) local h=getHum(); if h then h.WalkSpeed=v and 120 or 16 end end)
    slider(funTab,"Walk Speed",16,500,16,"WS",function(v) local h=getHum(); if h then h.WalkSpeed=v end end)
    toggle(funTab,"Inf Jump",false,"IJ",function(v) if v then UserInputService.JumpRequest:Connect(function() local h=getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end) end end)
    slider(funTab,"Jump Power",50,500,50,"JP",function(v) local h=getHum(); if h then h.JumpPower=v end end)
    toggle(funTab,"Noclip",false,"NC",function(v) if v then RunService.Stepped:Connect(function() local c=getChar(); if not c then return end for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end) end end)
    toggle(funTab,"Unsichtbar",false,"IV",function(v) local c=getChar(); if not c then return end for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=v and 1 or 0 end end end)
    section(funTab,"Outfit")
    button(funTab,"Outfit klauen",function()
        local tp=getTarget(selP); if not tp then return end
        local h=getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(tp.UserId)) end
        notify("Outfit","Outfit von "..selP.." geklaut!",C.ok)
    end)
    button(funTab,"Eigenes Outfit zurück",function() local h=getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LP.UserId)) end end)
    button(funTab,"Riesenkopf",function() local _,tc=getTarget(selP); if not tc then return end local hd=tc:FindFirstChild("Head"); if hd then hd.Size=Vector3.new(6,6,6) end end)

    -- ESP TAB
    local espTab=createTab("ESP"); local espOn=false; local espHL={}
    local espCol=Color3.fromRGB(88,130,255); local espFill=0.5; local espWalls=true
    local function remESP() for _,h in pairs(espHL) do pcall(function() h:Destroy() end) end espHL={} end
    local function addESP(char,name) local h=Instance.new("Highlight"); h.FillColor=espCol; h.OutlineColor=Color3.fromRGB(255,255,255); h.FillTransparency=espFill; h.OutlineTransparency=0; h.DepthMode=espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded; h.Parent=char; espHL[name]=h end
    local function buildESP() remESP() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then addESP(p.Character,p.Name) end end end
    toggle(espTab,"ESP aktivieren",false,"ESP",function(v) espOn=v; if v then buildESP() else remESP() end end)
    slider(espTab,"Transparenz",0,10,5,"EA",function(v) espFill=v/10; for _,h in pairs(espHL) do if h then h.FillTransparency=espFill end end end)
    toggle(espTab,"Durch Wände",true,"EW",function(v) espWalls=v; for _,h in pairs(espHL) do if h then h.DepthMode=v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded end end end)
    button(espTab,"ESP aktualisieren",function() if espOn then buildESP() end end)
    Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if espOn then task.wait(1); addESP(c,p.Name) end end) end)
    Players.PlayerRemoving:Connect(function(p) if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end); espHL[p.Name]=nil end end)

    -- WORLD TAB
    local worldTab=createTab("World")
    toggle(worldTab,"Fullbright",false,"FB",function(v) Lighting.Brightness=v and 10 or 2; Lighting.GlobalShadows=not v; Lighting.FogEnd=v and 1e9 or 1e5 end)
    slider(worldTab,"Helligkeit",0,10,2,"BR",function(v) Lighting.Brightness=v end)
    slider(worldTab,"Uhrzeit",0,24,14,"CL",function(v) Lighting.ClockTime=v end)
    toggle(worldTab,"Fog entfernen",false,"NF",function(v) Lighting.FogEnd=v and 1e9 or 1e5; Lighting.FogStart=v and 1e9 or 0 end)
    slider(worldTab,"Gravity",0,400,196,"GV",function(v) workspace.Gravity=v end)
    toggle(worldTab,"Anti-Gravity",false,"AG",function(v) workspace.Gravity=v and 0 or 196 end)

    -- PLAYER TAB
    local playerTab=createTab("Player")
    toggle(playerTab,"God Mode",false,"GM",function(v) local h=getHum(); if h then h.MaxHealth=v and math.huge or 100; h.Health=v and math.huge or 100 end end)
    toggle(playerTab,"Auto-Heal",false,"AH",function(v) if v then task.spawn(function() while v do local h=getHum(); if h then h.Health=h.MaxHealth end task.wait(0.1) end end) end end)
    slider(playerTab,"HP setzen",1,1000,100,"HP",function(v) local h=getHum(); if h then h.Health=v end end)
    button(playerTab,"Respawn",function() LP:LoadCharacter() end)
    slider(playerTab,"FOV",30,120,70,"FOV",function(v) Camera.FieldOfView=v end)

    -- SETTINGS TAB
    local settTab=createTab("Settings")
    local infoBlock=Instance.new("Frame",settTab.scroll); infoBlock.Size=UDim2.new(1,0,0,86)
    infoBlock.BackgroundColor3=C.el; infoBlock.BorderSizePixel=0; infoBlock.LayoutOrder=settTab.order; settTab.order=settTab.order+1; corner(infoBlock,8)
    grad(infoBlock,Color3.fromRGB(22,28,65),Color3.fromRGB(16,22,52),90)
    local ib=Instance.new("TextLabel",infoBlock); ib.Size=UDim2.new(1,-16,1,0); ib.Position=UDim2.fromOffset(12,0)
    ib.BackgroundTransparency=1; ib.TextColor3=C.txtD; ib.Font=Enum.Font.Gotham; ib.TextSize=11; ib.TextWrapped=true; ib.TextXAlignment=Enum.TextXAlignment.Left
    ib.Text="Splash Scripts v8.0  —  German Voice Edition\nKey: SplashScripts2026!\nDiscord: discord.gg/eyzfsAjpSr\nFly: W/A/S/D · Space · Shift · Strg=4x"
    button(settTab,"Key zurücksetzen",function() pcall(function() delfile(KEY_FILE) end); notify("Key","Key gelöscht. Nächster Start fragt neu.") end)

    -- Ersten Tab aktivieren
    flyTab.btn.MouseButton1Click:Fire()

    -- Einfahren
    win.Position=UDim2.new(0.5,0,1.6,0)
    tw(win,{Position=UDim2.fromScale(0.5,0.5)},0.6,Enum.EasingStyle.Back)

    task.delay(0.9,function() notify("Splash Scripts v8.0","Script geladen! Viel Spaß.",C.ok) end)
end

-- ═══════════════════════════════
-- START
-- ═══════════════════════════════
if loadKey()==VALID_KEY then
    task.spawn(loadMain)
else
    task.spawn(function() showKey(loadMain) end)
end
