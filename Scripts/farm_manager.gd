## FarmManager - Farm Tile and Crop Management System
##
## This script manages all farm tiles, their states, and crop lifecycle.
## It handles tilling, watering, planting, and harvesting operations.
##
## Tile State Flow:
##   GRASS -> (till) -> TILLED -> (water) -> TILLED_WATERED
##   On new day: TILLED_WATERED -> TILLED (crop grows if watered)
##   On new day: TILLED (no crop) -> GRASS (reverts if empty)
##
## Dependencies:
##   - GameManager: Listens to NewDay and HarvestCrop signals
##   - CropData: Resource defining crop properties
##   - Crop: Scene instantiated for planted crops
class_name FarmManager
extends Node

## Represents the visual and logical state of a farm tile.
enum TileType {
	GRASS,          ## Default untilled ground
	TILLED,         ## Tilled soil, ready for planting
	TILLED_WATERED  ## Tilled and watered, crops will grow
}

## Inner class storing the state of each individual tile.
## Tracks whether the tile is tilled, watered, and if it has a crop.
class TileInfo:
	var tilled : bool   ## Whether the tile has been tilled
	var watered : bool  ## Whether the tile has been watered today
	var crop : Crop     ## Reference to the crop planted on this tile (null if none)

## Reference to the TileMapLayer containing farm tiles.
@onready var tile_map : TileMapLayer = $FarmTileMap

## Audio players for farming action sound effects.
@onready var till_sound : AudioStreamPlayer = get_parent().get_node("TillSound")
@onready var water_sound : AudioStreamPlayer = get_parent().get_node("WaterSound")
@onready var plant_sound : AudioStreamPlayer = get_parent().get_node("PlantSound")
@onready var harvest_sound : AudioStreamPlayer = get_parent().get_node("HarvestSound")

## Dictionary mapping tile coordinates to their TileInfo state.
## Key: Vector2i (tile coordinates), Value: TileInfo instance.
var tile_info : Dictionary[Vector2i, TileInfo]

## Preloaded crop scene for instantiation when planting.
var crop_scene : PackedScene = preload("res://Scenes/crop.tscn")

## Maps TileType enum to atlas coordinates in the tileset.
## Used to update the visual appearance of tiles.
var tile_atlas_coords : Dictionary[TileType, Vector2i] = {
	TileType.GRASS: Vector2i(0, 0),
	TileType.TILLED: Vector2i(1, 0),
	TileType.TILLED_WATERED: Vector2i(0, 1)
}


## Initializes the farm by connecting signals and creating TileInfo for all tiles.
func _ready():
	GameManager.NewDay.connect(_on_new_day)
	GameManager.HarvestCrop.connect(_on_harvest_crop)

	for cell in tile_map.get_used_cells():
		tile_info[cell] = TileInfo.new()


## Called when a new day begins.
## Resets watered tiles to tilled, and reverts empty tilled tiles to grass.
## @param _day: The new day number (unused but required by signal).
func _on_new_day(_day: int):
	for tile_pos in tile_map.get_used_cells():
		if tile_info[tile_pos].watered:
			_set_tile_state(tile_pos, TileType.TILLED)
		elif tile_info[tile_pos].tilled:
			if tile_info[tile_pos].crop == null:
				_set_tile_state(tile_pos, TileType.GRASS)


## Called when a crop is harvested.
## Awards the player a seed of the harvested crop type as bonus.
## @param crop: The Crop instance that was harvested.
func _on_harvest_crop(crop: Crop):
	# Add harvested crop to player's inventory
	if GameManager and crop and crop.crop_data:
		# Add harvested crop to inventory (for now, add 1 of the same crop type as seed)
		if not GameManager.owned_seeds.has(crop.crop_data):
			GameManager.owned_seeds[crop.crop_data] = 0
		GameManager.owned_seeds[crop.crop_data] += 1
		# Emit signal to update UI
		GameManager.ChangeSeedQuantity.emit(crop.crop_data, GameManager.owned_seeds[crop.crop_data])


