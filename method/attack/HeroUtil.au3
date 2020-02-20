Func dropKing()
	setLog("Robot: Dropping King.", $COLOR_BLUE)
	clickKing()
	$nRandom = Random(0, 9, 1)
	$nKingSpotRandom = Random(0, 3, 1)
	clickScreen($aRandomBoxAttackX[$nKingSpotRandom][$nRandom], $aRandomBoxAttackY[$nKingSpotRandom][$nRandom])
EndFunc

Func activateKing()
	$nHeroSkilLDelay = Random(8000, 10000, 1)
	setLog("Robot: Waiting " & $nHeroSkilLDelay / 1000 & " seconds before activating King's Power.", $COLOR_BLUE)
	sleepThread($nHeroSkilLDelay)
	setLog("Robot: Activating King's Power.", $COLOR_BLUE)
	clickKing()
EndFunc

Func clickKing()
	If _GUICtrlComboBox_GetCurSel($cmTrainingCondition) = 0 Then
		clickScreen(211, 605)
	EndIf
EndFunc