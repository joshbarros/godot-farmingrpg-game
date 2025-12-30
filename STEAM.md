# Steam Commercial Release Guide

This document outlines the requirements and steps for releasing Farming RPG as a commercial game on Steam.

## Pre-Launch Requirements

### 1. Legal & Business Setup
- [ ] Register business entity (LLC, Corporation, etc.)
- [ ] Obtain tax ID/EIN number
- [ ] Trademark your game title if unique
- [ ] Copyright your game assets and code
- [ ] Prepare privacy policy and EULA

### 2. Steam Direct Requirements
- [ ] Pay $100 USD Steam Direct fee per application
- [ ] Prepare marketing materials (screenshots, trailers, logos)
- [ ] Create compelling store page description
- [ ] Obtain any necessary music/sound licenses
- [ ] Ensure compliance with platform requirements

### 3. Technical Requirements
- [ ] Implement Steamworks SDK integration (GodotSteam plugin)
- [ ] Add achievements system with meaningful unlocks
- [ ] Implement cloud saves for cross-device progress
- [ ] Performance optimization for minimum specs
- [ ] Proper initialization with error handling
- [ ] Offline mode support for graceful degradation

---

## Marketing & Promotion

### 1. Pre-Launch Marketing
- [ ] Build community on Discord/Social media
- [ ] Create trailer and gameplay videos
- [ ] Submit to gaming websites for coverage
- [ ] Consider Early Access program
- [ ] Influencer outreach program
- [ ] Wishlist campaign (target: 10,000+)

### 2. Store Page Optimization
- [ ] High-quality screenshots (8+ recommended)
- [ ] Gameplay trailer (60-90 seconds)
- [ ] Detailed game description
- [ ] System requirements clearly listed
- [ ] Tags and categories properly set
- [ ] Compelling capsule images (all sizes)

### Store Page Description Template

```
🌱 Welcome to [Game Name]!

Inherit your grandfather's abandoned farm and transform it into a thriving paradise.
But this isn't just about farming—uncover the mysteries of the valley, befriend quirky
villagers, and maybe find love along the way.

✨ FEATURES:

🌾 FARM YOUR WAY
• Plant, water, and harvest 40+ crops across all seasons
• Raise adorable animals: chickens, cows, sheep, and more
• Automate your farm with sprinklers and upgrades

👥 BEFRIEND THE VILLAGERS
• Meet 12 unique characters with their own stories
• Build friendships through gifts and conversations
• Romance and marry your favorite villager

🎣 EXPLORE & DISCOVER
• Fish in the river, lake, and ocean (30+ fish species)
• Mine for ores and gems in the mysterious caves
• Forage for seasonal treasures in the forest

🏠 BUILD YOUR DREAM LIFE
• Upgrade and decorate your farmhouse
• Craft 60+ items from gathered resources
• Complete the Community Center to restore the town

🎮 KEY FEATURES:
• Relaxing gameplay with no pressure
• Day/night cycle and changing seasons
• Cozy pixel art visuals
• Original soundtrack
• 30+ hours of content

Perfect for fans of Stardew Valley and Animal Crossing!
```

---

## Monetization Strategy

### Pricing Model Options
| Model | Price Range | Notes |
|-------|-------------|-------|
| **Early Access** | $14.99 | Build community while developing |
| **Full Release** | $19.99-$24.99 | Complete experience |
| **Deluxe Edition** | $29.99 | Base + soundtrack + artbook |
| **Launch Discount** | 10-15% off | First week incentive |

### Revenue Streams
- Base game sales
- DLC content packs (new areas, crops, villagers)
- Soundtrack bundle
- Digital artbook
- Seasonal content updates

### Revenue Projections (at $19.99)

| Scenario | Copies | Gross | Net (after Steam 30%) |
|----------|--------|-------|----------------------|
| Conservative | 2,000 | $39,980 | $27,986 |
| Realistic | 10,000 | $199,900 | $139,930 |
| Optimistic | 50,000 | $999,500 | $699,650 |
| Dream | 100,000+ | $1,999,000+ | $1,399,300+ |

