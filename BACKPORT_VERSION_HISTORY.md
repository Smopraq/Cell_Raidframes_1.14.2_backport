# Cell 1.14.2 Backport Version History


This is the cumulative history for the modified/previously patched Cell r241 tree used on WoW Classic Era 1.14.2. Every entry is carried forward unless a later entry explicitly supersedes it.


## v13 - Bugfix

- fixed issue with UnitButton_UpdateThreat() going haywire.

## v12 — Master Looter assignment icon

- Extended the existing Party Assignment indicator to show a dedicated Cell Master Looter icon when no higher-priority Main Tank/Main Assist icon applies.
- Added `Media/Icons/master-looter.tga`, normalized to a transparent 32x32 32-bit TGA for reliable 1.14.2 rendering.
- Resolves both raid and party Master Looter unit indices returned by `GetLootMethod()`.
- Registered `PARTY_LOOT_METHOD_CHANGED` on Vanilla unit buttons for immediate icon refresh.
- Reused the existing configured assignment-icon position and size, requiring no SavedVariables migration.
- Preserved every v1-v11 fix, Blizzard's protected raid menu, and both nested reference trees.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v12`.

## v11 — Vanilla raid-metadata icon refresh

- Confirmed clean v10 Mage and Priest tests through five-player groups, raid transitions, Indicators/Default, and Raid Helper drag operations.
- Added a one-tick deferred refresh for leader and Main Tank/Main Assist indicators after `GROUP_ROSTER_UPDATE` when unit GUIDs remain unchanged.
- Preserved Blizzard's Raid menu as the 1.14.2 assignment interface; Cell's generic unit popup is not replaced or tainted.
- Left gameplay targeting, click casting, PixelPerfect, SavedVariables, and nested references unchanged.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v11`.

## v10 — five-player role and indicator-editor compatibility

- Added a 1.14.2 fallback for the unavailable `UnitGroupRolesAssigned` API in Spotlight tank discovery and shared group information; Vanilla leaves roles unassigned and preserves manual Spotlight assignment.
- Completed v8's four/five-part position support in all three indicator position-setting widgets, preventing anchor names such as `CENTER` from reaching numeric sliders.
- Kept five-part saved positions untouched when merely opening the settings page.
- Strengthened all three preview glow guards by capturing and type-checking the method before calling it.
- Preserved the nested r241 and r207 reference trees and all SavedVariables.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v10`.

## v9 — Indicators-preview glow capability guards

- Confirmed v8 eliminated the repeated Mage PixelPerfect failures in both Indicators triggers.
- Guarded preview initialization when layout data contains `glowOptions` but the 1.14.2 indicator widget has no `UpdateGlowOptions` method.
- Applied the same capability guard to preview live updates and newly created preview indicators.
- Preserved cooldown preview refresh behavior when glow updates are unsupported.
- Left live-frame guards, PixelPerfect, gameplay code, and all SavedVariables unchanged.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v9`.

## v8 — complete five-part indicator-position coverage

- Confirmed a clean v7 Mage-only reproduction: opening Indicators or selecting Default failed, while the Priest profile did not.
- Traced the difference to the Mage's valid imported five-part positions; the Priest retains original four-part r241 positions.
- Added schema-aware positioning to both Indicators preview paths, including `healthBar` and `button` relative-frame resolution.
- Routed the overlooked live indicator-creation path through the existing Vanilla four/five-part resolver.
- Kept `PixelPerfect:Point()` unchanged so malformed callers are fixed at their semantic source rather than silently masked globally.
- Left all account and character SavedVariables untouched.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v8`.

## v7 — 1.14.2 raid-roster mouse compatibility

- Removed the unsupported `GLOBAL_MOUSE_UP` registration from every Raid Roster grid slot.
- Replaced global mouse-up delivery with a local drop-target scan when a roster drag stops, preserving instant and premade subgroup movement.
- Removed the 1.14.2-incompatible `SetUserPlaced(false)` sequence from roster-grid dragging.
- Explicitly enabled mouse input on the two main handles and the exposed options body.
- Confirmed in-client that the v6 main frame is movable by dragging either small handle; the secure unit frame itself remains reserved for targeting and click casting.
- Identified the reported PixelPerfect and About entries as retained pre-v6 BugSack records by timestamp and compiled line mapping; no SavedVariables were edited.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v7`.

## v6 — 1.14.2 menu access, movement, and About compatibility

- Kept the blue raid/setup handle visible while solo and in parties so the Raid Roster configuration is accessible before joining a raid.
- Registered both small main-frame handles for dragging immediately instead of relying only on a later menu callback.
- Removed the post-`StartMoving()` `SetUserPlaced(false)` calls that can cancel movement on the 1.14.2 client.
- Preserved the Cell lock setting and added explicit combat guards to the main-frame drag path.
- Made exposed options-window body space draggable in addition to every options tab, while retaining position snapping and SavedVariables persistence.
- Added a 1.14.2 fallback for the About/Supporters label because 1.14.2 FontStrings do not implement `SetRotation`.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v6`.

