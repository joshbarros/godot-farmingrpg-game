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
var is_selecting : bool = false
var previous_selected_button : ToolButton = null  # Track the previously selected button

const TILE_SIZE : int = 16

@onready var player : CharacterBody2D = get_parent()
@onready var farm_manager : FarmManager = get_node("/root/Main/FarmManager")
var highlight : ColorRect

func _ready():
    current_tool = Tool.HOE
    _create_highlight()

func _create_highlight():
    highlight = ColorRect.new()
    highlight.size = Vector2(TILE_SIZE, TILE_SIZE)
    highlight.color = Color(1, 1, 0, 0.4)  # Yellow with transparency
    highlight.visible = false
    highlight.z_index = 10
    get_tree().root.call_deferred("add_child", highlight)

func set_tool(tool_type: Tool, crop_seed: CropData = null):
    print("Setting tool to: ", tool_type, " with seed: ", crop_seed)  # Debug print
    current_tool = tool_type
    current_seed = crop_seed
    _cancel_selection()

    # Update UI to show selected tool
    _update_tool_ui(tool_type)

    print("Tool set successfully. Current tool: ", current_tool)  # Additional debug

func _update_tool_ui(selected_tool: Tool):
    # Find all tool buttons and update their visual state
    var canvas_layer = get_tree().root.get_node_or_null("Main/CanvasLayer")
    if canvas_layer:
        var hbox_container = canvas_layer.get_node_or_null("HBoxContainer")
        if hbox_container:
            # Reset all buttons to normal state
            for child in hbox_container.get_children():
                if child.has_method("set_selected") and child is ToolButton:
                    child.set_selected(false)

            # Highlight the selected tool button
            var button_name = ""
            match selected_tool:
                Tool.HOE:
                    button_name = "HoeButton"
                Tool.WATER_BUCKET:
                    button_name = "WaterButton"
                Tool.SCYTHE:
                    button_name = "ScytheButton"
                Tool.SEED:
                    # For seed tool, we can't determine which seed button, so highlight both
                    var corn_button = hbox_container.get_node_or_null("CornSeedButton")
                    var tomato_button = hbox_container.get_node_or_null("TomatoSeedButton")
                    if corn_button:
                        corn_button.set_selected(true)
                    if tomato_button:
                        tomato_button.set_selected(true)
                    return

            # Highlight the specific tool button
            var button = hbox_container.get_node_or_null(button_name)
            if button and button is ToolButton:
                button.set_selected(true)

func _get_target_tile_pos() -> Vector2:
    var facing = player.facing_direction.normalized()
    # Snap to cardinal direction
    if abs(facing.x) > abs(facing.y):
        facing = Vector2(sign(facing.x), 0)
    else:
        facing = Vector2(0, sign(facing.y))
    return player.global_position + facing * TILE_SIZE

func _get_tile_center(pos: Vector2) -> Vector2:
    var tile_map = farm_manager.tile_map
    var local_pos = tile_map.to_local(pos)
    var coords = tile_map.local_to_map(local_pos)
    return tile_map.to_global(tile_map.map_to_local(coords))

func _cancel_selection():
    is_selecting = false
    highlight.visible = false

func _confirm_action():
    var target_pos = _get_target_tile_pos()
    match current_tool:
        Tool.HOE:
            farm_manager.try_till_tile(target_pos)
            current_tool = Tool.WATER_BUCKET  # Auto-switch to water after tilling
        Tool.WATER_BUCKET:
            farm_manager.try_water_tile(target_pos)
            current_tool = Tool.HOE  # Auto-switch back to hoe after watering
        Tool.SCYTHE:
            farm_manager.try_harvest_tile(target_pos)
        Tool.SEED:
            farm_manager.try_seed_tile(target_pos, current_seed)
    _cancel_selection()

func _process(_delta):
    # Update highlight position when selecting
    if is_selecting:
        var target_pos = _get_target_tile_pos()
        var tile_center = _get_tile_center(target_pos)
        highlight.global_position = tile_center - Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)

    # E to select/confirm
    if Input.is_action_just_pressed("interact"):
        if is_selecting:
            _confirm_action()
        else:
            is_selecting = true
            highlight.visible = true

    # F to cancel
    if Input.is_action_just_pressed("cancel") and is_selecting:
        _cancel_selection()