# fx-blue
### Roblox Effect Animator
(This is my first kinda proffesional plugin so beware of errors and stuff)\
(Scripting side, check [FX-Blue Plugin](https://github.com/3gabyxD/fx-blue) for the Animation side)

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#Documentation)

## Installation
- Rojo\
Take the FX-Blue folder from Modules folder and put it in/in a folder in `ReplicatedStorage`.
- RBXM\
Download the FX-Blue `.rbxm` then drag and drop it in Roblox Studio.

## Usage
### Initializing Client
- Require FX-Blue
```lua
local FXBlue = require(ReplicatedStorage:WaitForChild("FX-Blue"))
```
- Call `Init`
```lua
FXBlue.Init()
```
### Running effects from Client
- Call `RunEffect`
```lua
FXBlue.RunEffect("EffectName", Time)
```
### Broadcasting from Server
- Require FX-Blue
```lua
local FXBlue = require(ReplicatedStorage:WaitForChild("FX-Blue"))
```
- Call `Broadcast`
```lua
FXBlue.Broadcast("EffectName", Time)
```

## Documentation
- TODO(gaby): Documentation
