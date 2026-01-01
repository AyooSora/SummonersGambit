<div align="center">

# ⚔️ Summoner's Gambit ⚔️

### *A Roblox Strategic Card Battler*

[![Roblox Profile](https://img.shields.io/badge/Roblox-AyooSora-00a2ff?style=for-the-badge&logo=roblox)](https://www.roblox.com/users/99067322/profile)
[![Lua](https://img.shields.io/badge/Lua-5.1-2C2D72?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow?style=for-the-badge)](https://github.com/AyooSora/SummonersGambit)

*Every card is a move. Every move is destiny.*

**Developer:** AyooSora

[Features](#-features) • [Frameworks](#-frameworks-used) • [Gameplay](#-gameplay) • [Tech Stack](#-tech-stack) • [Roadmap](#-roadmap)

</div>

---

## 📖 About

**Summoner's Gambit** is a strategic card battler where players summon powerful anime-inspired units and engage in tactical turn-based combat. Inspired by Magic: The Gathering's deep strategy and anime gacha games' progression systems, every battle requires careful planning and tactical decision-making.

This isn't just about collecting cards—it's about mastering the art of strategy:
- **MTG-Inspired Tactics** - Strategic card play with instant responses and combat tricks
- **Dynamic Stat System** - F-SSS rankings create unique card instances
- **Potential-Based Progression** - Your favorite units grow stronger through use
- **Gacha Collection** - Summon legendary units with pity mechanics
- **17+ Combat Traits** - Flying, First Blood, Executioner, and more
- **Shiny Variants** - Rare cosmetic collectibles

> **Note:** This repository is primarily used for version control and progress tracking. The game is currently in active development.

---

## 🔧 Frameworks Used

This project wouldn't be possible without these amazing open-source frameworks created by talented Roblox developers:

### **[ProfileStore](https://github.com/MadStudioRoblox/ProfileStore)** by loleris (MAD STUDIO)
<img src="https://img.shields.io/badge/ProfileStore-v1.0.1-blue?style=flat-square" alt="ProfileStore">

ProfileStore is a robust data persistence solution that handles all player data saving/loading with session locking, auto-save functionality, and GDPR compliance. It ensures that player progress is never lost and handles edge cases like server crashes gracefully.

**Why I use it:**
- ✅ Automatic session locking prevents data loss
- ✅ Built-in auto-save every 5 minutes
- ✅ Handles server shutdowns gracefully
- ✅ Profile reconciliation for missing data
- ✅ Battle-tested in production games

**Links:**
- 📦 [GitHub Repository](https://github.com/MadStudioRoblox/ProfileStore)
- 🛒 [Roblox Creator Store](https://create.roblox.com/store/asset/109379033046155/ProfileStore)
- 📖 [Documentation](https://madstudioroblox.github.io/ProfileStore/)

---

### **[Chance](https://devforum.roblox.com/t/2806263)** by avodey (avocado)
<img src="https://img.shields.io/badge/Chance-v1.0.1-green?style=flat-square" alt="Chance">

Chance is a lightweight weighted random number generation framework with built-in luck modifiers. It powers our entire stat rolling system, trait selection, and gacha mechanics.

**Why I use it:**
- ✅ Clean API for weighted randomness
- ✅ Luck modifier support (0-10 scale)
- ✅ Perfect for gacha and loot systems
- ✅ No dependencies
- ✅ Extremely lightweight

**Links:**
- 💬 [DevForum Post](https://devforum.roblox.com/t/chance-easy-random-items-luck-modifiers/2806263)
- 📖 [Documentation](https://devforum.roblox.com/t/2806263)

---

**Huge thanks to these developers for making their work open-source!** 🙏

---

## ✨ Features

### 🎴 Card System
- **6 Rarity Tiers**: Common → Rare → Epic → Legendary → Mythic → Divine
- **Stat Rankings**: F, E, D, C, B, A, S, SS, SSS (with multipliers 0.5x - 3.0x)
- **5 Card Types**: Creature, Instant, Sorcery, Enchantment, Artifact
- **8 Elements**: Fire 🔥, Water 💧, Earth 🌿, Lightning ⚡, Wind 🌪️, Dark 🌑, Light ✨, Neutral ⚪
- **Shiny Variants**: 5% chance for cosmetic shiny versions

### ⚔️ Combat Stats
Each card has dynamic stats influenced by their stat ranking:
- **Damage** - Attack power per hit
- **Health** - Total HP before death
- **Defense** - % damage reduction
- **Critical Chance** - % chance to land critical hits
- **Critical Multiplier** - Bonus damage on crits (2x-3x)
- **Speed** - Attacks per turn
- **Range** - Number of enemies hit

### 🎯 Unit Traits
17+ unique combat traits including:
- **Flying** ⚡ - Can only be targeted by Long Reach units
- **First Blood** 🗡️ - Strikes before enemy counter-attacks
- **Executioner** ⚔️ - Instantly destroys any unit damaged
- **Soul Link** 💝 - Heals for 50% of damage dealt
- **Guardian** 🛡️ - High defense tank units
- **Haste** 💨 - Can attack immediately when played
- **Executioner** 💀 - Instant kill on damage
- **True Strike** ✨ - Ignores all defense
- **Divine Shield** 🛡️ - Immune to first damage source
- And many more...

### 🎲 Gacha & Progression
- **Summon System**: Single pulls (100 Yen) or Multi-pulls (900 Yen)
- **Pity System**: 
  - Guaranteed Mythic every 75 pulls
  - Guaranteed Divine every 150 pulls
- **Potential System**: Units gain potential (0-100) through use, increasing chances for better stat rolls on future summons
- **Currency**: Earn Yen (free) and Gems (premium) through gameplay

### 💾 Data Persistence
- **ProfileStore Integration**: Reliable data saving with session locking
- **Auto-Save**: Profiles save every 5 minutes automatically
- **Data Reconciliation**: Missing data auto-fills from template
- **GDPR Compliant**: User ID tracking for data rights

---

## 🎮 Gameplay

### Strategic Card Battles
Summoner's Gambit emphasizes **tactical decision-making** over automation:
- **Turn-Based Strategy** - Think ahead, plan your moves
- **Resource Management** - Energy costs and timing matter
- **Combat Tricks** - Instant spells can turn the tide
- **Trait Synergies** - Combine abilities for devastating combos
- **Counter-Play** - React to your opponent's strategy

### Card Collection
Summon cards through the gacha system and build your collection. Each card pulled has:
- Randomly rolled stat rankings (F-SSS)
- Randomly assigned combat trait
- Chance to be a shiny variant
- Unique instance ID for tracking

### Deck Building *(Coming Soon)*
- Build decks of 40-60 cards
- Strategic element combinations
- Balance offensive and defensive units
- Counter-meta deck strategies
- Side deck for adaptability

### Strategic Combat *(Coming Soon)*
- **Turn Structure**: Draw → Main Phase → Combat → End Phase
- **Instant Speed Responses**: React to opponent actions
- **Combat Stack**: MTG-inspired priority system
- **Trait Interactions**: Flying vs. Long Reach, First Blood mechanics
- **Win Conditions**: Reduce opponent HP to zero or deck them out

---

## 🛠️ Tech Stack

### Core Technologies
- **Roblox Studio** - Game engine
- **Lua 5.1** - Primary scripting language
- **ProfileStore** - Data persistence ([loleris/ProfileStore](https://github.com/MadStudioRoblox/ProfileStore))
- **Chance** - Weighted RNG with luck modifiers ([avodey/Chance](https://devforum.roblox.com/t/2806263))

### Custom Systems
- **StatsModule** - Dynamic stat calculation system
- **CardModule** - Card generation and instance management
- **DataManager** - ProfileStore wrapper with auto-save
- **Config** - Centralized game constants

### Architecture
```
Client (LocalScripts)
    ↓
RemoteEvents
    ↓
Server (ModuleScripts)
    ├── CardModule (Card logic & generation)
    ├── DataManager (ProfileStore wrapper)
    ├── StatsModule (Stat calculations)
    └── BattleModule (Combat system - Coming Soon)
```

---

## 📊 Current Progress

### ✅ Completed Features
- [x] ProfileStore data persistence
- [x] Currency system (Yen/Gems)
- [x] Gacha summon system (Single/Multi)
- [x] Pity mechanics (Mythic/Divine)
- [x] Card stat generation (F-SSS rankings)
- [x] Trait system (17 unique traits)
- [x] Shiny system (5% rate)
- [x] Potential-based luck system
- [x] Card instance management
- [x] Inventory tracking
- [x] Stat multiplier calculations

### 🚧 In Development
- [ ] Card artwork and UI design
- [ ] Inventory display interface
- [ ] Deck builder system
- [ ] Battle system (MTG-inspired mechanics)
- [ ] Trait ability implementation
- [ ] Combat stack and priority system

### 📅 Planned Features
- [ ] Strategic PvP battles
- [ ] Ranked ladder system
- [ ] Daily quests and rewards
- [ ] Achievement system
- [ ] Trading system
- [ ] Draft mode (limited format)
- [ ] Seasonal events
- [ ] Tournament system

---

## 🎨 Card Template Example
```lua
{
  name = "Crimson Dragon Knight",
  cardId = 301,
  cardType = "Creature",
  element = "Fire",
  rarity = "Legendary",
  stars = 4,
  cost = 6,
  
  -- Base Stats
  baseDamage = 200,
  baseCriticalChance = 25,
  criticalMultiplier = 2.5,
  baseHealth = 1000,
  baseDefense = 20,
  
  -- Rolled Stats (example with S-rank)
  damageStat = "S",    -- 200 * 2.0 = 400 damage
  healthStat = "A",    -- 1000 * 1.5 = 1500 HP
  defenseStat = "B",   -- 20 * 1.2 = 24% reduction
  criticalStat = "SS", -- 25 * 2.5 = 62.5% crit chance
  
  trait = "Flying",    -- Can only be hit by Long Reach
  shiny = false,
  potential = 0,
  instanceId = "5a3b9c7d-1e4f-8a2b-9d6c-4e7f8a9b0c1d"
}
```

---

## 🗺️ Roadmap

### Phase 1: Foundation ✅ (Complete)
- Core card system
- Data persistence
- Gacha mechanics
- Stat system

### Phase 2: Visual Polish 🎨 (Current)
- Card artwork creation
- UI/UX design
- Animation system
- Card display frames

### Phase 3: Battle System ⚔️
- Turn-based combat engine
- MTG-inspired stack system
- Trait ability implementation
- Combat animations

### Phase 4: Competitive Play 📈
- Ranked ladder
- Deck archetypes
- Meta balancing
- Tournament system

### Phase 5: Community Features 🌐
- Trading system
- Guilds/Clans
- Draft mode
- Social features

---

## 🎯 Design Philosophy

### Strategic Depth Over Automation
Unlike automated card battlers, Summoner's Gambit requires:
- **Active Decision Making** - Every turn matters
- **Resource Management** - Energy and card advantage
- **Risk vs. Reward** - High-cost cards vs. tempo
- **Adaptation** - React to opponent strategies
- **Skill Expression** - Better players win more

### Inspired by Magic: The Gathering
- **Instant Speed** - Respond during opponent's turn
- **Combat Tricks** - Surprise defensive plays
- **Card Types** - Creatures, Instants, Sorceries, etc.
- **Stack System** - Priority and spell resolution
- **Deck Building** - Synergy and consistency

---

## 🙏 Credits & Acknowledgments

### Frameworks & Modules
- **[ProfileStore](https://github.com/MadStudioRoblox/ProfileStore)** by loleris - Data persistence
- **[Chance](https://devforum.roblox.com/t/2806263)** by avodey - Weighted RNG system

### Inspiration
- **Magic: The Gathering** - Strategic card game mechanics
- **Hearthstone** - Digital card game UI/UX
- **Anime Gacha Games** - Progression and collection systems
- **Roblox Card Games** - Community and platform integration

### Learning Resources
- [Roblox Tower Defense Tutorial](https://www.youtube.com/playlist?list=PL056rW52NIt1F6pKCDT7-8htms-hidrhU)
- Roblox Developer Hub
- MTG Rules & Game Design

---

## 📞 Contact

**Developer:** AyooSora

**Roblox Profile:** [AyooSora](https://www.roblox.com/users/99067322/profile)

**Project Repository:** [https://github.com/AyooSora/SummonersGambit](https://github.com/AyooSora/SummonersGambit)

**Roblox Game:** *(Coming Soon)*

---

<div align="center">

### ⭐ This is a personal project tracking repository ⭐

*Every card is a move. Every move is destiny.*

Built with ❤️ using Roblox Studio

**Special thanks to loleris and avodey for their amazing frameworks!**

</div>
