Func collectResources()
	If $aCollectorPosition[0][0] = "" Then
		locateCollectors()
		saveConfig()
		If sleepThread(2000) Then Return
	EndIf
	
	setLog ("Robot: Resource Collecting Is Permitted.", $COLOR_BLUE)
	setLog("Robot: Starting To Collect Resources.", $COLOR_BLUE)
	If sleepThread(250) Then Return
	clickScreen(1, 1)
	If sleepThread(250) Then Return
	For $i = 0 To 13
		If sleepThread(150) Or $bRunState = False Then ExitLoop
		clickScreen($aCollectorPosition[$i][0], $aCollectorPosition[$i][1])
		If sleepThread(250) Then Return
	Next
	setLog("Robot: Done Collecting Resources.", $COLOR_BLUE)
EndFunc

Func boostBarracks()
	If GUICtrlRead($cBoostBarracks) = $GUI_CHECKED Then
		If $aBarracksPosition[0][0] = "" Then
			locateBarracks()
			saveConfig()
			If sleepThread(2000) Then Return
		EndIf
		
		setLog("Robot: Barracks Boosting Is Permitted.", $COLOR_BLUE)
		setLog("Robot: Checking Status Of Boost.", $COLOR_BLUE)
		
		If $bBoostState = False Then
			$nBoostVariant = TimerInit()
			$bBoostState = True
			setLog("Robot: Starting To Boost Barracks.", $COLOR_BLUE)
			clickScreen(1, 1)
			sleepThread(500)
			clickScreen($aBarracksPosition[0][0], $aBarracksPosition[0][1])
			sleepThread(500)
			clickScreen(440, 600)
			sleepThread(500)
			clickScreen(433, 392)
			sleepThread(500)
			setLog("Robot: Finished Boosting Barracks.", $COLOR_BLUE)
		Else
			setLog("Robot: All Barracks Are Currently Boosted.", $COLOR_BLUE)
			$nBoostTime += Round(TimerDiff($nBoostVariant) / 1000, 2)
			$nBoostVariant = TimerInit()
		EndIf
		
		setLog("Boost Time: " & Floor(Floor($nBoostTime / 60) / 60) & " hours " & Floor(Mod(Floor($nBoostTime / 60), 60)) & " minutes " & Floor(Mod($nBoostTime, 60)) & " seconds.", $COLOR_GREEN)
		If Floor(Floor($nBoostTime / 60) / 60) >= 2 AND Floor(Mod(Floor($nBoostTime / 60), 60)) > 15 Then
			$bBoostState = False
			$nBoostTime = 0
		EndIf
	EndIf
EndFunc