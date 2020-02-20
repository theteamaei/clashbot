Func saveConfig()
	;GENERAL SETTINGS
	Local $aTempAppPosition = WinGetPos($sAppTitle)
	IniWrite($config, "generalSettings", "xApplicationPosition", $aTempAppPosition[0])
	IniWrite($config, "generalSettings", "yApplicationPosition", $aTempAppPosition[1])
	If GUICtrlRead($cBoostBarracks) = $GUI_CHECKED Then
		IniWrite($config, "generalSettings", "boostBarracks", 1)
	Else
		IniWrite($config, "generalSettings", "boostBarracks", 0)
	EndIf
	
	If GUICtrlRead($cCollectResources) = $GUI_CHECKED Then
		IniWrite($config, "generalSettings", "collectResources", 1)
	Else
		IniWrite($config, "generalSettings", "collectResources", 0)
	EndIf
	
	;UNIT SETTINGS
	IniWrite($config, "unitsSettings", "troopComposition", _GUICtrlComboBox_GetCurSel($cmTrainingCondition))
	IniWrite($config, "unitsSettings", "troopCapacity", GUICtrlRead($tUnitCapacity))
	IniWrite($config, "unitsSettings", "townHall", _GUICtrlComboBox_GetCurSel($cmTownHall))
	
	;MATCH SETTINGS
	IniWrite($config, "matchSettings", "minimumGold", GUICtrlRead($tMinGold))
	IniWrite($config, "matchSettings", "minimumElixir", GUICtrlRead($tMinElixir))
	IniWrite($config, "matchSettings", "minimumDarkElixir", GUICtrlRead($tMinDarkElixir))

	If GUICtrlRead($cMeetGnE) = $GUI_CHECKED Then
		IniWrite($config, "matchSettings", "conditionGoldAndElixir", 1)
	Else
		IniWrite($config, "matchSettings", "conditionGoldAndElixir", 0)
	EndIf

	If GUICtrlRead($cMeetGoE) = $GUI_CHECKED Then
		IniWrite($config, "matchSettings", "conditionGoldOrElixir", 1)
	Else
		IniWrite($config, "matchSettings", "conditionGoldOrElixir", 0)
	EndIf

	If GUICtrlRead($cMeetDE) = $GUI_CHECKED Then
		IniWrite($config, "matchSettings", "conditionDarkElixir", 1)
	Else
		IniWrite($config, "matchSettings", "conditionDarkElixir", 0)
	EndIf

	If GUICtrlRead($cMeetThOut) = $GUI_CHECKED Then
		IniWrite($config, "matchSettings", "conditionTownHallOutside", 1)
	Else
		IniWrite($config, "matchSettings", "conditionTownHallOutside", 0)
	EndIf
	
	;ATTACK SETTINGS
	IniWrite($config, "attackSettings", "attackMode", _GUICtrlComboBox_GetCurSel($cmAttackMode))
	IniWrite($config, "attackSettings", "attackDeployment", _GUICtrlComboBox_GetCurSel($cmAttackDeployment))
	
	If GUICtrlRead($cEnableKing) = $GUI_CHECKED Then
		IniWrite($config, "attackSettings", "enableKing", 1)
	Else
		IniWrite($config, "attackSettings", "enableKing", 0)
	EndIf
	
	If GUICtrlRead($cEnableQueen) = $GUI_CHECKED Then
		IniWrite($config, "attackSettings", "enableQueen", 1)
	Else
		IniWrite($config, "attackSettings", "enableQueen", 0)
	EndIf
	
	;DEVELOPMENT SETTINGS
	If GUICtrlRead($cCaptureConditionMatch) = $GUI_CHECKED Then
		IniWrite($config, "developmentSettings", "captureMatch", 1)
	Else
		IniWrite($config, "developmentSettings", "captureMatch", 0)
	EndIf
	
	If GUICtrlRead($cCaptureConditionNotMatch) = $GUI_CHECKED Then
		IniWrite($config, "developmentSettings", "captureNotMatch", 1)
	Else
		IniWrite($config, "developmentSettings", "captureNotMatch", 0)
	EndIf
	
	If GUICtrlRead($cCaptureLoot) = $GUI_CHECKED Then
		IniWrite($config, "developmentSettings", "captureLoot", 1)
	Else
		IniWrite($config, "developmentSettings", "captureLoot", 0)
	EndIf
	
	For $i = 0 To 3
		IniWrite($config, "developmentSettings", "xBarrack" & $i + 1, $aBarracksPosition[$i][0])
		IniWrite($config, "developmentSettings", "yBarrack" & $i + 1, $aBarracksPosition[$i][1])
	Next
	
	For $i = 0 To 13
		IniWrite($config, "developmentSettings", "xCollector" & $i + 1, $aCollectorPosition[$i][0])
		IniWrite($config, "developmentSettings", "yCollector" & $i + 1, $aCollectorPosition[$i][1])
	Next
	
	IniWrite($config, "developmentSettings", "xTrap", $aTrapPosition[0])
	IniWrite($config, "developmentSettings", "yTrap", $aTrapPosition[1])
