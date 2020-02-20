Func getResources()
	While 1
		Local $i = 0
		Local $x = 0
		While getGold(51, 66) = ""
			If sleepThread(500) Then ExitLoop (2)
			$i += 1
			If $i >= 20 Then
				If $bRunState = False Then
					ExitLoop (2)
				EndIf
				If checkSynchronizationOrConnectionLost() And $x <= 10 Then
					clickScreen(750, 500)
					$x += 1
				Else
					setLog("Robot: Synchronization Error. Restarting Application.", $COLOR_RED)
					If sleepThread(1000) Then Return
					getMainScreen()
					If sleepThread(1000) Then Return
					zoomOut()
					If sleepThread(1000) Then Return
					initializeMatch()
					If sleepThread(1000) Then Return
				EndIf
				$i = 0
			EndIf
		WEnd
		If sleepThread(300) Then ExitLoop (2)

		;$nSearchTownHall = searchTownHall()
		$nSearchGold = getGold(51, 66)
		$nSearchElixir = getElixir(51, 66 + 29)
		$nSearchDarkElixir = getDarkElixir(51, 66 + 57)

		$nSearchCount += 1
		setLog("------------------------------------------------------------", $COLOR_GREEN);
		setLog("MATCH #" & $nSearchCount & " INFORMATION", $COLOR_GREEN);
		setLog("Gold: " & $nSearchGold, $COLOR_GREEN) 
		setLog("Elixir: " & $nSearchElixir, $COLOR_GREEN) 
		setLog("Dark Elixir: " & $nSearchDarkElixir, $COLOR_GREEN)
		;setLog("Town Hall: " & $nSearchTownHall, $COLOR_GREEN)
		ExitLoop
	WEnd
EndFunc

Func compareResources()
	If $nSearchCount = 20 Then
		If $minGold - 5000 >= 0 Then $minGold -= 5000
		If $minElixir - 5000 >= 0 Then $minElixir -= 5000
		If $minDarkElixir - 100 >= 0 Then $minDarkElixir -= 100
		setLog("------------------------------------------------------------", $COLOR_GREEN);
		setLog("New Search Configuration", $COLOR_GREEN);
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
	EndIf
	
	Local $nGoldDifference = (Number($nSearchGold) >= Number($minGold))
	Local $nElixirDifference = (Number($nSearchElixir) >= Number($minElixir))
	Local $nDarkElixirDifference = (Number($nSearchDarkElixir) >= Number($minDarkElixir))
	
	If GUICtrlRead($cMeetGnE) = $GUI_CHECKED Then
		If $nGoldDifference = False Or $nElixirDifference = False Then Return False
	EndIf

	If GUICtrlRead($cMeetDE) = $GUI_CHECKED Then
		If $nDarkElixirDifference = False Then Return False
	EndIf

	If GUICtrlRead($cMeetGoE) = $GUI_CHECKED Then
		If $nGoldDifference = False And $nElixirDifference = False Then Return False
	EndIf

	Return True
EndFunc

Func getGold($x_start, $y_start)
	captureRegion(0, 0, $x_start + 90, $y_start + 20)

	Local $x = $x_start, $y = $y_start
	Local $Gold, $i = 0
	While getDigit($x, $y + $i, "Gold") = ""
		If $i >= 15 Then ExitLoop
		$i += 1
	WEnd
	$x = $x_start
	$Gold &= getDigit($x, $y + $i, "Gold")
	$Gold &= getDigit($x, $y + $i, "Gold")
	$Gold &= getDigit($x, $y + $i, "Gold")
	$x += 6
	$Gold &= getDigit($x, $y + $i, "Gold")
	$Gold &= getDigit($x, $y + $i, "Gold")
	$Gold &= getDigit($x, $y + $i, "Gold")
	Return $Gold
EndFunc

Func getElixir($x_start, $y_start)
	captureRegion(0, 0, $x_start + 90, $y_start + 20)
	
	Local $x = $x_start, $y = $y_start
	Local $Elixir, $i = 0
	While getDigit($x, $y + $i, "Elixir") = ""
		If $i >= 15 Then ExitLoop
		$i += 1
	WEnd
	$x = $x_start
	$Elixir &= getDigit($x, $y + $i, "Elixir")
	$Elixir &= getDigit($x, $y + $i, "Elixir")
	$Elixir &= getDigit($x, $y + $i, "Elixir")
	$x += 6
	$Elixir &= getDigit($x, $y + $i, "Elixir")
	$Elixir &= getDigit($x, $y + $i, "Elixir")
	$Elixir &= getDigit($x, $y + $i, "Elixir")
	Return $Elixir
EndFunc

Func getDarkElixir($x_start, $y_start)
	captureRegion(0, 0, $x_start + 90, $y_start + 20)
	
	Local $x = $x_start, $y = $y_start
	Local $DarkElixir, $i = 0
	While getDigit($x, $y + $i, "DarkElixir") = ""
		If $i >= 15 Then ExitLoop
		$i += 1
	WEnd
	$x = $x_start
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$x += 6
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	$DarkElixir &= getDigit($x, $y + $i, "DarkElixir")
	Return $DarkElixir
EndFunc