-- Engine Sim Linker

local ESOutput = require("ESOutput")
local Settings = require("Settings")

----- Init UI -----
local behaviourWheel = nil
local behaviourBrake = nil
local SaveRPM
local SaveTorque
local SaveBrake


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


----- Entry functions -----

function FixedUpdate()

	if Input.GetKeyDown( string.format('%s',inputField.Value) ) then
		print( 'Throttle = 1' )
	end
	if Input.GetKeyUp( string.format('%s',inputField.Value) ) then
		print( 'Throttle = 0' )
	end

--time = os.date("*t")
--print(time.hour .. time.min .. time.sec)

	--behaviour3 = 
	--print(LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Control Wheel").IsActivated)

	--thing to get the names of objects
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
	
	if behaviourWheel ~= nil then
		if SaveRPM.Value ~= ESOutput.RPM
			then
				SaveRPM.Value = ESOutput.RPM
				SaveTorque.Value = ESOutput.Torque
				behaviourWheel.SyncTweakables()
		end
	end

	if behaviourBrake ~= nil then
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
