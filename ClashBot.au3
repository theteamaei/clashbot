#include "global\GlobalUtil.au3"
#include "global\MethodUtil.au3"
#include "gui\ClashBotView.au3"
#include "gui\ClashBotController.au3"
#include-once

While 1
	If GUIGetMsg() == $GUI_EVENT_CLOSE Then
		ApplicationClose()
	EndIf
WEnd

Func restartVariables()
	saveConfig()
	readConfig()
	applyConfig()
	$bFullUnitState = False
	$bCancelUnitsState = False
	$bTrainAttackState = False
	$bFinishTrainAttackState = False
	$nIdleTime = 60000
	$nRandomChecker
	$nPositionIndex = 0
	$aAttackPosition[0] = ""	
	$aAttackPosition[1] = ""
	$aAttackPosition[2] = ""
	$aAttackPosition[3] = ""
EndFunc
Func startBot()
	While 1
		restartVariables()
		If sleepThread(1000) Then Return
		getMainScreen()
		If sleepThread(1000) Then Return
		zoomOut()
		If GUICtrlRead($cCollectResources) = $GUI_CHECKED Then
			If sleepThread(1000) Then Return
			collectResources()
		EndIf
		If sleepThread(1000) Then Return
		clickBarracks()
		If sleepThread(1000) Then Return
		If GUICtrlRead($cBoostBarracks) = $GUI_CHECKED Then
			boostBarracks()
			If sleepThread(1000) Then Return
		EndIf
		idleTime()
		If sleepThread(3000) Then Return
		initializeMatch()
		If sleepThread(1000) Then Return
		getVillageInformation()
		If sleepThread(1000) Then Return
		preparePositions()
		If sleepThread(1000) Then Return
		prepareAttack()
		If sleepThread(1000) Then Return
		initiateAttack()
		If sleepThread(1000) Then Return
		checkBattleOver()
		If sleepThread($nIdleTime) Then Return
	WEnd
EndFunc

Func continueBot()
	$bRunState = True
	setUIAvailability("StartRobot")
	startBot() 
EndFunc

Func idleTime()
	Local $TimeIdle = 0
	While $bFinishTrainAttackState = False
		setLog("Robot: Waiting For Full Army.", $COLOR_BLUE)
		Local $hTimer = TimerInit()
		If sleepThread($nIdleTime) Then ExitLoop
		getMainScreen()
		If sleepThread(1000) Then ExitLoop
		zoomOut()
		If sleepThread(1000) Then ExitLoop
		clickBarracks()
		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2)
		setLog("Time Idle: " & Floor(Floor($TimeIdle / 60) / 60) & " hours " & Floor(Mod(Floor($TimeIdle / 60), 60)) & " minutes " & Floor(Mod($TimeIdle, 60)) & " seconds.", $COLOR_GREEN)
	WEnd
EndFunc