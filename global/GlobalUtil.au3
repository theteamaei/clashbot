#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <GuiTab.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>

Global CONST $COLOR_ORANGE = 0xFFA500

Global $sAppTitle = "ClashBot Version 11.4.5.5"
Global $sFont = "Calibri"
Global $fMain, $tMain, $tClashBotLog
Global $tpGeneral, $tpUnits, $tpMatch, $tpAttack, $tpDevelopment
Global $tLog
Global $bStart, $bStop

Global $aBarracksPosition[4][2]
Global $aCollectorPosition[17][2]
Global $aTrapPosition[2] = [-1, -1]

Global $gRobotSettings
Global $cBoostBarracks, $cCollectResources

Global $gUnitSettings, $gTrainingSettings, $gUpgradeSettings
Global $lTownHall, $lTrainingCondition, $lUnitCapacity
Global $cmTownHall, $tUnitCapacity
Global $cmTrainingCondition
Global $cUpgradeTarget1, $cUpgradeTarget2, $cUpgradeTarget3, $cUpgradeTarget4, $cUpgradeTarget5
Global $lGoldNeeded1, $lGoldNeeded2, $lGoldNeeded3, $lGoldNeeded4, $lGoldNeeded5
Global $tGoldNeeded1, $tGoldNeeded2, $tGoldNeeded3, $tGoldNeeded4, $tGoldNeeded5
Global $bUpgradeTarget1, $bUpgradeTarget2, $bUpgradeTarget3, $bUpgradeTarget4, $bUpgradeTarget5

Global $gConditionSettings, $gVariableSettings, $gSearchSettings
Global $cMeetGnE, $cMeetGoE, $cMeetDE, $cMeetThOut
Global $lMinGold, $lMinElixir, $lMinDarkElixir
Global $tMinGold, $tMinElixir, $tMinDarkElixir
Global $bStartSearch, $bContinueSearch, $bStopSearch

Global $gBehaviorSettings, $gHeroSettings
Global $lAttackMode, $lAttackDeployment
Global $cmAttackMode, $cmAttackDeployment
Global $cEnableKing, $cEnableQueen

Global $gLocationSettings, $gCreatorSettings
Global $cCaptureConditionMatch, $cCaptureConditionNotMatch, $cCaptureLoot

Global $bLocateTownHall, $bLocateBarracks, $bLocateCollectors, $bLocateTraps, $bLocateCannons
Global $bLocateArcherTowers, $bLocateMortars, $bLocateWizardTowers, $bLocateAirDefenses
Global $bLocateHiddenTeslas, $bLocateXBow, $bLocateInfernoTowers
Global $bClickArea, $bSearchImage, $bAttack

Global $sAppPlayerTitle = "BlueStacks App Player"
Global $oAppPlayerWindow = WinGetHandle($sAppPlayerTitle)
Global $oBitmap
Global $oTempBitmap
Global $config = @ScriptDir & "\config.ini"

Global $bRunState = False
Global $bTrainState1 = False
Global $bTrainState2 = False
Global $bTrainState3 = False
Global $bTrainState4 = False
Global $bFullUnitState = False
Global $bCancelUnitsState = False
Global $bTrainAttackState = False
Global $bFinishTrainAttackState = False
Global $nIdleTime = 60000

Global $aBlueStacksPosition[2]

Global $nSearchCount = 0
Global $minGold, $minElixir, $minDarkElixir
Global $nSearchGold, $nSearchElixir, $nSearchDarkElixir, $nSearchTownHall
Global $aChkConditions[4], $aDevConditions[3]
Global $nUnitComposition, $nUnitCapacity, $nTownHall
Global $nAttackMode, $nAttackDeployment
Global $aAppPosition[2]
Global $bBoostBarracks, $bCollectResources
Global $bEnableKing, $bEnableQueen

Global $aTownHallList[5]
$aTownHallList[0] = "4-6"
$aTownHallList[1] = "7"
$aTownHallList[2] = "8"
$aTownHallList[3] = "9"
$aTownHallList[4] = "10"

Global $nHeroSkilLDelay
Global $ichkBackground = 0
Global $variantX = 0, $variantY = 0
Local $nDate = @MDAY & "." & @MON & "." & @YEAR
Local $nTime = @HOUR & "." & @MIN & "." & @SEC
Global $nBoostTime = 0
Global $nBoostVariant = 0
Global $bBoostState = False