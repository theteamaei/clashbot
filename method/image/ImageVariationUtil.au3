Func searchImage($findImage, $resultPosition, ByRef $x, ByRef $y, $Tolerance)
	;Return searchImageArea($findImage, $resultPosition, 0, 0, 840, 720, $x, $y, $Tolerance)
	Return searchImageArea($findImage, $resultPosition, 0, 0, @DesktopWidth, @DesktopHeight, $x, $y, $Tolerance)
EndFunc

Func searchImageArea($findImage, $resultPosition, $x1, $y1, $right, $bottom, ByRef $x, ByRef $y, $Tolerance)
	Global $HBMP = $oTempBitmap
	If $ichkBackground = 0 Then
	    $HBMP = 0
		$x1 += $aBlueStacksPosition[0]
		$y1 += $aBlueStacksPosition[1]
		$right += $aBlueStacksPosition[0]
		$bottom += $aBlueStacksPosition[1]
	EndIf

	If IsString($findImage) Then
		If $Tolerance > 0 Then $findImage = "*" & $Tolerance & " " & $findImage
		If $HBMP = 0 Then
			$result = DllCall(@ScriptDir & "\ClashBot.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage)
		Else
			$result = DllCall(@ScriptDir & "\ClashBot.dll", "str", "ImageSearchEx", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "str", $findImage, "ptr", $HBMP)
		EndIf
	Else
		$result = DllCall(@ScriptDir & "\ClashBot.dll", "str", "ImageSearchExt", "int", $x1, "int", $y1, "int", $right, "int", $bottom, "int", $Tolerance, "ptr", $findImage, "ptr", $HBMP)
	EndIf

	If IsArray($result) Then
		If $result[0] = "0" Then Return 0
	Else
		setLog("Robot: Image Search Not Working.", $COLOR_RED)
		Return 1
	EndIf

	$array = StringSplit($result[0], "|")
	If (UBound($array) >= 4) Then
		$x = Int(Number($array[2]))
		$y = Int(Number($array[3]))
		If $resultPosition = 1 Then
			$x = $x + Int(Number($array[4]) / 2)
			$y = $y + Int(Number($array[5]) / 2)
		EndIf
		Return 1
	EndIf
EndFunc