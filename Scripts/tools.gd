## PlayerTools - Tool Selection and Action System
##
## This script handles the player's tool system including selection, targeting,
## and action execution. It provides a two-step interaction system where players
## first highlight a tile (E key), then confirm the action (E again).
##
## Tool Types:
##   - HOE: Tills grass into farmable soil
##   - WATER_BUCKET: Waters tilled soil for crop growth
##   - SCYTHE: Harvests fully grown crops
##   - SEED: Plants seeds on tilled soil (requires selecting specific seed type)
##
## Controls:
##   - Click tool buttons in UI to select tools
##   - E: Highlight target tile / Confirm action
##   - F: Cancel current selection
##
## Auto-Switching:
##   - After using HOE, automatically switches to WATER_BUCKET
##   - After using WATER_BUCKET, automatically switches back to HOE
class_name PlayerTools

extends Node

## Available tool types the player can use.
enum Tool {
	HOE,          ## Tills grass into farmable soil
	WATER_BUCKET, ## Waters tilled/planted tiles
	SCYTHE,       ## Harvests mature crops
	SEED          ## Plants seeds (requires crop_seed to be set)
}

## The currently selected tool.
var current_tool: Tool

## The seed type to plant when using SEED tool. Null for other tools.
var current_seed : CropData

## Whether the player is currently in selection mode (highlighting a tile).
var is_selecting : bool = false

## Reference to the previously selected tool button for UI state tracking.
var previous_selected_button : ToolButton = null

## Size of one tile in pixels. Used for positioning highlight and calculating targets.
const TILE_SIZE : int = 16

## Reference to the parent player node for position and facing direction.
@onready var player : CharacterBody2D = get_parent()

## Reference to the FarmManager for executing farming actions.
@onready var farm_manager : FarmManager = get_node("/root/Main/FarmManager")

## Visual indicator showing which tile the player is targeting.
var highlight : ColorRect


## Initializes the tool system and sets default tool to HOE.
func _ready():
	# Connect to the GameManager for tool selection
	if GameManager:
		GameManager.SetPlayerTool.connect(set_tool)
		# Set the default tool via GameManager
		GameManager.SetPlayerTool.emit(Tool.HOE, null)
	else:
		# Fallback if GameManager is not available
		current_tool = Tool.HOE
		print("Warning: GameManager not found, using fallback tool selection")
	_create_highlight()


## Creates the yellow highlight rectangle for tile selection.
## Added to the scene root for proper positioning.
func _create_highlight():
	highlight = ColorRect.new()
	highlight.size = Vector2(TILE_SIZE, TILE_SIZE)
	highlight.color = Color(1, 1, 0, 0.4)  # Yellow with transparency
	highlight.visible = false
	highlight.z_index = 10
	get_tree().root.call_deferred("add_child", highlight)


## Changes the current tool and updates UI state.
## Called when player clicks a tool button or via GameManager signal.
## @param tool_type: The Tool enum value to switch to.
## @param crop_seed: The CropData for SEED tool, or null for other tools.
func set_tool(tool_type: Tool, crop_seed: CropData = null):
	print("Setting tool to: ", tool_type, " with seed: ", crop_seed)  # Debug print
	current_tool = tool_type
	current_seed = crop_seed
	_cancel_selection()

	# Update UI to show selected tool
	_update_tool_ui(tool_type)

	print("Tool set successfully. Current tool: ", current_tool)  # Additional debug


## Updates the visual state of tool buttons to show which is selected.
## Finds buttons by name and calls set_selected() on matching button.
## @param selected_tool: The currently selected Tool enum value.
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
					# For seed tool, we need to determine which specific seed was selected
					# We'll check the current_seed to determine which button to highlight
					if current_seed and current_seed.resource_path.find("corn") != -1:
						button_name = "CornSeedButton"
					elif current_seed and current_seed.resource_path.find("tomato") != -1:
						button_name = "TomatoSeedButton"
					else:
						# If no specific seed is selected, don't highlight any seed button
						return

			# Highlight the specific tool button
			var button = hbox_container.get_node_or_null(button_name)
			if button and button is ToolButton:
				button.set_selected(true)


## Calculates the world position of the tile in front of the player.
## Uses the player's facing direction snapped to cardinal directions.
## @return: World position of the target tile center.
func _get_target_tile_pos() -> Vector2:
	var facing = player.facing_direction.normalized()
	# Snap to cardinal direction
	if abs(facing.x) > abs(facing.y):
		facing = Vector2(sign(facing.x), 0)
	else:
		facing = Vector2(0, sign(facing.y))
	return player.global_position + facing * TILE_SIZE


## Converts a world position to the center of its containing tile.
## Used for accurate highlight positioning.
## @param pos: World position to convert.
## @return: World position of the tile's center.
func _get_tile_center(pos: Vector2) -> Vector2:
	var tile_map = farm_manager.tile_map
	var local_pos = tile_map.to_local(pos)
	var coords = tile_map.local_to_map(local_pos)
	return tile_map.to_global(tile_map.map_to_local(coords))


## Cancels the current tile selection and hides the highlight.
func _cancel_selection():
	is_selecting = false
	if highlight:
		highlight.visible = false


## Executes the current tool's action on the targeted tile.
## Calls the appropriate FarmManager method based on current_tool.
## Auto-switches between HOE and WATER_BUCKET after use.
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


## Called every frame. Updates highlight position and handles input.
## E key toggles between selection mode and action confirmation.
## F key cancels current selection.
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
