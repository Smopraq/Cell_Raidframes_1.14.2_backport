# Cell 1.14.2 Backport Recursive Verification

Build: `Cell-1.14.2-current-fix-v17`

Source: live `r241-beta-backport-v16` modified/previously patched tree plus the documented v17 ready-check display delta. The nested clean r241, official r207, and accidental `Cell/Cell` installation-copy trees are untouched and excluded from release packaging.

## New v17 delta

- [x] Vanilla unit buttons never display incomplete ready/waiting/not-ready status supplied by Kronos V.
- [x] Ready-check state is cleared and the icon is hidden both during updates and when the check finishes.
- [x] New Vanilla layouts default the Ready Check Icon to disabled.
- [x] Blizzard's response popup and Kronos's final initiator chat message remain untouched.
- [x] Cell's ready-check initiation button remains available.
- [x] No addon communication protocol is added.
- [x] No WTF or SavedVariables files are modified or packaged.

## New v16 delta

- [x] Vanilla Type B action rotation uses the 1.14.2 one-argument `SetRotation` signature.
- [x] Both action scale previews test for `SetScaleFrom` and `SetScaleTo` before calling them.
- [x] Alpha action animation remains configured when scale endpoints are unavailable.
- [x] Missing built-in indicator colors are copied from the matching Vanilla default only when absent.
- [x] Missing built-in indicator filters are copied from the matching Vanilla default only when absent.
- [x] Class-color and missing-buff widgets tolerate malformed/sparse values without throwing.
- [x] Existing complete indicator settings and surrounding layout data remain unchanged.
- [x] Options-frame dragging and saved positioning remain present and unchanged.
- [x] The opaque raid-debuff overlay remains explicitly pending visual identification.
- [x] No WTF or SavedVariables files are modified or packaged.

## New v15 delta

- [x] All boss tables in MC, BWL, AQ20, and AQ40 now contain a comprehensive candidate baseline where applicable.
- [x] Spell entries follow Cell's native built-in format and preserve configuration override behavior.
- [x] Friendly-unit actionable auras are prioritized; ordinary boss buffs and seasonal spells are excluded.
- [x] Existing empty dungeon tables remain unchanged pending dungeon-specific evidence.
- [x] Missing Classic navigation for Naxxramas, Zul'Gurub, and Onyxia is documented rather than assigned conflicting IDs.
- [x] No SavedVariables migration or WTF change is required.

## New v14 delta

- [x] One global listener handles Ragnaros knockback combat-log events; unit buttons do not register duplicate listeners.
- [x] Wrath of Ragnaros (`20566`) and Might of Ragnaros (`21154`) are recognized only on successful `SPELL_DAMAGE` events.
- [x] Destination GUIDs resolve through Cell's existing unit-button mapping.
- [x] Only friendly destinations can receive the marker.
- [x] The orange `KNOCK` overlay is non-interactive, pre-created, and automatically fades after four seconds.
- [x] Repeated hits restart the existing animation safely.
- [x] The feature does not alter raid-debuff data, boss-mod timers, click casting, or SavedVariables.

## New v13 delta

- [x] Embedded LibHealComm XML loads from `LoadLibs_Classic.xml` before Vanilla unit frames.
- [x] Cell enables HealComm only when `LibStub` returns the library.
- [x] Existing HealComm callbacks update affected unit GUIDs.
- [x] Native `UnitGetIncomingHeals()` remains the fallback when HealComm is unavailable.
- [x] Heal Prediction remains controlled by the existing Appearance checkbox.
- [x] SavedVariables remain untouched.

## New v12 delta

- [x] Party Assignment indicator detects Master Looter through `GetLootMethod()`.
- [x] Dedicated Master Looter artwork is a transparent 32x32 32-bit TGA under `Media/Icons`.
- [x] Raid and party indices resolve to stable unit IDs, including player index zero in parties.
- [x] Main Tank/Main Assist retain display priority over Master Looter.
- [x] Vanilla unit buttons refresh assignments on `PARTY_LOOT_METHOD_CHANGED`.
- [x] Existing assignment size/position settings are reused without SavedVariables migration.

## New v11 delta

- [x] `GROUP_ROSTER_UPDATE` schedules a deferred raid-metadata refresh on every Vanilla unit button.
- [x] The settled update refreshes both leader and Main Tank/Main Assist indicators.
- [x] The refresh flag clears after one update and does not create a permanent polling loop.
- [x] Cell does not replace or modify Blizzard's protected raid assignment menu.
- [x] SavedVariables and nested reference trees remain untouched.

## New v10 delta

