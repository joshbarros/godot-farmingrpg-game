class_name PlayerTools

extends Node

enum Tool {
    HOE,
    WATER_BUCKET,
    SCYTHE,
    SEED
}

var current_tool: Tool
var current_seed : CropData

@onready var player : CharacterBody2D = get_parent()
@onready var farm_manager : FarmManager = get_node("/root/Main/FarmManager")

func _ready():
    current_tool = Tool.HOE

func set_tool(tool_type: Tool, crop_seed: CropData = null):
    current_tool = tool_type
    current_seed = crop_seed

func _process(_delta):
    if Input.is_action_just_pressed("interact"):
        var player_pos = player.global_position
        match current_tool:
            Tool.HOE:
                farm_manager.try_till_tile(player_pos)
            Tool.WATER_BUCKET:
                farm_manager.try_water_tile(player_pos)
            Tool.SCYTHE:
                farm_manager.try_harvest_tile(player_pos)
            Tool.SEED:
                farm_manager.try_seed_tile(player_pos, current_seed)