EndFunc

Func readConfig()
	;GENERAL SETTINGS
	$aAppPosition[0] = IniRead($config, "generalSettings", "xApplicationPosition", "0")
	$aAppPosition[1] = IniRead($config, "generalSettings", "yApplicationPosition", "0")
	$bBoostBarracks = IniRead($config, "generalSettings", "boostBarracks", "0")
	$bCollectResources = IniRead($config, "generalSettings", "collectResources", "0")
	
	;UNIT SETTINGS
	$nUnitComposition = IniRead($config, "unitsSettings", "troopComposition", "0")
	$nUnitCapacity = IniRead($config, "unitsSettings", "troopCapacity", "0")
	$nTownHall = IniRead($config, "unitsSettings", "townHall", "0") + 1
	
	;MATCH SETTINGS
	$minGold = IniRead($config, "matchSettings", "minimumGold", "0")
	$minElixir = IniRead($config, "matchSettings", "minimumGold", "0")
	$minDarkElixir = IniRead($config, "matchSettings", "minimumDarkElixir", "0")

	$aChkConditions[0] = IniRead($config, "matchSettings", "conditionGoldAndElixir", "0")
	$aChkConditions[1] = IniRead($config, "matchSettings", "conditionGoldOrElixir", "0")
	$aChkConditions[2] = IniRead($config, "matchSettings", "conditionDarkElixir", "0")
	$aChkConditions[3] = IniRead($config, "matchSettings", "conditionTownHallOutside", "0")
	
	;ATTACK SETTINGS
	$nAttackMode = IniRead($config, "attackSettings", "attackMode", "0")
	$nAttackDeployment = IniRead($config, "attackSettings", "attackDeployment", "0")
	
	$bEnableKing = IniRead($config, "attackSettings", "enableKing", "0")
	$bEnableQueen = IniRead($config, "attackSettings", "enableQueen", "0")
	
	;DEVELOPMENT SETTINGS
	$aDevConditions[0] = IniRead($config, "developmentSettings", "captureMatch", "0")
	$aDevConditions[1] = IniRead($config, "developmentSettings", "captureNotMatch", "0")
	$aDevConditions[2] = IniRead($config, "developmentSettings", "captureLoot", "0")

	For $i = 0 To 3
		$aBarracksPosition[$i][0] = IniRead($config, "developmentSettings", "xBarrack" & $i + 1, "0")
		$aBarracksPosition[$i][1] = IniRead($config, "developmentSettings", "yBarrack" & $i + 1, "0")
	Next
	
	For $i = 0 To 13
	$aCollectorPosition[$i][0] = IniRead($config, "developmentSettings", "xCollector" & $i + 1, "0")
	$aCollectorPosition[$i][1] = IniRead($config, "developmentSettings", "yCollector" & $i + 1, "0")
	Next
	
	$aTrapPosition[0] = IniRead($config, "developmentSettings", "xTrap", "-1")
	$aTrapPosition[1] = IniRead($config, "developmentSettings", "yTrap", "-1")
