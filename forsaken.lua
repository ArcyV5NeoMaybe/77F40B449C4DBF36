local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Bugsaken",
    LoadingTitle = "Rayfield Library",
    LoadingSubtitle = "by sirius",
    ConfigurationSaving = {
        Enabled = false,
        FolderName = "MyHub",
        FileName = "Config"
    },

    Discord = {
        Enabled = false,
        Invite = "",
        RememberJoins = false
    },

    KeySystem = false
})

local Main = Window:CreateTab("Main", 4483362458)  -- ใช้ ID icon ที่พี่กำหนด

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local sprintModule = nil
local function findModule()
    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "StaminaLossDisabled") ~= nil and rawget(v, "Stamina") and rawget(v, "MaxStamina") then
            return v
        end
    end
end
while not sprintModule do
    sprintModule = findModule()
    task.wait(0.5)
end

local function enableInfiniteStamina()
    task.spawn(function()
        while _G.InfiniteStamina do
            pcall(function()
                sprintModule.StaminaLossDisabled = true
                sprintModule.Stamina = sprintModule.MaxStamina
                sprintModule.timeUntilStaminaRecovers = 0
            end)
            task.wait(0.3)
        end
    end)
end

Main:CreateToggle({
    Name = "Infinite Stamina",
    CurrentValue = false,
    Callback = function(Value)
        _G.InfiniteStamina = Value
        if Value then
            enableInfiniteStamina()
        else
            pcall(function()
                sprintModule.StaminaLossDisabled = false
            end)
        end
    end
})

local graffitiTarget = nil
local graffitiHighlight = nil
local graffitiBillboard = nil
local function startGraffitiESP()
    if graffitiHighlight then return end
    local map = workspace:FindFirstChild("Map")
    local ingame = map and map:FindFirstChild("Ingame")
    graffitiTarget = ingame and ingame:FindFirstChild("GraffitiCL")
    if not graffitiTarget then return end
    graffitiHighlight = Instance.new("Highlight")
    graffitiHighlight.Name = "ESP_VeeGraffiti_Highlight"
    graffitiHighlight.FillColor = Color3.fromRGB(255, 105, 180)
    graffitiHighlight.FillTransparency = 0.3
    graffitiHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    graffitiHighlight.OutlineTransparency = 0.5
    graffitiHighlight.Enabled = false
    graffitiHighlight.Parent = graffitiTarget
    graffitiBillboard = Instance.new("BillboardGui")
    graffitiBillboard.Name = "ESP_VeeGraffiti_Billboard"
    graffitiBillboard.Size = UDim2.new(0, 200, 0, 40)
    graffitiBillboard.StudsOffset = Vector3.new(0, 2, 0)
    graffitiBillboard.AlwaysOnTop = true
    graffitiBillboard.Enabled = false
    graffitiBillboard.Parent = graffitiTarget
    local nameLabel = Instance.new("TextLabel", graffitiBillboard)
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(255, 105, 180)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Text = "VeeGraffiti"
    local distLabel = Instance.new("TextLabel", graffitiBillboard)
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0.5
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 12
end

Main:CreateToggle({
    Name = "Veeronica Graffiti ESP",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            if not graffitiHighlight then startGraffitiESP() end
            if graffitiHighlight then graffitiHighlight.Enabled = true end
            if graffitiBillboard then graffitiBillboard.Enabled = true end
        else
            if graffitiHighlight then graffitiHighlight.Enabled = false end
            if graffitiBillboard then graffitiBillboard.Enabled = false end
        end
    end,
})

