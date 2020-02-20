Func getPixelColor($iX, $iY)
	Local $aPixelColor = _GDIPlus_BitmapGetPixel($oBitmap, $iX, $iY)
	Return Hex($aPixelColor, 6)
EndFunc

Func searchPixel($iLeft, $iTop, $iRight, $iBottom, $iColor, $iColorVariation)
	captureRegion($iLeft, $iTop, $iRight, $iBottom)
	For $x = $iRight - $iLeft To 0 Step -1
		For $y = 0 To $iBottom - $iTop
			If checkColor(getPixelColor($x, $y), $iColor, $iColorVariation) Then
				Local $Pos[2] = [$iLeft + $x, $iTop + $y]
				Return $Pos
			EndIf
		Next
	Next
	Return 0
EndFunc 

Func booleanSearchPixel($pixel1, $pixel2, $pixel3, $variation = 10)
	If checkColor(getPixelColor($pixel1[0], $pixel1[1]), $pixel1[2], $variation) And checkColor(getPixelColor($pixel2[0], $pixel2[1]), $pixel2[2], $variation) And checkColor(getPixelColor($pixel3[0], $pixel3[1]), $pixel3[2], $variation) Then 
		Return True
	EndIf
		
	Return False
EndFunc