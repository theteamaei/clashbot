Func checkBattleOver()
	While checkBattleProgress()
		If sleepThread(1000) Then Return
	WEnd
	
	setLog("Robot: Returning Home.", $COLOR_BLUE)
	If sleepThread(2000) Then Return
	setLog("Robot: Clicking the RETURN HOME BUTTON.", $COLOR_BLUE)
	clickScreen(428, 544)

	Local $nCounter = 0
	While 1
		If sleepThread(2000) Then Return
		captureRegion()
		If checkColor(getPixelColor(284, 28), Hex(0x41B1CD, 6), 20) Then
			_GUICtrlEdit_SetText($tLog, "")
			Return
		EndIf

		$nCounter += 1

		If $nCounter >= 50 Then
			setLog("Robot: Cannot Click RETURN HOME Button.", $COLOR_RED)
			getMainScreen()
			Return
		EndIf
	WEnd
EndFunc

Func checkBattleProgress()
	Local $Gold1, $Gold2, $Elixir1, $Elixir2
	While 1
		$Gold1 = getGold(51, 66)
		$Elixir1 = getElixir(51, 66 + 29)
		Local $iBegin = TimerInit()
		While TimerDiff($iBegin) < 3000000
			If sleepThread(2000) Then Return
			captureRegion()
			If checkColor(getPixelColor(433, 549), Hex(0xFFFFFF, 6), 20) Then Return False
		WEnd
		$Gold2 = getGold(51, 66)
		$Elixir2 = getElixir(51, 66 + 29)
		If ($Gold1 = $Gold2 And $Elixir1 = $Elixir2) Or ($Gold2 = "" And $Elixir2 = "") Then
			Return False
		Else
			setLog("Robot: Resource Changes Detected. Waiting To Finish.", $COLOR_BLUE)
			Return True
		EndIf
		ExitLoop
	WEnd
EndFunc