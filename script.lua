-- ╔═══════════════════════════════════════════╗
-- ║      SPLASH SCRIPTS  v10.0               ║
-- ║      German Voice Edition                ║
-- ╚═══════════════════════════════════════════╝

local Players          = game:GetService("Players")
local RunService       = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting         = game:GetService("Lighting")
local TweenService     = game:GetService("TweenService")
local LP               = Players.LocalPlayer
local Cam              = workspace.CurrentCamera

-- ── Shortcuts ──────────────────────────────
local function char()  return LP.Character end
local function hrp()   local c=char() return c and c:FindFirstChild("HumanoidRootPart") end
local function hum()   local c=char() return c and c:FindFirstChild("Humanoid") end
local function plist()
    local t={} for _,p in ipairs(Players:GetPlayers()) do if p~=LP then t[#t+1]=p.Name end end
    return #t>0 and t or {"(Niemand)"}
end
local function ptarget(name)
    local p=Players:FindFirstChild(name)
    return (p and p.Character) and p or nil, (p and p.Character) or nil
end

-- ── Farben ─────────────────────────────────
-- Dunkel-Indigo / Mitternacht mit leuchtendem Blau
local BG   = Color3.fromRGB(13, 16, 38)
local BG2  = Color3.fromRGB( 9, 12, 28)
local SIDE = Color3.fromRGB(10, 13, 32)
local EL   = Color3.fromRGB(18, 23, 55)
local EL2  = Color3.fromRGB(24, 30, 70)
local ELH  = Color3.fromRGB(28, 36, 85)
local SAC  = Color3.fromRGB(26, 34, 80)
local ACC  = Color3.fromRGB(88, 138, 255)
local ACCD = Color3.fromRGB(55,  98, 220)
local ACCL = Color3.fromRGB(140, 178, 255)
local TXT  = Color3.fromRGB(222, 230, 255)
local TXTD = Color3.fromRGB(138, 156, 210)
local TXTM = Color3.fromRGB( 72,  92, 160)
local OK   = Color3.fromRGB( 52, 215, 118)
local ERR  = Color3.fromRGB(248,  88,  88)
local TON  = Color3.fromRGB( 88, 138, 255)
local TOFF = Color3.fromRGB( 28,  36,  82)
local SBG  = Color3.fromRGB( 10,  13,  36)

-- ── Kleine Helfer ──────────────────────────
local function C(p,r) local c=Instance.new("UICorner",p) c.CornerRadius=UDim.new(0,r or 8) end
local function G(p,a,b,r) local g=Instance.new("UIGradient",p) g.Color=ColorSequence.new(a,b) g.Rotation=r or 90 end
local function TW(o,pr,t,s) if o and o.Parent then TweenService:Create(o,TweenInfo.new(t or .14,s or Enum.EasingStyle.Quad),pr):Play() end end

-- Notification
local NF -- wird in loadMain gesetzt
local function notify(title,msg,col)
    if not NF or not NF.Parent then return end
    local t=NF:FindFirstChild("T") local m=NF:FindFirstChild("M")
    if t then t.Text=title end if m then m.Text=msg end
    NF.BackgroundColor3=col or EL
    TW(NF,{Position=UDim2.new(1,-310,1,-88)},0.4,Enum.EasingStyle.Back)
    task.delay(3.5,function() TW(NF,{Position=UDim2.new(1,-310,1,14)},0.3) end)
end

-- ════════════════════════════════════════════
-- KEY SYSTEM
-- ════════════════════════════════════════════
local KEY_VALID   = "SplashScripts2026!"
local KEY_DISCORD = "https://discord.gg/eyzfsAjpSr"
local KEY_FILE    = "SplashKey.txt"
local function keySave(k) pcall(function() writefile(KEY_FILE,k) end) end
local function keyLoad() local ok,v=pcall(function() return readfile(KEY_FILE) end) return (ok and type(v)=="string") and v or "" end

local function showKey(onOK)
    local sg=Instance.new("ScreenGui") sg.Name="SplKey" sg.ResetOnSpawn=false sg.IgnoreGuiInset=true
    sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling sg.Parent=LP:WaitForChild("PlayerGui")
    local bl=Instance.new("BlurEffect") bl.Size=22 bl.Parent=Lighting
    local dim=Instance.new("Frame",sg) dim.Size=UDim2.fromScale(1,1) dim.BackgroundColor3=Color3.new(0,0,0)
    dim.BackgroundTransparency=0.48 dim.BorderSizePixel=0 dim.ZIndex=1

    local card=Instance.new("Frame",sg) card.Size=UDim2.fromOffset(468,372)
    card.AnchorPoint=Vector2.new(0.5,0.5) card.Position=UDim2.new(0.5,0,1.7,0)
    card.BackgroundColor3=BG card.BorderSizePixel=0 card.ZIndex=2 C(card,16)
    G(card,Color3.fromRGB(16,21,50),BG2,140)
    -- Accent top stripe
    local st=Instance.new("Frame",card) st.Size=UDim2.new(1,0,0,3) st.BackgroundColor3=ACC
    st.BorderSizePixel=0 st.ZIndex=5 C(st,16) G(st,ACCD,ACCL,0)
    -- Glow (innerhalb der Karte, kein externer Ring)
    local gl=Instance.new("ImageLabel",card) gl.Size=UDim2.fromOffset(420,300)
    gl.AnchorPoint=Vector2.new(0.5,0.5) gl.Position=UDim2.fromScale(0.5,0.55)
    gl.BackgroundTransparency=1 gl.Image="rbxassetid://5028857084"
    gl.ImageColor3=Color3.fromRGB(60,95,255) gl.ImageTransparency=0.78 gl.ZIndex=2
    -- Title
    local tl=Instance.new("TextLabel",card) tl.Size=UDim2.new(1,0,0,50) tl.Position=UDim2.fromOffset(0,20)
    tl.BackgroundTransparency=1 tl.Text="SPLASH SCRIPTS" tl.TextColor3=TXT
    tl.Font=Enum.Font.GothamBlack tl.TextSize=27 tl.ZIndex=4 tl.TextXAlignment=Enum.TextXAlignment.Center
    local sl=Instance.new("TextLabel",card) sl.Size=UDim2.new(1,0,0,20) sl.Position=UDim2.fromOffset(0,68)
    sl.BackgroundTransparency=1 sl.Text="German Voice Edition  ·  Key System" sl.TextColor3=TXTD
    sl.Font=Enum.Font.Gotham sl.TextSize=13 sl.ZIndex=4 sl.TextXAlignment=Enum.TextXAlignment.Center
    -- Divider
    local dv=Instance.new("Frame",card) dv.Size=UDim2.new(0.88,0,0,1) dv.Position=UDim2.new(0.06,0,0,100)
    dv.BackgroundColor3=Color3.fromRGB(35,46,105) dv.BorderSizePixel=0 dv.ZIndex=4 G(dv,Color3.fromRGB(16,22,60),ACC,0)
    -- Discord label
    local dl=Instance.new("TextLabel",card) dl.Size=UDim2.new(0.88,0,0,18) dl.Position=UDim2.new(0.06,0,0,114)
    dl.BackgroundTransparency=1 dl.Text="Key holen → Trete unserem Discord bei:"
    dl.TextColor3=TXTD dl.Font=Enum.Font.GothamBold dl.TextSize=12 dl.TextXAlignment=Enum.TextXAlignment.Left dl.ZIndex=4
    -- Discord box
    local db=Instance.new("Frame",card) db.Size=UDim2.new(0.88,0,0,42) db.Position=UDim2.new(0.06,0,0,136)
    db.BackgroundColor3=Color3.fromRGB(12,16,46) db.BorderSizePixel=0 db.ZIndex=4 C(db,9)
    G(db,Color3.fromRGB(15,20,54),Color3.fromRGB(10,13,38),90)
    local dt=Instance.new("TextLabel",db) dt.Size=UDim2.new(1,-104,1,0) dt.Position=UDim2.fromOffset(12,0)
    dt.BackgroundTransparency=1 dt.Text=KEY_DISCORD dt.TextColor3=ACCL
    dt.Font=Enum.Font.Gotham dt.TextSize=12 dt.TextXAlignment=Enum.TextXAlignment.Left dt.ZIndex=5
    local cb=Instance.new("TextButton",db) cb.Size=UDim2.fromOffset(88,30)
    cb.Position=UDim2.new(1,-96,0.5,-15) cb.BackgroundColor3=ACCD
    cb.Text="Kopieren" cb.TextColor3=Color3.new(1,1,1) cb.Font=Enum.Font.GothamBold
    cb.TextSize=12 cb.BorderSizePixel=0 cb.ZIndex=6 C(cb,7) G(cb,ACC,ACCD,90)
    cb.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(KEY_DISCORD) end)
        cb.Text="✓ Kopiert!" cb.BackgroundColor3=OK
        task.delay(2.5,function() cb.Text="Kopieren" cb.BackgroundColor3=ACCD end)
    end)
    -- Key input label
    local kl=Instance.new("TextLabel",card) kl.Size=UDim2.new(0.88,0,0,18) kl.Position=UDim2.new(0.06,0,0,192)
    kl.BackgroundTransparency=1 kl.Text="Key eingeben:" kl.TextColor3=TXTD
    kl.Font=Enum.Font.GothamBold kl.TextSize=12 kl.TextXAlignment=Enum.TextXAlignment.Left kl.ZIndex=4
    -- Key input box
    local kf=Instance.new("Frame",card) kf.Size=UDim2.new(0.88,0,0,44) kf.Position=UDim2.new(0.06,0,0,214)
    kf.BackgroundColor3=Color3.fromRGB(12,16,46) kf.BorderSizePixel=0 kf.ZIndex=4 C(kf,9)
    G(kf,Color3.fromRGB(15,20,54),Color3.fromRGB(10,13,38),90)
    local ks=Instance.new("UIStroke",kf) ks.Color=Color3.fromRGB(42,56,125) ks.Thickness=1
    local kb=Instance.new("TextBox",kf) kb.Size=UDim2.new(1,-16,1,0) kb.Position=UDim2.fromOffset(12,0)
    kb.BackgroundTransparency=1 kb.PlaceholderText="Key hier eingeben..."
    kb.PlaceholderColor3=TXTM kb.Text="" kb.TextColor3=TXT
    kb.Font=Enum.Font.Gotham kb.TextSize=14 kb.ClearTextOnFocus=false kb.ZIndex=5
    kb.Focused:Connect(function() TW(ks,{Color=ACC,Thickness=1.6}) end)
    kb.FocusLost:Connect(function() TW(ks,{Color=Color3.fromRGB(42,56,125),Thickness=1}) end)
    -- Status
    local st2=Instance.new("TextLabel",card) st2.Size=UDim2.new(1,0,0,18) st2.Position=UDim2.fromOffset(0,266)
    st2.BackgroundTransparency=1 st2.Text="" st2.Font=Enum.Font.Gotham st2.TextSize=12
    st2.TextColor3=ERR st2.TextXAlignment=Enum.TextXAlignment.Center st2.ZIndex=4
    -- Confirm button
    local cf=Instance.new("TextButton",card) cf.Size=UDim2.new(0.88,0,0,46) cf.Position=UDim2.new(0.06,0,0,288)
    cf.BackgroundColor3=ACC cf.Text="Bestätigen" cf.TextColor3=Color3.new(1,1,1)
    cf.Font=Enum.Font.GothamBlack cf.TextSize=15 cf.BorderSizePixel=0 cf.ZIndex=4 C(cf,11) G(cf,ACCL,ACCD,90)
    cf.MouseEnter:Connect(function() TW(cf,{BackgroundColor3=ACCL}) end)
    cf.MouseLeave:Connect(function() TW(cf,{BackgroundColor3=ACC}) end)
    -- Animate in
    TW(card,{Position=UDim2.fromScale(0.5,0.5)},0.55,Enum.EasingStyle.Back)
    local function tryKey()
        if kb.Text==KEY_VALID then
            keySave(kb.Text) cf.Text="Zugang gewährt!" cf.BackgroundColor3=OK
            st2.TextColor3=OK st2.Text="Willkommen bei Splash Scripts!"
            task.delay(1.4,function()
                TW(card,{Position=UDim2.new(0.5,0,-0.85,0)},0.4,Enum.EasingStyle.Back)
                task.wait(0.46) pcall(function() bl:Destroy() end) sg:Destroy() onOK()
            end)
        else
            st2.Text="Falscher Key!  →  discord.gg/eyzfsAjpSr"
            TW(ks,{Color=ERR},0.1) task.delay(1.5,function() TW(ks,{Color=Color3.fromRGB(42,56,125)}) end)
        end
    end
    cf.MouseButton1Click:Connect(tryKey)
    kb.FocusLost:Connect(function(e) if e then tryKey() end end)
