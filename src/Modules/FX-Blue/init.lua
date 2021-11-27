local RunService = game:GetService("RunService")
if RunService:IsServer() then
	return require(script:WaitForChild("FX-Blue-Server"))
elseif RunService:IsClient() then
	return require(script:WaitForChild("FX-Blue-Client"))
end