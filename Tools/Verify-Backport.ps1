param([string]$CellPath = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = "Stop"
$failures = [System.Collections.Generic.List[string]]::new()

function Assert-Check([bool]$Condition, [string]$Description) {
    if ($Condition) { Write-Output "PASS  $Description" }
    else { Write-Output "FAIL  $Description"; $failures.Add($Description) }
}

$cellRoot = (Resolve-Path -LiteralPath $CellPath).Path
$cleanReference = Join-Path $cellRoot '_clean1.15.0 repo'
$r207Reference = Join-Path $cellRoot '_official-r207-release-interface-11500'
$nestedInstallCopy = Join-Path $cellRoot 'Cell'
$allFiles = Get-ChildItem -LiteralPath $cellRoot -Recurse -File | Where-Object {
    $_.FullName -notlike "$cleanReference\*" -and $_.FullName -notlike "$r207Reference\*" -and $_.FullName -notlike "$nestedInstallCopy\*"
}
$runtimeFiles = $allFiles | Where-Object { $_.Extension -in '.lua', '.xml', '.toc' }

Assert-Check ((@($runtimeFiles | Select-String -SimpleMatch 'FIRST_FRAME_RENDERED')).Count -eq 0) 'FIRST_FRAME_RENDERED is absent from runtime source recursively'

$supporter = Get-Content -LiteralPath (Join-Path $cellRoot 'Indicators\Supporter.lua') -Raw
Assert-Check ($supporter.Contains('RegisterEvent("PLAYER_ENTERING_WORLD")') -and $supporter.Contains('UnregisterEvent("PLAYER_ENTERING_WORLD")')) 'Supporter uses PLAYER_ENTERING_WORLD'

$clickCasting = Get-Content -LiteralPath (Join-Path $cellRoot 'Modules\ClickCastings\ClickCastings.lua') -Raw
Assert-Check (-not $clickCasting.Contains('UnitHasVehicleUI(')) 'Secure click-casting does not call UnitHasVehicleUI'
Assert-Check ($clickCasting.Contains('local clickCastingUnit = unit')) 'Secure click-casting uses the actual secure unit'

$unitButton = Get-Content -LiteralPath (Join-Path $cellRoot 'RaidFrames\UnitButton_Vanilla.lua') -Raw
Assert-Check ($unitButton.Contains('if t["glowOptions"] and indicator.UpdateGlowOptions then')) 'Initial Vanilla glow update is guarded'
Assert-Check ($unitButton.Contains('if indicator and indicator.UpdateGlowOptions then')) 'Live Vanilla glow update is guarded'
Assert-Check ($unitButton.Contains('if value["glowOptions"] and indicator.UpdateGlowOptions then')) 'Layout Vanilla glow update is guarded'
Assert-Check ($unitButton.Contains('b._indicatorsCreated = b.indicators.defensiveCooldowns and b.indicators.externalCooldowns and b.indicators.allCooldowns and b.indicators.debuffs and true or nil')) 'Deferred indicator completion is transactional'
Assert-Check (-not $unitButton.Contains('UnitHasVehicleUI or function()')) 'No fake UnitHasVehicleUI fallback exists'
Assert-Check ($unitButton.Contains('if UnitHasVehicleUI and UnitHasVehicleUI(unit) then')) 'Ordinary Vanilla vehicle API use is guarded'
Assert-Check ($unitButton.Contains('if position[5] ~= nil then')) 'Indicator position resolver recognizes five-part positions'
Assert-Check ($unitButton.Contains('local relativeTo = position[2] == "healthBar" and b.widgets.healthBar or b')) 'Five-part health-bar anchor is preserved'
Assert-Check ($unitButton.Contains('P:Point(indicator, position[1], relativeTo, position[3], position[4], position[5])')) 'Five-part position is applied with numeric offsets'
Assert-Check ($unitButton.Contains('P:Point(indicator, position[1], b, position[2], position[3], position[4])')) 'Original four-part r241 position remains supported'
Assert-Check (([regex]::Matches($unitButton, 'SetIndicatorPosition\(')).Count -eq 4) 'Shared position resolver is used by initialization, live updates, and creation'
Assert-Check (-not $unitButton.Contains('P:Point(indicator, value["position"][1], b, value["position"][2], value["position"][3], value["position"][4])')) 'Live Vanilla indicator creation has no legacy four-part-only call'
Assert-Check ($unitButton.Contains('HealComm = LibStub("LibHealComm-4.0", true)') -and $unitButton.Contains('local CELL_USE_LIBHEALCOMM = HealComm ~= nil')) 'Vanilla heal prediction enables HealComm by capability'
Assert-Check ($unitButton.Contains('value = UnitGetIncomingHeals(unit) or 0')) 'Native incoming-heal prediction remains available as fallback'
Assert-Check (([regex]::Matches($unitButton, 'HealComm.RegisterCallback')).Count -eq 6) 'All six HealComm update callbacks remain registered'
Assert-Check ($unitButton.Contains('self._rosterMetadataUpdateRequired = 1')) 'Roster changes schedule a Vanilla metadata-icon refresh'
Assert-Check ($unitButton.Contains('if self._rosterMetadataUpdateRequired then') -and $unitButton.Contains('self._rosterMetadataUpdateRequired = nil')) 'Roster metadata refresh is one-shot'
Assert-Check (([regex]::Matches($unitButton, 'UnitButton_UpdateAssignment\(self\)')).Count -ge 2 -and ([regex]::Matches($unitButton, 'UnitButton_UpdateLeader\(self\)')).Count -ge 2) 'Settled roster refresh updates assignment and leader icons'

$indicatorsOptions = Get-Content -LiteralPath (Join-Path $cellRoot 'Modules\Indicators\Indicators.lua') -Raw
Assert-Check ($indicatorsOptions.Contains('local function SetPreviewIndicatorPosition(indicator, position)')) 'Indicators preview has a schema-aware position resolver'
Assert-Check ($indicatorsOptions.Contains('local relativeTo = position[2] == "healthBar" and previewButton.widgets.healthBar or previewButton')) 'Preview resolver preserves health-bar and button anchors'
Assert-Check (([regex]::Matches($indicatorsOptions, 'SetPreviewIndicatorPosition\(')).Count -eq 3) 'Preview resolver is used by initialization and live creation'
Assert-Check (-not $indicatorsOptions.Contains('P:Point(indicator, t["position"][1], previewButton, t["position"][2], t["position"][3], t["position"][4])')) 'Preview initialization has no legacy four-part-only call'
Assert-Check (-not $indicatorsOptions.Contains('P:Point(indicator, value["position"][1], previewButton, value["position"][2], value["position"][3], value["position"][4])')) 'Preview creation has no legacy four-part-only call'
Assert-Check (([regex]::Matches($indicatorsOptions, 'type\(updateGlowOptions\) == "function"')).Count -eq 3) 'All preview glow updates capture and type-check the method'

$positionWidgets = Get-Content -LiteralPath (Join-Path $cellRoot 'Widgets\Widgets_IndicatorSettings.lua') -Raw
Assert-Check ($positionWidgets.Contains('local function GetPositionWidgetValues(positionTable)')) 'Indicator settings normalize four-part and five-part positions'
Assert-Check (([regex]::Matches($positionWidgets, 'GetPositionWidgetValues\(positionTable\)')).Count -eq 4) 'All three position widgets use normalized display values'

$spotlight = Get-Content -LiteralPath (Join-Path $cellRoot 'RaidFrames\Groups\SpotlightFrame.lua') -Raw
Assert-Check ($spotlight.Contains('local UnitGroupRolesAssigned = UnitGroupRolesAssigned or function()')) 'Spotlight has a Vanilla assigned-role fallback'
$groupInfo = Get-Content -LiteralPath (Join-Path $cellRoot 'Libs\LibGroupInfo.lua') -Raw
Assert-Check ($groupInfo.Contains('local UnitGroupRolesAssigned = UnitGroupRolesAssigned or function()')) 'Shared group info has a Vanilla assigned-role fallback'

$classicLibs = Get-Content -LiteralPath (Join-Path $cellRoot 'Libs\LoadLibs_Classic.xml') -Raw
Assert-Check ($classicLibs.Contains('<Include file="LibHealComm-4.0\LibHealComm-4.0.xml"/>')) 'Classic library manifest embeds LibHealComm'
Assert-Check ((Test-Path -LiteralPath (Join-Path $cellRoot 'Libs\LibHealComm-4.0\LibHealComm-4.0.lua'))) 'Embedded LibHealComm implementation exists'

$mainFrame = Get-Content -LiteralPath (Join-Path $cellRoot 'RaidFrames\MainFrame.lua') -Raw
Assert-Check (([regex]::Matches($mainFrame, 'frame:RegisterForDrag\("LeftButton"\)')).Count -eq 1) 'Main menu handles register for drag immediately'
Assert-Check ($mainFrame.Contains('frame:EnableMouse(true)')) 'Main menu handles explicitly enable mouse input'
Assert-Check ($mainFrame.Contains('if CellDB["general"]["locked"] or InCombatLockdown() then return end')) 'Main menu drag honors lock and combat state'
Assert-Check (-not $mainFrame.Contains('anchorFrame:SetUserPlaced(false)')) 'Main menu drag does not cancel user-placed movement'
Assert-Check ($mainFrame.Contains('local function MainFrame_GroupTypeChanged(groupType)') -and $mainFrame.Contains('raid:Show()') -and -not $mainFrame.Contains('raid:Hide()')) 'Blue raid/setup handle remains visible outside raids'

$optionsFrame = Get-Content -LiteralPath (Join-Path $cellRoot 'Modules\OptionsFrame.lua') -Raw
Assert-Check ($optionsFrame.Contains('RegisterDragForOptionsFrame(optionsFrame)')) 'Options body is a drag surface'
Assert-Check ($optionsFrame.Contains('optionsFrame:EnableMouse(true)')) 'Options body explicitly enables mouse input'
Assert-Check (([regex]::Matches($optionsFrame, 'RegisterDragForOptionsFrame\(')).Count -eq 10) 'Options body and all eight tabs use the shared drag handler'
Assert-Check (-not $optionsFrame.Contains('optionsFrame:SetUserPlaced(false)')) 'Options drag does not cancel user-placed movement'
Assert-Check ($optionsFrame.Contains('P:SavePosition(optionsFrame, CellDB["optionsFramePosition"])')) 'Options drag still persists position'

$about = Get-Content -LiteralPath (Join-Path $cellRoot 'Modules\About\About.lua') -Raw
Assert-Check ($about.Contains('if label.SetRotation then')) 'About rotation is capability-guarded'
Assert-Check ($about.Contains('label:SetText("S\nu\np\np\no\nr\nt\ne\nr\ns")')) 'About has a vertical-text fallback for 1.14.2'

$raidRoster = Get-Content -LiteralPath (Join-Path $cellRoot 'Utilities\RaidRosterFrame.lua') -Raw
Assert-Check (-not $raidRoster.Contains('GLOBAL_MOUSE_UP')) 'Raid Roster does not use unsupported GLOBAL_MOUSE_UP'
Assert-Check ($raidRoster.Contains('local function FinishGridDrop()')) 'Raid Roster resolves drops locally'
Assert-Check ($raidRoster.Contains('FinishGridDrop()')) 'Roster drag-stop invokes local drop resolution'
Assert-Check (-not $raidRoster.Contains('grid:SetUserPlaced(false)')) 'Roster drag does not cancel user-placed movement'
Assert-Check ($raidRoster.Contains('SwapRaidSubgroup(source.raidIndex, target.raidIndex)') -and $raidRoster.Contains('SetRaidSubgroup(source.raidIndex, target.subgroup)')) 'Instant Raid Roster drop actions remain present'
Assert-Check ($raidRoster.Contains('PremadeSwap(source, target)') -and $raidRoster.Contains('PremadeSet(source, target)')) 'Premade Raid Roster drop actions remain present'

$builtIn = Get-Content -LiteralPath (Join-Path $cellRoot 'Indicators\Built-in.lua') -Raw
Assert-Check ($builtIn.Contains('local method, partyIndex, raidIndex = GetLootMethod()')) 'Assignment indicator queries the Vanilla loot method'
Assert-Check ($builtIn.Contains('masterLooterUnit = "raid" .. raidIndex') -and $builtIn.Contains('partyIndex == 0 and "player" or "party" .. partyIndex')) 'Master Looter resolves raid, party, and player units'
Assert-Check ($builtIn.Contains('Interface\\AddOns\\Cell\\Media\\Icons\\master-looter')) 'Assignment indicator uses the packaged Cell Master Looter texture'
$masterLooterIcon = Join-Path $cellRoot 'Media\Icons\master-looter.tga'
$masterLooterHeader = [System.IO.File]::ReadAllBytes($masterLooterIcon)
Assert-Check ((Test-Path -LiteralPath $masterLooterIcon) -and $masterLooterHeader[12] -eq 32 -and $masterLooterHeader[13] -eq 0 -and $masterLooterHeader[14] -eq 32 -and $masterLooterHeader[15] -eq 0 -and $masterLooterHeader[16] -eq 32) 'Master Looter artwork is a 32x32 32-bit TGA'
Assert-Check ($unitButton.Contains('self:RegisterEvent("PARTY_LOOT_METHOD_CHANGED")') -and $unitButton.Contains('elseif event == "PARTY_LOOT_METHOD_CHANGED" then')) 'Vanilla unit buttons refresh on loot-method changes'
foreach ($status in 'OFFLINE', 'AFK', 'FEIGN', 'DEAD', 'GHOST', 'DRINKING') {
    Assert-Check ($builtIn.Contains($status + ' = {')) "StatusText fallback includes $status"
}

$coreVanilla = Get-Content -LiteralPath (Join-Path $cellRoot 'Core_Vanilla.lua') -Raw
foreach ($setting in 'showSolo', 'showParty', 'showRaid') {
    Assert-Check ($coreVanilla.Contains('if type(CellDB["general"]["' + $setting + '"]) ~= "boolean" then')) "Sparse general DB backfills $setting"
}

$unitButtonXml = Get-Content -LiteralPath (Join-Path $cellRoot 'RaidFrames\UnitButton.xml') -Raw
Assert-Check ($unitButtonXml.Contains('<Attribute name="toggleForVehicle" type="boolean" value="false"/>')) 'Unit button vehicle toggle defaults false'
$activeVehicleTrue = $runtimeFiles | Select-String -SimpleMatch 'toggleForVehicle' | Where-Object {
    $_.Line.Contains('true') -and -not $_.Line.TrimStart().StartsWith('--') -and -not $_.Line.TrimStart().StartsWith('<!--')
}
Assert-Check (@($activeVehicleTrue).Count -eq 0) 'No active toggleForVehicle=true path exists'

$tocPath = Join-Path $cellRoot 'Cell_Vanilla.toc'
$toc = Get-Content -LiteralPath $tocPath
Assert-Check ((@($toc | Select-String '^## Interface:\s*11402\s*$')).Count -eq 1) 'Vanilla TOC interface is 11402'
Assert-Check ((@($toc | Select-String '^## Version:\s*r241-beta-backport-v13\s*$')).Count -eq 1) 'Vanilla TOC version identifies backport v13'

$missingTocFiles = @()
foreach ($line in $toc) {
    $entry = $line.Trim()
    if ($entry -and -not $entry.StartsWith('#')) {
        $candidate = Join-Path $cellRoot ($entry -replace '/', '\')
        if (-not (Test-Path -LiteralPath $candidate)) { $missingTocFiles += $entry }
    }
}
Assert-Check ($missingTocFiles.Count -eq 0) 'Every direct Vanilla TOC reference exists'

$xmlFiles = $allFiles | Where-Object { $_.Extension -eq '.xml' }
$xmlFailures = @()
foreach ($xmlFile in $xmlFiles) {
    try { [xml](Get-Content -LiteralPath $xmlFile.FullName -Raw) | Out-Null }
    catch { $xmlFailures += $xmlFile.FullName }
}
Assert-Check ($xmlFailures.Count -eq 0) "All $($xmlFiles.Count) XML files parse"

$luaFiles = $allFiles | Where-Object { $_.Extension -eq '.lua' }
$luac = Get-Command luac -ErrorAction SilentlyContinue
if ($luac) {
    $luaFailures = @()
    foreach ($luaFile in $luaFiles) {
        & $luac.Source -p $luaFile.FullName 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) { $luaFailures += $luaFile.FullName }
    }
    Assert-Check ($luaFailures.Count -eq 0) "All $($luaFiles.Count) Lua files pass syntax validation"
} else {
    Write-Output "SKIP  Lua syntax validation (luac not installed)"
}

Write-Output "FILES $($allFiles.Count)"
Write-Output "XML   $($xmlFiles.Count)"
Write-Output "LUA   $($luaFiles.Count)"
if ($failures.Count) { Write-Error ("Recursive verification failed: " + ($failures -join '; ')); exit 1 }
Write-Output 'RESULT PASS'