## Attempts to till the tile at the given world position.
## Fails if: tile doesn't exist, already has a crop, or already tilled.
## @param player_pos: World position (usually in front of the player).
func try_till_tile(player_pos: Vector2):
	var local_pos = tile_map.to_local(player_pos)
	var coords : Vector2i = tile_map.local_to_map(local_pos)
	if not tile_info.has(coords):
		return
	if tile_info[coords].crop:
		return
	if tile_info[coords].tilled:
		return

	_set_tile_state(coords, TileType.TILLED)
	if till_sound:
		till_sound.play()


## Attempts to water the tile at the given world position.
## Fails if: tile doesn't exist, not tilled, or already watered.
## Also updates the crop's watered state if one exists on the tile.
## @param player_pos: World position (usually in front of the player).
func try_water_tile(player_pos: Vector2):
	var local_pos = tile_map.to_local(player_pos)
	var coords : Vector2i = tile_map.local_to_map(local_pos)
	if not tile_info.has(coords):
		return
	if not tile_info[coords].tilled:
		return
	if tile_info[coords].watered:
		return

	_set_tile_state(coords, TileType.TILLED_WATERED)
	# Also update the crop's watered state if there's a crop on this tile
	if tile_info[coords].crop:
		tile_info[coords].crop.watered = true
	if water_sound:
		water_sound.play()


## Attempts to plant a seed on the tile at the given world position.
## Fails if: tile doesn't exist, not tilled, already has crop,
## no crop_data provided, or player has no seeds of this type.
## @param player_pos: World position (usually in front of the player).
## @param crop_data: The CropData resource defining the crop to plant.
func try_seed_tile(player_pos: Vector2, crop_data: CropData):
	var local_pos = tile_map.to_local(player_pos)
	var coords : Vector2i = tile_map.local_to_map(local_pos)
	if not tile_info.has(coords):
		return
	if not tile_info[coords].tilled:
		return
	if tile_info[coords].crop:
		return
	if crop_data == null:
		return

	# Check if GameManager exists and if player has enough seeds
	if GameManager:
		if not GameManager.owned_seeds.has(crop_data) or GameManager.owned_seeds[crop_data] <= 0:
			print("Not enough seeds to plant: ", crop_data.resource_path)
			return
		# Consume one seed
		GameManager.owned_seeds[crop_data] -= 1
		# Emit signal to update UI
		GameManager.ChangeSeedQuantity.emit(crop_data, GameManager.owned_seeds[crop_data])

	var crop_instance = crop_scene.instantiate()
	crop_instance.position = tile_map.map_to_local(coords)
	add_child(crop_instance)
	crop_instance.set_crop(crop_data, tile_info[coords].watered, coords)
	tile_info[coords].crop = crop_instance
	if plant_sound:
		plant_sound.play()


## Attempts to harvest the crop at the given world position.
## Fails if: tile doesn't exist, no crop present, or crop not harvestable.
## @param player_pos: World position (usually in front of the player).
func try_harvest_tile(player_pos: Vector2):
	var local_pos = tile_map.to_local(player_pos)
	var coords : Vector2i = tile_map.local_to_map(local_pos)
	if not tile_info.has(coords):
		return
	if not tile_info[coords].crop:
		return
	if not tile_info[coords].crop.harvestable:
		return

	_on_harvest_crop(tile_info[coords].crop)
	tile_info[coords].crop.queue_free()
	tile_info[coords].crop = null
	if harvest_sound:
		harvest_sound.play()


## Checks if the tile at the given position is watered.
## @param pos: Tile coordinates (Vector2i).
## @return: True if the tile is watered, false otherwise.
func is_tile_watered(pos: Vector2i) -> bool:
	var coords : Vector2i = tile_map.local_to_map(pos)
	return tile_info[coords].watered


## Sets the visual and logical state of a tile.
## Updates both the tilemap appearance and the TileInfo data.
## @param coords: Tile coordinates to update.
## @param tile_type: The new TileType state to apply.
func _set_tile_state(coords : Vector2i, tile_type: TileType):
	tile_map.set_cell(coords, 0, tile_atlas_coords[tile_type])

	match tile_type:
		TileType.GRASS:
			tile_info[coords].tilled = false
			tile_info[coords].watered = false
		TileType.TILLED:
			tile_info[coords].tilled = true
			tile_info[coords].watered = false
		TileType.TILLED_WATERED:
			tile_info[coords].tilled = true
			tile_info[coords].watered = true
