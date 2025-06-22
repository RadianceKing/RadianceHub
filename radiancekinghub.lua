local OrionLib = loadstring(game:HttpGet('https://pastebin.com/raw/WRUyYTdY'))()
local Window = OrionLib:MakeWindow({Name = "RadianceJ Hub 💀", HidePremium = false})

local MiscTab = Window:MakeTab({
Name = "Misc",
Icon = "rbxassetid://4483345998",
PremiumOnly = false
})

local BunkerTab = Window:MakeTab({
Name = "The Bunker",
Icon = "rbxassetid://4483345998",
PremiumOnly = false
})

local deletionEnabled = false
local redColor = Color3.fromRGB(255, 100, 100)
local NoclipConnection

local function noclip()
local Clip = false
local function Nocl()
if Clip == false and game.Players.LocalPlayer.Character ~= nil then
for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
if v:IsA("BasePart") and v.CanCollide then
v.CanCollide = false
end
end
end
wait(0.21)
end
NoclipConnection = game:GetService("RunService").Stepped:Connect(Nocl)
end

local function clip()
if NoclipConnection then
NoclipConnection:Disconnect()
end
end

MiscTab:AddToggle({
Name = "NoClip",
Default = false,
Callback = function(state)
if state then
noclip()
print("NoClip enabled.")
else
clip()
print("NoClip disabled.")
end
end
})

MiscTab:AddToggle({
Name = "Ctrl + Delete | delete parts",
Default = false,
Callback = function(state)
if state then
print("Part deletion enabled.")
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

deletionConnection = Mouse.Button1Down:Connect(function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
if not Mouse.Target then return end
Mouse.Target:Destroy()
end)
else
if deletionConnection then
deletionConnection:Disconnect()
deletionConnection = nil
end
print("Part deletion disabled.")
end
end
})

MiscTab:AddToggle({
Name = "Enable Infinite Jump",
Default = false,
Callback = function(state)
if state then
infiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end)
print("Infinite Jump enabled.")
else
if infiniteJumpConnection then
infiniteJumpConnection:Disconnect()
infiniteJumpConnection = nil
end
print("Infinite Jump disabled.")
end
end
})

MiscTab:AddSlider({
Name = "Walkspeed",
Min = 1,
Max = 200,
Default = 16,
Color = redColor,
Increment = 1,
ValueName = "Speed",
Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
end
})

MiscTab:AddSlider({
Name = "Gravity",
Min = 1,
Max = 1000,
Default = 50,
Color = Color3.fromRGB(255, 100, 100),
Increment = 1,
ValueName = "JumpGravity",
Callback = function(Value)
game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
end
})

MiscTab:AddButton({
Name = "Load Infinite Yield",
Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
print("Infinite Yield loaded.")
end
})

MiscTab:AddButton({
Name = "Fullbright",
Callback = function()
local Light = game:GetService("Lighting")

local function dofullbright()
Light.Ambient = Color3.new(1, 1, 1)
Light.ColorShift_Bottom = Color3.new(1, 1, 1)
Light.ColorShift_Top = Color3.new(1, 1, 1)
end

dofullbright()
Light.LightingChanged:Connect(dofullbright)
fullBrightEnabled = true
print("Full Bright enabled.")
end
})

MiscTab:AddButton({
Name = "ESP",
Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/n88ttmFh"))()
print("ESP loaded.")
end
})

BunkerTab:AddButton({
Name = "Teleport to Bunker",
Callback = function()
local player = game.Players.LocalPlayer
local id = player.UserId
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

local targetPartName = tostring(id) .. "_Bunker"
local targetPart = workspace.Bunkers:FindFirstChild(targetPartName)

if targetPart and targetPart:FindFirstChild("Stairs") then
local stairs = targetPart.Stairs:GetChildren()[11]
if stairs then
humanoidRootPart.CFrame = stairs.CFrame
print("Teleported to the bunker.")
else
warn("No valid stairs found!")
end
else
warn("Bunker not found!")
end
end
})

BunkerTab:AddButton({
Name = "Teleport to Store",
Callback = function()
local player = game.Players.LocalPlayer
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

local targetPart = workspace.Market.Market.Market:GetChildren()[96]:GetChildren()[4]:GetChildren()[2]
if humanoidRootPart and targetPart then
humanoidRootPart.CFrame = targetPart.CFrame
print("Teleported to the specified object in the market.")
else
warn("HumanoidRootPart or target part not found!")
end
end
})

BunkerTab:AddButton({
Name = "Remove Rare furniture doors",
Callback = function()
local leftDoor = workspace.Magazine.DoubleDoor.ScriptedComponents:FindFirstChild("LeftDoor")
local rightDoor = workspace.Magazine.DoubleDoor.ScriptedComponents:FindFirstChild("RightDoor")
local tgaz = workspace:FindFirstChild("TGaz")

if leftDoor then
leftDoor:Destroy()
print("Left door removed.")
else
print("Left door not found!")
end

if rightDoor then
rightDoor:Destroy()
print("Right door removed.")
else
print("Right door not found!")
end

if tgaz then
tgaz:Destroy()
print("TGaz removed.")
else
print("TGaz not found!")
end
end
})

