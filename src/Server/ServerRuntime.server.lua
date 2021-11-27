-- Server Runtime
local Repl = game:GetService("ReplicatedStorage")

local Remotes = Repl:WaitForChild("Remotes")
local RequestRemote = Remotes:WaitForChild("Request")

local Modules = Repl:WaitForChild("Modules")
local FXBlue = require(Modules:WaitForChild("FX-Blue"))

RequestRemote.OnServerEvent:Connect(function(player, effectName)
    FXBlue.Broadcast(effectName)
end)