- [x] Spotlight tank discovery does not require `UnitGroupRolesAssigned` on 1.14.2.
- [x] Shared group information records `NONE` when the assigned-role API is unavailable.
- [x] All three indicator position widgets display both four-part and five-part position tables with numeric offsets.
- [x] Opening a five-part position editor does not rewrite the saved position table.
- [x] All three preview glow paths capture and type-check `UpdateGlowOptions` before invocation.
- [x] SavedVariables and nested reference trees remain untouched.

## New v9 delta

- [x] Preview initialization calls `UpdateGlowOptions` only when implemented.
- [x] Preview live glow updates call `UpdateGlowOptions` only when implemented.
- [x] Preview indicator creation calls `UpdateGlowOptions` only when implemented.
- [x] External Cooldowns and other non-glow-capable 1.14.2 preview parents safely ignore imported glow metadata.
- [x] Existing live-frame glow guards remain present.
- [x] PixelPerfect and SavedVariables remain untouched.

## Carried-forward v8 delta

## New v8 delta

- [x] Indicators preview initialization accepts four-part and five-part positions.
- [x] Indicators preview live creation accepts four-part and five-part positions.
- [x] Preview `healthBar` anchors resolve to the preview health bar.
- [x] Preview `button` anchors resolve to the preview button.
- [x] Live unit-button indicator creation uses the shared schema-aware resolver.
- [x] No direct legacy four-part-only position application remains in these three paths.
- [x] `PixelPerfect:Point()` remains unchanged.
- [x] Account and character SavedVariables remain untouched.

## Carried-forward v7 delta

## New v7 delta

- [x] No `GLOBAL_MOUSE_UP` registration remains in packaged runtime source.
- [x] Raid Roster drop handling runs locally when roster-grid dragging stops.
- [x] Instant-mode drops still call `SwapRaidSubgroup` or `SetRaidSubgroup` as appropriate.
- [x] Premade-mode drops still call `PremadeSwap` or `PremadeSet` as appropriate.
- [x] Roster-grid movement no longer clears user-placed state immediately after `StartMoving()`.
- [x] The red and blue main handles explicitly enable mouse input.
- [x] The exposed options body explicitly enables mouse input.
- [x] No WTF or SavedVariables files were modified.

## Carried-forward v6 delta

- [x] The blue raid/setup handle is not hidden outside raids.
- [x] Both main-frame handles register for left-button dragging immediately.
- [x] The main-frame drag path honors Cell's lock setting and combat lockdown.
- [x] Main-frame movement no longer clears user-placed state immediately after `StartMoving()`.
- [x] The options body and every options tab are registered as drag surfaces.
- [x] Options movement no longer clears user-placed state immediately after `StartMoving()`.
- [x] Main-frame and options positions are still saved through the existing position tables.
- [x] The About/Supporters label calls `SetRotation` only when that method exists.
- [x] The 1.14.2 About fallback retains a readable vertical Supporters label.

## Carried-forward v5 delta

- [x] A shared resolver accepts original r241 four-part indicator positions.
- [x] The same resolver accepts newer five-part indicator positions.
- [x] Five-part `healthBar` positions retain their intended relative frame.
- [x] Five-part `button` positions resolve to the unit button.
- [x] Full layout initialization uses the shared resolver.
- [x] Live indicator-position updates use the shared resolver.
- [x] Account and character SavedVariables were not rewritten.

## Carried-forward v4 delta

- [x] Cumulative version history is included.
- [x] Recursive verification record is included.
- [x] Repeatable verification script is included.
- [x] Vanilla TOC version identifies the current backport.
- [x] Gameplay Lua and XML files are byte-identical to v3.

## Recursive regression verification

### v3 fixes

- [x] No `FIRST_FRAME_RENDERED` token remains in packaged runtime source (`.lua`, `.xml`, or `.toc`).
- [x] `Indicators/Supporter.lua` registers, handles, and unregisters `PLAYER_ENTERING_WORLD`.
- [x] The non-Retail secure click-casting snippet contains no `UnitHasVehicleUI` call.
- [x] The secure click-casting snippet uses the actual secure unit directly.

### v2 fixes

- [x] Vanilla `UpdateGlowOptions` calls remain capability-guarded.
- [x] Deferred indicator creation does not set `_indicatorsCreated` before required indicators are created.
- [x] `_indicatorsCreated` is committed only when all four required deferred indicators exist.
- [x] New Vanilla StatusText indicators receive fallback colors for `OFFLINE`, `AFK`, `FEIGN`, `DEAD`, `GHOST`, and `DRINKING`.
- [x] Sparse `showSolo`, `showParty`, and `showRaid` values are backfilled only when they are not booleans.
- [x] `CellUnitButtonTemplate` defaults `toggleForVehicle` to `false`.
- [x] No active `toggleForVehicle=true` assignment remains in packaged runtime source.
- [x] Vanilla Lua has no fake `UnitHasVehicleUI` function fallback.
- [x] Ordinary Vanilla `UnitHasVehicleUI` use remains availability-guarded.
- [x] SoloFrame visibility driver remains present.

