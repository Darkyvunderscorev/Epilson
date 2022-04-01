wait()

repeat
	wait()
until game:IsLoaded()

for i, v in next, getconnections(game:GetService('ScriptContext').Error) do
	v:Disable()    
end

if game.PlaceId ~= 9216633469 and game.PlaceId ~= 3328347965 then
	game.Players.LocalPlayer:Kick("Unsupported Game")
end

local SETTINGS_FILE = "epilson_UI_Settings.txt"

getgenv().Settings = {}

local function SaveSettings()
	if not (writefile) then
		return
	end

	local http = game:GetService("HttpService")
	writefile(SETTINGS_FILE, http:JSONEncode(getgenv().Settings))
end

local function LoadSettings()
	if not (readfile and isfile and isfile(SETTINGS_FILE)) then
		return
	end
	local http = game:GetService("HttpService")
	getgenv().Settings = http:JSONDecode(readfile(SETTINGS_FILE))
end

--[[
do
	do
		local mt = getrawmetatable(game)
		local oldnewindex = getgenv().oldnewindex or mt.__newindex
		getgenv().oldnewindex = oldnewindex

		setreadonly(mt, false)

		function mt.__newindex(self, obj, prop)
			local mt = getrawmetatable(game)
			local oldnewindex = getgenv().oldnewindex or mt.__newindex

			setreadonly(mt, false)

			function mt.__newindex(self, prop, val)
				if (self == "Humanoid" and prop == "Velocity") then
					return Vector3.new(0, 0, 0)
				end

				return oldnewindex(self, obj, prop)
			end
			setreadonly(mt, true)
		end
	end

	do
		local mt = getrawmetatable(game)
		local oldnewindex = getgenv().oldnewindex or mt.__newindex

		setreadonly(mt, false)

		function mt.__newindex(self, prop, val)
			if (self == "Humanoid" and prop == "WalkSpeed") then
				return 16
			end

			return oldnewindex(self, obj, prop)
		end
		setreadonly(mt, true)
	end
end

--]]

--services
local rs = game:GetService("RunService")
local uis = game:GetService("UserInputService")
--ui lib
local uiLib = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/UI%20Library%202.0.lua'))();

uiLib:SetWatermark("Testing v2")
uiLib:Notify("Loading UI....")

local function RemoveKillbricks()
	for _, kb in pairs(game.Workspace.Map.KillBricks:GetChildren()) do
		kb:Destroy()
	end
end

local function Bypass()
	local ch = game.Players.LocalPlayer.Character
	local a = ch.CharacterHandler
	local aa = a.ClientHandler
	local ad = a.Input
	local b = ch.ManaClimb
	local d = ch.FallDamage
	local e = ch.Humanoid
	local anim = ch.Animate

	anim.Disabled = true
	aa.Disabled = true
	ad.Disabled = true
	a.Disabled = true
	b.Disabled = true
	d.Disabled = true

	aa.Parent = nil
	ad.Parent = nil
	a.Parent = nil
	b.Parent = nil
	d.Parent = nil
	e.Parent = nil

	e.Parent = ch

	aa.Parent = a
	ad.Parent = a
	a.Parent = ch
	b.Parent = ch
	d.Parent = ch

	wait()

	anim.Disabled = false
	aa.Disabled = false
	ad.Disabled = false
	a.Disabled = false
	b.Disabled = false
	d.Disabled = false
end

local function Notification(Title, Text)
	game:GetService("StarterGui"):SetCore("SendNotification",
	{
		Title = Title;
		Text = Text;
		Duration = 20;
	});
end;

local main = uiLib:CreateWindow("Epilson UI")

local MainTab = main:AddTab("Main")

local UtilityTab = MainTab:AddLeftTabbox("LeftTab1")
local Locals = UtilityTab:AddTab("Local Cheats")

Locals:AddLabel("Movement Cheats")
---

Locals:AddToggle("Fly", {Default = false, Text = "Flight"}):AddKeyPicker("FlyKeybind", {Text = "Toggle", Default = ""})
Locals:AddSlider("FlySpeed", {Default = 50, Min = 10, Max = 500, Rounding = 0, Suffix = "", Text = "Flight Speed"})
---
Locals:AddToggle("NoClip", {Default = false, Text = "NoClip"}):AddKeyPicker("NoClipKeybind", {Text = "Toggle", Default = ""})
Locals:AddToggle("InfJump", {Default = false, Text = "Infinite Jump"}):AddKeyPicker("InfJumpKeybind", {Text = "Toggle", Default = ""})
---
Locals:AddToggle("Speed", {Default = false, Text = "Speed Toggle"}):AddKeyPicker("SpeedKeybind", {Text = "Toggle", Default = ""})
Locals:AddSlider("SpeedCheat", {Default = 50, Min = 10, Max = 500, Rounding = 0, Suffix = "", Text = "Speed Cheat"})
---
Locals:AddToggle("Climb", {Default = false, Text = "Modify Climb Speed"}):AddKeyPicker("ClimbSpeedKeybind", {Text = "Toggle", Default = ""})
Locals:AddSlider("ClimbSpeed", {Default = 0, Min = 0, Max = 5, Rounding = 0, Suffix = "", Text = "Speed"})
--
Locals:AddToggle("ManaCharge", {Default = false, Text = "Auto Charge Mana"}):AddKeyPicker("ManaChargeKeybind", {Text = "Toggle", Default = ""})
Locals:AddToggle("ManaInterval", {Default = false, Text = "Interval"})
Locals:AddSlider("Min", {Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = "", Text = "Min"})
Locals:AddSlider("Max", {Default = 0, Min = 0, Max = 100, Rounding = 0, Suffix = "", Text = "Max"})

