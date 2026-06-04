--After You Executed The Script,
--If You Are In A Round, Back To Menu Then Join The Round Again, The Unsuals Swapping Should Take Effects And The Emote Swapping Too
--Press "R" To Reload The Invisible Wall Remover
--Press "L" To Activate The Save And TP Script, "," To Save The Current Position, "T" To Load The Saved Position
--Note That After You Went From Menu To The Game, You Have To Press "L" Again To Activate Save And TP Script
local rightLeg = game.Workspace.Game.Players.nguyenvudung112:WaitForChild("Right Leg")
--local nameUnusual1 = "Charming Heart"
--local nameUnusual2 = "ToxicInferno"
local nameEmote1 = "SnowmobileCruise"
local nameEmote2 = "Broom"
local nameEmote3 = "BoldMarch"
local nameEmote4 = "RockinStride"
local function saveAndTP() local UserInputService = game:GetService("UserInputService");local shortcut = game.workspace.Game.Players;local playerName = game.Players.LocalPlayer.Name;local playerFolder = shortcut:FindFirstChild(playerName);if not playerFolder then return end;local HRP = playerFolder:FindFirstChild("HumanoidRootPart");if not HRP then return end;local position;UserInputService.InputBegan:Connect(function(input, gameProcessed) if gameProcessed then return end;if input.KeyCode == Enum.KeyCode.Comma then position = HRP.Position;print("Saved, Position: ", HRP.Position) end;if input.KeyCode == Enum.KeyCode.T then if not position then return end;HRP.Position = position; print("Loaded, Position: ", HRP.Position) end end) end
--local function changeUnusual() local function toggleNames(root) for _, obj in ipairs(root:GetDescendants()) do if obj.Name == nameUnusual1 then obj.Name = nameUnusual2;elseif obj.Name == nameUnusual2 then obj.Name = nameUnusual1 end end end;toggleNames(game:GetService("Players").LocalPlayer);toggleNames(game:GetService("Workspace"));toggleNames(game:GetService("ReplicatedStorage")) end
local function changeEmote1() local function toggleNames(root) for _, obj in ipairs(root:GetDescendants()) do if obj.Name == nameEmote1 then obj.Name = nameEmote2;elseif obj.Name == nameEmote2 then obj.Name = nameEmote1;end end end;toggleNames(game:GetService("Players").LocalPlayer);toggleNames(game:GetService("Workspace"));toggleNames(game:GetService("ReplicatedStorage"));changeUnusual() end
local function changeEmote2() local function toggleNames(root) for _, obj in ipairs(root:GetDescendants()) do if obj.Name == nameEmote3 then obj.Name = nameEmote4 elseif obj.Name == nameEmote4 then obj.Name = nameEmote3 end end end;toggleNames(game:GetService("Players").LocalPlayer);toggleNames(game:GetService("Workspace"));toggleNames(game:GetService("ReplicatedStorage"));changeEmote1() end
local function changeDaylight()
    local rainsound = game.Workspace.Camera.Outdoors
    local rainvisual = game.Workspace.Camera.Rain
    local Lighting = game:GetService("Lighting")
    local function changeTime()
        rainvisual:Destroy()
        rainsound:Destroy()
        Lighting.ClockTime = 12
        Lighting.Sky:Destroy()
    end
    changeTime()
    Lighting.Changed:Connect(changeTime)
