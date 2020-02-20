Global $aRandomBoxAttackX[4][10] = [[552, 572, 591, 620, 627, 645, 674, 699, 718, 753], [303, 273, 255, 230, 205, 179, 158, 147, 130, 112], [778, 727, 686, 654, 622, 586, 557, 529, 502, 745], [358, 67, 107, 137, 160, 177, 203, 244, 277, 317]]
Global $aRandomBoxAttackY[4][10] = [[523, 510, 498, 474, 469, 456, 436, 412, 400, 369], [522, 503, 488, 467, 447, 430, 413, 403, 392, 376], [254, 217, 188, 166, 140, 115, 93, 69, 52, 232], [50, 254, 235, 214, 195, 183, 163, 134, 106, 75]]
Global $nRandom
Global $nKingSpotRandom
Global $aAttackPosition[4]
Global $bRandomState = True
Global $nRandomChecker
Global $nPositionIndex = 0

Func preparePositions()
	While $bRandomState 
		$nRandom = Random(0, 4, 1)
		$nRandomChecker = _ArraySearch($aAttackPosition, $nRandom)
		If $nRandomChecker = -1 Then
			$aAttackPosition[$nPositionIndex] = $nRandom
			$nPositionIndex = $nPositionIndex + 1
			If $nPositionIndex = 4 Then
				ExitLoop
			EndIf
		EndIf
	WEnd
	
	For $i = 0 To 3
		$aAttackPosition[$i] = $aAttackPosition[$i] - 1
	Next
EndFunc

Func prepareAttack()
	setLog("------------------------------------------------------------", $COLOR_GREEN);
	setLog("Attack Initialization", $COLOR_GREEN)
	If _GUICtrlComboBox_GetCurSel($cmTrainingCondition) = 0 Then
		setLog("Troop Composition: Barbarian & Archers", $COLOR_GREEN)
		If GUICtrlRead($tUnitCapacity) = 200 Then
			setLog("Barbarian: 100 Units", $COLOR_GREEN)
			setLog("Archers: 100 Units", $COLOR_GREEN)
		EndIf
		
		If _GUICtrlComboBox_GetCurSel($cmAttackDeployment) = 0 Then
			setLog("Attack Mode: Random Box Attack", $COLOR_GREEN)
		EndIf
	EndIf
EndFunc

Func initiateAttack()
	If _GUICtrlComboBox_GetCurSel($cmTrainingCondition) = 0 Then
		If _GUICtrlComboBox_GetCurSel($cmAttackDeployment) = 0 Then
			If GUICtrlRead($tUnitCapacity) = 200 Then
				For $i = 0 To 3
					clickScreen(76, 610)
					setLog("Robot: Deploying Wave " & $i + 1 & " Of Barbarians.", $COLOR_BLUE)
					For $j = 0 To 24
						$nRandom = Random(0, 9, 1)
						If sleepThread(100) Then Return
						clickScreen($aRandomBoxAttackX[$aAttackPosition[$i]][$nRandom], $aRandomBoxAttackY[$aAttackPosition[$i]][$nRandom])
					Next
					clickScreen(147, 598)
					setLog("Robot: Deploying Wave " & $i + 1 & " Of Archers.", $COLOR_BLUE)
					For $k = 0 To 24
						$nRandom = Random(0, 9, 1)
						If sleepThread(100) Then Return
						clickScreen($aRandomBoxAttackX[$aAttackPosition[$i]][$nRandom], $aRandomBoxAttackY[$aAttackPosition[$i]][$nRandom])
					Next
				Next
			EndIf
		EndIf
	EndIf
	
	sleepThread(100)
	If GUICtrlRead($cEnableKing) = $GUI_CHECKED Then
		dropKing()
		activateKing()
	EndIf
	
	setLog("Robot: Finished Deploying Units. Waiting To Finish.", $COLOR_BLUE)
EndFunc