--

Locals:AddLabel("Bypasses")
Locals:AddToggle("NoFall", {Default = false, Text = "No Fall"})
Locals:AddToggle("NoStun", {Default = false, Text = "No Stun"})
Locals:AddToggle("FullBypass", {Default = false, Text = "Full AntiCheat Bypass (Rejoin to Undo)"})
Locals:AddButton("Remove Kill Bricks", RemoveKillbricks())
Locals:AddLabel("Features:")
Locals:AddLabel("-Disables Attacking, Mana Charge\n-Cannot be attacked\n-Cannot be spectated\n-Can Fly, TP, Speed etc\n-Inventory wont save\n-Last position wont save\n-You can drop artifacts/Items you picked up\n-Cannot sell items while this is on\nThis has upsides and downsides.")

local ESPTab = main:AddTab("ESP")

local trinketESP = ESPTab:AddLeftGroupbox("Trinkets")


--[[
Fly
NoClip
InfJump
Speed
Climb
ManaCharge
NoFall
NoStun

GobletESP
OldRingESP
RingESP
AmuletESP
OldAmuletESP
IdolESP
ScrollESP

RiftGemESP
EmeraldESP
RubyESP
SapphireESP
DiamondESP
OpalESP

PhiloESP
MannaEssESP
FFESP
LannisESP
QMESP
SCESP
PDESP
PFESP
]]
trinketESP:AddLabel("Trinkets ESP")
trinketESP:AddToggle("GobletESP", {Default = false, Text = "Goblet"})
trinketESP:AddToggle("OldRingESP", {Default = false, Text = "Old Ring"})
trinketESP:AddToggle("RingESP", {Default = false, Text = "Ring"})
trinketESP:AddToggle("AmuletESP", {Default = false, Text = "Amulet"})
trinketESP:AddToggle("OldAmuletESP", {Default = false, Text = "Old Amulet"})
trinketESP:AddToggle("IdolESP", {Default = false, Text = "Idol of the Forgotten"})
trinketESP:AddToggle("ScrollESP", {Default = false, Text = "Scrolls"})

local gemESP = ESPTab:AddRightGroupbox("Gems")

gemESP:AddLabel("Gems ESP")
gemESP:AddToggle("RiftGemESP", {Default = false, Text = "Rift Gem"})
gemESP:AddToggle("EmeraldESP", {Default = false, Text = "Emerald"})
gemESP:AddToggle("RubyESP", {Default = false, Text = "Ruby"})
gemESP:AddToggle("SapphireESP", {Default = false, Text = "Sapphire"})
gemESP:AddToggle("DiamondESP", {Default = false, Text = "Diamond"})
gemESP:AddToggle("OpalESP", {Default = false, Text = "Opal"})

local artiESP = ESPTab:AddLeftGroupbox("Artifacts")

artiESP:AddLabel("Artifacts ESP")
artiESP:AddToggle("PhiloESP", {Default = false, Text = "Philosopher's Stone"})
artiESP:AddToggle("ManaEssESP", {Default = false, Text = "Mana Essence"})
artiESP:AddToggle("ShinyEssESP", {Default = false, Text = "Shiny Essence"})
artiESP:AddToggle("IceEssESP", {Default = false, Text = "Ice Essence"})
artiESP:AddToggle("HowlerFESP", {Default = false, Text = "Howler Friend"})
artiESP:AddToggle("NightSESP", {Default = false, Text = "Night Stone"})
artiESP:AddToggle("ScrKESP", {Default = false, Text = "Scroom Key"})
artiESP:AddToggle("CatHESP", {Default = false, Text = "Cat's Hood"})
artiESP:AddToggle("AncPESP", {Default = false, Text = "Ancient Plating"})
artiESP:AddToggle("MystESP", {Default = false, Text = "Mysterious Artifact"})
artiESP:AddToggle("WKAESP", {Default = false, Text = "White King's Amulet"})
artiESP:AddToggle("FFESP", {Default = false, Text = "Fair Frozen"})
artiESP:AddToggle("LannisESP", {Default = false, Text = "Lannis's Amulet"})
artiESP:AddToggle("QMESP", {Default = false, Text = "???"})
artiESP:AddToggle("SCESP", {Default = false, Text = "Spider Cloak"})
artiESP:AddToggle("PDESP", {Default = false, Text = "Phoenix Down"})
artiESP:AddToggle("PBESP", {Default = false, Text = "Phoenix's Bloom"})
artiESP:AddToggle("PFESP", {Default = false, Text = "Phoenix Feather"})

