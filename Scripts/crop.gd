## Crop - Individual Crop Instance
##
## This script manages a single planted crop's lifecycle including growth,
## watering state, and harvest readiness. Each crop instance is created
## when the player plants a seed on a tilled tile.
##
## Growth Logic:
##   - Crops only grow on days when they were watered the previous day
##   - Growth progress is tracked via days_until_grown counter
##   - Sprite updates based on growth percentage through growth_sprites array
##   - When days_until_grown reaches 0, crop becomes harvestable
##
## Dependencies:
##   - GameManager: Listens to NewDay signal for growth updates
##   - CropData: Resource containing growth sprites and timing
class_name Crop
extends Node2D

## The CropData resource defining this crop's properties (sprites, growth time, prices).
var crop_data : CropData

## Days remaining until the crop is fully grown. Decrements each watered day.
var days_until_grown : int

## Whether this crop was watered today. Resets to false each new day after growth check.
var watered : bool

## Whether this crop is ready to harvest. Set to true when days_until_grown reaches 0.
var harvestable : bool

## The tile coordinates where this crop is planted. Used for position reference.
var tile_map_coords : Vector2i

## Reference to the Sprite2D node displaying the crop's current growth stage.
@onready var sprite : Sprite2D = $Sprite


## Connects to GameManager's NewDay signal to receive growth updates.
func _ready():
	if GameManager:
		GameManager.NewDay.connect(_on_new_day)


## Initializes the crop with its data and starting state.
## Called by FarmManager when planting a seed.
## @param data: The CropData resource for this crop type.
## @param already_watered: Whether the tile was already watered when planted.
## @param tile_coords: The tile map coordinates where this crop is planted.
func set_crop(data: CropData, already_watered: bool, tile_coords: Vector2i):
	crop_data = data
	watered = already_watered
	tile_map_coords = tile_coords
	harvestable = false

	days_until_grown = data.days_to_grow
	sprite.texture = crop_data.growth_sprites[0]


## Called when a new day begins.
## If the crop was watered, decrements growth counter and updates sprite.
## Crops that weren't watered don't grow that day.
## @param _day: The new day number (unused but required by signal).
func _on_new_day(_day: int):
	if not watered:
		return

	watered = false

	if days_until_grown > 0:
		days_until_grown -= 1
	else:
		harvestable = true

	# Calculate which sprite to display based on growth progress
	# Maps growth percentage to sprite array index
	var sprite_count : int = len(crop_data.growth_sprites)
	var growth_percent : float = (crop_data.days_to_grow - days_until_grown) / float(crop_data.days_to_grow)
	var index : int = floor(growth_percent * sprite_count)
	index = clamp(index, 0, sprite_count - 1)

	sprite.texture = crop_data.growth_sprites[index]
