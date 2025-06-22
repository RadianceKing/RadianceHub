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

local deletionEnabled = false -- Флаг для отслеживания состояния удаления объектов
local redColor = Color3.fromRGB(255, 100, 100) -- Слегка красный цвет
local NoclipConnection -- Переменная для хранения соединения

-- Функция ноклипа
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
wait(0.21) -- basic optimization
end
NoclipConnection = game:GetService("RunService").Stepped:Connect(Nocl)
end

local function clip()
if NoclipConnection then
NoclipConnection:Disconnect()
end
end

-- Checkbox для ноклипа
MiscTab:AddToggle({
Name = "NoClip",
Default = false,
Callback = function(state)
if state then
noclip() -- Включаем ноклип
print("NoClip enabled.")
else
clip() -- Выключаем ноклип
print("NoClip disabled.")
end
end
})

-- Checkbox для удаления объектов
MiscTab:AddToggle({
Name = "Ctrl + Delete | delete parts",
Default = false,
Callback = function(state)
if state then
print("Part deletion enabled.")
local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

-- Подключение функции удаления объектов
deletionConnection = Mouse.Button1Down:Connect(function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
if not Mouse.Target then return end
Mouse.Target:Destroy()
end)
else
-- Отключаем удаление
if deletionConnection then
deletionConnection:Disconnect()
deletionConnection = nil -- Убираем ссылку на соединение
end
print("Part deletion disabled.")
end
end
})

-- Checkbox для включения бесконечного прыжка
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
infiniteJumpConnection = nil -- Удаляем ссылку на соединение
end
print("Infinite Jump disabled.")
end
end
})

-- Слайдер для изменения скорости
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

-- Слайдер для изменения гравитации
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

-- Кнопка для загрузки Infinite Yield
MiscTab:AddButton({
Name = "Load Infinite Yield",
Callback = function()
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
print("Infinite Yield loaded.")
end
})

-- Кнопка для включения Full Bright
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

Light.LightingChanged:Connect(dofullbright) -- Обновляет цвета при изменении освещения
fullBrightEnabled = true
print("Full Bright enabled.")
end
})

-- Кнопка для включения ESP
MiscTab:AddButton({
Name = "ESP",
Callback = function()
loadstring(game:HttpGet("https://pastebin.com/raw/n88ttmFh"))()
print("ESP loaded.")
end
})

-- Кнопка для телепортации в The Bunker
BunkerTab:AddButton({
Name = "Teleport to Bunker",
Callback = function()
local player = game.Players.LocalPlayer
local id = player.UserId -- Получаем ID игрока
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

-- Формируем путь к Bunker с использованием ID игрока
local targetPartName = tostring(id) .. "_Bunker"
local targetPart = workspace.Bunkers:FindFirstChild(targetPartName)

if targetPart and targetPart:FindFirstChild("Stairs") then
local stairs = targetPart.Stairs:GetChildren()[11] -- Или нужный индекс
if stairs then
humanoidRootPart.CFrame = stairs.CFrame -- Телепортация игрока
print("Teleported to the bunker.")
else
warn("No valid stairs found!")
end
else
warn("Bunker not found!")
end
end
})

-- Кнопка для телепортации к указанному объекту в магазине
BunkerTab:AddButton({
Name = "Teleport to Store",
Callback = function()
local player = game.Players.LocalPlayer
local humanoidRootPart = player.Character:WaitForChild("HumanoidRootPart")

local targetPart = workspace.Market.Market.Market:GetChildren()[96]:GetChildren()[4]:GetChildren()[2] -- Получаем нужный MeshPart
if humanoidRootPart and targetPart then
humanoidRootPart.CFrame = targetPart.CFrame -- Телепортация игрока
print("Teleported to the specified object in the market.")
else
warn("HumanoidRootPart or target part not found!")
end
end
})

-- Кнопка для удаления дверей (левой и правой) и TGaz
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

-- Кнопка для перемещения Tool предметов в инвентарь игрока
BunkerTab:AddButton({
Name = "Collect All Food",
Callback = function()
local player = game.Players.LocalPlayer
local backpack = player.Backpack

for _, tool in pairs(workspace:GetChildren()) do
if tool:IsA("Tool") and (tool.Name == "Apple" or tool.Name == "Cola" or tool.Name == "Burger" or tool.Name == "Pizza" or tool.Name == "Water") then
tool.Parent = backpack -- Перемещаем предмет в инвентарь
print(tool.Name .. " moved to inventory.")
end
end
end
})