local playerESP = ESPTab:AddRightGroupbox("Players")
playerESP:AddToggle("plrESP", {Default = false, Text = "Enables"})
playerESP:AddToggle("DisplayDistance", {Default = false, Text = "Show Distance"})
playerESP:AddToggle("DisplayHP", {Default = false, Text = "Show Name"})
playerESP:AddToggle("DisplayName", {Default = false, Text = "Show Health"})
playerESP:AddToggle("DisplayInfo", {Default = false, Text = "Show Info"})

--[[


]]--
local Others = MainTab:AddRightTabbox("Others")
local Misc = Others:AddTab("Misc")
Misc:AddToggle("AutoLoot", {Default = false, Text = "Auto Loot"})

local Keybinds = main:AddTab("Keybinds")
local Settings = main:AddTab("Settings")
--main
local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")

local mouse = plr:GetMouse()
mouse.TargetFilter = game.Workspace
local camera = workspace.CurrentCamera

toggles = getgenv().Toggles or {}
options = getgenv().Options or {}

getgenv().FlyKeybind = options.FlyKeybind.Value ~= "" and Enum.KeyCode[options.FlyKeybind.Value] or "Unbinded"
getgenv().SpeedKeybind = options.SpeedKeybind.Value ~= "" and Enum.KeyCode[options.SpeedKeybind.Value] or "Unbinded"
getgenv().NoClipKeybind = options.NoClipKeybind.Value ~= "" and Enum.KeyCode[options.NoClipKeybind.Value] or "Unbinded"
getgenv().ClimbSpeedKeybind = options.ClimbSpeedKeybind.Value ~= "" and Enum.KeyCode[options.ClimbSpeedKeybind.Value] or "Unbinded"
getgenv().ManaChargeKeybind = options.ManaChargeKeybind.Value ~= "" and Enum.KeyCode[options.ManaChargeKeybind.Value] or "Unbinded"
getgenv().InfJumpKeybind = options.InfJumpKeybind.Value ~= "" and Enum.KeyCode[options.InfJumpKeybind.Value] or "Unbinded"

local flycontrol = {
	w = false,
	a = false,
	s = false,
	d = false,
}

function Action(Object, Function) if Object ~= nil then Function(Object); end end

--inputs
uis.InputBegan:Connect(function(input, process)
	if process then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end

	if input.KeyCode == Enum.KeyCode.W then
		flycontrol.w = true
	end

	if input.KeyCode == Enum.KeyCode.A then
		flycontrol.a = true
	end

	if input.KeyCode == Enum.KeyCode.S then
		flycontrol.s = true
	end

	if input.KeyCode == Enum.KeyCode.D then
		flycontrol.d = true
	end

	if input.KeyCode == Enum.KeyCode.Space then
		if toggles.InfJump.Value and not toggles.Fly.Value then
			Action(plr.Character.Humanoid, function(self)
				if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
					Action(self.Parent.HumanoidRootPart, function(self)
						self.Velocity = Vector3.new(self.Velocity.X, 50, self.Velocity.Z);
					end)
				end
			end)
		end
	end

	if getgenv().FlyKeybind ~= "Unbinded" and input.KeyCode == getgenv().FlyKeybind then
		toggles.Fly:SetValue(not toggles.Fly.Value)
	end

	if getgenv().FlyKeybind ~= "Unbinded" and input.KeyCode == getgenv().SpeedKeybind then
		toggles.Speed:SetValue(not toggles.Speed.Value)
	end

	if getgenv().NoClipKeybind ~= "Unbinded" and input.KeyCode == getgenv().NoClipKeybind then
		toggles.NoClip:SetValue(not toggles.NoClip.Value)
	end

	if getgenv().ClimbSpeedKeybind ~= "Unbinded" and input.KeyCode == getgenv().ClimbSpeedKeybind then
		toggles.Climb:SetValue(not toggles.Climb.Value)
	end

	if getgenv().ManaChargeKeybind ~= "Unbinded" and input.KeyCode == getgenv().ManaChargeKeybind then
		toggles.ManaCharge:SetValue(not toggles.ManaCharge.Value)
	end

	if getgenv().InfJumpKeybind ~= "Unbinded" and input.KeyCode == getgenv().InfJumpKeybind then
		toggles.InfJump:SetValue(not toggles.InfJump.Value)
	end
end)

