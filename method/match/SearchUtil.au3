Func initializeMatch()
	setLog("Robot: Match Initialization", $COLOR_BLUE)
	prepareSearch()
EndFunc

Func prepareSearch()
	While 1
		setLog("Robot: Clicking the ATTACK BUTTON.", $COLOR_BLUE)
		clickScreen(60, 614)
		If sleepThread(1000) Then ExitLoop
		setLog("Robot: Clicking the FIND MATCH BUTTON.", $COLOR_BLUE)
		clickScreen(217, 510)
		If sleepThread(3000) Then ExitLoop
		captureRegion()
		If checkColor(getPixelColor(513, 416), Hex(0x5DAC10, 6), 50) Then
			clickScreen(513, 416)
		EndIf
		ExitLoop
	WEnd
EndFunc

Func getVillageInformation()  
	While 1
		setLog("------------------------------------------------------------", $COLOR_GREEN);
		setLog("Search Configuration", $COLOR_GREEN);
		setLog("Minimum Gold: " & $minGold, $COLOR_GREEN);
		setLog("Minimum Elixir: " & $minElixir, $COLOR_GREEN);
		setLog("Minimum Dark Elixir: " & $minDarkElixir, $COLOR_GREEN);
		
		If GUICtrlRead($cMeetGnE) = $GUI_CHECKED Then
			setLog("Condition: Minimum Gold And Elixir", $COLOR_GREEN)
		EndIf

		If GUICtrlRead($cMeetGoE) = $GUI_CHECKED Then
			setLog("Condition: Minimum Gold or Elixir", $COLOR_GREEN)
		EndIf

		If GUICtrlRead($cMeetDE) = $GUI_CHECKED Then
			setLog("Condition: Minimum Dark Elixir", $COLOR_GREEN)
		EndIf

		If GUICtrlRead($cMeetThOut) = $GUI_CHECKED Then
			setLog("Condition: Town Hall Outside ", $COLOR_GREEN)
		EndIf
		
		Switch _GUICtrlComboBox_GetCurSel($cmAttackMode)
			Case 0
				setLog("Mode: Active", $COLOR_GREEN)
			Case 1
				setLog("Mode: Non-Active", $COLOR_GREEN)
		EndSwitch
		
		$nSearchCount = 0
		While 1
			If $bRunState = False Then
				ExitLoop
			EndIf
			
			$Date = @MDAY & "." & @MON & "." & @YEAR
			$Time = @HOUR & "." & @MIN & "." & @SEC
			If sleepThread(3000) Then ExitLoop (2)
			getResources()
			
			If compareResources() Then
				setLog("Robot: Base Meets The Variable Conditions.", $COLOR_BLUE)
				If _GUICtrlComboBox_GetCurSel($cmAttackMode) = 1 Then
					setLog("Robot: Checking The Base If It Is Non-Active.", $COLOR_BLUE)
					If sleepThread(500) Then ExitLoop (2)
					If checkNonActive() Then
						setLog("Robot: Non-Active Base Found!", $COLOR_BLUE)
						ExitLoop
					Else
						;If $nSearchTownHall = '4-6' OR $nSearchTownHall = '7' Then
							;setLog("Robot: Weak Base Found!", $COLOR_BLUE)
							;ExitLoop
						;Else	
							If GUICtrlRead($cCaptureConditionNotMatch) = $GUI_CHECKED Then
								$Date = @MDAY & "." & @MON & "." & @YEAR
								$Time = @HOUR & "." & @MIN & "." & @SEC
							   captureRegion()
							   _GDIPlus_ImageSaveToFile($oBitmap, @ScriptDir & "\screenshot\notmatch\" & $Date & " at " & $Time & ".png")
							EndIf
							setLog("Robot: Not A Non-Active Base! Skipping.", $COLOR_BLUE)
							clickScreen(750, 500)
						;EndIf						
					EndIf
				Else
					ExitLoop
				EndIf
			Else
				clickScreen(750, 500)
			EndIf
		WEnd
		
		If GUICtrlRead($cCaptureConditionMatch) = $GUI_CHECKED Then
			$Date = @MDAY & "." & @MON & "." & @YEAR
			$Time = @HOUR & "." & @MIN & "." & @SEC
			captureRegion()
		   _GDIPlus_ImageSaveToFile($oBitmap, @ScriptDir & "\screenshot\match\" & $Date & " at " & $Time & ".png")
		EndIf
		
		TrayTip("Match Found!", "An Enemy Base Meets Your Conditions!", 5, $TIP_ICONASTERISK)
		If FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
		   SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
		Else
		   SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
		EndIf
		
		setLog("Robot: Search Successfully Completed.", $COLOR_BLUE)
		$bFullUnitState = False
		ExitLoop
	WEnd
EndFunc

Func checkSynchronizationOrConnectionLost()
	$Message = searchPixel(457, 300, 458, 330, Hex(0x33B5E5, 6), 10)
	If IsArray($Message) = False Then
		Return True
	Else
		Return False
	EndIf
EndFunc