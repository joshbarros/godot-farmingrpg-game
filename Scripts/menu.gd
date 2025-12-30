## Menu - Main Menu Screen Controller
##
## This script handles the main menu UI with Play and Quit buttons.
## It's the entry point scene for the game.
##
## Scene Structure:
##   Menu (Control)
##     └─ CenterContainer
##         └─ VBoxContainer
##             ├─ PlayButton - Starts the game
##             └─ QuitButton - Exits the application
##
## Navigation:
##   - Play button loads main.tscn (the game scene)
##   - Quit button closes the application
class_name Menu
extends Control

## Reference to the Play button for starting the game.
@onready var play_button : Button = $CenterContainer/VBoxContainer/PlayButton

## Reference to the Quit button for exiting the application.
@onready var quit_button : Button = $CenterContainer/VBoxContainer/QuitButton


## Initializes the menu by connecting button signals and setting focus.
func _ready():
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	# Focus on play button by default
	play_button.grab_focus()


## Called when the Play button is pressed.
## Loads the main game scene.
func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


## Called when the Quit button is pressed.
## Closes the application.
func _on_quit_pressed():
	get_tree().quit()