task.spawn(function()
    while true do
        if graffitiHighlight and graffitiTarget and graffitiTarget.Parent then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local dist = (character.HumanoidRootPart.Position - graffitiTarget.Position).Magnitude
                if dist <= 650 then
                    if graffitiBillboard then
                        graffitiBillboard.Enabled = graffitiHighlight.Enabled
                        local distLabel = graffitiBillboard:FindFirstChild("DistLabel")
                        if distLabel then
                            distLabel.Text = string.format("%.1f m", dist)
                        end
                    end
                else
                    graffitiHighlight.Enabled = false
                    if graffitiBillboard then graffitiBillboard.Enabled = false end
                end
            else
                graffitiHighlight.Enabled = false
                if graffitiBillboard then graffitiBillboard.Enabled = false end
            end
        else
            if not graffitiTarget or not graffitiTarget.Parent then
                graffitiTarget = nil
                graffitiHighlight = nil
                graffitiBillboard = nil
            end
        end
        task.wait(1)
    end
end)

local SubspaceBoxTarget = nil
local SubspaceBoxHighlight = nil
local function startSubspaceBoxESP()
    if SubspaceBoxHighlight then return end
    local map = workspace:FindFirstChild("Map")
    local ingame = map and map:FindFirstChild("Ingame")
    local tripmine = ingame and ingame:FindFirstChild("SubspaceTripmine")
    SubspaceBoxTarget = tripmine and tripmine:FindFirstChild("SubspaceBox")
    if not SubspaceBoxTarget then return end
    SubspaceBoxHighlight = Instance.new("Highlight")
    SubspaceBoxHighlight.Name = "ESP_SubspaceBox_Highlight"
    SubspaceBoxHighlight.FillColor = Color3.fromRGB(255, 0, 0)
    SubspaceBoxHighlight.FillTransparency = 0.3
    SubspaceBoxHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    SubspaceBoxHighlight.OutlineTransparency = 0.5
    SubspaceBoxHighlight.Enabled = false
    SubspaceBoxHighlight.Parent = SubspaceBoxTarget
end

Main:CreateToggle({
    Name = "SubspaceBox ESP",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            if not SubspaceBoxHighlight then startSubspaceBoxESP() end
            if SubspaceBoxHighlight then SubspaceBoxHighlight.Enabled = true end
        else
            if SubspaceBoxHighlight then SubspaceBoxHighlight.Enabled = false end
        end
    end,
})

task.spawn(function()
    while true do
        if SubspaceBoxHighlight and SubspaceBoxTarget and SubspaceBoxTarget.Parent then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local dist = (character.HumanoidRootPart.Position - SubspaceBoxTarget.Position).Magnitude
                SubspaceBoxHighlight.Enabled = (dist <= 650)
            else
                SubspaceBoxHighlight.Enabled = false
            end
        else
            if not SubspaceBoxTarget or not SubspaceBoxTarget.Parent then
                SubspaceBoxTarget = nil
                SubspaceBoxHighlight = nil
            end
        end
        task.wait(1)
    end
end)

