## UIManager - Game UI State Management
##
## This script manages the game's HUD elements including day counter,
## money display, and tool button visual states. It listens to GameManager
## signals to keep the UI synchronized with game state.
##
## UI Elements Managed:
##   - DayText: Shows current day number ("Day X")
##   - MoneyText: Shows player's money balance ("$ X")
##   - ToolButtons: Visual highlight for selected tool
##
## Dependencies:
##   - GameManager: Listens to SetPlayerTool, NewDay, ChangeMoney signals
##   - ToolButton: Child buttons in ToolButtons container
extends CanvasLayer

## Array of all ToolButton instances in the UI for batch operations.
var tool_buttons : Array[ToolButton]

## Label displaying the current day number.
@onready var day_text : Label = $DayText

## Label displaying the player's current money.
@onready var money_text : Label = $MoneyText


## Initializes the UI manager by finding tool buttons and connecting signals.
func _ready():
	# Get the ToolButtons container that contains the tool buttons
	var tool_buttons_container = $ToolButtons
	if tool_buttons_container:
		for child in tool_buttons_container.get_children():
			if child is ToolButton:
				tool_buttons.append(child)
	else:
		print("Warning: ToolButtons container not found")

	# Connect to GameManager if it exists
	if GameManager:
		GameManager.SetPlayerTool.connect(_on_set_player_tool)
		GameManager.NewDay.connect(_on_new_day)
		GameManager.ChangeMoney.connect(_on_change_money)
		# Initialize UI with current values
		_update_day_text(GameManager.day)
		_update_money_text(GameManager.money)
		print("UI Manager: Connected to GameManager, day=", GameManager.day, " money=", GameManager.money)
		print("UI Manager: day_text node=", day_text, " money_text node=", money_text)
	else:
		print("Warning: GameManager not found, UI manager won't receive tool updates")


## Called when the player selects a new tool.
## Updates button colors: selected tool is lime green, others are white.
## @param tool: The newly selected Tool enum value.
## @param _crop_seed: The CropData for seed tools (used to match specific seed buttons).
func _on_set_player_tool(tool: PlayerTools.Tool, _crop_seed: CropData):
	for button in tool_buttons:
		if button.tool != tool or button.crop_seed != _crop_seed:
			button.modulate = Color.WHITE
		else:
			button.modulate = Color.LIME_GREEN


## Called when a new day begins.
## Updates the day counter display.
## @param day: The new day number.
func _on_new_day(day: int):
	print("UI Manager: _on_new_day called with day=", day)
	_update_day_text(day)


## Called when the player's money changes.
## Updates the money display.
## @param money: The new money amount.
func _on_change_money(money: int):
	_update_money_text(money)


## Updates the day text label.
## @param day: The day number to display.
func _update_day_text(day: int):
	if day_text:
		day_text.text = "Day " + str(day)


## Updates the money text label.
## @param money: The money amount to display.
func _update_money_text(money: int):
	if money_text:
		money_text.text = "$ " + str(money)
