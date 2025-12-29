class_name FarmManager
extends Node

enum TileType {
    GRASS,
    TILLED,
    TILLED_WATERED
}

class TileInfo:
    var tilled : bool
    var watered : bool
    var crop : Crop

@onready var tile_map : TileMapLayer = $FarmTileMap
var tile_info : Dictionary[Vector2i, TileInfo]
var crop_scene : PackedScene = preload("res://Scenes/crop.tscn")

var tile_atlas_coords : Dictionary[TileType, Vector2i] = {
    TileType.GRASS: Vector2i(0, 0),
    TileType.TILLED: Vector2i(1, 0),
    TileType.TILLED_WATERED: Vector2i(0, 1)
}

func _ready():
    for cell in tile_map.get_used_cells():
        tile_info[cell] = TileInfo.new()

func _on_new_day(day: int):
    pass

func _on_harvest_crop(crop: Crop):
    pass

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

    var crop_instance = crop_scene.instantiate()
    crop_instance.position = tile_map.map_to_local(coords)
    add_child(crop_instance)
    crop_instance.set_crop(crop_data, tile_info[coords].watered, coords)
    tile_info[coords].crop = crop_instance

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

func is_tile_watered(pos: Vector2i) -> bool:
    return false

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