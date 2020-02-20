Func setLog($String, $Color = 0x000000)
	appendTextColor($tLog, getTime(), 0x000000)
	appendTextColor($tLog, $String & @CRLF, convertColor($Color))
EndFunc 

Func appendTextColor($hWnd, $sText, $iColor)
	Local $iLength = _GUICtrlRichEdit_GetTextLength($hWnd, True, True)
	Local $iCp = _GUICtrlRichEdit_GetCharPosOfNextWord($hWnd, $iLength)
	_GUICtrlRichEdit_AppendText($hWnd, $sText)
	_GUICtrlRichEdit_SetSel($hWnd, $iCp-1, $iLength + StringLen($sText))
	_GUICtrlRichEdit_SetCharColor($hWnd, $iColor)
	_GUICtrlRichEdit_SetFont($hWnd, 9, $sFont)
	_GuiCtrlRichEdit_Deselect($hWnd)
EndFunc

Func convertColor($nColor)
    Return _
        BitOR(BitShift(BitAND($nColor, 0x000000FF), -16), _
        BitAND($nColor, 0x0000FF00), _
        BitShift(BitAND($nColor, 0x00FF0000), 16))
EndFunc