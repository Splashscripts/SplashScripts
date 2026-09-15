-- SPLASH SCRIPTS v9.0 — German Voice Edition

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

-- ══════════════════════════════════════════
-- FARBEN — Midnight Blue mit Akzent
-- ══════════════════════════════════════════
local C={
    win   =Color3.fromRGB(14,18,42),
    winB  =Color3.fromRGB(10,13,32),
    top   =Color3.fromRGB(18,23,55),
    side  =Color3.fromRGB(12,16,40),
    sideH =Color3.fromRGB(20,26,62),
    sideA =Color3.fromRGB(28,36,88),
    el    =Color3.fromRGB(20,26,62),
    elH   =Color3.fromRGB(28,36,85),
    acc   =Color3.fromRGB(82,130,255),
    accD  =Color3.fromRGB(55,95,220),
    accL  =Color3.fromRGB(130,170,255),
    txt   =Color3.fromRGB(225,232,255),
    txtD  =Color3.fromRGB(140,158,210),
    txtM  =Color3.fromRGB(75,95,160),
    ok    =Color3.fromRGB(50,210,115),
    err   =Color3.fromRGB(248,88,88),
    tonOn =Color3.fromRGB(82,130,255),
    tonOff=Color3.fromRGB(30,38,88),
    slBg  =Color3.fromRGB(12,16,42),
}

-- ══════════════════════════════════════════
-- HELPERS
-- ══════════════════════════════════════════
local function crn(p,r) local c=Instance.new("UICorner",p); c.CornerRadius=UDim.new(0,r or 8); return c end
local function grd(p,a,b,r) local g=Instance.new("UIGradient",p); g.Color=ColorSequence.new(a,b); g.Rotation=r or 90; return g end
local function tw(o,pr,t,s,d) if o and o.Parent then TweenService:Create(o,TweenInfo.new(t or .15,s or Enum.EasingStyle.Quad,d or Enum.EasingDirection.Out),pr):Play() end end
local function lbl(par,txt,sz,col,fnt,xa)
    local l=Instance.new("TextLabel",par); l.BackgroundTransparency=1; l.Text=txt
    l.TextSize=sz or 13; l.TextColor3=col or C.txt; l.Font=fnt or Enum.Font.GothamBold
    l.TextXAlignment=xa or Enum.TextXAlignment.Left; l.TextYAlignment=Enum.TextYAlignment.Center
    l.Size=UDim2.new(1,0,1,0); return l
end

-- Notifications
local _notifF
local function notify(title,msg,col)
    if not _notifF or not _notifF.Parent then return end
    local t=_notifF:FindFirstChild("T"); local m=_notifF:FindFirstChild("M")
    if t then t.Text=title end; if m then m.Text=msg end
    _notifF.BackgroundColor3=col or C.el
    tw(_notifF,{Position=UDim2.new(1,-308,1,-88)},0.4,Enum.EasingStyle.Back)
    task.delay(3.5,function() tw(_notifF,{Position=UDim2.new(1,-308,1,10)},0.3) end)
end

-- ══════════════════════════════════════════
-- KEY SYSTEM
-- ══════════════════════════════════════════
local VALID_KEY    = "SplashScripts2026!"
local DISCORD_LINK = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE     = "SplashKey.txt"

local function saveKey(k) pcall(function() writefile(KEY_FILE,k) end) end
local function loadKey() local ok,v=pcall(function() return readfile(KEY_FILE) end); return (ok and type(v)=="string") and v or "" end

