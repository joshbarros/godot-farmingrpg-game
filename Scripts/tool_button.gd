## ToolButton - Tool/Seed Selection Button
##
## This script handles individual tool and seed buttons in the HUD.
## Each button can represent either a tool (hoe, water bucket, scythe)
## or a specific seed type (corn, tomato).
##
## Features:
##   - Click to select the associated tool/seed
##   - Visual feedback: yellow tint when selected, scale up on hover
##   - Displays seed quantity for seed-type buttons
##
## Dependencies:
##   - GameManager: Emits SetPlayerTool signal, listens to ChangeSeedQuantity
##   - PlayerTools: Uses Tool enum for tool type identification
class_name ToolButton
extends TextureButton

## The tool type this button represents (HOE, WATER_BUCKET, SCYTHE, or SEED).
@export var tool : PlayerTools.Tool

## For SEED tool buttons, the specific crop type. Null for other tools.
@export var crop_seed : CropData

## Label showing the quantity of seeds owned (only visible for seed buttons).
@onready var quantity_text : Label = $QuantityText

## Whether this button is currently selected. Updates visual state on change.
var is_selected = false:
	set(value):
		is_selected = value
		_update_visual_state()


## Initializes the button by connecting signals and setting up visuals.
func _ready():
	quantity_text.text = ""
	pivot_offset = size / 2
	# Connect the pressed signal explicitly
	if GameManager:
		GameManager.ChangeSeedQuantity.connect(_on_change_seed_quantity)
	self.pressed.connect(_on_button_pressed)
	_update_visual_state()  # Initialize visual state


## Empty handler for the built-in pressed signal.
## Actual logic is in _on_button_pressed() to avoid duplicate calls.
func _on_pressed():
	# This function is automatically called when the button is pressed
	# The actual logic is handled in _on_button_pressed() to avoid duplicate calls
	pass


## Sets the selected state of this button.
## @param value: True to select, false to deselect.
func set_selected(value: bool):
	is_selected = value


## Updates the button's visual appearance based on selection state.
## Selected buttons are tinted yellow, unselected are white.
func _update_visual_state():
	if is_selected:
		# Add a border or change appearance to indicate selection
		modulate = Color.YELLOW  # Make the button yellow when selected
	else:
		modulate = Color.WHITE  # Normal color when not selected


## Called when this button is pressed.
## Emits SetPlayerTool signal to change the active tool.
## Falls back to direct tool setting if GameManager unavailable.
func _on_button_pressed():
	print("Tool button pressed: ", tool)  # Debug print
	# Emit signal to GameManager to change the selected tool
	if GameManager:
		GameManager.SetPlayerTool.emit(tool, crop_seed)
		print("Emitted tool change to GameManager: ", tool)  # Debug print
	else:
		print("GameManager not available, trying direct tool setting")  # Debug print
		# Fallback: try to set tool directly
		var tools_node = null

		# Try different methods to find the tools node
		if has_node("/root/Main/Player/Tools"):
			tools_node = get_node("/root/Main/Player/Tools")
		else:
			# Alternative approach: search through the scene tree
			var main_node = get_tree().root.get_node_or_null("Main")
			if main_node:
				var player_node = main_node.get_node_or_null("Player")
				if player_node:
					tools_node = player_node.get_node_or_null("Tools")

		if tools_node and tools_node is PlayerTools:
			print("Found tools node, setting tool: ", tool)  # Debug print
			tools_node.set_tool(tool, crop_seed)
		else:
			print("Could not find tools node or wrong type")  # Debug print
			print("Tools node found: ", tools_node)
			if tools_node:
				print("Tools node type: ", tools_node.get_class())
			else:
				print("Available nodes from root: ", get_tree().root.get_children())


## Called when mouse enters the button area.
## Scales up the button slightly for hover feedback.
func _on_mouse_entered():
	scale.x = 1.05
	scale.y = 1.05


## Called when mouse exits the button area.
## Resets the button scale to normal.
func _on_mouse_exited():
	scale.x = 1
	scale.y = 1


## Called when seed quantity changes in GameManager.
## Updates the quantity label if this button matches the changed seed type.
## @param crop_data: The CropData that changed.
## @param quantity: The new quantity of that seed type.
func _on_change_seed_quantity(crop_data: CropData, quantity: int):
	if crop_data != crop_seed:
		return
	quantity_text.text = str(quantity)
