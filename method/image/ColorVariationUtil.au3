Func checkColor($nColor1, $nColor2, $sVariation = 5)
	Local $Red1, $Red2, $Blue1, $Blue2, $Green1, $Green2

	$Red1 = Dec(StringMid(String($nColor1), 1, 2))
	$Blue1 = Dec(StringMid(String($nColor1), 3, 2))
	$Green1 = Dec(StringMid(String($nColor1), 5, 2))

	$Red2 = Dec(StringMid(String($nColor2), 1, 2))
	$Blue2 = Dec(StringMid(String($nColor2), 3, 2))
	$Green2 = Dec(StringMid(String($nColor2), 5, 2))

	If Abs($Blue1 - $Blue2) > $sVariation Then 
		Return False
	ElseIf Abs($Green1 - $Green2) > $sVariation Then 
		Return False
	ElseIf Abs($Red1 - $Red2) > $sVariation Then 
		Return False
	Else
		Return True
	EndIf
EndFunc