-- Кнопка для удаления предметов GamePass
BunkerTab:AddButton({
Name = "Unlock Gamepass Rooms",
Callback = function()
local player = game.Players.LocalPlayer
local id = player.UserId -- Получаем ID игрока
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

-- Переменные
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local runService = game:GetService("RunService")

-- Флаг для управления ESP
local espEnabled = false

-- Функция для создания бокса ESP
local function createESPBox(character, outlineColor)
local highlight = Instance.new("Highlight")
highlight.Name = character.Name .. "_ESP"
highlight.Adornee = character
highlight.FillTransparency = 1 -- Делаем заполнение бокса невидимым
highlight.OutlineColor = outlineColor -- Устанавливаем цвет контура
highlight.OutlineTransparency = 0 -- Полностью видимый контур
highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop -- Видимость через стены
highlight.Parent = character
end

-- Функция для добавления ESP
local function addESP()
if espEnabled then
local targetPlayer = players:FindFirstChild("LurkerNight")
if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
-- Проверка, существует ли уже ESP, чтобы избежать дублирования
if not targetPlayer.Character:FindFirstChild(targetPlayer.Name .. "_ESP") then
createESPBox(targetPlayer.Character, Color3.new(1, 0, 0)) -- Красный цвет для LurkerNight
end
end

-- Добавляем ESP для всех объектов "JumperNight"
for _, object in pairs(workspace:GetChildren()) do
if object.Name == "JumperNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") and part:FindFirstChild("UpperTorso") then
-- Проверяем, существует ли ESP, чтобы избежать дублирования
if not part:FindFirstChild(part.Name .. "_ESP") then
createESPBox(part, Color3.new(0, 1, 0)) -- Зеленый цвет для JumperNight
end
end
end
end
end

-- Добавляем ESP для всех объектов "TheLurker"
for _, object in pairs(workspace:GetChildren()) do
if object.Name == "LurkerNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") and part:FindFirstChild("UpperTorso") then
-- Проверяем, существует ли ESP, чтобы избежать дублирования
if not part:FindFirstChild(part.Name .. "_ESP") then
createESPBox(part, Color3.new(0, 0, 1)) -- Синий цвет для TheLurker
end
end
end
end
end

-- Добавляем ESP для всех объектов "TheCatcher"
for _, object in pairs(workspace:GetChildren()) do
if object.Name == "CatcherNight" then
for _, part in pairs(object:GetChildren()) do
if part:IsA("Model") and part:FindFirstChild("UpperTorso") then
-- Проверяем, существует ли ESP, чтобы избежать дублирования
if not part:FindFirstChild(part.Name .. "_ESP") then
createESPBox(part, Color3.new(1, 0, 1)) -- Розовый цвет для TheCatcher
end
end
end
end
end
end
end

-- Кнопка переключения ESP в уже существующем BunkerTab
BunkerTab:AddToggle({
Name = "Enemy ESP",
Default = false,
Callback = function(state)
espEnabled = state -- Изменяем флаг состояния ESP
if not state then
-- Если ESP отключен, очищаем существующие ESP
for _, player in pairs(players:GetPlayers()) do
if player.Character then
local existingESP = player.Character:FindFirstChild(player.Name .. "_ESP")
if existingESP then
existingESP:Destroy()
end
end
end

-- Удаляем ESP для всех JumperNight
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

-- Удаляем ESP для всех TheLurker
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

-- Удаляем ESP для всех TheCatcher
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

-- Запуск функции добавления ESP непрерывно
runService.RenderStepped:Connect(function()
addESP()
end)

-- Удаление ESP при выходе игрока
players.PlayerRemoving:Connect(function(player)
if player.Character and player.Character:FindFirstChild(player.Name .. "_ESP") then
player.Character[player.Name .. "_ESP"]:Destroy()
end
end)

OrionLib:MakeNotification({
	Name = "Thank You for use my script !",
	Content = "sub on my yt channel RadianceMurder",
	Image = "rbxassetid://4483345998",
	Time = 15
})