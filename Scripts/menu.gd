class_name Menu
extends Control

@onready var play_button : Button = $CenterContainer/VBoxContainer/PlayButton
@onready var quit_button : Button = $CenterContainer/VBoxContainer/QuitButton

func _ready():
	play_button.pressed.connect(_on_play_pressed)
	quit_button.pressed.connect(_on_quit_pressed)

	# Focus on play button by default
	play_button.grab_focus()

func _on_play_pressed():
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_quit_pressed():
	get_tree().quit()