local function createESP(object, nameText, textColor, fillColor)
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_" .. nameText
    highlight.FillColor = fillColor or Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.3
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0.5
    highlight.Enabled = false
    highlight.Parent = object
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. nameText .. "_Billboard"
    billboard.Size = UDim2.new(0, 200, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = false
    billboard.Parent = object
    local nameLabel = Instance.new("TextLabel", billboard)
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = textColor
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Text = nameText
    local distLabel = Instance.new("TextLabel", billboard)
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0.5
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 12
    return highlight, billboard, distLabel
end

local function resolvePath(pathString)
    local parts = string.split(pathString, "/")
    local current = workspace
    for _, part in ipairs(parts) do
        current = current:FindFirstChild(part)
        if not current then return nil end
    end
    return current
end

local espItems = {
    {
        name = "BloxyCola",
        pathString = "Map/Ingame/Map/BloxyCola",
        textColor = Color3.fromRGB(255, 165, 0),
        fillColor = Color3.fromRGB(255, 255, 255),
        objects = nil,
        targetObject = nil
    },
    {
        name = "Medkit",
        pathString = "Map/Ingame/Map/Medkit",
        textColor = Color3.fromRGB(255, 127, 127),
        fillColor = Color3.fromRGB(255, 255, 255),
        objects = nil,
        targetObject = nil
    }
}

for _, item in ipairs(espItems) do
    Main:CreateToggle({
        Name = item.name .. " ESP",
        CurrentValue = false,
        Callback = function(Value)
            if Value then
                if not item.targetObject then
                    item.targetObject = resolvePath(item.pathString)
                end
                if item.targetObject and not item.objects then
                    pcall(function()
                        item.objects = { createESP(item.targetObject, item.name, item.textColor, item.fillColor) }
                    end)
                end
                if item.objects then
                    item.objects[1].Enabled = true
                    item.objects[2].Enabled = true
                end
            else
                if item.objects then
                    item.objects[1].Enabled = false
                    item.objects[2].Enabled = false
                end
            end
        end,
    })
end

task.spawn(function()
    while true do
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        for _, item in ipairs(espItems) do
            if not item.targetObject then
                item.targetObject = resolvePath(item.pathString)
            end
            if item.objects and item.targetObject and item.targetObject.Parent then
                local hl, bb, distLbl = unpack(item.objects)
                if root then
                    local dist = (root.Position - item.targetObject.Position).Magnitude
                    hl.Enabled = true
                    bb.Enabled = true
                    distLbl.Text = string.format("%.1f m", dist)
                else
                    hl.Enabled = false
                    bb.Enabled = false
                end
            end
        end
        task.wait(0.6)
    end
end)

local ESP_MAP = {}

local function createESPForRespawn(object)
    local rawName = object.Name
    local playerName = rawName:gsub("RespawnLocation$", "")
    local nameText = playerName .. "SpawnPoint"
    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP_" .. nameText
    highlight.FillColor = Color3.fromRGB(128, 128, 128)
    highlight.FillTransparency = 0.3
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.OutlineTransparency = 0.5
    highlight.Enabled = false
    highlight.Parent = object
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESP_" .. nameText .. "_Billboard"
    billboard.Size = UDim2.new(0, 200, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = false
    billboard.Parent = object
    local nameLabel = Instance.new("TextLabel", billboard)
    nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextColor3 = Color3.fromRGB(128, 128, 128)
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Text = nameText
    local distLabel = Instance.new("TextLabel", billboard)
    distLabel.Name = "DistLabel"
    distLabel.Size = UDim2.new(1, 0, 0.5, 0)
    distLabel.Position = UDim2.new(0, 0, 0.5, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    distLabel.TextStrokeTransparency = 0.5
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextSize = 12
    ESP_MAP[object] = {
        highlight = highlight,
        billboard = billboard,
        distLabel = distLabel,
        name = nameText,
    }
end

local function removeESPForObject(object)
    local data = ESP_MAP[object]
    if data then
        data.highlight:Destroy()
        data.billboard:Destroy()
        ESP_MAP[object] = nil
    end
end

local function clearAllRespawnESP()
    for obj, data in pairs(ESP_MAP) do
        data.highlight:Destroy()
        data.billboard:Destroy()
    end
    ESP_MAP = {}
end

Main:CreateToggle({
    Name = "Mommy 2time spawn point ESP",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    if obj:IsA("BasePart") and obj.Name:match("RespawnLocation$") and not ESP_MAP[obj] then
                        createESPForRespawn(obj)
                    end
                end
            end
            for _, data in pairs(ESP_MAP) do
                data.highlight.Enabled = true
                data.billboard.Enabled = true
            end
        else
            clearAllRespawnESP()
        end
    end,
})

task.spawn(function()
    while true do
        if next(ESP_MAP) then
            local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    if obj:IsA("BasePart") and obj.Name:match("RespawnLocation$") and not ESP_MAP[obj] then
                        createESPForRespawn(obj)
                    end
                end
            end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            for obj, data in pairs(ESP_MAP) do
                if obj and obj.Parent then
                    if root then
                        local dist = (root.Position - obj.Position).Magnitude
                        data.highlight.Enabled = true
                        data.billboard.Enabled = true
                        data.distLabel.Text = string.format("%.1f m", dist)
                    else
                        data.highlight.Enabled = false
                        data.billboard.Enabled = false
                    end
                else
                    removeESPForObject(obj)
                end
            end
        end
        task.wait(1)
    end
end)

Main:CreateToggle({
    Name = "Mommy 2time spawn point ESP",
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    if obj:IsA("BasePart") and obj.Name:match("RespawnLocation$") and not ESP_MAP[obj] then
                        createESPForRespawn(obj)
                    end
                end
            end
            for _, data in pairs(ESP_MAP) do
                data.highlight.Enabled = true
                data.billboard.Enabled = true
            end
        else
            clearAllRespawnESP()
        end
    end,
})

task.spawn(function()
    while true do
        if next(ESP_MAP) then
            local folder = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Ingame")
            if folder then
                for _, obj in ipairs(folder:GetChildren()) do
                    if obj:IsA("BasePart") and obj.Name:match("RespawnLocation$") and not ESP_MAP[obj] then
                        createESPForRespawn(obj)
                    end
                end
            end
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            for obj, data in pairs(ESP_MAP) do
                if obj and obj.Parent then
                    if root then
                        local dist = (root.Position - obj.Position).Magnitude
                        data.highlight.Enabled = true
                        data.billboard.Enabled = true
                        data.distLabel.Text = string.format("%.1f m", dist)
                    else
                        data.highlight.Enabled = false
                        data.billboard.Enabled = false
                    end
                else
                    removeESPForObject(obj)
                end
            end
        end
        task.wait(1)
    end
end)

local tripMineTarget = nil
local tripMineHighlight = nil
local tripMineEnabled = false

local function startTripMineESP()
    if tripMineHighlight then return end
    local map = workspace:FindFirstChild("Map")
    local ingame = map and map:FindFirstChild("Ingame")
    tripMineTarget = ingame and ingame:FindFirstChild("SubspaceTripmine")
    if not tripMineTarget then return end
    tripMineHighlight = Instance.new("Highlight")
    tripMineHighlight.Name = "ESP_SubspaceTripmine"
    tripMineHighlight.FillColor = Color3.fromRGB(255, 0, 0)
    tripMineHighlight.FillTransparency = 0.3
    tripMineHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    tripMineHighlight.OutlineTransparency = 0.5
    tripMineHighlight.Enabled = false
    tripMineHighlight.Parent = tripMineTarget
end

Main:CreateToggle({
    Name = "SubspaceTripmine ESP",
    CurrentValue = false,
    Callback = function(Value)
        tripMineEnabled = Value
        if tripMineHighlight then
            tripMineHighlight.Enabled = Value
        end
        if Value and not tripMineHighlight then
            startTripMineESP()
            if tripMineHighlight then tripMineHighlight.Enabled = true end
        end
    end,
})

task.spawn(function()
    while true do
        if tripMineEnabled then
            if not tripMineTarget or not tripMineTarget.Parent then
                tripMineTarget = nil
                tripMineHighlight = nil
                startTripMineESP()
            end
            if tripMineHighlight and tripMineTarget then
                local character = LocalPlayer.Character
                if character and character:FindFirstChild("HumanoidRootPart") then
                    local dist = (character.HumanoidRootPart.Position - tripMineTarget.Position).Magnitude
                    tripMineHighlight.Enabled = (dist <= 350)
                else
                    tripMineHighlight.Enabled = false
                end
            end
        else
            if tripMineHighlight then
                tripMineHighlight.Enabled = false
            end
        end
        task.wait(1)
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local network = ReplicatedStorage.Modules.Network.Network.RemoteEvent

local function createBuffer(action)
    local buf = buffer.create(10)
    buffer.writeu8(buf, 0, 0x03)
    buffer.writeu8(buf, 1, 0x05)
    buffer.writeu8(buf, 2, 0x00)
    buffer.writeu8(buf, 3, 0x00)
    buffer.writeu8(buf, 4, 0x00)
    buffer.writestring(buf, 5, action)
    return buf
end
local blockBuf = createBuffer("Block")
local punchBuf = createBuffer("Punch")

local ATTACK_SOUND_IDS = {
    "rbxassetid://112809109188560",
    "rbxassetid://80516583309685",
    "rbxassetid://117173212095661",
    "rbxassetid://98675122200448",
    "rbxassetid://119583605486352",
    "rbxassetid://140242176732868",
}

local MAX_DISTANCE = 10
local blockSent = false
local lastBlockTime = 0
local autoFaceConn = nil

local function getAttackingKiller()
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local myRoot = char.HumanoidRootPart
    local killersFolder = workspace.Players:FindFirstChild("Killers")
    if not killersFolder then return nil end

    for _, killer in pairs(killersFolder:GetChildren()) do
        if killer:IsA("Model") and killer ~= char then
            local root = killer:FindFirstChild("HumanoidRootPart")
            if root then
                local dist = (myRoot.Position - root.Position).Magnitude
                if dist <= MAX_DISTANCE then
                    for _, obj in pairs(killer:GetDescendants()) do
                        if obj:IsA("Sound") and obj.IsPlaying then
                            for _, soundId in ipairs(ATTACK_SOUND_IDS) do
                                if obj.SoundId == soundId then
                                    return killer
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    return nil
end

local function faceTarget(targetRoot, duration)
    local char = LocalPlayer.Character
    if not char or not targetRoot then return end
    local myRoot = char:FindFirstChild("HumanoidRootPart")
    if not myRoot then return end
    if autoFaceConn then
        autoFaceConn:Disconnect()
        autoFaceConn = nil
    end
    local endTime = os.clock() + duration
    autoFaceConn = RunService.Heartbeat:Connect(function()
        if os.clock() >= endTime or not targetRoot.Parent then
            autoFaceConn:Disconnect()
            autoFaceConn = nil
            return
        end
        local lookAt = (targetRoot.Position - myRoot.Position).Unit
        local flatLook = Vector3.new(lookAt.X, 0, lookAt.Z)
        if flatLook.Magnitude > 0.1 then
            myRoot.CFrame = CFrame.new(myRoot.Position, myRoot.Position + flatLook)
        end
    end)
end

local parryConn, heartbeatConn
local function parryEventHandler(name, data)
    if type(name) ~= "string" then return end
    if not name:match("1337ParryIcon$") then return end
    local parryReady = buffer.readu8(data[1], 1) == 1
    if not (parryReady and blockSent and (os.clock() - lastBlockTime) < 1.0) then return end
    blockSent = false
    local killer = getAttackingKiller()
    local root = killer and killer:FindFirstChild("HumanoidRootPart")
    task.spawn(function()
        if root then
            faceTarget(root, 0.75)
            RunService.Heartbeat:Wait()
        end
        local char = LocalPlayer.Character
        if not char then return end
        network:FireServer("UseActorAbility", { [1] = punchBuf })
    end)
end

local function heartbeatHandler()
    local killer = getAttackingKiller()
    if killer and not blockSent then
        network:FireServer("UseActorAbility", { [1] = blockBuf })
        blockSent = true
        lastBlockTime = os.clock()
    end
    if blockSent and (os.clock() - lastBlockTime) > 1.0 then
        blockSent = false
    end
end

if Main then
    Main:CreateToggle({
        Name = "Auto Block Parry",
        CurrentValue = false,
        Flag = "AutoParry",
        Callback = function(Value)
            if not Value then
                if parryConn then parryConn:Disconnect() parryConn = nil end
                if heartbeatConn then heartbeatConn:Disconnect() heartbeatConn = nil end
                return
            end
            if not parryConn then
                parryConn = network.OnClientEvent:Connect(parryEventHandler)
            end
            if not heartbeatConn then
                heartbeatConn = RunService.Heartbeat:Connect(heartbeatHandler)
            end
        end,
    })
else
    parryConn = network.OnClientEvent:Connect(parryEventHandler)
    heartbeatConn = RunService.Heartbeat:Connect(heartbeatHandler)
    warn("Main tab not found, auto block/parry started without toggle.")
end