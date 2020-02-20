Func clickBarracks()
	If $aBarracksPosition[0][0] = "" Then
		locateBarracks()
		saveConfig()
		If sleepThread(2000) Then Return
	EndIf
	
	$nBarracksCounter = (UBound($aBarracksPosition, $UBOUND_ROWS) - 1)
	For $i = 0 To $nBarracksCounter
		If sleepThread(500) Then ExitLoop
		clickScreen(629, 19)
		If sleepThread(500) Then ExitLoop
		clickScreen($aBarracksPosition[$i][0], $aBarracksPosition[$i][1])
		If sleepThread(1000) Then ExitLoop
		;Local $TrainButtonPosition = searchPixel(155, 603, 694, 605, Hex(0x603818, 6), 5)
		Local $TrainButtonPosition = searchPixel(390, 580, 665, 665, Hex(0x687DA1, 6), 10)
		;Local $TrainButtonPosition = searchPixel(155, 603, 694, 605, Hex(0x603818, 6), 10)
		If IsArray($TrainButtonPosition) = False Then
			setLog("Robot: Barracks #" & $i + 1 & " Is Not Available.", $COLOR_RED)
			If sleepThread(500) Then ExitLoop
		Else
			clickScreen($TrainButtonPosition[0], $TrainButtonPosition[1])
			If sleepThread(800) Then ExitLoop
			
			If $bFullUnitState = False Then
				setLog("Robot: Checking Unit Capacity If It Is Full.", $COLOR_BLUE)
				checkUnitCapacity($i + 1)
			EndIf
			
			If $bFullUnitState AND $bCancelUnitsState = False AND $bTrainAttackState = False Then
				$bTrainState1 = True
				$bTrainState2 = True
				$bTrainState3 = True
				$bTrainState4 = True
				$bCancelUnitsState = True	
				$nIdleTime = 1000
				ExitLoop
			ElseIf $bFullUnitState AND $bCancelUnitsState AND $bTrainAttackState = False Then
				cancelExcessUnits($i + 1)
			ElseIf $bFullUnitState AND $bCancelUnitsState AND $bTrainAttackState Then
				trainUnitsBeforeAttack($i + 1)
			Else	
				If $bTrainState1 = False Then
					setLog("Robot: Training Units On Barracks # " & $i + 1 & ".", $COLOR_BLUE)
					trainUnits($i + 1)
				ElseIf $bTrainState2 = False Then
					setLog("Robot: Training Units On Barracks # " & $i + 1 & ".", $COLOR_BLUE)
					trainUnits($i + 1)
				ElseIf $bTrainState3 = False Then
					setLog("Robot: Training Units On Barracks # " & $i + 1 & ".", $COLOR_BLUE)
					trainUnits($i + 1)
				ElseIf $bTrainState4 = False Then
					setLog("Robot: Training Units On Barracks # " & $i + 1 & ".", $COLOR_BLUE)
					trainUnits($i + 1)
				EndIf
			EndIf
		EndIf
	Next
	clickScreen(629, 19, 5)
 EndFunc
 
 Func trainUnits($nBarracks)
	setLog("Robot: Processing Training Action.", $COLOR_BLUE)
	If $nBarracks = 1 Then
		$bTrainState1 = True
	ElseIf $nBarracks = 2 Then
		$bTrainState2 = True
	ElseIf $nBarracks = 3 Then
		$bTrainState3 = True
	ElseIf $nBarracks = 4 Then
		$bTrainState4 = True	
	EndIf
	Local $ntroopCounter
	If _GUICtrlComboBox_GetCurSel($cmTrainingCondition) = 0 Then
		$ntroopCounter = GUICtrlRead($tUnitCapacity) / UBound($aBarracksPosition, $UBOUND_ROWS) / 2
		For $j = 1 To $ntroopCounter
			clickScreen(331, 320, 1)
			clickScreen(220, 320, 1)
			sleepThread(50)
		Next
		clickScreen(220, 320, 1)
	EndIf
	setLog("Robot: Barracks #" & $nBarracks & " Training Is Now Completed.", $COLOR_BLUE)
 EndFunc
 
 Func cancelExcessUnits($nBarracks)
	If $nBarracks = 1 Then
		setLog("Robot: Starting To Cancel Excess Units.", $COLOR_BLUE)
	EndIf
	
	clickScreen(498, 190, 25)
	clickScreen(498, 190, 25)
	
	If $nBarracks = 4 Then
		setLog("Robot: Cancelling Units Completed.", $COLOR_BLUE)
		$bTrainAttackState = True
	EndIf
 EndFunc
 
 Func trainUnitsBeforeAttack($nBarracks) 
	If $nBarracks = 1 Then
		setLog("Robot: Training Units Before Attacking.", $COLOR_BLUE)
	EndIf
	
	Local $ntroopCounter
	If _GUICtrlComboBox_GetCurSel($cmTrainingCondition) = 0 Then
		$ntroopCounter = GUICtrlRead($tUnitCapacity) / UBound($aBarracksPosition, $UBOUND_ROWS) / 2
		For $j = 1 To $ntroopCounter
			clickScreen(331, 320, 1)
			clickScreen(220, 320, 1)
			sleepThread(50)
		Next
		clickScreen(220, 320, 1)
	EndIf
	
	If $nBarracks = 4 Then
		setLog("Robot: Training Troops Completed!", $COLOR_BLUE)
		$bFinishTrainAttackState = True
	EndIf
	sleepThread(300)
 EndFunc
 
 Func checkUnitCapacity($nBarracks)
	captureRegion()
	$bPixel = checkColor(getPixelColor(327, 520), Hex(0xD03838, 6), 20)
	If $bPixel Then
		$bFullUnitState = True
		setLog("Robot: Unit Capacity Is Now Full.", $COLOR_BLUE)
	Else
		$bFullUnitState = False
		setLog("Robot: Unit Capacity Is Not Full.", $COLOR_BLUE)
	EndIf
EndFunc