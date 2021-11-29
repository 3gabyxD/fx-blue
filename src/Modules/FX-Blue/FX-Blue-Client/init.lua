-- Client Runtime
local Repl = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Remotes = Repl:WaitForChild("Remotes")
local RenderRemote = Remotes:WaitForChild("Render")

local Effects = Repl:WaitForChild("Effects")
local RunningEffects = {}

local ease = require(script:WaitForChild("ease"))

local function runEffect(info, origin)

    local _info = require(info)

    local duration = 0
    for _, frameset in pairs(_info.frames) do
        local final = frameset[#frameset].time
        if duration < final then duration = final end
    end

    local dump = {}
    for _, asset in pairs(_info.assets) do
        -- TODO: support custom folders
        local object = info:FindFirstChild(asset)
        dump[asset] = object:Clone()
        dump[asset].Parent = workspace
    end

    table.insert(RunningEffects, {
        info = _info,
        time = 0,
        duration = duration,
        dump = dump,
        origin = origin,
    })
end

local function getCurrent(frameset, property, time)
    local last, next
    local interpolation
    for index = #frameset, 1, -1 do
        local frame = frameset[index]
        if frame.time > time and frame[property] then
            next = frame[property]
            for i = index - 1, 1, -1  do
                local _frame = frameset[i]
                if _frame[property] then
                    last = _frame[property]
                    local position = (time - _frame.time) / (frame.time - _frame.time)
                    if type(_frame.easing) == "table" then
                        --bezier intrpolation
                        if _frame.bezier == nil then
                            _frame.bezier = ease.cubicbezier(
                                _frame.easing[1][1],
                                _frame.easing[1][2],
                                _frame.easing[2][1],
                                _frame.easing[2][2]
                            )
                        end
                        interpolation = _frame.bezier(position)

                    elseif type(_frame.easing) == "string" then

                    end
                    break
                end
            end
        end
    end

    if type(last) == "number" then
        return last + (next - last) * interpolation
    end

    return last:Lerp(next, interpolation)
end

local Client = {}

function Client:Init()
	RenderRemote.OnClientEvent:Connect(function(effectName)
		if Effects:FindFirstChild(effectName) then
			local info = Effects:FindFirstChild(effectName)
			runEffect(info, CFrame.new())
		end
	end)

	RunService.RenderStepped:Connect(function(deltaTime)
		local i = 1
		while i <= #RunningEffects do
			local effect = RunningEffects[i]
			effect.time += deltaTime
			if effect.time >= effect.duration then
				table.remove(RunningEffects, i)
				for _, object in pairs(effect.dump) do
					if object and typeof(object) == "Instance" then
						object:Destroy()
					end
				end
			else i += 1
			end
		end

		for _, effect in pairs(RunningEffects) do
			for key, object in pairs(effect.dump) do
				local frameset = effect.info.frames[key]
				local manipulations = effect.info.manipulations[key]
				for _, property in pairs(manipulations) do
					local current = getCurrent(frameset, property, effect.time)
					if property == "offset" then
						object.CFrame = effect.origin * current
					else
						object[property] = current
					end
				end
			end
		end
	end)
end

return Client