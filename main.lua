-- Engine Sim Linker

--local ESOutput = require("ESOutput")
local Settings = require("Settings")

----- Init UI -----
local behaviourWheel = nil
local behaviourBrake = nil
local SaveRPM
local SaveTorque
local SaveBrake

local x = os.clock()
local time = os.date("*t")
local TimeSave = os.date(time.sec)
local TimeMS

local win = Windows.CreateWindow()
win.SetAlignment( align_RightEdge, 20, 120 )
win.SetAlignment( align_TopEdge, 80, 200 )
local function onWindowClose()
	UnloadScript.Raise( ScriptName )	-- Window closed, so unload this script.
end
win.OnClose.add( onWindowClose )
win.Title = 'ES Linker'
win.Show( true )

--Wheel

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_LeftEdge, 5, 110 )
textButton.SetAlignment( align_TopEdge, 5, 30 )
local function onTextButtonClicked()
	behaviourWheel = LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Control Wheel")
	SaveRPM = behaviourWheel.GetTweakable("Max RPM")
	SaveTorque = behaviourWheel.GetTweakable("Peak Torque")
	print(behaviourWheel.Name)
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Hand Wheel'

--Brake

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_LeftEdge, 5, 110 )
textButton.SetAlignment( align_TopEdge, 40, 30 )
local function onTextButtonClicked()
	behaviourBrake = LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Brake")
	SaveBrake = behaviourBrake.GetTweakable("Peak Torque")
	print(behaviourBrake.Name)
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Break'

-- Asign Key

local inputField = win.CreateInputField()
inputField.SetAlignment( align_LeftEdge, 5, 110 )
inputField.SetAlignment( align_TopEdge, 75, 30 )
local function onInputFieldEndEdit()
	print(inputField.Value)
end
inputField.OnEndEdit.add( onInputFieldEndEdit )
inputField.Value = Settings.DefaultKey



-- Reset

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_LeftEdge, 5, 110 )
textButton.SetAlignment( align_TopEdge, 120, 30 )
local function onTextButtonClicked()
	behaviourWheel = nil
	behaviourBrake = nil
	inputField.Value = Settings.DefaultKey
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Reset'



-- manual test button, remove later

--	local textButton = win.CreateTextButton()
--	textButton.SetAlignment( align_LeftEdge, 5, 110 )
--	textButton.SetAlignment( align_TopEdge, 150, 30 )
--	local function onTextButtonClicked()
--				local ESOutput = loadfile(ScriptPath .. "ESOutput.lua")()--loads the file, put as part of execute
--				SaveRPM.Value = ESOutput.RPM
--				SaveTorque.Value = ESOutput.Torque
--				behaviourWheel.SyncTweakables()
--				print('work?')
--	end
--	textButton.OnClick.add( onTextButtonClicked )
--	textButton.Text = 'Update'




----- Entry functions -----

function Update()

--ESOutput Testing

	--local ESOutput = require("ESOutput")
	--local ESOutput = loadfile(ScriptPath .. "ESOutput.lua")()
	--print(ESOutput.Torque, SaveRPM.Value)
	--print(ESOutput.RPM, SaveTorque.Value)
	--print(ESOutput.Brake)


-- Throttle inputs

--	if Input.GetKeyDown( string.format('%s',inputField.Value) ) then
--		print( 'Throttle = 1' )
--	end
--	if Input.GetKeyUp( string.format('%s',inputField.Value) ) then
--		print( 'Throttle = 0' )
--	end
--	if Input.GetKey( string.format('%s',inputField.Value) ) then
--		print( 'Throttle = 1' )
--	else
--		print( 'Throttle = 0' )
--	end



-- System Time

time = os.date("*t")

if time.sec ~= TimeSave
	then
		x = os.clock()
		TimeSave = time.sec
	else
		TimeMS = (os.clock()-x)*1000
	end

-- Print Output for Engine Sim

print(string.format("H:%0.0f M:%0.0f S:%0.0f ms:%0.0f", time.hour, time.min, time.sec, TimeMS))



-- thing to get the names of objects

	--	local localPlayer = LocalPlayer.Value
	--	local targeter
	--	if localPlayer then
	--		targeter = localPlayer.Targeter
	--	end
	--	if targeter and targeter.TargetedPart then
	--		for behaviour in targeter.TargetedPart.Behaviours do
	--			print(behaviour.Name)
	--		end
	--	end

-- Auto Update

	if behaviourWheel ~= nil then
		local ESOutput = loadfile(ScriptPath .. "ESOutput.lua")()--loads the file, put as part of execute
		if SaveRPM.Value ~= ESOutput.RPM
			then
				SaveRPM.Value = ESOutput.RPM
				SaveTorque.Value = ESOutput.Torque
				behaviourWheel.SyncTweakables()
		end
	end

	if behaviourBrake ~= nil then
		local ESOutput = loadfile(ScriptPath .. "ESOutput.lua")()--loads the file, put as part of execute
		if SaveBrake.Value ~= ESOutput.Brake 
			then
				SaveBrake.Value = ESOutput.Brake
				behaviourBrake.SyncTweakables()
		end
	end


end	

function Cleanup()
	Windows.DestroyWindow( win )
end
