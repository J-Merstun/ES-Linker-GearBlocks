-- Engine Sim Linker

local ESOutput = require("ESOutput")


----- Init UI -----
local behaviourWheel = nil
local behaviourBrake = nil
local SaveRPM
local SaveTorque
local SaveBrake


local win = Windows.CreateWindow()
win.SetAlignment( align_RightEdge, 20, 250 )
win.SetAlignment( align_TopEdge, 80, 105 )
local function onWindowClose()
	UnloadScript.Raise( ScriptName )	-- Window closed, so unload this script.
end
win.OnClose.add( onWindowClose )
win.Title = 'ES Linker'
win.Show( true )

--Wheel

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_LeftEdge, 10, 110 )
textButton.SetAlignment( align_TopEdge, 5, 30 )
local function onTextButtonClicked()
	behaviourWheel = LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Control Wheel")
	SaveRPM = behaviourWheel.GetTweakable("Max RPM")
	SaveTorque = behaviourWheel.GetTweakable("Peak Torque")
	print(behaviourWheel.Name)
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Hand Wheel'

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_LeftEdge, 10, 110 )
textButton.SetAlignment( align_BottomEdge, 5, 30 )
local function onTextButtonClicked()
	behaviourWheel = nil
	behaviourBrake = nil
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Reset'

--Brake

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_RightEdge, 10, 110 )
textButton.SetAlignment( align_TopEdge, 5, 30 )
local function onTextButtonClicked()
	behaviourBrake = LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Brake")
	SaveBrake = behaviourBrake.GetTweakable("Peak Torque")
	print(behaviourBrake.Name)
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Break'

--local textButton = win.CreateTextButton()
--textButton.SetAlignment( align_RightEdge, 10, 110 )
--textButton.SetAlignment( align_BottomEdge, 5, 30 )
--local function onTextButtonClicked()
--	SaveBrake.Value = ESOutput.Brake
--	behaviourBrake.SyncTweakables()
--end
--textButton.OnClick.add( onTextButtonClicked )
--textButton.Text = 'Set 100 (temp)'




----- Entry functions -----

function FixedUpdate()

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
