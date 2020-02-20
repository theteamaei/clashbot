Opt("GUIOnEventMode", 1)
Opt("MouseClickDelay", 10)
Opt("MouseClickDownDelay", 10)
Opt("TrayMenuMode", 3)

_GDIPlus_Startup()

readConfig()
applyConfig()
	
Func ClashBotController($hWind, $iMsg, $wParam, $lParam)
	Local $nNotifyCode = BitShift($wParam, 16)
	Local $nID = BitAND($wParam, 0x0000FFFF)
	Local $hCtrl = $lParam
	#forceref $hWind, $iMsg, $wParam, $lParam
	Switch $iMsg
		Case 273
			Switch $nID
				Case $GUI_EVENT_CLOSE
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($tLog)
					saveConfig()
					Exit
				Case $bStop
					If $bRunState Then 
						bStop()
					EndIf
				Case $bStopSearch 
					If $bRunState Then
						bStopSearch()
					EndIf
			EndSwitch
		Case 274
			Switch $wParam
				Case 0xf060
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($tLog)
					saveConfig()
					Exit
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func ApplicationClose()
	GUIDelete($fMain)
	Exit
EndFunc

Func bStart()
	saveConfig()
	readConfig()
	applyConfig()
	$bRunState = False
	$bTrainState1 = False
	$bTrainState2 = False
	$bTrainState3 = False
	$bTrainState4 = False
	$bFullUnitState = False
	$bSyncOutState = False
	If GUICtrlRead($tUnitCapacity) = 0 Then
		 MsgBox(0, "", "Army Camp Unit Capacity Not Found.")
	Else
		_GUICtrlEdit_SetText($tLog, "")
		If WinExists($sAppPlayerTitle) Then
			If IsArray(ControlGetPos($sAppPlayerTitle, "_ctl.Window", "[CLASS:BlueStacksApp; INSTANCE:1]")) Then
				WinActivate($sAppPlayerTitle)

				SetLog("Application: " & $sAppTitle, $COLOR_PURPLE)
				SetLog("Application: Brought to you by Lunar Synergy.", $COLOR_PURPLE)
				SetLog("Application: Powered by AutoIT.", $COLOR_PURPLE)
				SetLog("Application: Software Running On " & @OSArch & " Operating System.", $COLOR_PURPLE)
				SetLog("Application: Activating Robot.", $COLOR_PURPLE)

				$bRunState = True
				setUIAvailability("StartRobot")
				startBot()
			Else
				setLog("Application: Not In Game!", $COLOR_RED)
			EndIf
		Else
			setLog("Application: BlueStacks Was Not Found!", $COLOR_RED)
		EndIf
	EndIf
	
EndFunc

Func bStop()
	If $bRunState Then
		setUIAvailability("StopRobot")
		$bRunState = False
		SetLog("Application: Deactivating Robot.", $COLOR_PURPLE)
	EndIf
EndFunc

Func bClickArea()
	clickArea()
EndFunc

Func bLocateBarracks() 
	locateBarracks()
EndFunc

Func bLocateCollectors()
	locateCollectors()
EndFunc

Func bStartSearch()
	saveConfig()
	readConfig()
	applyConfig()
	setUIAvailability("StartSearch")
	$bRunState = True
	initializeMatch()
	getVillageInformation()
	bStopSearch()
EndFunc

Func bContinueSearch()
	saveConfig()
	readConfig()
	applyConfig()
	setUIAvailability("ContinueSearch")
	$bRunState = True
	getVillageInformation()
	bStopSearch()
EndFunc

Func bStopSearch()
	If $bRunState Then
		setUIAvailability("StopSearch")
		$bRunState = False
		setLog("Robot: Stopping Match Initialization.", $COLOR_PURPLE)
	EndIf
EndFunc