end

-- ════════════════════════════════════════════
-- MAIN UI
-- ════════════════════════════════════════════
local function loadMain()
    -- Notif GUI
    local ng=Instance.new("ScreenGui") ng.Name="SplNotif10" ng.ResetOnSpawn=false
    ng.IgnoreGuiInset=true ng.Parent=LP:WaitForChild("PlayerGui")
    NF=Instance.new("Frame",ng) NF.Name="F" NF.Size=UDim2.fromOffset(292,68)
    NF.Position=UDim2.new(1,-308,1,14) NF.BackgroundColor3=EL NF.BorderSizePixel=0 NF.ZIndex=200
    C(NF,10) G(NF,EL2,EL,135)
    Instance.new("UIStroke",NF).Color=ACC
    local nb=Instance.new("Frame",NF) nb.Size=UDim2.fromOffset(3,50) nb.Position=UDim2.fromOffset(0,9)
    nb.BackgroundColor3=ACC nb.BorderSizePixel=0 C(nb,2) G(nb,ACCL,ACCD,90)
    local nT=Instance.new("TextLabel",NF) nT.Name="T" nT.Size=UDim2.new(1,-18,0,24) nT.Position=UDim2.fromOffset(14,8)
    nT.BackgroundTransparency=1 nT.Text="" nT.TextColor3=TXT nT.Font=Enum.Font.GothamBold nT.TextSize=13 nT.TextXAlignment=Enum.TextXAlignment.Left
    local nM=Instance.new("TextLabel",NF) nM.Name="M" nM.Size=UDim2.new(1,-18,0,20) nM.Position=UDim2.fromOffset(14,32)
    nM.BackgroundTransparency=1 nM.Text="" nM.TextColor3=TXTD nM.Font=Enum.Font.Gotham nM.TextSize=11 nM.TextXAlignment=Enum.TextXAlignment.Left

    -- Main ScreenGui
    local sg=Instance.new("ScreenGui") sg.Name="SplUI10" sg.ResetOnSpawn=false
    sg.IgnoreGuiInset=true sg.ZIndexBehavior=Enum.ZIndexBehavior.Sibling sg.Parent=LP:WaitForChild("PlayerGui")

    -- Konstanten
    local W,H,TH,SW,BH = 578,398,42,144,48

    -- Fenster (kein separater Glow-Ring, kein leuchtender Rand)
    local win=Instance.new("Frame",sg) win.Size=UDim2.fromOffset(W,H)
    win.AnchorPoint=Vector2.new(0.5,0.5) win.Position=UDim2.fromScale(0.5,0.5)
    win.BackgroundColor3=BG win.BorderSizePixel=0 C(win,14)
    G(win,Color3.fromRGB(16,21,48),BG2,140)
    -- Dezenter Rand (kein Glow)
    local ws=Instance.new("UIStroke",win) ws.Color=Color3.fromRGB(38,52,115) ws.Thickness=1.2

    -- Top Bar
    local tb=Instance.new("Frame",win) tb.Size=UDim2.new(1,0,0,TH)
    tb.BackgroundColor3=Color3.fromRGB(16,21,50) tb.BorderSizePixel=0 C(tb,14)
    G(tb,Color3.fromRGB(20,26,60),Color3.fromRGB(12,17,44),90)
    -- Accent-Linie unter Topbar
    local tl2=Instance.new("Frame",win) tl2.Size=UDim2.new(1,0,0,1) tl2.Position=UDim2.fromOffset(0,TH)
    tl2.BackgroundColor3=ACC tl2.BorderSizePixel=0 G(tl2,ACCD,ACCL,0)

    -- Logo
    local logo=Instance.new("TextLabel",tb) logo.Size=UDim2.new(0,240,1,0) logo.Position=UDim2.fromOffset(16,0)
    logo.BackgroundTransparency=1 logo.Text="SPLASH SCRIPTS" logo.TextColor3=TXT
    logo.Font=Enum.Font.GothamBlack logo.TextSize=16 logo.TextXAlignment=Enum.TextXAlignment.Left
    local ver=Instance.new("TextLabel",tb) ver.Size=UDim2.new(0,50,1,0) ver.Position=UDim2.fromOffset(238,0)
    ver.BackgroundTransparency=1 ver.Text="v10" ver.TextColor3=TXTM ver.Font=Enum.Font.Gotham ver.TextSize=11 ver.TextXAlignment=Enum.TextXAlignment.Left

    -- Minimize button
    local minB=Instance.new("TextButton",tb) minB.Size=UDim2.fromOffset(28,28)
    minB.Position=UDim2.new(1,-38,0.5,-14) minB.BackgroundColor3=Color3.fromRGB(24,32,75)
    minB.Text="—" minB.TextColor3=TXTD minB.Font=Enum.Font.GothamBold minB.TextSize=14
    minB.BorderSizePixel=0 C(minB,6) minB.AutoButtonColor=false
    minB.MouseEnter:Connect(function() TW(minB,{BackgroundColor3=Color3.fromRGB(40,52,115),TextColor3=TXT}) end)
    minB.MouseLeave:Connect(function() TW(minB,{BackgroundColor3=Color3.fromRGB(24,32,75),TextColor3=TXTD}) end)

    -- Content area
    local content=Instance.new("Frame",win) content.Size=UDim2.new(1,0,1,-TH-1-BH)
    content.Position=UDim2.fromOffset(0,TH+1) content.BackgroundTransparency=1 content.BorderSizePixel=0

    -- Minimize / K
    local minimized=false
    local function doMin()
        minimized=not minimized
        if minimized then
            content.Visible=false minB.Text="+" TW(win,{Size=UDim2.fromOffset(W,TH)},0.18)
        else
            TW(win,{Size=UDim2.fromOffset(W,H)},0.18) minB.Text="—"
            task.delay(0.19,function() content.Visible=true end)
        end
    end
    minB.MouseButton1Click:Connect(doMin)
    UserInputService.InputBegan:Connect(function(i,g) if not g and i.KeyCode==Enum.KeyCode.K then doMin() end end)

    -- Drag (gesamtes Fenster)
    do
        local dr,ds,sp=false
        local function startDrag(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=true ds=i.Position sp=win.Position end end
        local function endDrag(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dr=false end end
        tb.InputBegan:Connect(startDrag) tb.InputEnded:Connect(endDrag)
        local ov=Instance.new("TextButton",win) ov.Size=UDim2.fromScale(1,1) ov.BackgroundTransparency=1
        ov.Text="" ov.ZIndex=0 ov.AutoButtonColor=false ov.InputBegan:Connect(startDrag) ov.InputEnded:Connect(endDrag)
        UserInputService.InputChanged:Connect(function(i)
            if dr and i.UserInputType==Enum.UserInputType.MouseMovement then
                local d=i.Position-ds win.Position=UDim2.new(sp.X.Scale,sp.X.Offset+d.X,sp.Y.Scale,sp.Y.Offset+d.Y)
            end
        end)
    end

    -- Sidebar
    local sb=Instance.new("Frame",content) sb.Size=UDim2.new(0,SW,1,0)
    sb.BackgroundColor3=SIDE sb.BorderSizePixel=0
    G(sb,Color3.fromRGB(12,16,42),Color3.fromRGB( 8,11,30),90)
    local sbln=Instance.new("Frame",sb) sbln.Size=UDim2.new(0,1,1,0) sbln.Position=UDim2.new(1,-1,0,0)
    sbln.BackgroundColor3=Color3.fromRGB(36,48,108) sbln.BorderSizePixel=0

    -- Panel
    local panel=Instance.new("Frame",content) panel.Size=UDim2.new(1,-SW,1,0)
    panel.Position=UDim2.fromOffset(SW,0) panel.BackgroundTransparency=1 panel.BorderSizePixel=0
    local pbg=Instance.new("Frame",panel) pbg.Size=UDim2.fromScale(1,1)
    pbg.BackgroundColor3=BG pbg.BorderSizePixel=0 pbg.ZIndex=0
    G(pbg,Color3.fromRGB(16,21,48),BG2,140)

    -- User bar (unten)
    local ubar=Instance.new("Frame",win) ubar.Size=UDim2.new(0,SW,0,BH) ubar.Position=UDim2.new(0,0,1,-BH)
    ubar.BackgroundColor3=Color3.fromRGB( 8,11,30) ubar.BorderSizePixel=0
    G(ubar,Color3.fromRGB(10,14,38),Color3.fromRGB(7,10,26),90)
    local ubln=Instance.new("Frame",ubar) ubln.Size=UDim2.new(1,0,0,1) ubln.BackgroundColor3=Color3.fromRGB(36,48,108) ubln.BorderSizePixel=0
    -- Avatar
    local av=Instance.new("ImageLabel",ubar) av.Size=UDim2.fromOffset(30,30) av.Position=UDim2.fromOffset(9,9)
    av.BackgroundColor3=Color3.fromRGB(18,24,58) av.BorderSizePixel=0 C(av,15)
    av.Image="rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=48&h=48"
    local unl=Instance.new("TextLabel",ubar) unl.Size=UDim2.new(1,-46,0,16) unl.Position=UDim2.fromOffset(44,8)
    unl.BackgroundTransparency=1 unl.Text=LP.Name unl.TextColor3=TXT
    unl.Font=Enum.Font.GothamBold unl.TextSize=11 unl.TextXAlignment=Enum.TextXAlignment.Left unl.TextTruncate=Enum.TextTruncate.AtEnd
    local udl=Instance.new("TextLabel",ubar) udl.Size=UDim2.new(1,-46,0,13) udl.Position=UDim2.fromOffset(44,26)
    udl.BackgroundTransparency=1 udl.Text=LP.DisplayName udl.TextColor3=TXTM
    udl.Font=Enum.Font.Gotham udl.TextSize=10 udl.TextXAlignment=Enum.TextXAlignment.Left udl.TextTruncate=Enum.TextTruncate.AtEnd

    -- ════════════════════════════════════
    -- TAB SYSTEM
    -- ════════════════════════════════════
    local tabs={} local active=nil local tabY=10

    local function mkTab(name)
        local btn=Instance.new("TextButton",sb) btn.Size=UDim2.new(1,0,0,38)
        btn.Position=UDim2.fromOffset(0,tabY) tabY=tabY+40
        btn.BackgroundColor3=SIDE btn.Text="" btn.BorderSizePixel=0 btn.AutoButtonColor=false
        local ag=Instance.new("Frame",btn) ag.Size=UDim2.fromScale(1,1) ag.BackgroundColor3=SAC
        ag.BorderSizePixel=0 ag.BackgroundTransparency=1 G(ag,Color3.fromRGB(30,40,100),SIDE,0)
        local ab=Instance.new("Frame",btn) ab.Size=UDim2.fromOffset(3,22) ab.Position=UDim2.new(0,0,0.5,-11)
        ab.BackgroundColor3=ACC ab.BorderSizePixel=0 C(ab,2) ab.BackgroundTransparency=1 G(ab,ACCL,ACCD,90)
        local lbl=Instance.new("TextLabel",btn) lbl.Size=UDim2.new(1,-18,1,0) lbl.Position=UDim2.fromOffset(14,0)
        lbl.BackgroundTransparency=1 lbl.Text=string.upper(name) lbl.TextColor3=TXTM
        lbl.Font=Enum.Font.GothamBlack lbl.TextSize=12 lbl.TextXAlignment=Enum.TextXAlignment.Left lbl.ZIndex=5

        local scroll=Instance.new("ScrollingFrame",panel) scroll.Size=UDim2.fromScale(1,1)
        scroll.BackgroundTransparency=1 scroll.BorderSizePixel=0 scroll.Visible=false
        scroll.ScrollBarThickness=3 scroll.ScrollBarImageColor3=ACC scroll.ZIndex=2
        local lay=Instance.new("UIListLayout",scroll) lay.Padding=UDim.new(0,6) lay.SortOrder=Enum.SortOrder.LayoutOrder
        local pad=Instance.new("UIPadding",scroll) pad.PaddingLeft=UDim.new(0,12) pad.PaddingRight=UDim.new(0,12) pad.PaddingTop=UDim.new(0,12)
        lay.Changed:Connect(function() scroll.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+24) end)

        local tab={scroll=scroll,btn=btn,lbl=lbl,bar=ab,glow=ag,order=1}
        tabs[name]=tab

        btn.MouseButton1Click:Connect(function()
            if active then
                local at=tabs[active] at.scroll.Visible=false at.lbl.TextColor3=TXTM
                TW(at.bar,{BackgroundTransparency=1}) TW(at.glow,{BackgroundTransparency=1}) TW(at.btn,{BackgroundColor3=SIDE})
            end
            active=name scroll.Visible=true
            TW(lbl,{TextColor3=TXT}) TW(ab,{BackgroundTransparency=0},0.15) TW(ag,{BackgroundTransparency=0.5},0.15) TW(btn,{BackgroundColor3=SAC})
        end)
        btn.MouseEnter:Connect(function() if active~=name then TW(btn,{BackgroundColor3=Color3.fromRGB(18,24,56)}) TW(lbl,{TextColor3=TXTD}) end end)
        btn.MouseLeave:Connect(function() if active~=name then TW(btn,{BackgroundColor3=SIDE}) TW(lbl,{TextColor3=TXTM}) end end)
        return tab
    end

    -- ════════════════════════════════════
    -- ELEMENT BUILDERS
    -- ════════════════════════════════════
    local function mkSec(tab,txt)
        local f=Instance.new("Frame",tab.scroll) f.Size=UDim2.new(1,0,0,24)
        f.BackgroundTransparency=1 f.LayoutOrder=tab.order tab.order=tab.order+1
        local l=Instance.new("TextLabel",f) l.Size=UDim2.fromScale(1,1) l.BackgroundTransparency=1
        l.Text=string.upper(txt) l.TextColor3=ACC l.Font=Enum.Font.GothamBlack l.TextSize=11 l.TextXAlignment=Enum.TextXAlignment.Left
        local ln=Instance.new("Frame",f) ln.Size=UDim2.new(1,0,0,1) ln.Position=UDim2.new(0,0,1,-1)
        ln.BackgroundColor3=Color3.fromRGB(36,48,108) ln.BorderSizePixel=0 G(ln,ACC,Color3.fromRGB(16,22,58),0)
    end

    local function mkBtn(tab,txt,cb)
        local f=Instance.new("TextButton",tab.scroll) f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=EL f.Text="" f.BorderSizePixel=0 f.AutoButtonColor=false
        f.LayoutOrder=tab.order tab.order=tab.order+1 C(f,8) G(f,EL2,EL,90)
        local l=Instance.new("TextLabel",f) l.Size=UDim2.new(1,-16,1,0) l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1 l.Text=txt l.TextColor3=TXT l.Font=Enum.Font.GothamBlack l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left
        f.MouseEnter:Connect(function() TW(f,{BackgroundColor3=ELH}) end)
        f.MouseLeave:Connect(function() TW(f,{BackgroundColor3=EL}) end)
        f.MouseButton1Click:Connect(function() TW(f,{BackgroundColor3=ACC},0.08) task.delay(0.15,function() TW(f,{BackgroundColor3=EL}) end) cb() end)
    end

    local function mkTog(tab,txt,def,cb)
        local f=Instance.new("Frame",tab.scroll) f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=EL f.BorderSizePixel=0 f.LayoutOrder=tab.order tab.order=tab.order+1 C(f,8) G(f,EL2,EL,90)
        local l=Instance.new("TextLabel",f) l.Size=UDim2.new(1,-58,1,0) l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1 l.Text=txt l.TextColor3=TXT l.Font=Enum.Font.GothamBlack l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left
        local val=def
        local tr=Instance.new("Frame",f) tr.Size=UDim2.fromOffset(36,20) tr.Position=UDim2.new(1,-46,0.5,-10)
        tr.BackgroundColor3=val and TON or TOFF tr.BorderSizePixel=0 C(tr,10)
        local kn=Instance.new("Frame",tr) kn.Size=UDim2.fromOffset(16,16) kn.Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)
        kn.BackgroundColor3=Color3.new(1,1,1) kn.BorderSizePixel=0 C(kn,8)
        local ov=Instance.new("TextButton",f) ov.Size=UDim2.fromScale(1,1) ov.BackgroundTransparency=1 ov.Text="" ov.ZIndex=5
        ov.MouseButton1Click:Connect(function()
            val=not val cb(val)
            TW(tr,{BackgroundColor3=val and TON or TOFF}) TW(kn,{Position=val and UDim2.fromOffset(18,2) or UDim2.fromOffset(2,2)})
        end)
        return {get=function() return val end}
    end

    local function mkSld(tab,txt,mn,mx,def,cb)
        local f=Instance.new("Frame",tab.scroll) f.Size=UDim2.new(1,0,0,52)
        f.BackgroundColor3=EL f.BorderSizePixel=0 f.LayoutOrder=tab.order tab.order=tab.order+1 C(f,8) G(f,EL2,EL,90)
        local l=Instance.new("TextLabel",f) l.Size=UDim2.new(1,-66,0,22) l.Position=UDim2.fromOffset(14,7)
        l.BackgroundTransparency=1 l.Text=txt l.TextColor3=TXT l.Font=Enum.Font.GothamBlack l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left
        local vl=Instance.new("TextLabel",f) vl.Size=UDim2.fromOffset(58,22) vl.Position=UDim2.new(1,-64,0,7)
        vl.BackgroundTransparency=1 vl.Text=tostring(def) vl.TextColor3=ACCL vl.Font=Enum.Font.GothamBold vl.TextSize=13 vl.TextXAlignment=Enum.TextXAlignment.Right
        local tr=Instance.new("Frame",f) tr.Size=UDim2.new(1,-24,0,6) tr.Position=UDim2.new(0,12,1,-15)
        tr.BackgroundColor3=SBG tr.BorderSizePixel=0 C(tr,3)
        local fi=Instance.new("Frame",tr) fi.Size=UDim2.new((def-mn)/(mx-mn),0,1,0)
        fi.BackgroundColor3=ACC fi.BorderSizePixel=0 C(fi,3) G(fi,ACC,ACCL,0)
        local hd=Instance.new("Frame",tr) hd.Size=UDim2.fromOffset(14,14) hd.Position=UDim2.new((def-mn)/(mx-mn),0,0.5,-7)
        hd.BackgroundColor3=Color3.new(1,1,1) hd.BorderSizePixel=0 C(hd,7)
        local curVal=def local drag=false
        local function upd(x)
            local pct=math.clamp((x-tr.AbsolutePosition.X)/tr.AbsoluteSize.X,0,1)
            curVal=math.floor(mn+(mx-mn)*pct)
            fi.Size=UDim2.new(pct,0,1,0) hd.Position=UDim2.new(pct,0,0.5,-7)
            vl.Text=tostring(curVal) cb(curVal)
        end
        tr.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=true upd(i.Position.X) end end)
        UserInputService.InputChanged:Connect(function(i) if drag and i.UserInputType==Enum.UserInputType.MouseMovement then upd(i.Position.X) end end)
        UserInputService.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then drag=false end end)
        return {get=function() return curVal end}
    end

    local function mkKB(tab,txt,def,cb)
        local cur=Enum.KeyCode[def] or Enum.KeyCode.F
        local f=Instance.new("Frame",tab.scroll) f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=EL f.BorderSizePixel=0 f.LayoutOrder=tab.order tab.order=tab.order+1 C(f,8) G(f,EL2,EL,90)
        local l=Instance.new("TextLabel",f) l.Size=UDim2.new(1,-92,1,0) l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1 l.Text=txt l.TextColor3=TXT l.Font=Enum.Font.GothamBlack l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left
        local kb=Instance.new("TextButton",f) kb.Size=UDim2.fromOffset(76,24) kb.Position=UDim2.new(1,-84,0.5,-12)
        kb.BackgroundColor3=ACCD kb.Text="["..def.."]" kb.TextColor3=TXT kb.Font=Enum.Font.GothamBold kb.TextSize=11 kb.BorderSizePixel=0 C(kb,6) G(kb,ACC,ACCD,90)
        local lst=false
        kb.MouseButton1Click:Connect(function() lst=true kb.Text="[...]" kb.BackgroundColor3=ACC end)
        UserInputService.InputBegan:Connect(function(i,g)
            if g then return end
            if lst then lst=false cur=i.KeyCode kb.Text="["..i.KeyCode.Name.."]" kb.BackgroundColor3=ACCD
            elseif i.KeyCode==cur then cb() end
        end)
    end

    local function mkDrop(tab,txt,opts,cb)
        local val=opts[1] or ""
        local f=Instance.new("Frame",tab.scroll) f.Size=UDim2.new(1,0,0,34)
        f.BackgroundColor3=EL f.BorderSizePixel=0 f.LayoutOrder=tab.order tab.order=tab.order+1 C(f,8) G(f,EL2,EL,90)
        local l=Instance.new("TextLabel",f) l.Size=UDim2.new(1,-196,1,0) l.Position=UDim2.fromOffset(14,0)
        l.BackgroundTransparency=1 l.Text=txt l.TextColor3=TXT l.Font=Enum.Font.GothamBlack l.TextSize=13 l.TextXAlignment=Enum.TextXAlignment.Left
        local db=Instance.new("TextButton",f) db.Size=UDim2.fromOffset(172,24) db.Position=UDim2.new(1,-180,0.5,-12)
        db.BackgroundColor3=SBG db.Text=val db.TextColor3=TXT db.Font=Enum.Font.Gotham db.TextSize=12 db.BorderSizePixel=0 C(db,6)
        local open=false local dF
        db.MouseButton1Click:Connect(function()
            open=not open
            if open then
                dF=Instance.new("Frame",sg) dF.ZIndex=300 dF.Size=UDim2.fromOffset(200,math.min(#opts,7)*36+6)
                local ap=db.AbsolutePosition dF.Position=UDim2.fromOffset(ap.X-30,ap.Y+28)
                dF.BackgroundColor3=Color3.fromRGB(14,19,50) dF.BorderSizePixel=0 C(dF,9)
                local ds2=Instance.new("UIStroke",dF) ds2.Color=ACC ds2.Thickness=1
                local dll=Instance.new("UIListLayout",dF) dll.SortOrder=Enum.SortOrder.LayoutOrder
                local dp=Instance.new("UIPadding",dF) dp.PaddingTop=UDim.new(0,3) dp.PaddingBottom=UDim.new(0,3)
                for i,o in ipairs(opts) do
                    local ob=Instance.new("TextButton",dF) ob.Size=UDim2.new(1,0,0,34)
                    ob.BackgroundColor3=Color3.fromRGB(14,19,50) ob.Text="" ob.BorderSizePixel=0 ob.LayoutOrder=i
                    -- Avatar
                    local pp=Players:FindFirstChild(o)
                    if pp then
                        local ai=Instance.new("ImageLabel",ob) ai.Size=UDim2.fromOffset(24,24) ai.Position=UDim2.fromOffset(8,5)
                        ai.BackgroundTransparency=1 ai.Image="rbxthumb://type=AvatarHeadShot&id="..pp.UserId.."&w=48&h=48" C(ai,12)
                    end
                    local ol=Instance.new("TextLabel",ob) ol.Size=UDim2.new(1,-44,1,0) ol.Position=UDim2.fromOffset(40,0)
                    ol.BackgroundTransparency=1 ol.Text=o ol.TextColor3=o==val and ACCL or TXT
                    ol.Font=Enum.Font.GothamBold ol.TextSize=12 ol.TextXAlignment=Enum.TextXAlignment.Left
                    ob.MouseEnter:Connect(function() TW(ob,{BackgroundColor3=ELH}) end)
                    ob.MouseLeave:Connect(function() TW(ob,{BackgroundColor3=Color3.fromRGB(14,19,50)}) end)
                    ob.MouseButton1Click:Connect(function()
                        val=o db.Text=o cb(o) if dF then dF:Destroy() dF=nil end open=false
                    end)
                end
            else if dF then dF:Destroy() dF=nil end end
        end)
        cb(val)
        return {get=function() return val end}
    end

    -- ════════════════════════════════════
    -- FLY TAB
    -- ════════════════════════════════════
    local flyTab=mkTab("Fly")
    local flyOn=false local flySpd=80
    local flyConn local flyBV local flyBG

    local function flyClean()
        flyOn=false
        if flyConn then flyConn:Disconnect() flyConn=nil end
        if flyBV then flyBV:Destroy() flyBV=nil end
        if flyBG then flyBG:Destroy() flyBG=nil end
        local h=hum() if h then h.PlatformStand=false end
        local c=char() if not c then return end
        local t=c:FindFirstChild("Torso")
        if t then
            local rs=t:FindFirstChild("Right Shoulder") local ls=t:FindFirstChild("Left Shoulder")
            local rh=t:FindFirstChild("Right Hip") local lh=t:FindFirstChild("Left Hip") local nk=t:FindFirstChild("Neck")
            if rs then rs.C0=CFrame.new(1,0.5,0,0,0,1,0,1,0,-1,0,0) end
            if ls then ls.C0=CFrame.new(-1,0.5,0,0,0,-1,0,1,0,1,0,0) end
            if rh then rh.C0=CFrame.new(1,-1,0,0,0,1,0,1,0,-1,0,0) end
            if lh then lh.C0=CFrame.new(-1,-1,0,0,0,-1,0,1,0,1,0,0) end
            if nk then nk.C0=CFrame.new(0,1,0) end
        end
        task.delay(0.1,function() local h2=hum() if h2 then h2:ChangeState(Enum.HumanoidStateType.GettingUp) end end)
    end

    local function flyStart()
        local r=hrp() local h=hum() if not r or not h then return end
        flyClean() flyOn=true h.PlatformStand=true
        flyBV=Instance.new("BodyVelocity") flyBV.MaxForce=Vector3.new(1e9,1e9,1e9) flyBV.Velocity=Vector3.zero flyBV.Parent=r
        flyBG=Instance.new("BodyGyro") flyBG.MaxTorque=Vector3.new(1e9,1e9,1e9) flyBG.D=50 flyBG.P=1200 flyBG.Parent=r
        -- Pose
        task.spawn(function()
            task.wait(0.1) local c=char() if not c then return end
            local t=c:FindFirstChild("Torso") local ut=c:FindFirstChild("UpperTorso")
            if t then
                local rs=t:FindFirstChild("Right Shoulder") local ls=t:FindFirstChild("Left Shoulder")
                local rh=t:FindFirstChild("Right Hip") local lh=t:FindFirstChild("Left Hip") local nk=t:FindFirstChild("Neck")
                if rs then rs.C0=CFrame.new(1,0.5,0)*CFrame.Angles(0,math.rad(90),math.rad(-90)) end
                if ls then ls.C0=CFrame.new(-1,0.5,0)*CFrame.Angles(0,-math.rad(90),math.rad(90)) end
                if rh then rh.C0=CFrame.new(1,-1,0)*CFrame.Angles(0,math.rad(90),math.rad(90)) end
                if lh then lh.C0=CFrame.new(-1,-1,0)*CFrame.Angles(0,-math.rad(90),math.rad(-90)) end
                if nk then nk.C0=CFrame.new(0,1,0)*CFrame.Angles(math.rad(30),0,0) end
            elseif ut then
                local lt=char():FindFirstChild("LowerTorso")
                local function gm(p,n) if not p then return nil end for _,v in ipairs(p:GetDescendants()) do if v:IsA("Motor6D") and v.Name==n then return v end end end
                local rs=gm(ut,"RightShoulder") local ls=gm(ut,"LeftShoulder") local rh=gm(lt,"RightHip") local lh=gm(lt,"LeftHip") local nk=gm(ut,"Neck")
                if rs then rs.C0=CFrame.Angles(math.rad(-90),0,0) end
                if ls then ls.C0=CFrame.Angles(math.rad(50),0,0) end
                if rh then rh.C0=CFrame.Angles(math.rad(15),0,0) end
                if lh then lh.C0=CFrame.Angles(math.rad(15),0,0) end
                if nk then nk.C0=CFrame.Angles(math.rad(25),0,0) end
            end
        end)
        flyConn=RunService.Heartbeat:Connect(function()
            if not flyOn then flyClean() return end
            local r2=hrp() if not r2 then flyClean() return end
            local dir=Vector3.zero local cf=Cam.CFrame
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir+=cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir-=cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir-=cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir+=cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir+=Vector3.new(0,1,0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir-=Vector3.new(0,1,0) end
            local boost=UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) and 4 or 1
            -- flySpd wird live benutzt — kein fix auf 80
            if dir.Magnitude>0 then
                flyBV.Velocity=dir.Unit*(flySpd*boost)
                flyBG.CFrame=flyBG.CFrame:Lerp(CFrame.new(r2.Position,r2.Position+dir.Unit)*CFrame.Angles(-math.rad(72),0,0),0.12)
            else
                flyBV.Velocity=Vector3.zero
                flyBG.CFrame=flyBG.CFrame:Lerp(CFrame.new(r2.Position,r2.Position+cf.LookVector)*CFrame.Angles(-math.rad(15),0,0),0.08)
            end
        end)
    end

    mkTog(flyTab,"Fly aktivieren",false,"Fly",function(v) if v then flyStart() else flyClean() end end)
    mkSld(flyTab,"Fly Speed",10,600,80,"FS",function(v) flySpd=v end)   -- direkt flySpd setzen
    mkKB(flyTab,"Fly Keybind","F",function() if flyOn then flyClean() else flyStart() end end)
    local fi2=Instance.new("Frame",flyTab.scroll) fi2.Size=UDim2.new(1,0,0,42) fi2.BackgroundColor3=EL
    fi2.BorderSizePixel=0 fi2.LayoutOrder=flyTab.order flyTab.order=flyTab.order+1 C(fi2,8) G(fi2,EL2,EL,90)
    local fl2=Instance.new("TextLabel",fi2) fl2.Size=UDim2.new(1,-16,1,0) fl2.Position=UDim2.fromOffset(12,0)
    fl2.BackgroundTransparency=1 fl2.TextColor3=TXTD fl2.Font=Enum.Font.Gotham fl2.TextSize=11 fl2.TextWrapped=true fl2.TextXAlignment=Enum.TextXAlignment.Left
    fl2.Text="W/A/S/D  ·  Space = hoch  ·  Shift = runter  ·  Strg = 4× Speed\nK = minimize  ·  Superman-Pose (R6 & R15)"

    -- ════════════════════════════════════
    -- FUN TAB
    -- ════════════════════════════════════
    local funTab=mkTab("Fun")
    local selP=plist()[1] or ""

    -- Orbit
    local orbitOn=false local orbitConn local orbitBP local orbitBV2
    local function orbitStop()
        orbitOn=false
        if orbitConn then orbitConn:Disconnect() orbitConn=nil end
        if orbitBP then orbitBP:Destroy() orbitBP=nil end
        if orbitBV2 then orbitBV2:Destroy() orbitBV2=nil end
    end

    -- Head sit
    local headConn local headBP local headBG2
    local function headStop()
        if headConn then headConn:Disconnect() headConn=nil end
        if headBP then headBP:Destroy() headBP=nil end
        if headBG2 then headBG2:Destroy() headBG2=nil end
        local h=hum() if h then h.PlatformStand=false end
    end

    -- Inf Jump connection
    local ijConn
    -- Noclip connection
    local ncConn

    -- Player dropdown
    mkDrop(funTab,"Spieler",plist(),function(v) selP=v end)
    mkBtn(funTab,"Liste aktualisieren",function()
        selP=plist()[1] or "" notify("OK","Spielerliste aktualisiert.")
    end)

    mkSec(funTab,"Fling & Teleport")
    mkBtn(funTab,"Spieler flingen",function()
        local _,tc=ptarget(selP) if not tc then notify("Fehler","Spieler nicht gefunden!",ERR) return end
        local r2=tc:FindFirstChild("HumanoidRootPart") if not r2 then return end
        for i=1,10 do task.delay(i*0.01,function()
            local f=Instance.new("BodyVelocity") f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)) f.Parent=r2
            game:GetService("Debris"):AddItem(f,0.1)
        end) end
        notify("Fling",selP.." geflingt!",OK)
    end)
    mkBtn(funTab,"Alle flingen",function()
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local r2=p.Character:FindFirstChild("HumanoidRootPart") if not r2 then continue end
            local f=Instance.new("BodyVelocity") f.MaxForce=Vector3.new(1e9,1e9,1e9)
            f.Velocity=Vector3.new(math.random(-600,600),1000,math.random(-600,600)) f.Parent=r2
            game:GetService("Debris"):AddItem(f,0.1)
        end end
        notify("Fling","Alle geflingt!",OK)
    end)
    mkBtn(funTab,"Orbit Fling (kreisen)",function()
        local _,tc=ptarget(selP) if not tc then notify("Fehler","Spieler nicht gefunden!",ERR) return end
        local myR=hrp() if not myR then return end
        if orbitOn then orbitStop() notify("Orbit","Orbit gestoppt.") return end
        orbitOn=true
        local ang=0 local hOsc=0
        orbitBV2=Instance.new("BodyVelocity") orbitBV2.MaxForce=Vector3.new(1e9,1e9,1e9) orbitBV2.Velocity=Vector3.zero orbitBV2.Parent=myR
        orbitBP=Instance.new("BodyPosition") orbitBP.MaxForce=Vector3.new(1e9,1e9,1e9) orbitBP.D=600 orbitBP.P=12000 orbitBP.Parent=myR
        notify("Orbit","Orbit gestartet! Nochmal klicken = stopp.")
        orbitConn=RunService.Heartbeat:Connect(function(dt)
            if not orbitOn then orbitStop() return end
            local _,tc2=ptarget(selP) if not tc2 then orbitStop() return end
            local tr2=tc2:FindFirstChild("HumanoidRootPart") if not tr2 then return end
            ang=ang+dt*2.5 hOsc=hOsc+dt*1.4
            orbitBP.Position=tr2.Position+Vector3.new(math.cos(ang)*9,math.sin(hOsc)*7+5,math.sin(ang)*9)
        end)
    end)
    mkBtn(funTab,"Orbit stoppen",function() orbitStop() notify("OK","Orbit gestoppt.") end)
    mkBtn(funTab,"Zu Spieler TP",function()
        local _,tc=ptarget(selP) if not tc then return end
        local th,mh=tc:FindFirstChild("HumanoidRootPart"),hrp() if th and mh then mh.CFrame=th.CFrame*CFrame.new(3,0,0) end
    end)
    mkBtn(funTab,"Spieler zu mir TP",function()
        local _,tc=ptarget(selP) if not tc then return end
        local th,mh=tc:FindFirstChild("HumanoidRootPart"),hrp() if th and mh then th.CFrame=mh.CFrame*CFrame.new(3,0,0) end
    end)
    mkBtn(funTab,"Auf Kopf sitzen",function()
        headStop()
        local _,tc=ptarget(selP) if not tc then notify("Fehler","Spieler nicht gefunden!",ERR) return end
        local head=tc:FindFirstChild("Head") local myR=hrp() local myH=hum()
        if not head or not myR or not myH then return end
        myH.PlatformStand=true
        headBP=Instance.new("BodyPosition") headBP.MaxForce=Vector3.new(1e9,1e9,1e9) headBP.D=900 headBP.P=16000 headBP.Parent=myR
        headBG2=Instance.new("BodyGyro") headBG2.MaxTorque=Vector3.new(1e9,1e9,1e9) headBG2.D=120 headBG2.P=1200 headBG2.Parent=myR
        notify("Sitzen","Auf "..selP.."s Kopf! [Kopf verlassen] zum Stoppen.")
        headConn=RunService.Heartbeat:Connect(function()
            if not head or not head.Parent then headStop() return end
            headBP.Position=head.Position+Vector3.new(0,3.3,0)
            headBG2.CFrame=head.CFrame
        end)
    end)
    mkBtn(funTab,"Kopf verlassen",function() headStop() notify("OK","Kopf verlassen.") end)
    mkBtn(funTab,"Hochkatapultieren",function()
        local _,tc=ptarget(selP) if not tc then return end
        local r2=tc:FindFirstChild("HumanoidRootPart") if not r2 then return end
        local bv2=Instance.new("BodyVelocity") bv2.MaxForce=Vector3.new(0,1e9,0) bv2.Velocity=Vector3.new(0,2800,0) bv2.Parent=r2
        game:GetService("Debris"):AddItem(bv2,0.25)
    end)
    mkBtn(funTab,"Einfrieren",function()
        local _,tc=ptarget(selP) if not tc then return end
        local hm=tc:FindFirstChild("Humanoid") if not hm then return end
        local fr=hm.WalkSpeed==0 hm.WalkSpeed=fr and 16 or 0 hm.JumpPower=fr and 50 or 0
        notify("Freeze",selP..(fr and " freigegeben" or " eingefroren"))
    end)
    mkBtn(funTab,"Spin",function()
        local _,tc=ptarget(selP) if not tc then return end
        local r2=tc:FindFirstChild("HumanoidRootPart") if not r2 then return end
        task.spawn(function() for i=1,120 do r2.CFrame=r2.CFrame*CFrame.Angles(0,math.rad(18),0) task.wait(0.01) end end)
    end)
    mkBtn(funTab,"Alle zu mir TP",function()
        local mh=hrp() if not mh then return end
        for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then
            local r2=p.Character:FindFirstChild("HumanoidRootPart")
            if r2 then r2.CFrame=mh.CFrame*CFrame.new(math.random(-5,5),0,math.random(-5,5)) end
        end end
    end)

    mkSec(funTab,"Speed & Movement")
    mkTog(funTab,"Super Speed",false,"SS",function(v) local h=hum() if h then h.WalkSpeed=v and 120 or 16 end end)
    mkSld(funTab,"Walk Speed",16,500,16,"WS",function(v) local h=hum() if h then h.WalkSpeed=v end end)
    mkTog(funTab,"Inf Jump",false,"IJ",function(v)
        if v then ijConn=UserInputService.JumpRequest:Connect(function() local h=hum() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end)
        else if ijConn then ijConn:Disconnect() ijConn=nil end end
    end)
    mkSld(funTab,"Jump Power",50,500,50,"JP",function(v) local h=hum() if h then h.JumpPower=v end end)
    mkTog(funTab,"Noclip",false,"NC",function(v)
        if v then ncConn=RunService.Stepped:Connect(function()
            local c=char() if not c then return end
            for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end
        end) else if ncConn then ncConn:Disconnect() ncConn=nil end end
    end)
    mkTog(funTab,"Unsichtbar",false,"IV",function(v)
        local c=char() if not c then return end
        for _,p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") or p:IsA("Decal") then p.Transparency=v and 1 or 0 end end
    end)

    mkSec(funTab,"Outfit")
    mkBtn(funTab,"Outfit klauen",function()
        local tp=ptarget(selP) if not tp then notify("Fehler","Spieler nicht gefunden!",ERR) return end
        local h=hum() if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(tp.UserId)) end
        notify("Outfit","Outfit von "..selP.." geklaut!",OK)
    end)
    mkBtn(funTab,"Eigenes Outfit zurück",function()
        local h=hum() if h then h:ApplyDescription(Players:GetHumanoidDescriptionFromUserId(LP.UserId)) end
    end)
    mkBtn(funTab,"Riesenkopf",function()
        local _,tc=ptarget(selP) if not tc then return end
        local hd=tc:FindFirstChild("Head") if hd then hd.Size=Vector3.new(6,6,6) end
    end)

    -- ════════════════════════════════════
    -- ESP TAB
    -- ════════════════════════════════════
    local espTab=mkTab("ESP")
    local espOn=false local espHL={} local espFill=0.5 local espWalls=true
    local function espRem() for _,h in pairs(espHL) do pcall(function() h:Destroy() end) end espHL={} end
    local function espAdd(c,n)
        local h=Instance.new("Highlight") h.FillColor=ACC h.OutlineColor=Color3.new(1,1,1)
        h.FillTransparency=espFill h.OutlineTransparency=0
        h.DepthMode=espWalls and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded
        h.Parent=c espHL[n]=h
    end
    local function espBld() espRem() for _,p in ipairs(Players:GetPlayers()) do if p~=LP and p.Character then espAdd(p.Character,p.Name) end end end
    mkTog(espTab,"ESP aktivieren",false,"ESP",function(v) espOn=v if v then espBld() else espRem() end end)
    mkSld(espTab,"Transparenz",0,10,5,"EA",function(v) espFill=v/10 for _,h in pairs(espHL) do if h then h.FillTransparency=espFill end end end)
    mkTog(espTab,"Durch Wände",true,"EW",function(v) espWalls=v for _,h in pairs(espHL) do if h then h.DepthMode=v and Enum.HighlightDepthMode.AlwaysOnTop or Enum.HighlightDepthMode.Occluded end end end)
    mkBtn(espTab,"ESP aktualisieren",function() if espOn then espBld() end end)
    Players.PlayerAdded:Connect(function(p) p.CharacterAdded:Connect(function(c) if espOn then task.wait(1) espAdd(c,p.Name) end end) end)
    Players.PlayerRemoving:Connect(function(p) if espHL[p.Name] then pcall(function() espHL[p.Name]:Destroy() end) espHL[p.Name]=nil end end)

    -- ════════════════════════════════════
    -- WORLD TAB
    -- ════════════════════════════════════
    local worldTab=mkTab("World")
    mkTog(worldTab,"Fullbright",false,"FB",function(v) Lighting.Brightness=v and 10 or 2 Lighting.GlobalShadows=not v Lighting.FogEnd=v and 1e9 or 1e5 end)
    mkSld(worldTab,"Helligkeit",0,10,2,"BR",function(v) Lighting.Brightness=v end)
    mkSld(worldTab,"Uhrzeit",0,24,14,"CL",function(v) Lighting.ClockTime=v end)
    mkTog(worldTab,"Fog entfernen",false,"NF",function(v) Lighting.FogEnd=v and 1e9 or 1e5 Lighting.FogStart=v and 1e9 or 0 end)
    mkSld(worldTab,"Gravity",0,400,196,"GV",function(v) workspace.Gravity=v end)
    mkTog(worldTab,"Anti-Gravity",false,"AG",function(v) workspace.Gravity=v and 0 or 196 end)

    -- ════════════════════════════════════
    -- PLAYER TAB
    -- ════════════════════════════════════
    local plTab=mkTab("Player")
    mkTog(plTab,"God Mode",false,"GM",function(v) local h=hum() if h then h.MaxHealth=v and math.huge or 100 h.Health=v and math.huge or 100 end end)
    mkTog(plTab,"Auto-Heal",false,"AH",function(v) if v then task.spawn(function() while v do local h=hum() if h then h.Health=h.MaxHealth end task.wait(0.1) end end) end end)
    mkSld(plTab,"HP setzen",1,1000,100,"HP",function(v) local h=hum() if h then h.Health=v end end)
    mkBtn(plTab,"Respawn",function() LP:LoadCharacter() end)
    mkSld(plTab,"FOV",30,120,70,"FOV",function(v) Cam.FieldOfView=v end)

    -- ════════════════════════════════════
    -- SETTINGS TAB
    -- ════════════════════════════════════
    local setTab=mkTab("Settings")
    local ib=Instance.new("Frame",setTab.scroll) ib.Size=UDim2.new(1,0,0,90) ib.BackgroundColor3=EL
    ib.BorderSizePixel=0 ib.LayoutOrder=setTab.order setTab.order=setTab.order+1 C(ib,8) G(ib,EL2,EL,90)
    local il3=Instance.new("TextLabel",ib) il3.Size=UDim2.new(1,-16,1,0) il3.Position=UDim2.fromOffset(12,0)
    il3.BackgroundTransparency=1 il3.TextColor3=TXTD il3.Font=Enum.Font.Gotham il3.TextSize=11 il3.TextWrapped=true il3.TextXAlignment=Enum.TextXAlignment.Left
    il3.Text="Splash Scripts v10.0  —  German Voice Edition\nKey: SplashScripts2026!\nDiscord: discord.gg/eyzfsAjpSr\nFly: W/A/S/D · Space · Shift · Strg=4× · K=toggle"
    mkBtn(setTab,"Discord kopieren",function() pcall(function() setclipboard(KEY_DISCORD) end) notify("Discord","Link kopiert!",OK) end)
    mkBtn(setTab,"Key zurücksetzen",function() pcall(function() delfile(KEY_FILE) end) notify("Key","Key gelöscht.") end)

    -- Ersten Tab aktivieren
    flyTab.btn.MouseButton1Click:Fire()

    -- Einfahren
    win.Position=UDim2.new(0.5,0,1.7,0)
    TW(win,{Position=UDim2.fromScale(0.5,0.5)},0.6,Enum.EasingStyle.Back)
    task.delay(0.85,function() notify("Splash Scripts v10.0","Geladen! Viel Spaß 🎮",OK) end)
end

-- ════════════════════════════════════════════
-- START
-- ════════════════════════════════════════════
if keyLoad()==KEY_VALID then
    task.spawn(loadMain)
else
    task.spawn(function() showKey(loadMain) end)
end
