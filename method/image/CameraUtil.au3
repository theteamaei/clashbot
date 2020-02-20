Func captureRegion($iLeft = 0, $iTop = 0, $iRight = 860, $iBottom = 720, $ReturnBMP = False)
	_GDIPlus_BitmapDispose($oBitmap)
	_WinAPI_DeleteObject($oTempBitmap)	
	getBlueStacksPosition()
	$oTempBitmap = _ScreenCapture_Capture("", $iLeft + $aBlueStacksPosition[0], $iTop + $aBlueStacksPosition[1], $iRight + $aBlueStacksPosition[0], $iBottom + $aBlueStacksPosition[1])
	Global $oBitmap = _GDIPlus_BitmapCreateFromHBITMAP($oTempBitmap)
	
	If $ReturnBMP Then 
		Return $oBitmap
	EndIf
EndFunc

Func captureScreen($iLeft = 0, $iTop = 0, $iRight = @DesktopWidth, $iBottom = @DesktopHeight, $ReturnBMP = False)
	_GDIPlus_BitmapDispose($oBitmap)
	_WinAPI_DeleteObject($oTempBitmap)	
	$oTempBitmap = _ScreenCapture_Capture("", $iLeft, $iTop, $iRight, $iBottom)
	Global $oBitmap = _GDIPlus_BitmapCreateFromHBITMAP($oTempBitmap)
	
	If $ReturnBMP Then 
		Return $oBitmap
	EndIf
EndFunc