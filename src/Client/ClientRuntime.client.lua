
local Repl = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Remotes = Repl:WaitForChild("Remotes")
local RequestRemote = Remotes:WaitForChild("Request")

local Modules = Repl:WaitForChild("Modules")
local FXBlue = require(Modules:WaitForChild("FX-Blue"))

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    if input.KeyCode == Enum.KeyCode.R then
        RequestRemote:FireServer("Test")
        --            effect name ^
    end
end)

FXBlue.Init()