local function showKeyPanel(onDone)
    local sg=Instance.new("ScreenGui"); sg.Name="SplashKey9"; sg.ResetOnSpawn=false
    sg.IgnoreGuiInset=true; sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
    sg.Parent=LP:WaitForChild("PlayerGui")

    local blur=Instance.new("BlurEffect"); blur.Size=22; blur.Parent=Lighting

    local dim=Instance.new("Frame",sg); dim.Size=UDim2.fromScale(1,1)
    dim.BackgroundColor3=Color3.fromRGB(0,0,0); dim.BackgroundTransparency=0.45; dim.BorderSizePixel=0; dim.ZIndex=1

    -- Card — kein UIStroke, nur Schatten-Gradient
    local card=Instance.new("Frame",sg); card.Size=UDim2.fromOffset(475,375)
    card.AnchorPoint=Vector2.new(0.5,0.5); card.Position=UDim2.new(0.5,0,1.6,0)
    card.BackgroundColor3=C.win; card.BorderSizePixel=0; card.ZIndex=2; crn(card,16)
    grd(card,Color3.fromRGB(20,26,58),Color3.fromRGB(10,14,36),140)

    -- Dünner Accent-Streifen oben (kein glühender Rand, nur oben)
    local stripe=Instance.new("Frame",card); stripe.Size=UDim2.new(1,0,0,3)
    stripe.BackgroundColor3=C.acc; stripe.BorderSizePixel=0; stripe.ZIndex=5; crn(stripe,16)
    grd(stripe,C.accD,C.accL,0)

    -- Titel
    local tl=Instance.new("TextLabel",card); tl.Size=UDim2.new(1,0,0,50); tl.Position=UDim2.fromOffset(0,20)
    tl.BackgroundTransparency=1; tl.Text="SPLASH SCRIPTS"; tl.TextColor3=C.txt
    tl.Font=Enum.Font.GothamBlack; tl.TextSize=27; tl.ZIndex=3; tl.TextXAlignment=Enum.TextXAlignment.Center
    local sl=Instance.new("TextLabel",card); sl.Size=UDim2.new(1,0,0,20); sl.Position=UDim2.fromOffset(0,68)
    sl.BackgroundTransparency=1; sl.Text="German Voice  ·  Key System"
    sl.TextColor3=C.txtD; sl.Font=Enum.Font.Gotham; sl.TextSize=13; sl.ZIndex=3; sl.TextXAlignment=Enum.TextXAlignment.Center

    -- Divider
    local dv=Instance.new("Frame",card); dv.Size=UDim2.new(0.88,0,0,1); dv.Position=UDim2.new(0.06,0,0,100)
    dv.BackgroundColor3=Color3.fromRGB(38,48,105); dv.BorderSizePixel=0; dv.ZIndex=3
    grd(dv,Color3.fromRGB(18,24,62),C.acc,0)

    -- Discord Section
    local dlbl=Instance.new("TextLabel",card); dlbl.Size=UDim2.new(0.88,0,0,18); dlbl.Position=UDim2.new(0.06,0,0,114)
    dlbl.BackgroundTransparency=1; dlbl.Text="Key holen → Trete unserem Discord bei:"
    dlbl.TextColor3=C.txtD; dlbl.Font=Enum.Font.GothamBold; dlbl.TextSize=12
    dlbl.TextXAlignment=Enum.TextXAlignment.Left; dlbl.ZIndex=3

    local db=Instance.new("Frame",card); db.Size=UDim2.new(0.88,0,0,42); db.Position=UDim2.new(0.06,0,0,136)
    db.BackgroundColor3=Color3.fromRGB(14,18,50); db.BorderSizePixel=0; db.ZIndex=3; crn(db,9)
    grd(db,Color3.fromRGB(17,22,56),Color3.fromRGB(11,14,42),90)

    local discTxt=Instance.new("TextLabel",db); discTxt.Size=UDim2.new(1,-102,1,0); discTxt.Position=UDim2.fromOffset(12,0)
    discTxt.BackgroundTransparency=1; discTxt.Text=DISCORD_LINK; discTxt.TextColor3=C.accL
    discTxt.Font=Enum.Font.Gotham; discTxt.TextSize=12; discTxt.TextXAlignment=Enum.TextXAlignment.Left; discTxt.ZIndex=4

    local copyBtn=Instance.new("TextButton",db); copyBtn.Size=UDim2.fromOffset(86,30)
    copyBtn.Position=UDim2.new(1,-94,0.5,-15); copyBtn.BackgroundColor3=C.accD
    copyBtn.Text="Kopieren"; copyBtn.TextColor3=Color3.fromRGB(255,255,255)
    copyBtn.Font=Enum.Font.GothamBold; copyBtn.TextSize=12; copyBtn.BorderSizePixel=0; copyBtn.ZIndex=5; crn(copyBtn,7)
    grd(copyBtn,C.acc,C.accD,90)
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(DISCORD_LINK) end)
        copyBtn.Text="✓ Kopiert!"; copyBtn.BackgroundColor3=C.ok
        task.delay(2.5,function() copyBtn.Text="Kopieren"; copyBtn.BackgroundColor3=C.accD end)
    end)

    -- Key Input
    local klbl=Instance.new("TextLabel",card); klbl.Size=UDim2.new(0.88,0,0,18); klbl.Position=UDim2.new(0.06,0,0,192)
    klbl.BackgroundTransparency=1; klbl.Text="Key eingeben:"; klbl.TextColor3=C.txtD
    klbl.Font=Enum.Font.GothamBold; klbl.TextSize=12; klbl.TextXAlignment=Enum.TextXAlignment.Left; klbl.ZIndex=3

    local kf=Instance.new("Frame",card); kf.Size=UDim2.new(0.88,0,0,44); kf.Position=UDim2.new(0.06,0,0,214)
    kf.BackgroundColor3=Color3.fromRGB(14,18,50); kf.BorderSizePixel=0; kf.ZIndex=3; crn(kf,9)
    grd(kf,Color3.fromRGB(17,22,56),Color3.fromRGB(11,14,42),90)
    local ks=Instance.new("UIStroke",kf); ks.Color=Color3.fromRGB(45,58,130); ks.Thickness=1

    local kb=Instance.new("TextBox",kf); kb.Size=UDim2.new(1,-16,1,0); kb.Position=UDim2.fromOffset(12,0)
    kb.BackgroundTransparency=1; kb.PlaceholderText="Dein Key hier..."
    kb.PlaceholderColor3=C.txtM; kb.Text=""; kb.TextColor3=C.txt
    kb.Font=Enum.Font.Gotham; kb.TextSize=14; kb.ClearTextOnFocus=false; kb.ZIndex=4
    kb.Focused:Connect(function() tw(ks,{Color=C.acc,Thickness=1.5}) end)
    kb.FocusLost:Connect(function() tw(ks,{Color=Color3.fromRGB(45,58,130),Thickness=1}) end)

    -- Status
    local st=Instance.new("TextLabel",card); st.Size=UDim2.new(1,0,0,18); st.Position=UDim2.fromOffset(0,266)
    st.BackgroundTransparency=1; st.Text=""; st.Font=Enum.Font.Gotham; st.TextSize=12
    st.TextColor3=C.err; st.TextXAlignment=Enum.TextXAlignment.Center; st.ZIndex=3

    -- Confirm Button
    local cf=Instance.new("TextButton",card); cf.Size=UDim2.new(0.88,0,0,46); cf.Position=UDim2.new(0.06,0,0,288)
    cf.BackgroundColor3=C.acc; cf.Text="Bestätigen"; cf.TextColor3=Color3.fromRGB(255,255,255)
    cf.Font=Enum.Font.GothamBlack; cf.TextSize=15; cf.BorderSizePixel=0; cf.ZIndex=3; crn(cf,11)
    grd(cf,C.accL,C.accD,90)
    cf.MouseEnter:Connect(function() tw(cf,{BackgroundColor3=C.accL}) end)
    cf.MouseLeave:Connect(function() tw(cf,{BackgroundColor3=C.acc}) end)

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
            st.Text="Falscher Key!  →  discord.gg/eyzfsAjpSr"
            tw(ks,{Color=C.err},0.1); task.delay(1.5,function() tw(ks,{Color=Color3.fromRGB(45,58,130)}) end)
        end
    end
    cf.MouseButton1Click:Connect(tryKey)
    kb.FocusLost:Connect(function(e) if e then tryKey() end end)
end

