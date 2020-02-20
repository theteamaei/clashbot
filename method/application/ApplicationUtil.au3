Func checkObstacles() 
	$Message = searchPixel(457, 300, 458, 330, Hex(0x33B5E5, 6), 10)
	
	;Out of Sync or Inactive
	If IsArray($Message) Then
		clickScreen(416, 399)
		If sleepThread(6000) Then Return
		Return True
	EndIf

	captureRegion()
	
	;Attack Village Information PopUp
	If checkColor(getPixelColor(235, 209), Hex(0x9E3826, 6), 20) Then
		clickScreen(429, 493)
		Return True
	EndIf
	
	;Deselect Objects
	If checkColor(getPixelColor(284, 28), Hex(0x215B69, 6), 20) Then
		clickScreen(1, 1)
		Return True
	EndIf
	
	;Clicks X
	If checkColor(getPixelColor(819, 55), Hex(0xD80400, 6), 20) Then
		clickScreen(819, 55) 
		Return True
	EndIf

	;Clicks X
	If checkColor(getPixelColor(822, 48), Hex(0xD80408, 6), 20) Or checkColor(getPixelColor(830, 59), Hex(0xD80408, 6), 20) Then
		clickScreen(822, 48)
		Return True
	EndIf

	;Clicks Chat Log
	If checkColor(getPixelColor(331, 330), Hex(0xF0A03B, 6), 20) Then
		clickScreen(331, 330) 
		If sleepThread(1000) Then Return
		Return True
	EndIf

	;Victory or Defeat PopUp
	If checkColor(getPixelColor(429, 519), Hex(0xB8E35F, 6), 20) Then
		clickScreen(429, 519) 
		Return True
	EndIf

	;End Battle PopUp
	If checkColor(getPixelColor(71, 530), Hex(0xC00000, 6), 20) Then
		;ReturnHome(False, False) 
		Return True
	EndIf

	Return False
EndFunc

Func zoomOut()
	Local $i = 0
	While 1
		captureRegion(0, 0, 860, 2)
		If getPixelColor(1, 1) <> Hex(0x000000, 6) And getPixelColor(850, 1) <> Hex(0x000000, 6) Then 
			SetLog("Robot: Zooming Out.", $COLOR_BLUE)
		EndIf
		
		While getPixelColor(1, 1) <> Hex(0x000000, 6) And getPixelColor(850, 1) <> Hex(0x000000, 6)
			If sleepThread(600) Then 
				Return
			EndIf
				
			If ControlSend($sAppPlayerTitle, "", "", "{DOWN}") Then 
				$i += 1
			EndIf
			
			If $i = 20 Then
				ExitLoop
			EndIf
			captureRegion(0, 0, 860, 2)
		WEnd
		ExitLoop
	WEnd
EndFunc