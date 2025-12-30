# Farming RPG

A cozy farming simulation game inspired by **Animal Crossing** and **Stardew Valley**, built with Godot 4.5.

![Godot](https://img.shields.io/badge/Godot-4.5-blue?logo=godot-engine)
![License](https://img.shields.io/badge/License-MIT-green)
![Status](https://img.shields.io/badge/Status-In%20Development-orange)

---

## About

Farming RPG combines the relaxed, charming atmosphere of Animal Crossing with the satisfying progression systems of Stardew Valley. Tend your farm, befriend villagers, explore the world, and build the life you've always dreamed of.

### Vision

- **Relaxed Gameplay:** No pressure, play at your own pace
- **Charming Villagers:** Unique personalities, deep relationships, romance options
- **Satisfying Farming:** Plant, water, grow, harvest - feel the progress
- **Living World:** Seasons change, villagers have routines, the town evolves

---

## Current Features

- Player movement with 4-directional animations
- Tool system (Hoe, Watering Can, Scythe, Seed Planting)
- Tile-based farming (till, water, plant, harvest)
- Crop growth system with visual stages
- 2 crop types (Tomato, Corn)
- Economy system (buy seeds, sell crops)
- Dynamic UI (day counter, money display, tool buttons)
- Sound effects for all farming actions
- Main menu

---

## Controls

| Action | Key |
|--------|-----|
| Move | W / A / S / D |
| Use Tool | E |
| Cancel / Deselect | F |
| Next Day | Enter |

---

## Getting Started

### Prerequisites

- [Godot 4.5](https://godotengine.org/download) or later

### Running the Game

1. Clone the repository:
   ```bash
   git clone https://github.com/joshbarros/godot-farmingrpg-game.git
   ```

2. Open Godot and import the project

3. Press F5 to run

---

## Project Structure

```
farming-rpg/
├── Audio/              # Sound effects
├── Crops/              # Crop data resources (.tres)
├── Scenes/             # Game scenes (.tscn)
│   ├── main.tscn       # Main game scene
│   ├── menu.tscn       # Main menu
│   └── crop.tscn       # Crop prefab
├── Scripts/            # GDScript files
│   ├── game_manager.gd # Global game state (autoload)
│   ├── farm_manager.gd # Farm tile operations
│   ├── player.gd       # Player movement
│   ├── tools.gd        # Tool interactions
│   ├── crop.gd         # Crop growth logic
│   └── ...
├── Sprites/            # Visual assets
│   ├── Crops/          # Crop growth sprites
│   ├── Player/         # Player animations
│   ├── Tiles/          # Tileset
│   └── UI/             # UI elements
├── ROADMAP.md          # Development roadmap
└── README.md           # This file
```

---

## Roadmap

See [ROADMAP.md](ROADMAP.md) for the full development plan.

### Upcoming Features

- **Phase 1:** Save/Load system, pause menu, more crops
- **Phase 2:** Day/night cycle, seasons, weather
- **Phase 3:** Town, forest, beach, mine areas
- **Phase 4:** NPCs with personalities, friendship system
- **Phase 5:** Fishing, mining, foraging, crafting
- **Phase 6:** Farm upgrades, animals, romance/marriage
- **Phase 7:** Visual & audio polish
- **Phase 8:** Commercial release

---

## Tech Stack

- **Engine:** Godot 4.5
- **Language:** GDScript
- **Resolution:** 1920x1080 (fullscreen)
- **Art Style:** Pixel art (16x16 tiles)

### AI-Assisted Development

This project leverages AI tools for accelerated development:

| Tool | Purpose |
|------|---------|
| Claude Code | Development assistance |
| Scenario | Sprite generation |
| AIVA | Music composition |
| ElevenLabs | Sound effects & voice |

---

## Contributing

This is currently a solo project, but feedback and suggestions are welcome!

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Inspired by [Stardew Valley](https://www.stardewvalley.net/) by ConcernedApe
- Inspired by [Animal Crossing](https://www.animal-crossing.com/) by Nintendo
- Built with [Godot Engine](https://godotengine.org/)

---

## Contact

**Starstream Games**

- GitHub: [@joshbarros](https://github.com/joshbarros)

---

*Happy Farming!*