BunkerTab:AddButton({
Name = "Collect All Food",
Callback = function()
local player = game.Players.LocalPlayer
local backpack = player.Backpack

for _, tool in pairs(workspace:GetChildren()) do
if tool:IsA("Tool") and (tool.Name == "Apple" or tool.Name == "Cola" or tool.Name == "Burger" or tool.Name == "Pizza" or tool.Name == "Water") then
tool.Parent = backpack
print(tool.Name .. " moved to inventory.")
end
end
end
})

BunkerTab:AddButton({
Name = "Unlock Gamepass Rooms",
Callback = function()
local player = game.Players.LocalPlayer
local id = player.UserId
local bunkerPath = "Bunkers[" .. tostring(id) .. "_Bunker]"

local bunker = workspace.Bunkers:FindFirstChild(tostring(id) .. "_Bunker")
if bunker then
local gamePass1 = bunker:FindFirstChild("GamePass1")
local gamePass2 = bunker:FindFirstChild("GamePass2")
local gamePass3 = bunker:FindFirstChild("GamePass3")

if gamePass1 then
gamePass1:Destroy()
print("GamePass1 removed.")
end
if gamePass2 then
gamePass2:Destroy()
print("GamePass2 removed.")
end
if gamePass3 then
gamePass3:Destroy()
print("GamePass3 removed.")
end
else
warn("Bunker with ID " .. tostring(id) .. " not found!")
end
end
})

local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")

local espEnabled = false

local function createESPBox(character, outlineColor)
local highlight = Instance.new("Highlight")
highlight.Name = character.Name .. "_ESP"
highlight.Adornee = character
highlight.FillTransparency = 1
highlight.OutlineColor = outlineColor
highlight.OutlineTransparency = 0
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
highlight.Parent = character
end

local function addESP()
if espEnabled then
local targetPlayer = players:FindFirstChild("LurkerNight")
if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
if not targetPlayer.Character:FindFirstChild(targetPlayer.Name .. "_ESP") then
createESPBox(targetPlayer.Character, Color3.new(1, 0, 0))
end
end

for _, object in pairs(workspace:GetChildren()) do
if object.Name == "JumperNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") and part:FindFirstChild("UpperTorso") then
if not part:FindFirstChild(part.Name .. "_ESP") then
createESPBox(part, Color3.new(0, 1, 0))
end
end
end
end
end

for _, object in pairs(workspace:GetChildren()) do
if object.Name == "LurkerNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") and part:FindFirstChild("UpperTorso") then
if not part:FindFirstChild(part.Name .. "_ESP") then
createESPBox(part, Color3.new(0, 0, 1))
end
end
end
end
end

for _, object in pairs(workspace:GetChildren()) do
if object.Name == "CatcherNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") and part:FindFirstChild("UpperTorso") then
if not part:FindFirstChild(part.Name .. "_ESP") then
createESPBox(part, Color3.new(1, 0, 1))
end
end
end
end
end
end
end

BunkerTab:AddToggle({
Name = "Enemy ESP",
Default = false,
Callback = function(state)
espEnabled = state
if not state then
for _, player in pairs(players:GetPlayers()) do
if player.Character then
local existingESP = player.Character:FindFirstChild(player.Name .. "_ESP")
if existingESP then
existingESP:Destroy()
end
end
end

for _, object in pairs(workspace:GetChildren()) do
if object.Name == "JumperNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") then
local existingESP = part:FindFirstChild(part.Name .. "_ESP")
if existingESP then
existingESP:Destroy()
end
end
end
end
end

for _, object in pairs(workspace:GetChildren()) do
if object.Name == "LurkerNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") then
local existingESP = part:FindFirstChild(part.Name .. "_ESP")
if existingESP then
existingESP:Destroy()
end
end
end
end
end

for _, object in pairs(workspace:GetChildren()) do
if object.Name == "CatcherNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") then
local existingESP = part:FindFirstChild(part.Name .. "_ESP")
if existingESP then
existingESP:Destroy()
end
end
end
end
end
end
end
})

runService.RenderStepped:Connect(function()
addESP()
end)

players.PlayerRemoving:Connect(function(player)
if player.Character and player.Character:FindFirstChild(player.Name .. "_ESP") then
player.Character[player.Name .. "_ESP"]:Destroy()
end
end)

OrionLib:MakeNotification({
Name = "Thank You for using my script!",
Content = "Subscribe to my YouTube channel RadianceMurder",
Image = "rbxassetid://4483345998",
Time = 15
})
