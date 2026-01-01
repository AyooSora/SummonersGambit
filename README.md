<div align="center">

# ⚔️ Anime Card Clash ⚔️

### *A Roblox Anime Tower Defense Card Battler*

[![Roblox Profile](https://img.shields.io/badge/Roblox-AyooSora-00a2ff?style=for-the-badge&logo=roblox)](https://www.roblox.com/users/99067322/profile)
[![Lua](https://img.shields.io/badge/Lua-5.1-2C2D72?style=for-the-badge&logo=lua)](https://www.lua.org/)
[![Status](https://img.shields.io/badge/Status-In%20Development-yellow?style=for-the-badge)](https://github.com/AyooSora/AnimeCardClash)

*Collect powerful anime-inspired cards, build strategic decks, and battle your way to victory!*

**Developer:** AyooSora

[Features](#-features) • [Frameworks](#-frameworks-used) • [Gameplay](#-gameplay) • [Tech Stack](#-tech-stack) • [Roadmap](#-roadmap)

</div>

---

## 📖 About

**Anime Card Clash** is a tower defense-style card battler where players summon anime-inspired units, build powerful decks, and engage in strategic turn-based combat. Each card has unique stats, traits, and abilities that can be upgraded through gameplay.

Inspired by popular anime gacha games and tower defense mechanics, this game features:
- **Dynamic stat system** with F-SSS rankings
- **Potential-based progression** - your favorite units get stronger the more you use them
- **Gacha summon system** with pity mechanics
- **17+ unique unit traits** (Flying, First Blood, Executioner, etc.)
- **Shiny variants** for rare cosmetic collectibles

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

### Card Collection
Summon cards through the gacha system and build your collection. Each card pulled has:
- Randomly rolled stat rankings (F-SSS)
- Randomly assigned combat trait
- Chance to be a shiny variant

### Deck Building *(Coming Soon)*
- Build decks of 40-60 cards
- Strategic element combinations
- Balance offensive and defensive units

### Card Battles *(Coming Soon)*
- Turn-based combat system
- Deploy units to defend against waves
- Use abilities and traits strategically
- Evolve units through battle experience

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