uis.InputEnded:Connect(function(input, process)
	if process then
		return
	end

	if input.UserInputType ~= Enum.UserInputType.Keyboard then
		return
	end

	if input.KeyCode == Enum.KeyCode.W then
		flycontrol.w = false
	end

	if input.KeyCode == Enum.KeyCode.A then
		flycontrol.a = false
	end

	if input.KeyCode == Enum.KeyCode.S then
		flycontrol.s = false
	end

	if input.KeyCode == Enum.KeyCode.D then
		flycontrol.d = false
	end
end)


--[[
Modifying mana climb speed = change Armor Data (ReplicatedStorage.Outfits[player.Data.Armor.Value].Stats) -- Stat name = ClimbBoost
Auto mana charge = check for the mana value (Character.Stats.Mana.Value) --
remote:
game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.KeyInput
code:
-- Script generated by SimpleSpy - credits to exx#9394

local args = {
    [1] = Enum.KeyCode.G,
    [2] = false
}

game:GetService("Players").LocalPlayer.Character.CharacterHandler.Remotes.KeyInput:FireServer(unpack(args))

]]

--
getgenv().Bypassed = false
toggles.FullBypass:OnChanged(function()
	if toggles.FullBypass.Value == true and not getgenv().Bypassed then
		getgenv().Bypassed = true
		Bypass()
	end
end)

--Flying Part

task.spawn(function()
	while true do
		if toggles.Fly.Value then
			if hum ~= nil and root ~= nil then
				if hum.SeatPart then
					hum.Jump = true
				else
					local speed = options.FlySpeed.Value
					local direction = (mouse.Hit.Position - root.Position).Unit
					local vel = direction * (math.random((math.random(1, 2) - 1) * 0, (math.random(1, 2) + 2.5) * 0) / 1000); -- adds random speed so the velocity doesn't always measure to a certain amount (prevents detection)
					local pos = root.Position * 10;

					if (flycontrol.w or flycontrol.a or flycontrol.d) and not flycontrol.s then
						vel = direction * (math.random((speed - 1) * 1000, (speed + 2.5) * 1000) / 1000)
					elseif flycontrol.s then
						vel = -direction * (math.random((speed - 1) * 1000, (speed + 2.5) * 1000) / 1000)
					end

					if not (flycontrol.w or flycontrol.a or flycontrol.d or flycontrol.s) then
						speed = 0.1
						direction = (mouse.Hit.Position - root.Position).Unit
						vel = direction * (math.random((math.random(1, 2) - 1) * 0, (math.random(1, 2) + 2.5) * 0) / 1000); -- adds random speed so the velocity doesn't always measure to a certain amount (prevents detection)
						pos = root.Position * 10;
					end
					root.Velocity = vel
				end
			end
		end
		rs.RenderStepped:Wait()
	end
end)

-- Mana Charge

task.spawn(function()
	local on = {
		[1] = Enum.KeyCode.G,
		[2] = true
	}

	local off = {
		[1] = Enum.KeyCode.G,
		[2] = false
	}

	while true do
		local currentMana = char.Stats.Mana.Value
		local max = options.Max.Value
		local min = options.Min.Value

		if toggles.ManaCharge.Value == true then
			local input = char.CharacterHandler.Remotes.KeyInput
			char.Stats.ManaCharge.Value = false
			if toggles.Interval then
				if currentMana > max then
					input:FireServer(Enum.KeyCode.G, false)
				end
				if currentMana < min then
					input:FireServer(Enum.KeyCode.G, true)
				end
			else
				input:FireServer(Enum.KeyCode.G, true)
			end
		end

		rs.RenderStepped:Wait()
	end
end)

-- Climb Speed

task.spawn(function()
	local armors = {}
	local oldSpeed = {}

	while true do
		if toggles.Climb.Value == true then
			for i, v in pairs(game:GetService("ReplicatedStorage").Outfits:GetChildren()) do
				wait()
				if not v:FindFirstChild("ClimbSpeed") then
					local new = Instance.new("IntValue")
					new.Name = "ClimbSpeed"
					new.Value = 0
					new.Parent = v
				end

				table.insert(armors, v)
				oldSpeed[v.Name] = v:FindFirstChild("ClimbSpeed").Value
			end
			local armor = plr.Data.Armor.Value
			game:GetService("ReplicatedStorage").Outfits[armor].ClimbSpeed.Value = options.ClimbSpeed.Value
		else
			for nam, oldspeed in pairs(oldSpeed) do
				game:GetService("ReplicatedStorage").Outfits[nam].ClimbSpeed.Value = oldspeed[nam]
			end
		end

		rs.RenderStepped:Wait()
	end
end)

