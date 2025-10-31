-- Engine Sim Linker

local "put file path here"

----- Init UI -----
local behaviour
local behaviour2
local SaveRPM
local SavePT
local SaveBrake


local win = Windows.CreateWindow()
win.SetAlignment( align_RightEdge, 20, 250 )
win.SetAlignment( align_TopEdge, 80, 100 )
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
	behaviour = LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Control Wheel")
	SaveRPM = behaviour.GetTweakable("Max RPM")
	SavePT = behaviour.GetTweakable("Peak Torque")
	print(behaviour.Name)
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Hand Wheel'

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_LeftEdge, 10, 110 )
textButton.SetAlignment( align_BottomEdge, 5, 30 )
local function onTextButtonClicked()
	SaveRPM.Value = 100
	SavePT.Value = 100
	behaviour.SyncTweakables()
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Set 100 (temp)'

--Brake

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_RightEdge, 10, 110 )
textButton.SetAlignment( align_TopEdge, 5, 30 )
local function onTextButtonClicked()
	behaviour2 = LocalPlayer.Value.Targeter.TargetedPart.GetBehaviour("Brake")
	SaveBrake = behaviour2.GetTweakable("Peak Torque")
	print(behaviour2.Name)
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Break'

local textButton = win.CreateTextButton()
textButton.SetAlignment( align_RightEdge, 10, 110 )
textButton.SetAlignment( align_BottomEdge, 5, 30 )
local function onTextButtonClicked()
	SaveBrake.Value = 100
	behaviour2.SyncTweakables()
end
textButton.OnClick.add( onTextButtonClicked )
textButton.Text = 'Set 100 (temp)'




----- Entry functions -----

function FixedUpdate()


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
			
	
end	

function Cleanup()
	Windows.DestroyWindow( win )
end