### v1/baseline integrity

- [x] `Cell_Vanilla.toc` targets interface `11402`.
- [x] Every direct file referenced by `Cell_Vanilla.toc` exists.
- [x] All packaged XML files parse successfully.
- [x] All packaged Lua files pass syntax validation.
- [x] The archive opens and enumerates successfully.
- [x] The ZIP contains one top-level `Cell/` addon folder.

## Runtime verification pending in WoW Classic Era 1.14.2

Static/package verification cannot prove protected execution or live event behavior. Test v16 over the current modified/previously patched install without deleting SavedVariables first.

The client `WTF` folder and its account/character SavedVariables are preserved as the relevant runtime test state; this build does not modify or package them.

- [ ] Login/reload produces no `FIRST_FRAME_RENDERED` boot error.
- [ ] Login/reload produces no associated `(null)` BugGrabber burst.
- [ ] Clicking `CellSoloFrame` produces no restricted `UnitHasVehicleUI` error.
- [ ] SoloFrame remains visible at the saved account scale.
- [ ] Clicking the player frame still targets the player.
- [ ] Buff, debuff, cooldown, and StatusText indicators initialize and update.
- [ ] Existing valid `showSolo`, `showParty`, and `showRaid` preferences remain unchanged.
- [ ] Priest and Mage test cases retain their previously working behavior.
- [ ] Account scale `2` triggers no `PixelPerfect:Scale()` type error.
- [ ] The Mage profile's five-part positions retain their intended button/health-bar anchors.
- [ ] Existing four-part profiles retain their previous indicator positions.
- [ ] Both red and blue menu handles are visible while solo.
- [ ] Clicking the blue handle opens the Raid Roster/setup window while solo.
- [ ] Dragging either small handle moves the solo/main frame while unlocked and out of combat.
- [ ] Dragging the exposed options body or any options tab moves the options window.
- [ ] Main-frame and options-window positions persist after reload.
- [ ] The first About-tab open produces no `SetRotation` error and the Supporters label remains readable.
- [ ] Opening and closing the blue Raid Roster window produces no `GLOBAL_MOUSE_UP` errors.
- [ ] In a raid, dragging a populated roster slot onto another slot performs the intended instant/premade move without Lua errors.
- [ ] Mage: opening Indicators at scale `2` produces no PixelPerfect type error.
- [ ] Mage: selecting Default in the Indicators layout dropdown produces no PixelPerfect type error.
- [ ] Mage: imported `healthBar` and `button` relative anchors render correctly in the preview and live frame.
- [ ] Priest: original four-part positions remain unchanged and error-free.
- [ ] Mage: opening Indicators reaches External Cooldowns without an `UpdateGlowOptions` error.
- [ ] Mage: selecting Default reaches External Cooldowns without an `UpdateGlowOptions` error.
- [ ] Brainfever: opening the Indicators tab produces no Actions `SetRotation` error.
- [ ] Brainfever: Actions previews produce no `SetScaleFrom` errors.
- [ ] Brainfever: Name Text/Health Text color settings tolerate the existing sparse layout.
- [ ] Brainfever: Missing Buffs settings open without a nil `filters` error.
- [ ] Actions previews retain their alpha animation on 1.14.2.
- [ ] Capture the exact debuff and a screenshot if the opaque black raid-frame overlay recurs.

## Vehicle-removal investigation pending

- [x] Secure click-casting vehicle remapping is removed.
- [x] No active `toggleForVehicle=true` path remains.
- [ ] Trace XML inheritance from `CellUnitButtonTemplate` through every Vanilla-loaded secure unit button.
- [ ] Confirm in-client whether explicit `toggleForVehicle=false` suppressors are required to block 1.14.2 FrameXML fallback behavior.
- [ ] Inventory every remaining Vanilla vehicle reference before deleting any of them.
- [ ] Determine whether the guarded ordinary-Lua `UnitHasVehicleUI` branch can be removed without changing unit identity, pet buttons, targeting, or click casting.
- [ ] Do not claim complete vehicle-logic removal until remaining references are gone or documented as engine-required suppressors.

## Final package record

The exact ZIP SHA-256 is delivered beside the archive in a `.sha256` companion file. Measured file/XML counts and the verification transcript are delivered beside it as a build record.