## v5 — dual indicator-position schema compatibility

- Added a shared Vanilla position resolver that accepts both r241 four-part positions (`point`, `relativePoint`, `x`, `y`) and newer five-part positions (`point`, `relativeTo`, `relativePoint`, `x`, `y`).
- Preserved newer `healthBar` anchoring and mapped `button` anchoring to the unit button, matching current upstream behavior.
- Applied the resolver during full layout initialization and live indicator-position updates.
- Prevented anchor strings such as `CENTER` from reaching `PixelPerfect:Scale()` as numeric offsets.
- Left all account and character SavedVariables untouched; the compatibility is handled in code.
- Changed Vanilla TOC version metadata to `r241-beta-backport-v5`.

## v4 — cumulative records and repeatable verification

- Added this cumulative version history.
- Added `BACKPORT_VERIFICATION.md`, separating static/package checks from in-client runtime checks.
- Added `Tools/Verify-Backport.ps1`, which rechecks the full compatibility chain on every future build.
- Changed only Vanilla TOC version metadata to `r241-beta-backport-v4`.
- No gameplay Lua, XML behavior, bindings, layouts, frame dimensions, or SavedVariables behavior changed from v3.

## v3 — boot event and secure click vehicle path

- Replaced the unsupported `FIRST_FRAME_RENDERED` event in `Indicators/Supporter.lua` with `PLAYER_ENTERING_WORLD`.
- Removed vehicle remapping from the non-Retail secure click-casting `_onenter` snippet. It uses the secure button's actual unit directly (`clickCastingUnit = unit`) and does not call `UnitHasVehicleUI`.
- Preserved the working click bindings, indicator initialization, frame sizes, and SavedVariables handling from v2.

## v2 — initialization, sparse data, and Vanilla vehicle compatibility

- Restored the correct SoloFrame visibility driver.
- Guarded all Vanilla `UpdateGlowOptions` calls by checking that the indicator implements the method.
- Made deferred indicator creation retry-safe: `_indicatorsCreated` is committed only after defensive cooldowns, external cooldowns, all cooldowns, and debuffs all exist.
- Added native Vanilla fallback colors to newly created StatusText indicators so old or sparse layouts cannot reach `SetStatus` with missing colors.
- Backfilled missing `CellDB.general.showSolo`, `showParty`, and `showRaid` values without overwriting existing boolean settings.
- Set the Vanilla unit-button template vehicle-toggle default to `false` and retained explicit false values on pet/header/solo/spotlight/NPC paths that must not enter unsupported vehicle remapping.
- Removed the fake `UnitHasVehicleUI` fallback. Ordinary Vanilla Lua treats the real API as optional and guards its use.
- Kept the Vanilla TOC at interface `11402`.

## v1 — modified-tree compatibility baseline

- Established the 1.14.2 package from the existing modified/previously patched Cell tree rather than resetting to clean upstream r241.
- Preserved the earlier working Vanilla backport changes already present in that tree, including the frame/click compatibility work that made the SoloFrame visible and functional during testing.
- Established that later builds preserve working click behavior, indicator setup, frame sizing, and user SavedVariables unless a specific regression requires changing them.

## Release rule for v9 and later

1. Add the new delta to this file.
2. Carry forward every applicable earlier item.
3. Run `Tools/Verify-Backport.ps1` against the staged `Cell` folder.
4. Record all static and archive results in `BACKPORT_VERIFICATION.md`.
5. Leave runtime-only checks pending until tested inside WoW Classic Era 1.14.2.

## Vehicle-removal status

v4 preserves v3's transitional compatibility state; it does **not** claim that all vehicle-related code has been removed. Secure click-casting vehicle remapping is gone, but ordinary Vanilla Lua still contains an availability-guarded `UnitHasVehicleUI` path, and several secure buttons explicitly set `toggleForVehicle=false` to suppress Blizzard's vehicle behavior.

The intended end state for the 1.14.2/1.12.1 gameplay target is no vehicle gameplay logic. The recurring errors came through XML/secure-template inheritance, so the next gameplay investigation must trace `CellUnitButtonTemplate` and every inherited secure button before deleting suppressive false attributes. Complete removal is safe only if the inherited 1.14.2 templates do not fall back into vehicle-aware unit resolution.