EndFunc

Func applyConfig()	
	;GENERAL SETTINGS
	If $aAppPosition[1] <> -32000 Then 
		WinMove($sAppTitle, "", $aAppPosition[0], $aAppPosition[1])
	EndIf
	
	If $bBoostBarracks = 1 then
		GUICtrlSetState($cBoostBarracks, $GUI_CHECKED)
	Else
		GUICtrlSetState($cBoostBarracks, $GUI_UNCHECKED)
	EndIf
	
	If $bCollectResources = 1 then
		GUICtrlSetState($cCollectResources, $GUI_CHECKED)
	Else
		GUICtrlSetState($cCollectResources, $GUI_UNCHECKED)
	EndIf
	
	;UNIT SETTINGS
	_GUICtrlComboBox_SetCurSel($cmTrainingCondition, $nUnitComposition)
	GUICtrlSetData($tUnitCapacity, $nUnitCapacity)
	GUICtrlSetData($cmTownHall, $nTownHall)
	
	;MATCH SETTINGS
	GUICtrlSetData($tMinGold, $minGold)
	GUICtrlSetData($tMinElixir, $minElixir)
	GUICtrlSetData($tMinDarkElixir, $minDarkElixir)

	If $aChkConditions[0] = 1 Then
		GUICtrlSetState($cMeetGnE, $GUI_CHECKED)
	Else
		GUICtrlSetState($cMeetGnE, $GUI_UNCHECKED)
	EndIf

	If $aChkConditions[1] = 1 Then
		GUICtrlSetState($cMeetGoE, $GUI_CHECKED)
	Else
		GUICtrlSetState($cMeetGoE, $GUI_UNCHECKED)
	EndIf

	If $aChkConditions[2] = 1 Then
		GUICtrlSetState($cMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($cMeetDE, $GUI_UNCHECKED)
	EndIf

	If $aChkConditions[3] = 1 Then
		GUICtrlSetState($cMeetThOut, $GUI_CHECKED)
	Else
		GUICtrlSetState($cMeetThOut, $GUI_UNCHECKED)
	EndIf
	
	;ATTACK SETTINGS
	_GUICtrlComboBox_SetCurSel($cmAttackMode, $nAttackMode)
	_GUICtrlComboBox_SetCurSel($cmAttackDeployment, $nAttackDeployment)
	
	If $bEnableKing = 1 then
		GUICtrlSetState($cEnableKing, $GUI_CHECKED)
	Else
		GUICtrlSetState($cEnableKing, $GUI_UNCHECKED)
	EndIf
	
	If $bEnableQueen = 1 then
		GUICtrlSetState($cEnableQueen, $GUI_CHECKED)
	Else
		GUICtrlSetState($cEnableQueen, $GUI_UNCHECKED)
	EndIf
	
	;DEVELOPMENT SETTINGS
	If $aDevConditions[0] = 1 Then
		GUICtrlSetState($cCaptureConditionMatch, $GUI_CHECKED)
	Else
		GUICtrlSetState($cCaptureConditionMatch, $GUI_UNCHECKED)
	EndIf

	If $aDevConditions[1] = 1 Then
		GUICtrlSetState($cCaptureConditionNotMatch, $GUI_CHECKED)
	Else
		GUICtrlSetState($cCaptureConditionNotMatch, $GUI_UNCHECKED)
	EndIf

	If $aDevConditions[2] = 1 Then
		GUICtrlSetState($cCaptureLoot, $GUI_CHECKED)
	Else
		GUICtrlSetState($cCaptureLoot, $GUI_UNCHECKED)
	EndIf
EndFunc