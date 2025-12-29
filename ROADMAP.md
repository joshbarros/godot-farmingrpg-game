# Farming RPG - Development Roadmap

## Current State (Prototype ~10%)

### Implemented
- Player movement with 4-directional animations
- Basic farm tile system (grass, tilled, watered states)
- Crop data system with growth stages (tomato, corn)
- CropData resource for seed/sell prices and growth time
- TileMapLayer-based farm grid
- Audio files for farming actions (harvest, plant, till, water)
- UI icons for tools and seeds

### Scaffolded (Empty Stubs)
- `_on_new_day()` - day progression
- `try_till_tile()` - tilling logic
- `try_water_tile()` - watering logic
- `try_seed_tile()` - planting logic
- `_on_harvest_crop()` - harvesting logic

---

## Phase 1: Core Farming Loop
- [ ] Implement tool interactions (till, water, harvest)
- [ ] Tool switching system
- [ ] Basic inventory system
- [ ] Day/night cycle with time progression
- [ ] Crop growth tied to days
- [ ] Harvesting mechanics

## Phase 2: Economy & Progression
- [ ] Money/currency system
- [ ] Shop to buy seeds
- [ ] Selling harvested crops
- [ ] More crop varieties
- [ ] Tool upgrades

## Phase 3: World & Content
- [ ] Expanded farm area
- [ ] Town/village area
- [ ] NPCs with basic dialogue
- [ ] Buildings (house, barn, shop)
- [ ] Seasons system

## Phase 4: Polish & Systems
- [ ] Save/load system
- [ ] Main menu & pause menu
- [ ] Settings (audio, controls)
- [ ] Tutorial/onboarding
- [ ] Sound design & music

## Phase 5: Advanced Features
- [ ] Relationships/friendship system
- [ ] Animals (chickens, cows)
- [ ] Fishing minigame
- [ ] Mining/foraging
- [ ] Crafting system
- [ ] Quests/objectives

## Phase 6: Commercial Release
- [ ] Unique hook/differentiator
- [ ] Full art pass (consistent style)
- [ ] Localization
- [ ] Steam page & marketing
- [ ] Playtesting & balancing
- [ ] Bug fixes & optimization

---

## Reference: Stardew Valley Stats

| Metric | Value |
|--------|-------|
| Development Time | 4.5 years (solo, 10+ hrs/day) |
| Total Sales (2025) | 41 million copies |
| Gross Revenue | ~$500-600M |
| Net Revenue | ~$150M+ |
| Developer Net Worth | $34-100M estimated |

### AI-Assisted Development Advantage (2025)
- AI-assisted coding (Claude Code)
- AI sprite/texture generation
- AI 3D model generation
- AI audio/SFX generation
- Potential 3-5x speed increase on execution

**Target:** Polished MVP in 6-12 months with AI tools

---

## AI Tools Arsenal (40 Tools for Game Development)

### Coding & Development (6 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **Claude Code** | AI coding assistant, refactoring, debugging | Subscription |
| **GitHub Copilot** | Code completion, suggestions | $10-19/mo |
| **Cursor** | AI-native code editor (VS Code fork) | Free / $20/mo |
| **Codeium** | Free AI code completion | Free |
| **Tabnine** | Privacy-focused code AI | Free / $12/mo |
| **Bolt.new** | AI app builder from prompts | Free / Paid |

### 2D Art & Sprites (8 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **Scenario** | Game-specific AI art, sprite sheets, textures | $15-99/mo |
| **Leonardo AI** | Sprites, icons, game visuals (150 free/day) | Free / $12/mo |
| **Midjourney** | Concept art, illustrations | $10-30/mo |
| **Stable Diffusion** | Open source, local generation | Free (GPU req) |
| **PixelLab** | AI pixel art generation | Varies |
| **Aseprite** | Pixel art editor & animation | $20 one-time |
| **DALL-E 3** | General image generation | Pay per use |
| **Ideogram** | Text-in-image, logos | Free / Paid |

### 3D Models & Assets (7 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **3DFY.AI** | Text-to-3D models | Subscription |
| **Meshy** | Text/image to 3D models | Free / $20/mo |
| **Tripo AI** | Fast 3D model generation | Free / Paid |
| **Rodin** | High-quality 3D with clean topology | Varies |
| **Hunyuan3D** | Realistic 3D characters (Tencent) | Free |
| **Alpha3D** | 2D to 3D conversion | Subscription |
| **3D AI Studio** | 3D models, textures, landscapes | Varies |