local picked = {}

task.spawn(function()
	while true do
		if toggles.AutoLoot.Value == true then
			for _, loot in pairs(game.Workspace.MouseIgnore:GetChildren()) do
				local lootBase = loot:FindFirstChildWhichIsA("BasePart")
				if lootBase and not picked[lootBase] then
					picked[lootBase] = true
					local cd = lootBase.ClickPart:FindFirstChildWhichIsA("ClickDetector")
					local distance = cd.MaxActivationDistance
					fireclickdetector(cd, distance)
				end
			end
		end
		rs.RenderStepped:Wait()
	end
end)

task.spawn(function()
	while wait(1) do
		picked = {}
	end
end)

--

--

task.spawn(function()
	local oldws = hum.WalkSpeed
	while true do
		if toggles.Speed.Value == true then
			local speed = options.SpeedCheat.Value
			hum.WalkSpeed = speed
		else
			hum.WalkSpeed = oldws
		end
		rs.RenderStepped:Wait()
	end
end)

task.spawn(function()
	while true do
		local falldamage
		if char:FindFirstChild("FallDamage") then
			falldamage = char.FallDamage
		end
		if toggles.NoFall.Value then
			if falldamage then
				falldamage.Disabled = true
			end
		else
			if falldamage then
				falldamage.Disabled = false
			end
		end
		rs.RenderStepped:Wait()
	end
end)



task.spawn(function()
	while true do
		if toggles.NoStun.Value then
			local blacklist = {
				"InFlock";
				"LightAttack";
				"Attack";
				"HeavyAttack";
				"Stun";
				"ReturnStun";
				"ActiveCast";
				"Action";
				"Blocking";
				"Climbing";
				"NoJump"
			}

			local AliveData = game.Workspace.AliveData:FindFirstChild(plr.Name)
			for _, v in pairs(blacklist) do
				if AliveData.Status:FindFirstChild(v) then
					AliveData.Status[v]:Destroy()
				end
			end
		end
		rs.RenderStepped:Wait()
	end
end)

task.spawn(function()
	while true do
		if toggles.NoClip.Value then
			char.Head.CanCollide = false
			char.Torso.CanCollide = false
			rs.Stepped:Wait()
		else
			wait()
		end
	end
end)

rs.RenderStepped:Connect(function()--update stuff man
	plr = game:GetService("Players").LocalPlayer
	char = plr.Character or plr:WaitForChild("Character")
	hum = char:WaitForChild("Humanoid")
	root = char:WaitForChild("HumanoidRootPart")

	mouse = plr:GetMouse()
	mouse.TargetFilter = game.Workspace
	camera = workspace.CurrentCamera

	toggles = getgenv().Toggles or {}
	options = getgenv().Options or {}

	getgenv().FlyKeybind = options.FlyKeybind.Value ~= "" and Enum.KeyCode[options.FlyKeybind.Value] or "Unbinded"
	getgenv().SpeedKeybind = options.SpeedKeybind.Value ~= "" and Enum.KeyCode[options.SpeedKeybind.Value] or "Unbinded"
	getgenv().NoClipKeybind = options.NoClipKeybind.Value ~= "" and Enum.KeyCode[options.NoClipKeybind.Value] or "Unbinded"
	getgenv().ClimbSpeedKeybind = options.ClimbSpeedKeybind.Value ~= "" and Enum.KeyCode[options.ClimbSpeedKeybind.Value] or "Unbinded"
	getgenv().ManaChargeKeybind = options.ManaChargeKeybind.Value ~= "" and Enum.KeyCode[options.ManaChargeKeybind.Value] or "Unbinded"
	getgenv().InfJumpKeybind = options.InfJumpKeybind.Value ~= "" and Enum.KeyCode[options.InfJumpKeybind.Value] or "Unbinded"

	Settings["Fly"] = toggles.Fly.Value

	Settings["FlyKey"] = options.FlyKeybind.Value
	Settings["SpeedKey"] = options.SpeedKeybind.Value
	Settings["NoClipKey"] = options.NoClipKeybind.Value
	Settings["ClimbKey"] = options.ClimbSpeedKeybind.Value
	Settings["ManaChargeKey"] = options.ManaChargeKeybind.Value
	Settings["InfJumpKey"] = options.InfJumpKeybind.Value
end)

--Player ESP


--Trinket ESP
local AllowedTrinkets = {
	["Goblet"] = false;
	["Old Ring"] = false;
	["Ring"] = false;
	["Amulet"] = false;
	["Old Amulet"] = false;
	["Idol of the Forgotten"] = false;
	["Scroll"] = false
}
local AllowedGems = {
	["Right Gem"] = false;
	["Emerald"] = false;
	["Ruby"] = false;
	["Sapphire"] = false;
	["Diamond"] = false;
	["Opal"] = false
}
local AllowedArtifacts = {
	["Philosopher's Stone"] = false;
	["Mana Essence"] = false;
	["White King's Amulet"] = false;
	["Fair Frozen"] = false;
	["Lannis's Amulet"] = false;
	["???"] = false;
	["Spider Cloak"] = false;
	["Phoenix Down"] = false;
	["Phoenix Feather"] = false
}