*Note: Additional costs include taxes (15-35%), marketing, and operational expenses.*

---

## Post-Launch Support

### 1. Community Management
- [ ] Dedicated support email
- [ ] Active Discord community
- [ ] Regular updates based on feedback
- [ ] Bug fix priorities
- [ ] Feature request tracking

### 2. Content Updates
- [ ] Scheduled content drops (quarterly)
- [ ] Seasonal events (holidays, festivals)
- [ ] New crops, fish, items
- [ ] New villagers and romance options
- [ ] Quality of life improvements
- [ ] Free major updates (Year 2 content, etc.)

---

## Success Metrics

### Key Performance Indicators
- Steam reviews and ratings (target: 90%+ positive)
- Daily/Monthly active users
- Average playtime per session (target: 2+ hours)
- Revenue per user
- Community engagement rates
- Wishlist conversion rate

### Milestone Targets
| Timeline | Target |
|----------|--------|
| Pre-launch | 10,000+ wishlists |
| Week 1 | 2,000 copies sold |
| Month 1 | 5,000 copies sold |
| Month 3 | 15,000 copies sold |
| Month 6 | 30,000 copies sold |
| Year 1 | 50,000+ copies sold |

---

## Budget Planning

### Estimated Costs
| Category | Cost |
|----------|------|
| Steam Direct fee | $100 |
| Marketing budget | $2,000-$10,000 |
| Music licensing/commission | $500-$2,000 |
| Art assets/commission | $500-$3,000 |
| Steam revenue share | 30% of sales |
| Taxes | 15-35% of profit |

### Minimum Viable Budget
- **Lean launch:** $500-$1,000 (DIY marketing, AI assets)
- **Standard launch:** $5,000-$10,000 (some paid marketing)
- **Professional launch:** $15,000-$25,000 (PR, influencers, ads)

---

## GodotSteam Implementation Guide

### Prerequisites
- ✅ Core gameplay feature-complete
- ✅ Meaningful stats to track (days played, crops harvested, friendships)
- ✅ Achievements worth unlocking
- ✅ $100 USD for Steam Direct fee ready
- ✅ Business entity setup (LLC recommended)

### Installation Steps

1. **Download GodotSteam:**
   - Visit: https://godotsteam.com/
   - **Latest Version:** Compatible with Godot 4.5
   - **Repository:** https://codeberg.org/godotsteam/godotsteam
   - Download the GDExtension version for plug-and-play usage
   - Extract to `addons/godotsteam/` in your project folder

2. **Steamworks SDK Files:**
   - Download Steamworks SDK from https://partner.steamgames.com/
   - Copy `steam_api64.dll` (Windows) to `addons/godotsteam/win64/`
   - Copy `libsteam_api.so` (Linux) to `addons/godotsteam/linux64/`
   - Copy `libsteam_api.dylib` (Mac) to `addons/godotsteam/osx/`

3. **Configure Steam App ID:**

   **Method 1 - Project Settings (Recommended for Godot 4.x):**
   - Go to Project > Project Settings > Steam > Initialization
   - Set "App ID" field
   - Enable "Auto-initialize" if desired

   **Method 2 - steam_appid.txt (Testing Method):**
   - Create `steam_appid.txt` in project root
   - Add your Steam App ID: `480` (use 480 for testing, your real ID later)
   - Valve recommends NOT shipping this file with your game

4. **Enable Logging (Recommended):**
   - Project > Project Settings > Logging > File Logging
   - Check "Enable File Logging"
   - Helps debug Steam initialization issues

