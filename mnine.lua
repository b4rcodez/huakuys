task.wait(10)

local v2 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
while not v2.Loaded do
	game:GetService("RunService").Heartbeat:Wait();
end;
local Network = require(game:GetService("ReplicatedStorage").Library.Client.Network)
local Client = require(game:GetService("ReplicatedStorage").Library.Client)
local Fire, Invoke = Network.Fire, Network.Invoke
local Coins = Workspace["__THINGS"].Coins
local old
old = hookfunction(getupvalue(Fire, 1), function(...)
   return true
end)

local function getNearestCoin()
    local TargetDistance = math.huge
    local Target
    for i, v in ipairs(Coins:GetChildren()) do
        if v:FindFirstChild("Coin") then
            local Mag = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v:FindFirstChild("Coin").Position).Magnitude
            if Mag < TargetDistance then
                TargetDistance = Mag
                Target = v
                --print(v.Name)
            end
        end
    end
    return Target
end
local function teleport()
    local v1 = require(game.ReplicatedStorage:WaitForChild("Framework"):WaitForChild("Library"));
    local Client = require(game:GetService("ReplicatedStorage").Library.Client)
    local function teleport(map)
            syn.set_thread_identity(2)
            task.wait(1)
            local maps = map
        
        
        
            local v17 = v1.Directory.Areas[maps];
            if v1.WorldCmds.Get() ~= v17.world then
                if not v1.WorldCmds.Load(v17.world) then
                    print('failed')
                    return false, "World failed to load!";
                end;
            end;
        
            local v18 = v1.WorldCmds.GetMap().Teleports:FindFirstChild(maps);
            if not v18 then
                --print(v18)
                return false, "No such teleport for area!";
            end;
            assert(v18);
        
            local l__LocalPlayer__19 = v1.LocalPlayer;
            local v20 = l__LocalPlayer__19.Character or l__LocalPlayer__19.CharacterAdded:Wait();
            local l__Humanoid__21 = v20:WaitForChild("Humanoid");
            local l__HumanoidRootPart__22 = v20:WaitForChild("HumanoidRootPart");
            v1.Signal.Fire("Teleporting");
            task.wait(0.25);
            local l__CFrame__23 = v18.CFrame;
            v20:PivotTo(l__CFrame__23 + l__CFrame__23.UpVector * (l__Humanoid__21.HipHeight + l__HumanoidRootPart__22.Size.Y / 2));
        
            Fire("Performed Teleport", maps);
            syn.set_thread_identity(7)
            task.wait(0.5)
        end
        teleport("Mystic Mine")
        task.wait(2)
        padteleport = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position+Vector3.new(5,30,-340))
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(padteleport)
        task.wait(2)
end
local function farm()
    task.wait(5)
    repeat
        task.wait()
    until (#Workspace["__THINGS"].Coins:GetChildren() > 0)
    teleport()
    local count = 0
    local petsname = {}
    local Pets = Client.PetCmds.GetEquipped()
    
for K,O in pairs(Pets) do
        petsname[K] = O.uid
        --Invoke('Join Coin', getNearestCoin().Name, {O.uid})
        --Fire('Farm Coin', getNearestCoin().Name, O.uid)
            
    end 
    while count <= 600 do
        task.wait(0.1)
        if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Orange")) ~= nil then
            local orangestr = game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts.Orange.TimeLeft.Text
            local orange = tonumber(string.match(orangestr, '%d[%d.,]*'))
            count = orange
        else
            count = 0
        end
        print(count)
        a = getNearestCoin().Name
        
	Invoke('Join Coin', a, petsname)
        for K,O in pairs(Pets) do
        Fire('Farm Coin', a, O.uid)
        end
        --Fire('Farm Coin', getNearestCoin().Name,petsname)
	    for i,v in pairs(Workspace["__THINGS"].Orbs:GetChildren()) do
                v.CFrame = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            end 
            for i,v in pairs(Workspace["__THINGS"].Lootbags:GetChildren()) do
                v.CFrame = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame)
            end
    end
    print('hee')
    
end


if (game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts:FindFirstChild("Orange")) ~= nil then

    local orangestr = game:GetService("Players").LocalPlayer.PlayerGui.Main.Boosts.Orange.TimeLeft.Text
    local orange = tonumber(string.match(orangestr, '%d[%d.,]*'))
    print('first', orange)
    if orange <= 500 then
        farm()
    end
    print('hee')
else
    farm()
end