local items = {}
local taggeditems = {}
local lineditems = {}

local plr = game:GetService("Players").LocalPlayer
local char = plr.Character
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local camera = workspace.CurrentCamera

local rs = game:GetService("RunService")

task.spawn(function()
	function WorldToScreen(part, idx)
		if part ~= nil then
			root = part.position
			local scr, vis = camera:WorldToScreenPoint(root)
			if vis then
				items[idx].Visible = true
				return Vector2.new(scr.x, scr.y)
			else
				items[idx].Visible = false
				return Vector2.new(0, 0)
			end
		else
			items[idx].Visible = false
			return Vector2.new(0, 0)
		end
	end
	while true do
		for index, item in pairs(game.Workspace.MouseIgnore:GetChildren()) do
			if item:IsA("Model") then
				local itemPart = item:FindFirstChildWhichIsA("BasePart")
				if not taggeditems[item] and (AllowedTrinkets[itemPart.Name] or AllowedGems[itemPart.Name] or AllowedArtifacts[itemPart.Name]) then
					taggeditems[item] = true
					items[index] = Drawing.new("Text")
					--table.insert(lineditems, Drawing.new("Line"))

					if itemPart ~= nil and items[index] ~= nil then
						if AllowedTrinkets[itemPart.Name] then
							items[index].Text = itemPart.Name
							items[index].Size = 15.0
							items[index].Color = Color3.fromRGB(255, 255, 255)
							items[index].Outline = true
							items[index].Center = true

							local pos = WorldToScreen(itemPart, index)
							items[index].Position = pos
						end
						if AllowedGems[itemPart.Name] then
							items[index].Text = itemPart.Name
							items[index].Size = 15.0
							items[index].Color = Color3.fromRGB(0, 207, 17)
							items[index].Outline = true
							items[index].Center = true

							local pos = WorldToScreen(itemPart, index)
							items[index].Position = pos
						end
						if AllowedArtifacts[itemPart.Name] then
							items[index].Text = itemPart.Name
							items[index].Size = 15.0
							items[index].Color = Color3.fromRGB(207, 0, 3)
							items[index].Outline = true
							items[index].Center = true

							local pos = WorldToScreen(itemPart, index)
							items[index].Position = pos
						end
					end
				else
					if (AllowedTrinkets[itemPart.Name] or AllowedGems[itemPart.Name] or AllowedArtifacts[itemPart.Name]) then
						if AllowedTrinkets[itemPart.Name] then
							items[index].Text = itemPart.Name
							items[index].Size = 15.0
							items[index].Color = Color3.fromRGB(255, 255, 255)
							items[index].Outline = true
							items[index].Center = true

							local pos = WorldToScreen(itemPart, index)
							items[index].Position = pos
						end
						if AllowedGems[itemPart.Name] then
							items[index].Text = itemPart.Name
							items[index].Size = 15.0
							items[index].Color = Color3.fromRGB(0, 207, 17)
							items[index].Outline = true
							items[index].Center = true

							local pos = WorldToScreen(itemPart, index)
							items[index].Position = pos
						end
						if AllowedArtifacts[itemPart.Name] then
							items[index].Text = itemPart.Name
							items[index].Size = 15.0
							items[index].Color = Color3.fromRGB(207, 0, 3)
							items[index].Outline = true
							items[index].Center = true

							local pos = WorldToScreen(itemPart, index)
							items[index].Position = pos
						end
					end
				end
			end
		end
		rs.RenderStepped:Wait()
	end
end)

