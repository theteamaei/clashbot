Func clickScreen($x, $y, $times = 1, $speed = 0)
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($sAppPlayerTitle, "", "", "left", "1", $x, $y)
			If sleepThread($speed, False) Then ExitLoop
		Next
	Else
		ControlClick($sAppPlayerTitle, "", "", "left", "1", $x, $y)
	EndIf
EndFunc

Func clickArea()
	Local $MsgBox
	While 1
		$MsgBox = MsgBox(6 + 262144, "Click An Area", "Click [Continue] To Click an Area. Click [Cancel] To Stop Clicking An Area.", 0, $fMain)
		If $MsgBox = 11 Then
			;Continue
			$sMouseX = getMousePosition()[0]
			$sMouseY = getMousePosition()[1]
			setLog("Application: Area's X Coordinate - " & $sMouseX, $COLOR_RED)
			setLog("Application: Area's Y Coordinate - " & $sMouseY, $COLOR_RED)
		Else
			;Cancel
			ExitLoop
		EndIf
	WEnd
EndFunc

Func getMousePosition()
	getBlueStacksPosition()
	Local $aMousePosition[2]
	While 1
		If _IsPressed("01") Then
			$aMousePosition[0] = MouseGetPos()[0] - $aBlueStacksPosition[0]
			$aMousePosition[1] = MouseGetPos()[1] - $aBlueStacksPosition[1]
			Return $aMousePosition
		EndIf
	WEnd
EndFunc