-- ══════════════════════════════════════════
-- MAIN UI
-- ══════════════════════════════════════════
local function loadMain()
    -- Notif
    local notifGui=Instance.new("ScreenGui"); notifGui.Name="SplashNotif9"; notifGui.ResetOnSpawn=false
    notifGui.IgnoreGuiInset=true; notifGui.Parent=LP:WaitForChild("PlayerGui")
    _notifF=Instance.new("Frame",notifGui); _notifF.Name="F"; _notifF.Size=UDim2.fromOffset(292,68)
    _notifF.Position=UDim2.new(1,-308,1,10); _notifF.BackgroundColor3=C.el; _notifF.BorderSizePixel=0; _notifF.ZIndex=200
    crn(_notifF,10); grd(_notifF,C.elH,C.el,135)
    local nStr=Instance.new("UIStroke",_notifF); nStr.Color=C.acc; nStr.Thickness=1
    local nBar=Instance.new("Frame",_notifF); nBar.Size=UDim2.fromOffset(3,50); nBar.Position=UDim2.fromOffset(0,9)
    nBar.BackgroundColor3=C.acc; nBar.BorderSizePixel=0; crn(nBar,2); grd(nBar,C.accL,C.accD,90)
    local nT=Instance.new("TextLabel",_notifF); nT.Name="T"; nT.Size=UDim2.new(1,-18,0,24); nT.Position=UDim2.fromOffset(14,8)
    nT.BackgroundTransparency=1; nT.Text=""; nT.TextColor3=C.txt; nT.Font=Enum.Font.GothamBold; nT.TextSize=13; nT.TextXAlignment=Enum.TextXAlignment.Left
    local nM=Instance.new("TextLabel",_notifF); nM.Name="M"; nM.Size=UDim2.new(1,-18,0,20); nM.Position=UDim2.fromOffset(14,32)
    nM.BackgroundTransparency=1; nM.Text=""; nM.TextColor3=C.txtD; nM.Font=Enum.Font.Gotham; nM.TextSize=11; nM.TextXAlignment=Enum.TextXAlignment.Left

    -- Main ScreenGui
    local sg=Instance.new("ScreenGui"); sg.Name="SplashUI9"; sg.ResetOnSpawn=false
    sg.IgnoreGuiInset=true; sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling; sg.Parent=LP:WaitForChild("PlayerGui")

    local W,H=575,400; local TH=42; local SW=142; local BH=46

    -- Hauptfenster — kein UIStroke, kein separater Glow
    local win=Instance.new("Frame",sg); win.Size=UDim2.fromOffset(W,H)
    win.AnchorPoint=Vector2.new(0.5,0.5); win.Position=UDim2.fromScale(0.5,0.5)
    win.BackgroundColor3=C.win; win.BorderSizePixel=0; crn(win,14)
    grd(win,Color3.fromRGB(18,23,52),Color3.fromRGB(10,13,34),140)

    -- Accent-Rand (nur 1.5px, dezent, kein Glow)
    local winStroke=Instance.new("UIStroke",win)
    winStroke.Color=Color3.fromRGB(45,60,130); winStroke.Thickness=1.5
    winStroke.ApplyStrokeMode=Enum.ApplyStrokeMode.Border

    -- Topbar
    local tb=Instance.new("Frame",win); tb.Size=UDim2.new(1,0,0,TH)
    tb.BackgroundColor3=C.top; tb.BorderSizePixel=0; crn(tb,14)
    grd(tb,Color3.fromRGB(22,29,66),Color3.fromRGB(14,19,50),90)

    -- Trennlinie
    local tline=Instance.new("Frame",win); tline.Size=UDim2.new(1,0,0,1); tline.Position=UDim2.fromOffset(0,TH)
    tline.BackgroundColor3=Color3.fromRGB(42,55,120); tline.BorderSizePixel=0
    grd(tline,Color3.fromRGB(82,130,255),Color3.fromRGB(22,30,75),0)

    -- Logo
    local logo=Instance.new("TextLabel",tb); logo.Size=UDim2.new(0,230,1,0); logo.Position=UDim2.fromOffset(16,0)
    logo.BackgroundTransparency=1; logo.Text="SPLASH SCRIPTS"; logo.TextColor3=C.txt
    logo.Font=Enum.Font.GothamBlack; logo.TextSize=16; logo.TextXAlignment=Enum.TextXAlignment.Left

    local ver=Instance.new("TextLabel",tb); ver.Size=UDim2.new(0,50,1,0); ver.Position=UDim2.fromOffset(232,0)
    ver.BackgroundTransparency=1; ver.Text="v9.0"; ver.TextColor3=C.txtM
    ver.Font=Enum.Font.Gotham; ver.TextSize=11; ver.TextXAlignment=Enum.TextXAlignment.Left

    -- Minimize button
    local minBtn=Instance.new("TextButton",tb); minBtn.Size=UDim2.fromOffset(28,28)
    minBtn.Position=UDim2.new(1,-38,0.5,-14); minBtn.BackgroundColor3=Color3.fromRGB(26,34,80)
    minBtn.Text="—"; minBtn.TextColor3=C.txtD; minBtn.Font=Enum.Font.GothamBold; minBtn.TextSize=14
    minBtn.BorderSizePixel=0; crn(minBtn,6); minBtn.AutoButtonColor=false
    minBtn.MouseEnter:Connect(function() tw(minBtn,{BackgroundColor3=Color3.fromRGB(42,54,120),TextColor3=C.txt}) end)
    minBtn.MouseLeave:Connect(function() tw(minBtn,{BackgroundColor3=Color3.fromRGB(26,34,80),TextColor3=C.txtD}) end)

    -- Content Area
    local content=Instance.new("Frame",win); content.Size=UDim2.new(1,0,1,-TH-1-BH)
    content.Position=UDim2.fromOffset(0,TH+1); content.BackgroundTransparency=1; content.BorderSizePixel=0

    -- Minimize / K toggle
    local minimized=false
    local function toggleMin()
        minimized=not minimized
        if minimized then
            content.Visible=false; minBtn.Text="+"
            tw(win,{Size=UDim2.fromOffset(W,TH)},0.2)
        else
            tw(win,{Size=UDim2.fromOffset(W,H)},0.2); minBtn.Text="—"
            task.delay(0.21,function() content.Visible=true end)
        end
    end
    minBtn.MouseButton1Click:Connect(toggleMin)
    UserInputService.InputBegan:Connect(function(i,g)
        if not g and i.KeyCode==Enum.KeyCode.K then toggleMin() end
    end)

    -- ════════════════════════════════
    -- DRAG — überall (ganzes Fenster)
    -- ════════════════════════════════
    do
        local dragging=false; local dragStart; local startPos
        local function beginDrag(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 then
                dragging=true; dragStart=input.Position; startPos=win.Position
            end
        end
        local function endDrag(input)
            if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end
        end
        -- Topbar drag
        tb.InputBegan:Connect(beginDrag); tb.InputEnded:Connect(endDrag)
        -- Unsichtbarer Drag-Overlay für gesamtes Fenster (nur als Fallback, niedrigste Priority)
        local dragOverlay=Instance.new("TextButton",win)
        dragOverlay.Size=UDim2.fromScale(1,1); dragOverlay.BackgroundTransparency=1
        dragOverlay.Text=""; dragOverlay.ZIndex=0; dragOverlay.AutoButtonColor=false
        dragOverlay.InputBegan:Connect(beginDrag); dragOverlay.InputEnded:Connect(endDrag)

        UserInputService.InputChanged:Connect(function(i)
            if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then
                local d=i.Position-dragStart
                win.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
            end
        end)
    end

    -- Sidebar
    local sb=Instance.new("Frame",content); sb.Size=UDim2.new(0,SW,1,0)
    sb.BackgroundColor3=C.side; sb.BorderSizePixel=0
    grd(sb,Color3.fromRGB(15,20,48),Color3.fromRGB(10,13,36),90)
    local sbLine=Instance.new("Frame",sb); sbLine.Size=UDim2.new(0,1,1,0); sbLine.Position=UDim2.new(1,-1,0,0)
    sbLine.BackgroundColor3=Color3.fromRGB(38,50,110); sbLine.BorderSizePixel=0

    -- Panel
    local panel=Instance.new("Frame",content); panel.Size=UDim2.new(1,-SW,1,0)
    panel.Position=UDim2.fromOffset(SW,0); panel.BackgroundTransparency=1; panel.BorderSizePixel=0

    -- Panel BG
    local pbg=Instance.new("Frame",panel); pbg.Size=UDim2.fromScale(1,1)
    pbg.BackgroundColor3=C.win; pbg.BorderSizePixel=0; pbg.ZIndex=0
    grd(pbg,Color3.fromRGB(18,23,52),Color3.fromRGB(12,16,40),140)

    -- ════════════════════════════════
    -- USER INFO unten in Sidebar
    -- ════════════════════════════════
    local userBar=Instance.new("Frame",win)
    userBar.Size=UDim2.new(0,SW,0,BH); userBar.Position=UDim2.new(0,0,1,-BH)
    userBar.BackgroundColor3=Color3.fromRGB(10,14,36); userBar.BorderSizePixel=0
    grd(userBar,Color3.fromRGB(12,17,44),Color3.fromRGB(8,11,30),90)
    local ubLine=Instance.new("Frame",userBar); ubLine.Size=UDim2.new(1,0,0,1)
    ubLine.BackgroundColor3=Color3.fromRGB(38,50,110); ubLine.BorderSizePixel=0

    -- Avatar Icon (Thumbnail)
    local avatarImg=Instance.new("ImageLabel",userBar); avatarImg.Size=UDim2.fromOffset(32,32)
    avatarImg.Position=UDim2.fromOffset(8,7); avatarImg.BackgroundColor3=Color3.fromRGB(20,26,60)
    avatarImg.BorderSizePixel=0; crn(avatarImg,16)
    local avatarUrl="rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=48&h=48"
    avatarImg.Image=avatarUrl

    local userNameLbl=Instance.new("TextLabel",userBar); userNameLbl.Size=UDim2.new(1,-48,0,16)
    userNameLbl.Position=UDim2.fromOffset(46,8); userNameLbl.BackgroundTransparency=1
    userNameLbl.Text=LP.Name; userNameLbl.TextColor3=C.txt
    userNameLbl.Font=Enum.Font.GothamBold; userNameLbl.TextSize=11; userNameLbl.TextXAlignment=Enum.TextXAlignment.Left
    userNameLbl.TextTruncate=Enum.TextTruncate.AtEnd

    local displayLbl=Instance.new("TextLabel",userBar); displayLbl.Size=UDim2.new(1,-48,0,14)
    displayLbl.Position=UDim2.fromOffset(46,24); displayLbl.BackgroundTransparency=1
    displayLbl.Text=LP.DisplayName; displayLbl.TextColor3=C.txtM
    displayLbl.Font=Enum.Font.Gotham; displayLbl.TextSize=10; displayLbl.TextXAlignment=Enum.TextXAlignment.Left
    displayLbl.TextTruncate=Enum.TextTruncate.AtEnd

    -- ════════════════════════════════
    -- TAB SYSTEM
    -- ════════════════════════════════
    local tabs={}; local activeTab=nil; local tabY=10

    local function createTab(name)
        local btn=Instance.new("TextButton",sb); btn.Size=UDim2.new(1,0,0,38)
        btn.Position=UDim2.fromOffset(0,tabY); tabY=tabY+40
        btn.BackgroundColor3=C.side; btn.Text=""; btn.BorderSizePixel=0; btn.AutoButtonColor=false

        local aGlow=Instance.new("Frame",btn); aGlow.Size=UDim2.fromScale(1,1)
        aGlow.BackgroundColor3=C.sideA; aGlow.BorderSizePixel=0; aGlow.BackgroundTransparency=1
        grd(aGlow,Color3.fromRGB(32,42,100),C.side,0)

        local aBar=Instance.new("Frame",btn); aBar.Size=UDim2.fromOffset(3,22)
        aBar.Position=UDim2.new(0,0,0.5,-11); aBar.BackgroundColor3=C.acc
        aBar.BorderSizePixel=0; crn(aBar,2); aBar.BackgroundTransparency=1
        grd(aBar,C.accL,C.accD,90)

        local lbl2=Instance.new("TextLabel",btn); lbl2.Size=UDim2.new(1,-18,1,0)
        lbl2.Position=UDim2.fromOffset(14,0); lbl2.BackgroundTransparency=1
        lbl2.Text=string.upper(name); lbl2.TextColor3=C.txtM
        lbl2.Font=Enum.Font.GothamBlack; lbl2.TextSize=12
        lbl2.TextXAlignment=Enum.TextXAlignment.Left; lbl2.ZIndex=5

        local scroll=Instance.new("ScrollingFrame",panel); scroll.Size=UDim2.fromScale(1,1)
        scroll.BackgroundTransparency=1; scroll.BorderSizePixel=0; scroll.Visible=false
        scroll.ScrollBarThickness=3; scroll.ScrollBarImageColor3=C.acc; scroll.ZIndex=2
        local layout=Instance.new("UIListLayout",scroll); layout.Padding=UDim.new(0,6)
        layout.SortOrder=Enum.SortOrder.LayoutOrder
        local pad=Instance.new("UIPadding",scroll)
        pad.PaddingLeft=UDim.new(0,12); pad.PaddingRight=UDim.new(0,12); pad.PaddingTop=UDim.new(0,12)
        layout.Changed:Connect(function() scroll.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+24) end)

        local tab={scroll=scroll,btn=btn,lbl=lbl2,bar=aBar,glow=aGlow,order=1}
        tabs[name]=tab

        btn.MouseButton1Click:Connect(function()
            if activeTab then
                local at=tabs[activeTab]
                at.scroll.Visible=false; at.lbl.TextColor3=C.txtM
                tw(at.bar,{BackgroundTransparency=1}); tw(at.glow,{BackgroundTransparency=1})
                tw(at.btn,{BackgroundColor3=C.side})
            end
            activeTab=name; scroll.Visible=true
            tw(lbl2,{TextColor3=C.txt}); tw(aBar,{BackgroundTransparency=0},0.15)
            tw(aGlow,{BackgroundTransparency=0.5},0.15); tw(btn,{BackgroundColor3=C.sideA})
        end)
        btn.MouseEnter:Connect(function() if activeTab~=name then tw(btn,{BackgroundColor3=C.sideH}); tw(lbl2,{TextColor3=C.txtD}) end end)
        btn.MouseLeave:Connect(function() if activeTab~=name then tw(btn,{BackgroundColor3=C.side}); tw(lbl2,{TextColor3=C.txtM}) end end)
        return tab
    end

    -- ════════════════════════════════
    -- ELEMENT BUILDERS
    -- ════════════════════════════════
    local function sec(tab,txt)
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,24)
        f.BackgroundTransparency=1; f.LayoutOrder=tab.order; tab.order=tab.order+1
        local l=Instance.new("TextLabel",f); l.Size=UDim2.fromScale(1,1); l.BackgroundTransparency=1
        l.Text=string.upper(txt); l.TextColor3=C.acc; l.Font=Enum.Font.GothamBlack; l.TextSize=11
        l.TextXAlignment=Enum.TextXAlignment.Left
        local ln=Instance.new("Frame",f); ln.Size=UDim2.new(1,0,0,1); ln.Position=UDim2.new(0,0,1,-1)
        ln.BackgroundColor3=Color3.fromRGB(38,50,110); ln.BorderSizePixel=0
        grd(ln,C.acc,Color3.fromRGB(18,24,60),0)
    end

    local function btn(tab,txt,cb)
        local f=Instance.new("TextButton",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.Text=""; f.BorderSizePixel=0; f.AutoButtonColor=false
        f.LayoutOrder=tab.order; tab.order=tab.order+1; crn(f,8)
        grd(f,Color3.fromRGB(24,30,70),Color3.fromRGB(16,22,55),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-16,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=txt; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        f.MouseEnter:Connect(function() tw(f,{BackgroundColor3=C.elH}) end)
        f.MouseLeave:Connect(function() tw(f,{BackgroundColor3=C.el}) end)
        f.MouseButton1Click:Connect(function() tw(f,{BackgroundColor3=C.acc},0.08); task.delay(0.15,function() tw(f,{BackgroundColor3=C.el}) end); cb() end)
    end

    local function tog(tab,txt,def,cb)
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; crn(f,8)
        grd(f,Color3.fromRGB(24,30,70),Color3.fromRGB(16,22,55),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-58,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=txt; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local val=def
        local track=Instance.new("Frame",f); track.Size=UDim2.fromOffset(36,20)
        track.Position=UDim2.new(1,-46,0.5,-10); track.BackgroundColor3=val and C.tonOn or C.tonOff
        track.BorderSizePixel=0; crn(track,10)
        local knob=Instance.new("Frame",track); knob.Size=UDim2.fromOffset(16,16)
        knob.Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)
        knob.BackgroundColor3=Color3.fromRGB(255,255,255); knob.BorderSizePixel=0; crn(knob,8)
        local overlay=Instance.new("TextButton",f); overlay.Size=UDim2.fromScale(1,1)
        overlay.BackgroundTransparency=1; overlay.Text=""; overlay.ZIndex=5
        overlay.MouseButton1Click:Connect(function()
            val=not val; cb(val)
            tw(track,{BackgroundColor3=val and C.tonOn or C.tonOff})
            tw(knob,{Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)})
        end)
        return {get=function() return val end}
    end

    local function sld(tab,txt,mn,mx,def,cb)
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,50)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; crn(f,8)
        grd(f,Color3.fromRGB(24,30,70),Color3.fromRGB(16,22,55),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-64,0,20); l.Position=UDim2.fromOffset(14,6)
        l.BackgroundTransparency=1; l.Text=txt; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local vl=Instance.new("TextLabel",f); vl.Size=UDim2.fromOffset(56,20); vl.Position=UDim2.new(1,-62,0,6)
        vl.BackgroundTransparency=1; vl.Text=tostring(def); vl.TextColor3=C.accL; vl.Font=Enum.Font.GothamBold; vl.TextSize=12; vl.TextXAlignment=Enum.TextXAlignment.Right
        local tr=Instance.new("Frame",f); tr.Size=UDim2.new(1,-24,0,5); tr.Position=UDim2.new(0,12,1,-14)
        tr.BackgroundColor3=C.slBg; tr.BorderSizePixel=0; crn(tr,3)
        local fi=Instance.new("Frame",tr); fi.Size=UDim2.new((def-mn)/(mx-mn),0,1,0)
        fi.BackgroundColor3=C.acc; fi.BorderSizePixel=0; crn(fi,3); grd(fi,C.acc,C.accL,0)
        local hd=Instance.new("Frame",tr); hd.Size=UDim2.fromOffset(12,12); hd.Position=UDim2.new((def-mn)/(mx-mn),0,0.5,-6)
        hd.BackgroundColor3=Color3.fromRGB(245,250,255); hd.BorderSizePixel=0; crn(hd,6)
        local drag=false
        local function upd(x) local pct=math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1); local v=math.floor(mn+(mx-mn)*pct); fi.Size=UDim2.new(pct,0,1,0); hd.Position=UDim2.new(pct,0,0.5,-6); vl.Text=tostring(v); cb(v) end
        tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true; upd(i.Position.X) end end)
        UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then upd(i.Position.X) end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
    end

    local function kbind(tab,txt,def,cb)
        local cur=Enum.KeyCode[def] or Enum.KeyCode.F
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; crn(f,8)
        grd(f,Color3.fromRGB(24,30,70),Color3.fromRGB(16,22,55),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-90,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=txt; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local kb=Instance.new("TextButton",f); kb.Size=UDim2.fromOffset(74,24); kb.Position=UDim2.new(1,-82,0.5,-12)
        kb.BackgroundColor3=C.accD; kb.Text="["..def.."]"; kb.TextColor3=C.txt
        kb.Font=Enum.Font.GothamBold; kb.TextSize=11; kb.BorderSizePixel=0; crn(kb,6); grd(kb,C.acc,C.accD,90)
        local listening=false
        kb.MouseButton1Click:Connect(function() listening=true; kb.Text="[...]"; kb.BackgroundColor3=C.acc end)
        UserInputService.InputBegan:Connect(function(i,g)
            if g then return end
            if listening then listening=false; cur=i.KeyCode; kb.Text="["..i.KeyCode.Name.."]"; kb.BackgroundColor3=C.accD
            elseif i.KeyCode==cur then cb() end
        end)
    end

    -- Dropdown mit Avatar-Icons für Spieler
    local function playerDrop(tab, txt, cb)
        local val=""
        local f=Instance.new("Frame",tab.scroll); f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=C.el; f.BorderSizePixel=0; f.LayoutOrder=tab.order; tab.order=tab.order+1; crn(f,8)
        grd(f,Color3.fromRGB(24,30,70),Color3.fromRGB(16,22,55),90)
        local l=Instance.new("TextLabel",f); l.Size=UDim2.new(1,-195,1,0); l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1; l.Text=txt; l.TextColor3=C.txt; l.Font=Enum.Font.GothamBlack; l.TextSize=13; l.TextXAlignment=Enum.TextXAlignment.Left
        local db=Instance.new("TextButton",f); db.Size=UDim2.fromOffset(172,24); db.Position=UDim2.new(1,-180,0.5,-12)
        db.BackgroundColor3=C.slBg; db.Text=val=="" and "Auswählen..." or val; db.TextColor3=C.txt
        db.Font=Enum.Font.Gotham; db.TextSize=11; db.BorderSizePixel=0; crn(db,6)
        local open=false; local dFrame
        db.MouseButton1Click:Connect(function()
            open=not open
            if open then
                local opts=getPlayerList()
                val=val=="" and (opts[1] or "") or val
                dFrame=Instance.new("Frame",sg); dFrame.ZIndex=300
                dFrame.Size=UDim2.fromOffset(200,math.min(#opts,6)*40+6)
                local ap=db.AbsolutePosition; dFrame.Position=UDim2.fromOffset(ap.X-28,ap.Y+28)
                dFrame.BackgroundColor3=Color3.fromRGB(16,21,52); dFrame.BorderSizePixel=0; crn(dFrame,9)
                local dStr=Instance.new("UIStroke",dFrame); dStr.Color=C.acc; dStr.Thickness=1
                local dll=Instance.new("UIListLayout",dFrame); dll.SortOrder=Enum.SortOrder.LayoutOrder
                local dPad=Instance.new("UIPadding",dFrame); dPad.PaddingTop=UDim.new(0,3); dPad.PaddingBottom=UDim.new(0,3)
                for i,o in ipairs(opts) do
                    local ob=Instance.new("TextButton",dFrame); ob.Size=UDim2.new(1,0,0,38)
                    ob.BackgroundColor3=Color3.fromRGB(16,21,52); ob.Text=""; ob.BorderSizePixel=0; ob.LayoutOrder=i
                    -- Avatar
                    local p=Players:FindFirstChild(o)
                    local avImg=Instance.new("ImageLabel",ob); avImg.Size=UDim2.fromOffset(26,26)
                    avImg.Position=UDim2.fromOffset(8,6); avImg.BackgroundTransparency=1
                    avImg.BorderSizePixel=0; crn(avImg,13)
                    if p then avImg.Image="rbxthumb://type=AvatarHeadShot&id="..p.UserId.."&w=48&h=48" end
                    local oLbl=Instance.new("TextLabel",ob); oLbl.Size=UDim2.new(1,-44,1,0); oLbl.Position=UDim2.fromOffset(40,0)
                    oLbl.BackgroundTransparency=1; oLbl.Text=o; oLbl.TextColor3=o==val and C.accL or C.txt
                    oLbl.Font=Enum.Font.GothamBold; oLbl.TextSize=12; oLbl.TextXAlignment=Enum.TextXAlignment.Left
                    ob.MouseEnter:Connect(function() tw(ob,{BackgroundColor3=C.elH}) end)
                    ob.MouseLeave:Connect(function() tw(ob,{BackgroundColor3=Color3.fromRGB(16,21,52)}) end)
                    ob.MouseButton1Click:Connect(function()
                        val=o; db.Text=o; cb(o)
                        if dFrame then dFrame:Destroy(); dFrame=nil end; open=false
                    end)
                end
            else if dFrame then dFrame:Destroy(); dFrame=nil end end
        end)
        -- Initial value
        local opts=getPlayerList(); val=opts[1] or ""; db.Text=val; cb(val)
        return {get=function() return val end}
    end

    -- ════════════════════════════════
    -- FLY TAB
    -- ════════════════════════════════
    local flyTab=createTab("Fly")
    local flyActive=false; local flySpeed=80; local flyConn; local flyBV; local flyBG

    local function cleanFly()
        flyActive=false
        if flyConn then flyConn:Disconnect(); flyConn=nil end
        if flyBV then flyBV:Destroy(); flyBV=nil end
        if flyBG then flyBG:Destroy(); flyBG=nil end
        local h=getHum(); if h then h.PlatformStand=false end
        local c=getChar(); if not c then return end
        local torso=c:FindFirstChild("Torso")
        if torso then
            local rs=torso:FindFirstChild("Right Shoulder"); local ls=torso:FindFirstChild("Left Shoulder")
            local rh=torso:FindFirstChild("Right Hip"); local lh=torso:FindFirstChild("Left Hip"); local nk=torso:FindFirstChild("Neck")
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
        flyBV=Instance.new("BodyVelocity"); flyBV.MaxForce=Vector3.new(1e9,1e9,1e9); flyBV.Velocity=Vector3.zero; flyBV.Parent=hrp
        flyBG=Instance.new("BodyGyro"); flyBG.MaxTorque=Vector3.new(1e9,1e9,1e9); flyBG.D=50; flyBG.P=1200; flyBG.Parent=hrp
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
                local function gm(p,n) if not p then return nil end; for _,v in ipairs(p:GetDescendants()) do if v:IsA("Motor6D") and v.Name==n then return v end end end
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
                flyBV.Velocity=dir.Unit*(flySpeed*boost)
                flyBG.CFrame=flyBG.CFrame:Lerp(CFrame.new(h2.Position,h2.Position+dir.Unit)*CFrame.Angles(-math.rad(72),0,0),0.12)
            else
                flyBV.Velocity=Vector3.zero
                flyBG.CFrame=flyBG.CFrame:Lerp(CFrame.new(h2.Position,h2.Position+cf.LookVector)*CFrame.Angles(-math.rad(15),0,0),0.08)
            end
        end)
    end

    tog(flyTab,"Fly aktivieren",false,"Fly",function(v) if v then startFly() else cleanFly() end end)
    sld(flyTab,"Fly Speed",10,600,80,"FS",function(v) flySpeed=v end)
    kbind(flyTab,"Fly Keybind","F",function() if flyActive then cleanFly() else startFly() end end)
    local inf=Instance.new("Frame",flyTab.scroll); inf.Size=UDim2.new(1,0,0,44); inf.BackgroundColor3=C.el
    inf.BorderSizePixel=0; inf.LayoutOrder=flyTab.order; flyTab.order=flyTab.order+1; crn(inf,8)
    grd(inf,Color3.fromRGB(20,26,62),Color3.fromRGB(14,18,48),90)
    local il=Instance.new("TextLabel",inf); il.Size=UDim2.new(1,-16,1,0); il.Position=UDim2.fromOffset(12,0)
    il.BackgroundTransparency=1; il.TextColor3=C.txtD; il.Font=Enum.Font.Gotham; il.TextSize=11; il.TextWrapped=true; il.TextXAlignment=Enum.TextXAlignment.Left
    il.Text="W/A/S/D · Space=hoch · Shift=runter · Strg=4x Speed\nK=minimize · Superman-Pose (R6 & R15)"

    -- ════════════════════════════════
    -- FUN TAB
    -- ════════════════════════════════
    local funTab=createTab("Fun"); local selP=""

    -- Orbit Variablen (müssen vor btn() deklariert sein)
    local orbitConn; local orbitActive=false
    local function stopOrbit()
        orbitActive=false
        if orbitConn then orbitConn:Disconnect(); orbitConn=nil end
        if _G._orbitBP then _G._orbitBP:Destroy(); _G._orbitBP=nil end
        if _G._orbitBP2 then _G._orbitBP2:Destroy(); _G._orbitBP2=nil end
    end
    local pDropHandle=playerDrop(funTab,"Spieler",function(v) selP=v end)
    btn(funTab,"Liste aktualisieren",function()
        selP=getPlayerList()[1] or ""; notify("OK","Liste aktualisiert.")
    end)

    -- Auf Kopf sitzen — WELD (bleibt drauf)
    local headSitConn; local headSitBP; local headSitBG2
    local function stopHeadSit()
        if headSitConn then headSitConn:Disconnect(); headSitConn=nil end
        if headSitBP then headSitBP:Destroy(); headSitBP=nil end
        if headSitBG2 then headSitBG2:Destroy(); headSitBG2=nil end
        local h=getHum(); if h then h.PlatformStand=false end
    end

    local function startHeadSit(targetName)
        stopHeadSit()
        local tp,tc=getTarget(targetName); if not tc then notify("Fehler","Spieler nicht gefunden!",C.err) return end
        local head=tc:FindFirstChild("Head"); local myHRP=getHRP(); local myHum=getHum()
        if not head or not myHRP or not myHum then return end
        myHum.PlatformStand=true
        -- BodyPosition: folgt dem Kopf kontinuierlich — funktioniert auch bei entfernten Spielern
        headSitBP=Instance.new("BodyPosition"); headSitBP.MaxForce=Vector3.new(1e9,1e9,1e9)
        headSitBP.D=800; headSitBP.P=15000; headSitBP.Parent=myHRP
        headSitBG2=Instance.new("BodyGyro"); headSitBG2.MaxTorque=Vector3.new(1e9,1e9,1e9)
        headSitBG2.D=100; headSitBG2.P=1000; headSitBG2.Parent=myHRP
        notify("Sitzen","Sitze auf "..targetName.."s Kopf! [Kopf verlassen] zum Stoppen.")
        headSitConn=RunService.Heartbeat:Connect(function()
            if not head or not head.Parent then stopHeadSit() return end
            headSitBP.Position=head.Position+Vector3.new(0,3.2,0)
            headSitBG2.CFrame=head.CFrame
        end)
    end

    sec(funTab,"Fling & Teleport")
    btn(funTab,"Spieler flingen",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        for i=1,10 do task.delay(i*0.01,function()
            local f=Instance.new("BodyVelocity"); f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent=hrp
            game:GetService("Debris"):AddItem(f,0.1)
        end) end; notify("Fling",selP.." geflingt!",C.ok)
    end)
    btn(funTab,"Alle flingen",function()
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local h=p.Character:FindFirstChild("HumanoidRootPart"); if not h then continue end
            local f=Instance.new("BodyVelocity"); f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)); f.Parent=h
            game:GetService("Debris"):AddItem(f,0.1)
        end end
    end)
    btn(funTab,"Zu Spieler TP",function() local _,tc=getTarget(selP); if not tc then return end local th,mh=tc:FindFirstChild("HumanoidRootPart"),getHRP(); if th and mh then mh.CFrame=th.CFrame*CFrame.new(3,0,0) end end)
    btn(funTab,"Spieler zu mir TP",function() local _,tc=getTarget(selP); if not tc then return end local th,mh=tc:FindFirstChild("HumanoidRootPart"),getHRP(); if th and mh then th.CFrame=mh.CFrame*CFrame.new(3,0,0) end end)
    btn(funTab,"Auf Kopf sitzen",function() startHeadSit(selP) end)
    btn(funTab,"Kopf verlassen",function() stopHeadSit(); notify("OK","Kopf verlassen.") end)
    btn(funTab,"Orbit Fling (kreisen)",function()
        local tp,tc=getTarget(selP); if not tc then notify("Fehler","Spieler nicht gefunden!",C.err) return end
        local myHRP=getHRP(); if not myHRP then return end
        if orbitActive then stopOrbit(); notify("Orbit","Orbit gestoppt.") return end
        orbitActive=true
        local angle=0; local radius=8; local heightOsc=0
        -- Gib uns Network Ownership über unseren eigenen Charakter
        local orbitBV=Instance.new("BodyVelocity"); orbitBV.MaxForce=Vector3.new(1e9,1e9,1e9); orbitBV.Velocity=Vector3.zero; orbitBV.Parent=myHRP
        local orbitBP=Instance.new("BodyPosition"); orbitBP.MaxForce=Vector3.new(1e9,1e9,1e9); orbitBP.D=500; orbitBP.P=10000; orbitBP.Parent=myHRP
        notify("Orbit","Orbit gestartet! Nochmal klicken = stop.")
        orbitConn=RunService.Heartbeat:Connect(function(dt)
            if not orbitActive then stopOrbit(); orbitBV:Destroy(); orbitBP:Destroy(); return end
            local _,tc2=getTarget(selP)
            if not tc2 then stopOrbit(); orbitBV:Destroy(); orbitBP:Destroy(); return end
            local tHRP=tc2:FindFirstChild("HumanoidRootPart"); if not tHRP then return end
            angle=angle+dt*2.5  -- Rotationsgeschwindigkeit
            heightOsc=heightOsc+dt*1.2
            local targetPos=tHRP.Position
                + Vector3.new(math.cos(angle)*radius, math.sin(heightOsc)*6+4, math.sin(angle)*radius)
            orbitBP.Position=targetPos
        end)
    end)

    btn(funTab,"Orbit stoppen",function() stopOrbit(); notify("Orbit","Orbit gestoppt.") end)
    btn(funTab,"Hochkatapultieren",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        local bv2=Instance.new("BodyVelocity"); bv2.MaxForce=Vector3.new(0,1e9,0); bv2.Velocity=Vector3.new(0,2500,0); bv2.Parent=hrp
        game:GetService("Debris"):AddItem(bv2,0.25)
    end)
    btn(funTab,"Einfrieren",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hm=tc:FindFirstChild("Humanoid"); if not hm then return end
        local fr=hm.WalkSpeed==0; hm.WalkSpeed=fr and 16 or 0; hm.JumpPower=fr and 50 or 0
        notify("Freeze",selP..(fr and " freigegeben" or " eingefroren"))
    end)
    btn(funTab,"Spin",function()
        local _,tc=getTarget(selP); if not tc then return end
        local hrp=tc:FindFirstChild("HumanoidRootPart"); if not hrp then return end
        task.spawn(function() for i=1,100 do hrp.CFrame=hrp.CFrame*CFrame.Angles(0,math.rad(20),0); task.wait(0.01) end end)
    end)
    btn(funTab,"Alle zu mir TP",function()
        local mh=getHRP(); if not mh then return end
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local h=p.Character:FindFirstChild("HumanoidRootPart")
            if h then h.CFrame=mh.CFrame*CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
        end end
    end)
    sec(funTab,"Speed & Movement")
    tog(funTab,"Super Speed",false,"SS",function(v) local h=getHum(); if h then h.WalkSpeed=v and 120 or 16 end end)
    sld(funTab,"Walk Speed",16,500,16,"WS",function(v) local h=getHum(); if h then h.WalkSpeed=v end end)
    tog(funTab,"Inf Jump",false,"IJ",function(v)
        if v then
            _G.infJumpConn=UserInputService.JumpRequest:Connect(function()
                local h=getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
            end)
        else
            if _G.infJumpConn then _G.infJumpConn:Disconnect(); _G.infJumpConn=nil end
        end
    end)
    sld(funTab,"Jump Power",50,500,50,"JP",function(v) local h=getHum(); if h then h.JumpPower=v end end)
    tog(funTab,"Noclip",false,"NC",function(v)
        if v then
            _G.noclipConn=RunService.Stepped:Connect(function()
                local c=getChar(); if not c then return end
                for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
            end)
        else
            if _G.noclipConn then _G.noclipConn:Disconnect(); _G.noclipConn=nil end
        end
    end)
    tog(funTab,"Unsichtbar",false,"IV",function(v) local c=getChar(); if not c then return end; for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=v and 1 or 0 end end end)
    sec(funTab,"Outfit")
    btn(funTab,"Outfit klauen",function()
        local tp=getTarget(selP); if not tp then return end
        local h=getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(tp.UserId)) end
        notify("Outfit","Outfit von "..selP.." geklaut!",C.ok)
    end)
    btn(funTab,"Eigenes Outfit zurück",function() local h=getHum(); if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LP.UserId)) end end)
    btn(funTab,"Riesenkopf",function() local _,tc=getTarget(selP); if not tc then return end; local hd=tc:FindFirstChild("Head"); if hd then hd.Size=Vector3.new(6,6,6) end end)

    -- ════════════════════════════════
    -- ESP TAB
    -- ════════════════════════════════
    local espTab=createTab("ESP"); local espOn=false; local espHL={}
    local espFill=0.5; local espWalls=true
    local function remESP() for _,h in pairs(espHL) do pcall(function() h:Destroy() end) end; espHL={} end
    local function addESP(char,name) local h=Instance.new("Highlight"); h.FillColor=C.acc; h.OutlineColor=Color3.fromRGB(255,255,255); h.FillTransparency=espFill; h.OutlineTransparency=0; h.DepthMode=espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded; h.Parent=char; espHL[name]=h end
    local function buildESP() remESP(); for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then addESP(p.Character,p.Name) end end end
    tog(espTab,"ESP aktivieren",false,"ESP",function(v) espOn=v; if v then buildESP() else remESP() end end)
    sld(espTab,"Transparenz",0,10,5,"EA",function(v) espFill=v/10; for _,h in pairs(espHL) do if h then h.FillTransparency=espFill end end end)
    tog(espTab,"Durch Wände",true,"EW",function(v) espWalls=v; for _,h in pairs(espHL) do if h then h.DepthMode=v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded end end end)
    btn(espTab,"ESP aktualisieren",function() if espOn then buildESP() end end)
    Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if espOn then task.wait(1); addESP(c,p.Name) end end) end)
    Players.PlayerRemoving:Connect(function(p) if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end); espHL[p.Name]=nil end end)

    -- ════════════════════════════════
    -- WORLD TAB
    -- ════════════════════════════════
    local worldTab=createTab("World")
    tog(worldTab,"Fullbright",false,"FB",function(v) Lighting.Brightness=v and 10 or 2; Lighting.GlobalShadows=not v; Lighting.FogEnd=v and 1e9 or 1e5 end)
    sld(worldTab,"Helligkeit",0,10,2,"BR",function(v) Lighting.Brightness=v end)
    sld(worldTab,"Uhrzeit",0,24,14,"CL",function(v) Lighting.ClockTime=v end)
    tog(worldTab,"Fog entfernen",false,"NF",function(v) Lighting.FogEnd=v and 1e9 or 1e5; Lighting.FogStart=v and 1e9 or 0 end)
    sld(worldTab,"Gravity",0,400,196,"GV",function(v) workspace.Gravity=v end)
    tog(worldTab,"Anti-Gravity",false,"AG",function(v) workspace.Gravity=v and 0 or 196 end)

    -- ════════════════════════════════
    -- PLAYER TAB
    -- ════════════════════════════════
    local playerTab=createTab("Player")
    tog(playerTab,"God Mode",false,"GM",function(v) local h=getHum(); if h then h.MaxHealth=v and math.huge or 100; h.Health=v and math.huge or 100 end end)
    tog(playerTab,"Auto-Heal",false,"AH",function(v) if v then task.spawn(function() while v do local h=getHum(); if h then h.Health=h.MaxHealth end; task.wait(0.1) end end) end end)
    sld(playerTab,"HP setzen",1,1000,100,"HP",function(v) local h=getHum(); if h then h.Health=v end end)
    btn(playerTab,"Respawn",function() LP:LoadCharacter() end)
    sld(playerTab,"FOV",30,120,70,"FOV",function(v) Camera.FieldOfView=v end)

    -- ════════════════════════════════
    -- SETTINGS TAB
    -- ════════════════════════════════
    local settTab=createTab("Settings")
    local infoBlock=Instance.new("Frame",settTab.scroll); infoBlock.Size=UDim2.new(1,0,0,88)
    infoBlock.BackgroundColor3=C.el; infoBlock.BorderSizePixel=0; infoBlock.LayoutOrder=settTab.order; settTab.order=settTab.order+1; crn(infoBlock,8)
    grd(infoBlock,Color3.fromRGB(22,28,66),Color3.fromRGB(14,18,50),90)
    local il2=Instance.new("TextLabel",infoBlock); il2.Size=UDim2.new(1,-16,1,0); il2.Position=UDim2.fromOffset(12,0)
    il2.BackgroundTransparency=1; il2.TextColor3=C.txtD; il2.Font=Enum.Font.Gotham; il2.TextSize=11; il2.TextWrapped=true; il2.TextXAlignment=Enum.TextXAlignment.Left
    il2.Text="Splash Scripts v9.0  —  German Voice Edition\nKey: SplashScripts2026!\nDiscord: discord.gg/eyzfsAjpSr\nFly: W/A/S/D · Space · Shift · Strg=4x · K=toggle"
    btn(settTab,"Key zurücksetzen",function() pcall(function() delfile(KEY_FILE) end); notify("Key","Key gelöscht.") end)
    btn(settTab,"Discord kopieren",function() pcall(function() setclipboard(DISCORD_LINK) end); notify("Discord","Link kopiert!",C.ok) end)

    -- Ersten Tab aktivieren
    flyTab.btn.MouseButton1Click:Fire()

    -- Einfahren
    win.Position=UDim2.new(0.5,0,1.6,0)
    tw(win,{Position=UDim2.fromScale(0.5,0.5)},0.6,Enum.EasingStyle.Back)
    task.delay(0.85,function() notify("Splash Scripts v9.0","Script geladen! Viel Spaß 🎮",C.ok) end)
end

-- ══════════════════════════════════════════
-- START
-- ══════════════════════════════════════════
if loadKey()==VALID_KEY then
    task.spawn(loadMain)
else
    task.spawn(function() showKeyPanel(loadMain) end)
end