task.spawn(function()
	local plrsBox = {}
	local nameinfo = {}
	local hpinfo = {}
	local distinfo = {}

	local classInfo = {}
	local silverInfo = {}
	local artifInfo = {}
	function WorldToScreen(part, idx)
		if part ~= nil then
			root = part.position
			local scr, vis = camera:WorldToScreenPoint(root)
			if vis then
				plrsBox[idx].Visible = true
				return Vector2.new(scr.x, scr.y)
			else
				plrsBox[idx].Visible = false
				return Vector2.new(0, 0)
			end
		else
			plrsBox[idx].Visible = false
			return Vector2.new(0, 0)
		end
	end

	while true do
		if toggles.plrESP then
			for index, trg in pairs(game.Workspace.Alive:GetChildren()) do
				if trg and trg:FindFirstChild("Humanoid") and trg:FindFirstChild("HumanoidRootPart") and game:GetService("Players"):GetPlayerFromCharacter(trg) then
					local trgplr = game:GetService("Players"):GetPlayerFromCharacter(trg)
					local hrp = trg:FindFirstChild("HumanoidRootPart")
					local thum = trg:FindFirstChild("Humanoid")
					plrsBox[index] = Drawing.new("Square")
					plrsBox[index].Thickness = 2
					plrsBox[index].Size = Vector2.new(8, 4)
					plrsBox[index].Filled = false

					local pos = WorldToScreen(hrp, index)
					plrsBox[index].Position = pos

					if toggles.DisplayName.Value and not toggles.DisplayHP.Value then
						nameinfo[index] = Drawing.new("Text")
						nameinfo[index].Text = trgplr.Name
						nameinfo[index].Size = 24
						nameinfo[index].Center = true
						nameinfo[index].Outline = true

						local pos = WorldToScreen(hrp, index)
						nameinfo[index].Position = pos + Vector2.new(0, -5)
					elseif toggles.DisplayName.Value and  toggles.DisplayHP.Value then
						nameinfo[index] = Drawing.new("Text")
						nameinfo[index].Text = trgplr.Name.." | "
						nameinfo[index].Size = 24
						nameinfo[index].Center = true
						nameinfo[index].Outline = true

						local pos = WorldToScreen(hrp, index)
						nameinfo[index].Position = pos + Vector2.new(-3, -5)
					else
						nameinfo = {}
					end

					if toggles.DisplayHP.Value and not toggles.DisplayName.Value then
						nameinfo[index] = Drawing.new("Text")
						nameinfo[index].Text = thum.Health.."/"..thum.MaxHealth.."|"..tostring(math.round((thum.Health * 100) / thum.MaxHealth))
						nameinfo[index].Size = 24
						nameinfo[index].Center = true
						nameinfo[index].Outline = true

						local pos = WorldToScreen(hrp, index)
						nameinfo[index].Position = pos + Vector2.new(0, -5)
					elseif toggles.DisplayName.Value and  toggles.DisplayHP.Value then
						nameinfo[index] = Drawing.new("Text")
						nameinfo[index].Text = thum.Health.."/"..thum.MaxHealth.."|"..tostring(math.round((thum.Health * 100) / thum.MaxHealth))
						nameinfo[index].Size = 24
						nameinfo[index].Center = true
						nameinfo[index].Outline = true

						local pos = WorldToScreen(hrp, index)
						nameinfo[index].Position = pos + Vector2.new(3, -5)
					else
						hpinfo = {}
					end
				end
			end
		end

		rs.Stepped:Wait()
	end
end)