5. **Test Without Real App ID:**
   - Use App ID `480` (Valve's SpaceWar example game) for development
   - Switch to your real App ID before release

---

## Steam Controller Implementation

Create `steam_controller.gd` as a singleton/autoload to handle all Steam integration:

```gdscript
extends Node

var achievements : Dictionary = {
    # Farming Achievements
    "ACH_FIRST_HARVEST": false,
    "ACH_HARVEST_100": false,
    "ACH_HARVEST_1000": false,
    "ACH_ALL_CROPS": false,

    # Fishing Achievements
    "ACH_FIRST_FISH": false,
    "ACH_CATCH_50": false,
    "ACH_LEGENDARY_FISH": false,

    # Mining Achievements
    "ACH_REACH_FLOOR_50": false,
    "ACH_REACH_FLOOR_100": false,
    "ACH_FIND_DIAMOND": false,

    # Social Achievements
    "ACH_FIRST_FRIEND": false,
    "ACH_MAX_FRIENDSHIP": false,
    "ACH_GET_MARRIED": false,
    "ACH_HAVE_CHILD": false,

    # Progression Achievements
    "ACH_YEAR_1_COMPLETE": false,
    "ACH_YEAR_2_COMPLETE": false,
    "ACH_COMMUNITY_CENTER": false,
    "ACH_MILLIONAIRE": false,

    # Secret Achievements
    "ACH_SECRET_1": false,
    "ACH_SECRET_2": false,
}

var stats : Dictionary = {
    "TotalCropsHarvested": 0,
    "TotalFishCaught": 0,
    "TotalMineralsFound": 0,
    "TotalMoneyEarned": 0,
    "TotalDaysPlayed": 0,
    "TotalGiftsGiven": 0,
    "TotalTimePlayed": 0,
}

func _init():
    # Initialize and connect to Steam
    var response: Dictionary = Steam.steamInitEx(true, 480)  # Use 480 for testing
    print("Steam Init Response: ", response)

    # Check initialization status
    if response['status'] > Steam.STEAM_API_INIT_RESULT_OK:
        push_error("Failed to initialize Steam: %s" % response['verbal'])
        return

    print("Steam initialized successfully!")

    # Fetch Steam user info
    var username: String = Steam.getPersonaName()
    var steam_id: int = Steam.getSteamID()
    var is_online: bool = Steam.loggedOn()

    # Load achievements and stats
    _load_achievements()
    _load_stats()

func _process(_delta):
    # CRITICAL: Must call Steam.run_callbacks() every frame
    # Alternative: Enable "Embed Callbacks" in Project Settings
    Steam.run_callbacks()

# Load Steam achievements locally
func _load_achievements():
    for a in achievements.keys():
        var steam_ach: Dictionary = Steam.getAchievement(a)

        if not steam_ach["ret"]:
            push_warning("Achievement not found in Steam: %s" % a)
            continue

        achievements[a] = steam_ach["achieved"]

# Unlock the given achievement
func set_achievement(achievement: String):
    if not achievements.has(achievement):
        push_error("Achievement not defined locally: %s" % achievement)
        return

    achievements[achievement] = true

    if not Steam.setAchievement(achievement):
        push_error("Failed to set achievement: " + achievement)
        return

    print("Achievement unlocked: ", achievement)

    if not Steam.storeStats():
        print("Failed to store data on Steam.")

# Load Steam stats locally
func _load_stats():
    for stat in stats.keys():
        var steam_stat: int = Steam.getStatInt(stat)
        stats[stat] = steam_stat
        print("Loaded stat %s: %s" % [stat, steam_stat])

# Update the value of a stat, saving it to Steam
func set_stat(stat_name: String, value: int):
    if not stats.has(stat_name):
        push_error("Stat not defined locally: %s" % stat_name)
        return

    stats[stat_name] = value

    if not Steam.setStatInt(stat_name, value):
        push_error("Failed to set stat: %s" % stat_name)
        return

    print("Stat updated: %s = %s" % [stat_name, value])

    if not Steam.storeStats():
        push_error("Failed to store data on Steam.")
        return

    print("Stats stored successfully")

# Increment a stat by a value
func increment_stat(stat_name: String, amount: int = 1):
    if stats.has(stat_name):
        set_stat(stat_name, stats[stat_name] + amount)
```

---

## Farming RPG Achievement Ideas (30+ Achievements)

### Farming Achievements (10)
| ID | Name | Description | Type |
|----|------|-------------|------|
| ACH_FIRST_HARVEST | First Harvest | Harvest your first crop | Easy |
| ACH_HARVEST_100 | Green Thumb | Harvest 100 crops | Medium |
| ACH_HARVEST_1000 | Master Farmer | Harvest 1,000 crops | Hard |
| ACH_ALL_CROPS | Crop Collector | Grow every type of crop | Hard |
| ACH_GOLD_CROP | Quality Farmer | Grow a gold-star quality crop | Medium |
| ACH_FULL_FIELD | Full Field | Have 100 crops growing at once | Medium |
| ACH_SPEED_HARVEST | Speed Farmer | Harvest 50 crops in one day | Hard |
| ACH_SEASONAL_MASTER | Seasonal Master | Complete all seasonal crops | Hard |
| ACH_NO_WILT | Perfect Care | Go a full season without a crop dying | Medium |
| ACH_ANCIENT_SEED | Ancient Discovery | Grow an ancient fruit | Secret |

### Fishing Achievements (6)
| ID | Name | Description | Type |
|----|------|-------------|------|
| ACH_FIRST_FISH | Gone Fishing | Catch your first fish | Easy |
| ACH_CATCH_50 | Angler | Catch 50 fish | Medium |
| ACH_CATCH_ALL | Master Angler | Catch every type of fish | Hard |
| ACH_LEGENDARY_FISH | Legendary | Catch a legendary fish | Hard |
| ACH_PERFECT_CATCH | Perfect Catch | Catch a fish with perfect timing | Medium |
| ACH_RAINY_FISHER | Rain Lover | Catch 10 fish in the rain | Medium |

### Mining Achievements (6)
| ID | Name | Description | Type |
|----|------|-------------|------|
| ACH_FIRST_ORE | Prospector | Find your first ore | Easy |
| ACH_REACH_FLOOR_50 | Spelunker | Reach floor 50 of the mine | Medium |
| ACH_REACH_FLOOR_100 | Deep Diver | Reach floor 100 of the mine | Hard |
| ACH_FIND_DIAMOND | Diamond Hunter | Find a diamond | Medium |
| ACH_ALL_MINERALS | Geologist | Find every type of mineral | Hard |
| ACH_MINE_1000 | Rock Smasher | Break 1,000 rocks | Medium |

### Social Achievements (8)
| ID | Name | Description | Type |
|----|------|-------------|------|
| ACH_FIRST_FRIEND | New Friend | Reach 2 hearts with any villager | Easy |
| ACH_MAX_FRIENDSHIP | Best Friends | Reach max hearts with any villager | Medium |
| ACH_ALL_FRIENDS | Popular | Reach 5 hearts with every villager | Hard |
| ACH_FIRST_GIFT | Generous | Give your first gift | Easy |
| ACH_LOVED_GIFT | Perfect Gift | Give a villager their favorite item | Medium |
| ACH_GET_MARRIED | Newlywed | Get married | Medium |
| ACH_HAVE_CHILD | Parent | Have a child | Hard |
| ACH_BIRTHDAY | Party Time | Attend a villager's birthday | Easy |

### Progression Achievements (6)
| ID | Name | Description | Type |
|----|------|-------------|------|
| ACH_YEAR_1_COMPLETE | First Year | Complete your first year | Medium |
| ACH_YEAR_2_COMPLETE | Veteran Farmer | Complete your second year | Hard |
| ACH_COMMUNITY_CENTER | Town Hero | Complete the Community Center | Hard |
| ACH_MILLIONAIRE | Millionaire | Earn 1,000,000 gold total | Hard |
| ACH_FULL_HOUSE | Home Sweet Home | Fully upgrade your house | Medium |
| ACH_ALL_TOOLS | Master Craftsman | Upgrade all tools to max level | Hard |

### Secret Achievements (4)
| ID | Name | Description | Type |
|----|------|-------------|------|
| ACH_SECRET_AREA | ??? | Find the secret area | Secret |
| ACH_METEOR | ??? | Witness a meteor event | Secret |
| ACH_ANCIENT_RELIC | ??? | Discover the ancient relic | Secret |
| ACH_TRUE_ENDING | ??? | See the true ending | Secret |

---

## Stats to Track

| Stat Name | Description | Use Case |
|-----------|-------------|----------|
| TotalCropsHarvested | Lifetime crops harvested | Farming achievements |
| TotalFishCaught | Lifetime fish caught | Fishing achievements |
| TotalMineralsFound | Lifetime minerals mined | Mining achievements |
| TotalMoneyEarned | Lifetime gold earned | Millionaire achievement |
| TotalDaysPlayed | In-game days passed | Year completion |
| TotalGiftsGiven | Gifts given to villagers | Social tracking |
| TotalTimePlayed | Real-time hours played | Engagement metric |
| HighestMineFloor | Deepest mine floor reached | Mining progression |
| VillagersMaxed | Villagers at max hearts | Social completion |
| CropsTypesGrown | Unique crop types grown | Completion tracking |

---

## Integration Timeline

### Month 1-2: Preparation
- Finalize achievement list (30+ achievements)
- Design achievement icons (64x64 PNG, locked/unlocked versions)
- Set up stat tracking hooks in existing code
- Test achievement triggers locally

### Month 3: Steamworks Setup
- Pay $100 Steam Direct fee
- Register game on Steamworks Partner portal
- Get Steam App ID
- Configure achievement/stat schemas in Steamworks
- Upload store page assets

### Month 4: Implementation
- Install GodotSteam plugin
- Implement steam_controller.gd as singleton
- Hook up achievement unlocks throughout game
- Connect stat tracking to gameplay events
- Test with real Steam App ID

### Month 5: Testing & Polish
- Beta test Steam features
- Verify all achievements unlock correctly
- Test stat tracking accuracy
- Ensure Steam Deck compatibility
- Test offline mode behavior
- Cloud save testing

---

## Steam Deck Compatibility

### Requirements for "Verified" Status
- [ ] Controller support (full gamepad navigation)
- [ ] Readable text at 1280x800 resolution
- [ ] No anti-cheat that blocks Proton
- [ ] Appropriate default graphics settings
- [ ] No external launchers required

### Testing Checklist
- [ ] All UI navigable with controller
- [ ] Text readable on 7" screen
- [ ] Runs at stable 30+ FPS on Deck
- [ ] Touch controls work for menus
- [ ] Suspend/resume works correctly

---

## Launch Timeline

### Pre-Launch (Months 1-3)
- Finalize game features
- Complete Steamworks integration
- Prepare marketing materials
- Build wishlist through content marketing
- Submit to Steam Direct

### Launch Phase (Month 4)
- Coordinated launch campaign
- Influencer content release
- Community engagement
- Day-one patch readiness
- Launch discount (10-15%)

### Post-Launch (Months 5-12)
- Monitor performance metrics
- Release content updates
- Address community feedback
- Plan expansion content
- Seasonal events
- Year 2 content development

---

## Competitor Pricing Analysis

| Game | Price | Launch Year | Est. Sales |
|------|-------|-------------|------------|
| Stardew Valley | $14.99 | 2016 | 41M+ |
| Coral Island | $29.99 | 2023 | 1M+ |
| Sun Haven | $24.99 | 2023 | 500K+ |
| Roots of Pacha | $24.99 | 2023 | 200K+ |
| Fields of Mistria | $24.99 | 2024 | 500K+ |
| Fae Farm | $59.99 | 2023 | 200K+ |

**Recommendation:** Launch at **$19.99** with 10% launch discount = **$17.99**

---

## Notes

### Keys to Success
1. **Polish over features** - A smaller, polished game beats a buggy ambitious one
2. **Community first** - Build Discord before launch, listen to feedback
3. **Consistent updates** - Show players you're committed post-launch
4. **Unique identity** - Don't just clone Stardew, offer something new
5. **Steam algorithm** - Launch matters, get reviews early

### Common Mistakes to Avoid
- Launching too early without enough content
- Ignoring negative feedback
- No post-launch content plan
- Underpricing (signals low quality)
- Overpricing (reduces impulse buys)
- No wishlist campaign before launch