### Textures & Materials (4 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **DreamTextures** | Open source texture generator | Free |
| **Poly AI** | Seamless texture generation | Varies |
| **Charmed Texture Generator** | UV-unwrapped textures | Free / Paid |
| **WithPoly** | Tileable textures for games | Free / Paid |

### Music & Soundtrack (5 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **Suno** | Full songs with vocals (v4.5) | Free / $10/mo |
| **AIVA** | Orchestral, game soundtracks | Free / $15/mo |
| **Udio** | High-quality music generation | Free / Paid |
| **Soundful** | Template-based music | Free / $10/mo |
| **Mubert** | Royalty-free AI music | Subscription |

### Sound Effects (4 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **ElevenLabs SFX** | AI sound effect generation | Pay per use |
| **Ludo.ai** | Game SFX, music, voices | Subscription |
| **AudioCraft (Meta)** | Open source audio generation | Free |
| **Unity Generators** | Built-in sound generation | Unity sub |

### Voice Acting & Dialogue (6 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **ElevenLabs** | Best voice cloning, emotional TTS | $5-22/mo |
| **Replica Studios** | Game character voices | Subscription |
| **PlayHT** | 800+ voices, 142 languages | Free / $30/mo |
| **Fish Audio** | High quality, cheap ($10/200min) | $10/mo |
| **Resemble AI** | Voice cloning from 10sec audio | Subscription |
| **Cartesia** | Ultra-low latency (40ms) | Varies |

### NPC & Game AI (3 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **Inworld AI** | Smart NPCs with memory/emotion | Free / Paid |
| **Charisma.ai** | Interactive NPC dialogue | Subscription |
| **Convai** | Game-ready conversational AI | Varies |

### Productivity & Marketing (7 tools)
| Tool | Purpose | Pricing |
|------|---------|---------|
| **ChatGPT** | Writing, planning, research | Free / $20/mo |
| **Zapier** | Automation workflows | Free / $20/mo |
| **Synthesia** | AI video for trailers/marketing | $30/mo |
| **Canva AI** | Graphics, social media | Free / $13/mo |
| **Notion AI** | Documentation, planning | $10/mo add-on |
| **Ludo.ai (Game Design)** | Game concept research | Subscription |
| **Descript** | Video/audio editing | Free / $12/mo |

---

### Quick Start Recommendations (Free Tier)
1. **Coding:** Claude Code + Codeium
2. **Art:** Leonardo AI (150/day free) + Stable Diffusion
3. **3D:** Meshy + Hunyuan3D
4. **Music:** Suno + AIVA (free tiers)
5. **Voice:** Fish Audio or ElevenLabs free tier
6. **SFX:** AudioCraft (open source)

---

## Starstream Games - Recommended Stack

| Category | Tool | Why This One |
|----------|------|--------------|
| **Coding** | Claude Code + GitHub Copilot | Already using - best combo |
| **2D Art/Sprites** | **Scenario** ($15/mo) | Built for games, sprite sheets, style training |
| **3D Models** | **Meshy** (Free/$20) | Best balance of quality + ease of use |
| **Textures** | **Scenario** | Same tool, handles textures too |
| **Music** | **AIVA** ($15/mo Pro) | Full copyright, orchestral/game focus |
| **SFX** | **ElevenLabs** ($5/mo) | Best quality, also does SFX now |
| **Voice Acting** | **ElevenLabs** ($5/mo) | Industry standard, emotion control |
| **NPC AI** | **Inworld AI** (Free tier) | Best for game NPCs with memory |
| **Marketing** | **Canva AI** (Free/$13) | Quick trailers, social, Steam assets |

### Monthly Cost Estimate
| Tier | Tools | Cost |
|------|-------|------|
| **Free** | Meshy, Inworld, Canva free | $0 |
| **Basic** | + AIVA Pro, ElevenLabs Starter | ~$20/mo |
| **Full** | + Scenario Pro | ~$35-50/mo |

### Why These Picks
- **Scenario** > Leonardo for games (sprite sheets, style consistency)
- **AIVA** > Suno for games (orchestral focus, full copyright on Pro)
- **ElevenLabs** > alternatives (quality + does both voice AND SFX)
- **Meshy** > others (clean topology, game-ready exports)
- **Inworld** > Charisma (better free tier, Godot support)

---

### Commercial License Notes
- Always check licensing before release
- Scenario/Leonardo paid tiers = full commercial rights
- AIVA Pro = full copyright ownership
- Open source tools = check individual licenses