--[[
game.Workspace.MouseIgnore.ChildAdded:Connect(function(item)
	while item.Parent == game.Workspace.MouseIgnore do
		if item:IsA("Model") then
			local itemPart = item:FindFirstChildWhichIsA("BasePart") or item:FindFirstChildWhichIsA("MeshPart")
			if not taggeditems[item] and (AllowedTrinkets[itemPart.Name] or AllowedGems[itemPart.Name] or AllowedArtifacts[itemPart.Name]) then
				taggeditems[item] = true
				items[#items + 1] = Drawing.new("Text")
				--table.insert(lineditems, Drawing.new("Line"))

				if itemPart ~= nil and items[#items + 1] ~= nil then
					if AllowedTrinkets[itemPart.Name] then
						items[#items + 1].Text = itemPart.Name
						items[#items + 1].Size = 15.0
						items[#items + 1].Color = Color3.fromRGB(255, 255, 255)
						items[#items + 1].Outline = true
						items[#items + 1].Center = true

						local pos = WorldToScreen(itemPart, #items + 1)
						items[#items + 1].Position = pos
					end
					if AllowedGems[itemPart.Name] then
						items[#items + 1].Text = itemPart.Name
						items[#items + 1].Size = 15.0
						items[#items + 1].Color = Color3.fromRGB(0, 207, 17)
						items[#items + 1].Outline = true
						items[#items + 1].Center = true

						local pos = WorldToScreen(itemPart, #items + 1)
						items[#items + 1].Position = pos
					end
					if AllowedArtifacts[itemPart.Name] then
						items[#items + 1].Text = itemPart.Name
						items[#items + 1].Size = 15.0
						items[#items + 1].Color = Color3.fromRGB(207, 0, 3)
						items[#items + 1].Outline = true
						items[#items + 1].Center = true

						local pos = WorldToScreen(itemPart, #items + 1)
						items[#items + 1].Position = pos
					end
				end
			else
				if (AllowedTrinkets[itemPart.Name] or AllowedGems[itemPart.Name] or AllowedArtifacts[itemPart.Name]) then
					if AllowedTrinkets[itemPart.Name] then
						items[#items + 1].Text = itemPart.Name
						items[#items + 1].Size = 15.0
						items[#items + 1].Color = Color3.fromRGB(255, 255, 255)
						items[#items + 1].Outline = true
						items[#items + 1].Center = true

						local pos = WorldToScreen(itemPart, #items + 1)
						items[#items + 1].Position = pos
					end
					if AllowedGems[itemPart.Name] then
						items[#items + 1].Text = itemPart.Name
						items[#items + 1].Size = 15.0
						items[#items + 1].Color = Color3.fromRGB(0, 207, 17)
						items[#items + 1].Outline = true
						items[#items + 1].Center = true

						local pos = WorldToScreen(itemPart, #items + 1)
						items[#items + 1].Position = pos
					end
					if AllowedArtifacts[itemPart.Name] then
						items[#items + 1].Text = itemPart.Name
						items[#items + 1].Size = 15.0
						items[#items + 1].Color = Color3.fromRGB(207, 0, 3)
						items[#items + 1].Outline = true
						items[#items + 1].Center = true

						local pos = WorldToScreen(itemPart, #items + 1)
						items[#items + 1].Position = pos
					end
				end
			end
		end
		rs.RenderStepped:Wait()
	end
end)
--]]
task.spawn(function()
	while true do
		--Trinkets start
		if toggles.GobletESP.Value then
			AllowedTrinkets.Goblet = true
		else
			AllowedTrinkets.Goblet = false
		end
		if toggles.OldRingESP.Value then
			AllowedTrinkets["Old Ring"] = true
		else
			AllowedTrinkets["Old Ring"] = false
		end
		if toggles.RingESP.Value then
			AllowedTrinkets.Ring = true
		else
			AllowedTrinkets.Ring = false
		end
		if toggles.AmuletESP.Value then
			AllowedTrinkets.Amulet = true
		else
			AllowedTrinkets.Amulet = false
		end
		if toggles.OldAmuletESP.Value then
			AllowedTrinkets["Old Amulet"] = true
		else
			AllowedTrinkets["Old Amulet"] = false
		end
		if toggles.IdolESP.Value then
			AllowedTrinkets["Idol of the Forgotten"] = true
		else
			AllowedTrinkets["Idol of the Forgotten"] = false
		end
		if toggles.ScrollESP.Value then
			AllowedTrinkets.Scroll = true
		else
			AllowedTrinkets.Scroll = false
		end
		--Trinkets end

		--Gems start
		if toggles.RiftGemESP.Value then
			AllowedGems["Right Gem"] = true
		else
			AllowedGems["Right Gem"] = false
		end
		if toggles.EmeraldESP.Value then
			AllowedGems.Emerald = true
		else
			AllowedGems.Emerald = false
		end
		if toggles.SapphireESP.Value then
			AllowedGems.Sapphire = true
		else
			AllowedGems.Sapphire = false
		end
		if toggles.RubyESP.Value then
			AllowedGems.Ruby = true
		else
			AllowedGems.Ruby = false
		end
		if toggles.DiamondESP.Value then
			AllowedGems.Diamond = true
		else
			AllowedGems.Diamond = false
		end
		if toggles.OpalESP.Value then
			AllowedGems.Opal = true
		else
			AllowedGems.Opal = false
		end
		--Gems end

		--Artifacts start
		if toggles.PhiloESP.Value then
			AllowedArtifacts["Philosopher's Stone"] = true
		else
			AllowedArtifacts["Philosopher's Stone"] = false
		end
		if toggles.ManaEssESP.Value then
			AllowedArtifacts["Mana Essence"] = true
		else
			AllowedArtifacts["Mana Essence"] = false
		end
		if toggles.WKAESP.Value then
			AllowedArtifacts["White King's Amulet"] = true
		else
			AllowedArtifacts["White King's Amulet"] = false
		end
		if toggles.FFESP.Value then
			AllowedArtifacts["Fair Frozen"] = true
		else
			AllowedArtifacts["Fair Frozen"] = false
		end
		if toggles.LannisESP.Value then
			AllowedArtifacts["Lannis's Amulet"] = true
		else
			AllowedArtifacts["Lannis's Amulet"] = false
		end
		if toggles.QMESP.Value then
			AllowedArtifacts["???"] = true
		else
			AllowedArtifacts["???"] = false
		end
		if toggles.PDESP.Value then
			AllowedArtifacts["Phoenix Down"] = true
		else
			AllowedArtifacts["Phoenix Down"] = false
		end
		if toggles.SCESP.Value then
			AllowedArtifacts["Spider Cloak"] = true
		else
			AllowedArtifacts["Spider Cloak"] = false
		end
		if toggles.PFESP.Value then
			AllowedArtifacts["Phoenix Feather"] = true
		else
			AllowedArtifacts["Phoenix Feather"] = false
		end

		wait()
	end
end)

uiLib:Notify("Loaded press RightControl to show/hide UI!")
