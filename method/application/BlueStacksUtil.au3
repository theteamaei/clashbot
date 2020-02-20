Func getBlueStacksPosition()
	$aPos = ControlGetPos($sAppPlayerTitle, "", "[CLASS:BlueStacksApp; INSTANCE:1]")
	$tPoint = DllStructCreate("int X;int Y")
	DllStructSetData($tPoint, "X", $aPos[0])
	DllStructSetData($tPoint, "Y", $aPos[1])
	_WinAPI_ClientToScreen(WinGetHandle(WinGetTitle($sAppPlayerTitle)), $tPoint)

	$aBlueStacksPosition[0] = DllStructGetData($tPoint, "X")
	$aBlueStacksPosition[1] = DllStructGetData($tPoint, "Y")
EndFunc

Func getMainScreen()
	setLog("Robot: Finding BlueStacks Screen.", $COLOR_BLUE)
    _WinAPI_EmptyWorkingSet(WinGetProcess($sAppPlayerTitle))

	captureRegion()
	
	While checkColor(getPixelColor(284, 28), Hex(0x41B1CD, 6), 20) = False
		$oAppPlayerWindow = WinGetHandle($sAppPlayerTitle)

		If sleepThread(1000) Then Return
		If checkObstacles() = False Then
			clickScreen(126, 700, 1, 500)
			Local $RunApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($sAppPlayerTitle)), "Frontend", "RunApp")
			Run($RunApp & " Android com.supercell.clashofclans com.supercell.clashofclans.GameApp")
		 EndIf
		waitMainScreen()
	WEnd
	
	setLog("Robot: BlueStacks Screen Found.", $COLOR_BLUE)
EndFunc


Func waitMainScreen()
	setLog("Robot: Waiting For Main Screen To Show.", $COLOR_BLUE)
	For $i = 0 To 150
		captureRegion()
		If checkColor(getPixelColor(284, 28), Hex(0x41B1CD, 6), 20) = False Then
			If sleepThread(2000) Then 
				Return
			EndIf
			If checkObstacles() Then 
				$i = 0
			EndIf
		Else
			Return
		EndIf
	Next

	setLog("Robot: Unable To Load Clash Of Clans. Restarting The Application.", $COLOR_RED)
	Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($sAppPlayerTitle)), "Frontend", "Restart")
	Run($RestartApp & " Android")
	If sleepThread(10000) Then 
		Return
	EndIf
	
	Do
		If sleepThread(5000) Then 
			Return
		EndIf
	Until ControlGetHandle($sAppPlayerTitle, "", "BlueStacksApp1") <> 0
EndFunc