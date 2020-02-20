Func sleepThread($iDelay, $iSleep = True)
	Local $iBegin = TimerInit()
	While TimerDiff($iBegin) < $iDelay
		If $bRunState = False Then 
			Return True
		EndIf
		If $iSleep = True Then 
			Sleep(50)
		EndIf
	WEnd
	Return False
EndFunc

#comments-start
Func sleepThread($iDelay)
	checkAppWindow()
	Sleep($iDelay)
	If $bRunState = False Then
		Return True
	Else
		Return False
	EndIf
EndFunc
#comments-end