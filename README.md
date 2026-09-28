# Cell Raidframes Backport 1.15.0 - > 1.14.2 



// Backport of the beautiful [Cell Raidframes](https://www.curseforge.com/wow/addons/cell) addon made by [Enderneko](https://github.com/enderneko).


// An addon so nice, even [blizzard is charmed by the thing]

[<img width="400" height="500" alt="image" src="https://github.com/user-attachments/assets/d6338ee8-32be-4cce-83af-0db528215269" />](https://worldofwarcraft.blizzard.com/en-us/news/24244638#:~:text=Healing%20and%20Raid%20Frames)

[source: original artikal](https://worldofwarcraft.blizzard.com/en-us/news/24244638#:~:text=Healing%20and%20Raid%20Frames)


// Original v1.15.0 backported to v1.14.2 so you all privateers can enjoy nice raid frames too!

// made to work for the WoW-client v1.14.2 that runs with the [jimproxy](https://github.com/jameopotato/jimsproxy) -on the [KronosV](https://www.kronos-wow.com/) 1.12.1 server.


// Backport changelog


[Backport v17]

- Add a 1.14.2 compatibility fallback for `GetThreatStatusColor`, preventing Aggro Bar, Aggro Border, and Aggro Blink Lua errors when the API is unavailable.
- Restore missing indicator `num` values from Vanilla defaults, fixing the `SetValue(nil)` Lua error when opening Missing Buffs settings.
- Remove Earth Shield (spell ID 974) from the Vanilla Healers indicator and clean it from existing Healers icon configurations for the 1.12.1 target.
- Preserve all cumulative backport fixes and existing saved layouts/settings.

[Backport v16]

- Fix 1.14.2 Actions preview rotation and scale-animation compatibility.
- Restore missing indicator color/filter settings from Vanilla defaults.
- Preserve draggable options window, saved layouts, and all cumulative fixes.









/////////////////////////////////

Original work by [**enderneko**](https://github.com/enderneko)

////////////////////////////////





## Features

- __Layouts:__ auto switch layout by spec/role, supports party, raid, arena, and battleground.
- __Customizable Appearance:__ textures, colors and alphas.
- __Built-in Click-Castings:__ supports keyboard and multi-button mouse.
- __Indicators:__ dozens of built-in indicators and unlimited custom indicators (icon, bar, rect, text, icons).
- __Raid Debuffs:__ debuffs priority and glow.
- __Useful Raid Tools:__ ready check, countdown, rebuff, death report, marks, battleres.
- __Nice Options UI:__ I mean yes it's pretty darn good!
- __Spotlight Frame:__ extra 15 unit buttons, can be set to Target, Focus, Unit, Tank, etc.
- __Quick Assist:__ for Augmentation Evokers!
- __Compatibility:__ [BigDebuffs](https://www.curseforge.com/wow/addons/bigdebuffs), [Class Colors](https://www.curseforge.com/wow/addons/classcolors), [OmniCD](https://www.curseforge.com/wow/addons/omnicd) and of course, [WAs](https://wago.io/weakauras).

## Slash Commands

Use __/cell__ for more information.

&nbsp;

## Guides & Sharing

- [ULTIMATE Cell Raid Frames AddOn Setup GUIDE for HEALERS (Reat TV)](https://www.youtube.com/watch?v=ntXko7htO2I)
- [Healer UI & Addon Guide for Dragonflight Season 4 (yumytv)](https://www.youtube.com/watch?v=XcXvXxFipOE)
- [Addon Spotlight: How to set up Cell + OmniCD for Augmentation Evoker (JFunkGaming)](https://www.youtube.com/watch?v=PMvtgJv-808)
- [团队框架插件 Cell 配置流程分享 (钛锬)](https://bbs.nga.cn/read.php?tid=32921170)

&nbsp;

## Want to help improve Raid Debuffs?

Use [Instance Spell Collector](https://www.curseforge.com/wow/addons/instance-spell-collector) to collect debuffs. Then create a PR or submit a ticket on GitHub.