Func setUIAvailability($sState)
	If $sState = "StartRobot" Then
		GUICtrlSetState($bStart, $GUI_DISABLE)
		GUICtrlSetState($bStop, $GUI_ENABLE)
		GUICtrlSetState($bStartSearch, $GUI_DISABLE)
		GUICtrlSetState($bContinueSearch, $GUI_DISABLE)
		GUICtrlSetState($bStopSearch, $GUI_DISABLE)
		setCommonUIAvailability(0)
	ElseIf $sState = "StopRobot" Then
		GUICtrlSetState($bStart, $GUI_ENABLE)
		GUICtrlSetState($bStop, $GUI_DISABLE)
		GUICtrlSetState($bStartSearch, $GUI_ENABLE)
		GUICtrlSetState($bContinueSearch, $GUI_ENABLE)
		GUICtrlSetState($bStopSearch, $GUI_ENABLE)
		setCommonUIAvailability(1)
	ElseIf $sState = "StartSearch" Then
		GUICtrlSetState($bStart, $GUI_DISABLE)
		GUICtrlSetState($bStop, $GUI_DISABLE)
		GUICtrlSetState($bStartSearch, $GUI_DISABLE)
		GUICtrlSetState($bContinueSearch, $GUI_DISABLE)
		GUICtrlSetState($bStopSearch, $GUI_ENABLE)
		setCommonUIAvailability(0)
	ElseIf $sState = "ContinueSearch" Then
		GUICtrlSetState($bStart, $GUI_DISABLE)
		GUICtrlSetState($bStop, $GUI_DISABLE)
		GUICtrlSetState($bStartSearch, $GUI_DISABLE)
		GUICtrlSetState($bContinueSearch, $GUI_DISABLE)
		GUICtrlSetState($bStopSearch, $GUI_ENABLE)
		setCommonUIAvailability(0)
	ElseIf $sState = "StopSearch" Then
		GUICtrlSetState($bStart, $GUI_DISABLE)
		GUICtrlSetState($bStop, $GUI_DISABLE)
		GUICtrlSetState($bStartSearch, $GUI_ENABLE)
		GUICtrlSetState($bContinueSearch, $GUI_ENABLE)
		GUICtrlSetState($bStopSearch, $GUI_DISABLE)
		setCommonUIAvailability(1)
	EndIf
EndFunc

Func setCommonUIAvailability($nState)
	If $nState = 1 Then
		GUICtrlSetState($tUnitCapacity, $GUI_ENABLE)
		GUICtrlSetState($cmTownHall, $GUI_ENABLE)
		GUICtrlSetState($cmTrainingCondition, $GUI_ENABLE)
		GUICtrlSetState($cMeetGnE, $GUI_ENABLE)
		GUICtrlSetState($cMeetGoE, $GUI_ENABLE)
		GUICtrlSetState($cMeetDE, $GUI_ENABLE)
		GUICtrlSetState($cMeetThOut, $GUI_ENABLE)
		GUICtrlSetState($tMinGold, $GUI_ENABLE)
		GUICtrlSetState($tMinElixir, $GUI_ENABLE)
		GUICtrlSetState($tMinDarkElixir, $GUI_ENABLE)
		GUICtrlSetState($cmAttackMode, $GUI_ENABLE)
		GUICtrlSetState($cmAttackDeployment, $GUI_ENABLE)
		GUICtrlSetState($cBoostBarracks, $GUI_ENABLE)
		GUICtrlSetState($cCollectResources, $GUI_ENABLE)
		GUICtrlSetState($cEnableKing, $GUI_ENABLE)
		GUICtrlSetState($cEnableQueen, $GUI_ENABLE)
	Else 
		GUICtrlSetState($tUnitCapacity, $GUI_DISABLE)
		GUICtrlSetState($cmTownHall, $GUI_DISABLE)
		GUICtrlSetState($cmTrainingCondition, $GUI_DISABLE)
		GUICtrlSetState($cMeetGnE, $GUI_DISABLE)
		GUICtrlSetState($cMeetGoE, $GUI_DISABLE)
		GUICtrlSetState($cMeetDE, $GUI_DISABLE)
		GUICtrlSetState($cMeetThOut, $GUI_DISABLE)
		GUICtrlSetState($tMinGold, $GUI_DISABLE)
		GUICtrlSetState($tMinElixir, $GUI_DISABLE)
		GUICtrlSetState($tMinDarkElixir, $GUI_DISABLE)
		GUICtrlSetState($cmAttackMode, $GUI_DISABLE)
		GUICtrlSetState($cmAttackDeployment, $GUI_DISABLE)
		GUICtrlSetState($cBoostBarracks, $GUI_DISABLE)
		GUICtrlSetState($cCollectResources, $GUI_DISABLE)
		GUICtrlSetState($cEnableKing, $GUI_DISABLE)
		GUICtrlSetState($cEnableQueen, $GUI_DISABLE)
	EndIf
EndFunc

Func bSearchImage()
	;searchTownHall()
	If checkNonActive() > 0 Then
		MouseMove($variantX , $variantY , 10)
		setLog("Robot: Image Found.", $COLOR_BLUE)
	Else
		setLog("Robot: Image Not Found.", $COLOR_RED)
	EndIf
EndFunc

Func bAttack()
	initializeMatch()
	getVillageInformation()
	preparePositions()
	prepareAttack()
	initiateAttack()
	checkBattleOver()
EndFunc

GUIRegisterMsg($WM_COMMAND, "ClashBotController")
GUIRegisterMsg($WM_SYSCOMMAND, "ClashBotController")