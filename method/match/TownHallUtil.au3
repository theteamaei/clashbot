Global $townHallVariant[5]
$townHallVariant[0] = @ScriptDir & "\src\townhall\townhall6.bmp"
$townHallVariant[1] = @ScriptDir & "\src\townhall\townhall7.bmp"
$townHallVariant[2] = @ScriptDir & "\src\townhall\townhall8.bmp"
$townHallVariant[3] = @ScriptDir & "\src\townhall\townhall9.bmp"
$townHallVariant[4] = @ScriptDir & "\src\townhall\townhall10.bmp"

Global $nTolerance1 = 80

Func searchTownHall()
    If sleepThread(500) Then Return
	captureRegion()
	For $i = 0 To 4
		$aTownHall = searchImage($townHallVariant[$i], 1, $variantX, $variantY, $nTolerance1)
		If $aTownHall = 1 Then
			Return $aTownHallList[$i]
		EndIf
	Next
   If $aTownHall = 0 Then Return "-"
EndFunc