[Backport v17]

- Add a 1.14.2 compatibility fallback for `GetThreatStatusColor`, preventing Aggro Bar, Aggro Border, and Aggro Blink Lua errors when the API is unavailable.
- Restore missing indicator `num` values from Vanilla defaults, fixing the `SetValue(nil)` Lua error when opening Missing Buffs settings.
- Remove Earth Shield (spell ID 974) from the Vanilla Healers indicator and clean it from existing Healers icon configurations for the 1.12.1 target.
- Preserve all cumulative backport fixes and existing saved layouts/settings.

[Backport v16]

- Fix 1.14.2 Actions preview rotation and scale-animation compatibility.
- Restore missing indicator color/filter settings from Vanilla defaults.
- Preserve draggable options window, saved layouts, and all cumulative fixes.

[Full Changelog](https://github.com/enderneko/Cell/compare/r240-release...09f80589eeca3cbc0830ab3cfaa8a3856d7d49f3)

- Implement nickname blacklist
- Fix Cell.GetUnitFramesForLGF
- Fix powerMax
- Fix GROUP_ROSTER_UPDATE
- Change GradientColors to ColorThresholds
- Update raid debuffs
- Update targeted spells
- Add esES (Thanks Zurent!)
- Update locales
