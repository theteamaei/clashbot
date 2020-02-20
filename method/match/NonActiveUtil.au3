Func checkNonActive()
	Return searchNonActive1()
EndFunc

GLOBAL $nAdjustTolerance = 0
Global $nTolerance[5][11] = [[55, 55, 55, 80, 70, 70, 75, 80, 0, 75, 65], [55, 55, 55, 80, 80, 70, 75, 80, 0, 75, 65], [55, 55, 55, 80, 80, 70, 75, 80, 0, 75, 65], [55, 55, 55, 80, 80, 60, 75, 75, 0, 75, 60], [55, 55, 55, 80, 80, 70, 75, 80, 0, 75, 65]]
Global $nHasFullCollectorCounter = 0, $nHasFullCollector = 0;
Global $CollectorFileSets = 4
Global $CollectorExclude = 0
Global $Lx[4] = [0, 400, 0, 400]
Global $Ly[4] = [0, 0, 265, 265]
Global $Rx[4] = [460, 860, 400, 860]
Global $Ry[4] = [325, 325, 590, 590]

Global $Area[5][11][4], $IS_x[11][4], $IS_y[11][4], $aVariantBatch1[5][11]

$aVariantBatch1[0][0] = @ScriptDir & "\src\batch1\variant1\E6F9.bmp"
$aVariantBatch1[0][1] = @ScriptDir & "\src\batch1\variant1\E7F9.bmp"
$aVariantBatch1[0][2] = @ScriptDir & "\src\batch1\variant1\E8F9.bmp"
$aVariantBatch1[0][3] = @ScriptDir & "\src\batch1\variant1\E9F9.bmp"
$aVariantBatch1[0][4] = @ScriptDir & "\src\batch1\variant1\E10F8.bmp"
$aVariantBatch1[0][5] = @ScriptDir & "\src\batch1\variant1\E10F9.bmp"
$aVariantBatch1[0][6] = @ScriptDir & "\src\batch1\variant1\E11F8.bmp"
$aVariantBatch1[0][7] = @ScriptDir & "\src\batch1\variant1\E11F9.bmp"
$aVariantBatch1[0][8] = @ScriptDir & "\src\batch1\variant1\E12F7.bmp"
$aVariantBatch1[0][9] = @ScriptDir & "\src\batch1\variant1\E12F8.bmp"
$aVariantBatch1[0][10] = @ScriptDir & "\src\batch1\variant1\E12F9.bmp"

$aVariantBatch1[1][0] = @ScriptDir & "\src\batch1\variant2\E6F9.bmp"
$aVariantBatch1[1][1] = @ScriptDir & "\src\batch1\variant2\E7F9.bmp"
$aVariantBatch1[1][2] = @ScriptDir & "\src\batch1\variant2\E8F9.bmp"
$aVariantBatch1[1][3] = @ScriptDir & "\src\batch1\variant2\E9F9.bmp"
$aVariantBatch1[1][4] = @ScriptDir & "\src\batch1\variant2\E10F8.bmp"
$aVariantBatch1[1][5] = @ScriptDir & "\src\batch1\variant2\E10F9.bmp"
$aVariantBatch1[1][6] = @ScriptDir & "\src\batch1\variant2\E11F8.bmp"
$aVariantBatch1[1][7] = @ScriptDir & "\src\batch1\variant2\E11F9.bmp"
$aVariantBatch1[1][8] = @ScriptDir & "\src\batch1\variant2\E12F7.bmp"
$aVariantBatch1[1][9] = @ScriptDir & "\src\batch1\variant2\E12F8.bmp"
$aVariantBatch1[1][10] = @ScriptDir & "\src\batch1\variant2\E12F9.bmp"

$aVariantBatch1[2][0] = @ScriptDir & "\src\batch1\variant3\E6F9.bmp"
$aVariantBatch1[2][1] = @ScriptDir & "\src\batch1\variant3\E7F9.bmp"
$aVariantBatch1[2][2] = @ScriptDir & "\src\batch1\variant3\E8F9.bmp"
$aVariantBatch1[2][3] = @ScriptDir & "\src\batch1\variant3\E9F9.bmp"
$aVariantBatch1[2][4] = @ScriptDir & "\src\batch1\variant3\E10F8.bmp"
$aVariantBatch1[2][5] = @ScriptDir & "\src\batch1\variant3\E10F9.bmp"
$aVariantBatch1[2][6] = @ScriptDir & "\src\batch1\variant3\E11F8.bmp"
$aVariantBatch1[2][7] = @ScriptDir & "\src\batch1\variant3\E11F9.bmp"
$aVariantBatch1[2][8] = @ScriptDir & "\src\batch1\variant3\E12F7.bmp"
$aVariantBatch1[2][9] = @ScriptDir & "\src\batch1\variant3\E12F8.bmp"
$aVariantBatch1[2][10] = @ScriptDir & "\src\batch1\variant3\E12F9.bmp"

$aVariantBatch1[3][0] = @ScriptDir & "\src\batch1\variant4\E6F9.bmp"
$aVariantBatch1[3][1] = @ScriptDir & "\src\batch1\variant4\E7F9.bmp"
$aVariantBatch1[3][2] = @ScriptDir & "\src\batch1\variant4\E8F9.bmp"
$aVariantBatch1[3][3] = @ScriptDir & "\src\batch1\variant4\E9F9.bmp"
$aVariantBatch1[3][4] = @ScriptDir & "\src\batch1\variant4\E10F8.bmp"
$aVariantBatch1[3][5] = @ScriptDir & "\src\batch1\variant4\E10F9.bmp"
$aVariantBatch1[3][6] = @ScriptDir & "\src\batch1\variant4\E11F8.bmp"
$aVariantBatch1[3][7] = @ScriptDir & "\src\batch1\variant4\E11F9.bmp"
$aVariantBatch1[3][8] = @ScriptDir & "\src\batch1\variant4\E12F7.bmp"
$aVariantBatch1[3][9] = @ScriptDir & "\src\batch1\variant4\E12F8.bmp"
$aVariantBatch1[3][10] = @ScriptDir & "\src\batch1\variant4\E12F9.bmp"

Func searchNonActive1()
	captureRegion()
	$nHasFullCollector = 0
	$nHasFullCollectorCounter = 0
	For $s = 0 To ($CollectorFileSets - 1) Step 1
		For $p = 10 To 0 + $CollectorExclude Step -1
			If FileExists($aVariantBatch1[$s][$p]) Then
			$Area[$s][$p][0] = searchImage($aVariantBatch1[$s][$p], 1, $IS_x[$p][0], $IS_y[$p][0], $nTolerance[$s][$p] + $nAdjustTolerance)
				If $Area[$s][$p][0] > 0 Then
					$variantX = $IS_x[$p][0]
					$variantY =	$IS_y[$p][0]
					$nHasFullCollectorCounter = 1
					ExitLoop (2)
				EndIf
			Else
				$Area[$s][$p][0]= 0
			EndIf
		Next
	Next
	$nHasFullCollector += $nHasFullCollectorCounter
	If $nHasFullCollector > 0 Then
		Return True
	Else
		Return False
	EndIf
EndFunc