Func locateBarracks()
	setLog("Robot: Locating Barracks Positions.", $COLOR_BLUE)
	Local $MsgBox
	While 1
		While 1
			$MsgBox = MsgBox(6 + 262144, "Locate Your First Barracks", "Click [Continue] To Click Your First Barracks. Click [Cancel] To Stop Locating Barracks. Click [Try Again] To Start Over Again.", 0, $fMain)
			If $MsgBox = 11 Then
				$aBarracksPosition[0][0] = getMousePosition()[0]
				$aBarracksPosition[0][1] = getMousePosition()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 0 To 3
				   $aBarracksPosition[$i][0] = ""
				   $aBarracksPosition[$i][1] = ""
			    Next
				ExitLoop (2)
			EndIf
			
			$MsgBox = MsgBox(6 + 262144, "Locate Your Second Barracks", "Click [Continue] To Click Your Second Barracks. Click [Cancel] To Stop Locating Barracks. Click [Try Again] To Start Over Again.", 0, $fMain)
			If $MsgBox = 11 Then
				$aBarracksPosition[1][0] = getMousePosition()[0]
				$aBarracksPosition[1][1] = getMousePosition()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 1 To 3
				   $aBarracksPosition[$i][0] = ""
				   $aBarracksPosition[$i][1] = ""
			    Next
				ExitLoop (2)
			EndIf
			
			$MsgBox = MsgBox(6 + 262144, "Locate Your Third Barracks", "Click [Continue] To Click Your Third Barracks. Click [Cancel] To Stop Locating Barracks. Click [Try Again] To Start Over Again.", 0, $fMain)
			If $MsgBox = 11 Then
				$aBarracksPosition[2][0] = getMousePosition()[0]
				$aBarracksPosition[2][1] = getMousePosition()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = 2 To 3
				   $aBarracksPosition[$i][0] = ""
				   $aBarracksPosition[$i][1] = ""
			    Next
				ExitLoop (2)
			EndIf
			
			$MsgBox = MsgBox(6 + 262144, "Locate Your Fourth Barracks", "Click [Continue] To Click Your Fourth Barracks. Click [Cancel] To Stop Locating Barracks. Click [Try Again] To Start Over Again.", 0, $fMain)
			If $MsgBox = 11 Then
				$aBarracksPosition[3][0] = getMousePosition()[0]
				$aBarracksPosition[3][1] = getMousePosition()[1]
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				$aBarracksPosition[3][0] = ""
				$aBarracksPosition[3][1] = ""
			EndIf
			
			ExitLoop (2)
		WEnd
	WEnd
	saveConfig()
	SetLog("Robot: Locating Barracks Positions Completed.", $COLOR_BLUE)
	setLog("Barracks #1 Coordinates: " & "(" & $aBarracksPosition[0][0] & ", " & $aBarracksPosition[0][1] & ")", $COLOR_GREEN)
	setLog("Barracks #2 Coordinates: " & "(" & $aBarracksPosition[1][0] & ", " & $aBarracksPosition[1][1] & ")", $COLOR_GREEN)
	setLog("Barracks #3 Coordinates: " & "(" & $aBarracksPosition[2][0] & ", " & $aBarracksPosition[2][1] & ")", $COLOR_GREEN)
	setLog("Barracks #4 Coordinates: " & "(" & $aBarracksPosition[3][0] & ", " & $aBarracksPosition[3][1] & ")", $COLOR_GREEN)
EndFunc

Func locateCollectors()
	setLog("Robot: Locating Collectors Positions.", $COLOR_BLUE)
	Local $MsgBox
	Local $nCounter = 0
	Local $nTemp = 0
	While 1
		For $i = 0 To 13
			$MsgBox = MsgBox(6 + 262144, "Locate Your Collector #" & $i + 1, "Click [Continue] To Click Your Collector #" & $i + 1 & ". Click [Cancel] To Stop Locating Collectors. Click [Try Again] To Start Over Again.", 0, $fMain)
			If $MsgBox = 11 Then
				$aCollectorPosition[$i][0] = getMousePosition()[0]
				$aCollectorPosition[$i][1] = getMousePosition()[1]
				$nCounter = $nCounter + 1
			ElseIf $MsgBox = 10 Then
				ExitLoop
			Else
				For $i = $i To 13
					$aCollectorPosition[$i][0] = ""
					$aCollectorPosition[$i][1] = ""
					$nCounter = 0
				Next
				ExitLoop (2)
			EndIf
		Next
		ExitLoop
	WEnd
	
	saveConfig()
	setLog("Robot: Locating Collectors Positions Completed.", $COLOR_BLUE)
	While $nTemp <> $nCounter
		setLog("Collector #" & $nTemp + 1 & " Coordinates: " & "(" & $aCollectorPosition[$nTemp][0] & ", " & $aCollectorPosition[$nTemp][1] & ")", $COLOR_GREEN)
		$nTemp = $nTemp + 1
	WEnd
	
EndFunc