end
local function HLAKB()
    local alwaystrue = game
    local shortcut = game.workspace.Game.Players
    local playerName = game.Players.LocalPlayer.Name

    local player = shortcut:FindFirstChild(playerName)
    if not player then return end

    local head = player:FindFirstChild("Head")

    local rightleg = player:FindFirstChild("Right Leg")

    local alreadyKorblox = player:FindFirstChild("KorbloxRightLeg")

    -- add "--" to the line that you dont want to remove
    if alwaystrue then
        if head then
            head.Transparency = 1
        end
        if rightleg then
            rightleg.Transparency = 1
        end
        -- Korblox Right Leg Spawn
        if not alreadyKorblox then
            local korbloxLeg = Instance.new("Part")
            korbloxLeg.Name = "KorbloxRightLeg"
            korbloxLeg.Size = Vector3.new(1,1,1)
            korbloxLeg.CanCollide = false
            korbloxLeg.Massless = true
            korbloxLeg.Parent = player

            local mesh = Instance.new("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = "rbxassetid://101851696"
            mesh.TextureId = "rbxassetid://101851254"
            mesh.Scale = Vector3.new(1,1,1)
            mesh.Parent = korbloxLeg

            korbloxLeg.CFrame = rightleg.CFrame

            local weld = Instance.new("WeldConstraint")
            weld.Part0 = korbloxLeg
            weld.Part1 = rightleg
            weld.Parent = korbloxLeg
        end
    end
end
local function wallRemover()
    local Players=game:GetService("Players")
    local Workspace=game:GetService("Workspace")
    local StarterGui=game:GetService("StarterGui")
    local ReplicatedStorage=game:GetService("ReplicatedStorage")
    local RunService=game:GetService("RunService")
    local UserInputService=game:GetService("UserInputService")
    local storedParts={}
    local function getRepairKeywords()
      return {"stair", "step", "ramp", "trimp", "platform", "invisibleplatform", "floor", "ground", "pad", "road", "path", "bridge", "fence"}
    end
    local function isGameplayPart(name)
      local repairKeywords=getRepairKeywords()
      name=string.lower(name)
      for _,keyword in pairs(repairKeywords) do
        if name:find(keyword) then
          return true
        end
      end
      return false
    end
    local function destroyAndStore()
      local destroyedCount=0
      local storedCount=0
      for _,obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
          local name=string.lower(obj.Name)
          local shouldDestroy=false
          if name:find("water") or name:find("sea") then
            shouldDestroy=true
          elseif obj.CanCollide and obj.Transparency>=0.8 and obj.Position.Y>50 and not isGameplayPart(name) then
            shouldDestroy=true
          end
          if shouldDestroy then
            pcall(function() obj:Destroy(); destroyedCount=destroyedCount+1 end)
          end
          if isGameplayPart(name) and obj.CanCollide==true then
            local newPart=obj:Clone()
            newPart.Parent=nil
            table.insert(storedParts,newPart)
            pcall(function() obj:Destroy() end)
            storedCount=storedCount+1
          end
        end
      end
      return storedCount,destroyedCount
    end
    local function restoreStoredParts()
      local restoredCount=0
      local mapParent=Workspace:FindFirstChild("Map") or Workspace:FindFirstChild("Level") or Workspace
      if not mapParent then return 0 end
      for _,part in pairs(storedParts) do
        pcall(function()
          part.Parent=mapParent
          restoredCount=restoredCount+1
        end)
      end
      storedParts={}
      return restoredCount
    end
    local function runCleanAndFix()
      local stored,destroyed=destroyAndStore()
      task.wait(0.2)
      local restored=restoreStoredParts()
      if destroyed>0 or restored>0 then
        StarterGui:SetCore("SendNotification",{
          Title="MAP REGENERATION",
          Text=string.format("Ramp reset: %d. Walls destroyed: %d. Restored: %d.",stored,destroyed,restored),
          Duration=6
        })
      else
        StarterGui:SetCore("SendNotification",{
          Title="CLEAN",
          Text="No issues found yo",
          Duration=3
        })
      end
    end
    local function runRefresh()
      if #storedParts>0 then
        local restored=restoreStoredParts()
        StarterGui:SetCore("SendNotification",{
          Title="map drugs",
          Text=string.format("Restored %d parts.",restored),
          Duration=3
        })
      end
      runCleanAndFix()
    end
    UserInputService.InputBegan:Connect(function(input,gameProcessed)
      if gameProcessed then return end
      if input.KeyCode==Enum.KeyCode.R then
        runRefresh()
      end
    end)
    pcall(function()
      StarterGui:SetCore("SendNotification",{
        Title="invis walls removed bruh",
        Text="invis walls should be removed,please follow me on @milkanolol,dm @lpvv on dc if questions/concerns",
        Duration=6
      })
    end)
    pcall(function()
      StarterGui:SetCore("SendNotification",{
        Title="Bond R",
        Text="Click R to refresh the script plz",
        Duration=6
      })
    end)
end
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.L then
        saveAndTP()
    end
end)
if rightLeg then
    HLAKB()
end
wallRemover()
changeDaylight()
changeEmote2()
