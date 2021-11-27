local Repl = game:GetService("ReplicatedStorage")

local Remotes = Repl:WaitForChild("Remotes")
local RequestRemote = Remotes:WaitForChild("Request")
local RenderRemote = Remotes:WaitForChild("Render")

local Effects = Repl:WaitForChild("Effects")

local Server = {}

function Server.Broadcast(effectName)
	if Effects:FindFirstChild(effectName) then
		RenderRemote:FireAllClients(effectName)
	end
end

return Server