## Player - Player Character Controller
##
## This script handles player movement and animation.
## Uses CharacterBody2D for physics-based movement with 4-directional animation.
##
## Controls:
##   - W/Up: Move up
##   - S/Down: Move down
##   - A/Left: Move left
##   - D/Right: Move right
##
## Animation System:
##   - 8 animations total: idle_up, idle_down, idle_left, idle_right,
##     walk_up, walk_down, walk_left, walk_right
##   - Animation selected based on movement state (idle/walk) and facing direction
##   - Facing direction persists when player stops moving
extends CharacterBody2D

## Movement speed in pixels per second. Adjustable in the inspector.
@export var move_speed : float = 30

## The direction the player is currently facing. Used for tool targeting.
## Persists even when not moving.
var facing_direction : Vector2

## Reference to the AnimatedSprite2D for playing movement animations.
@onready var anim : AnimatedSprite2D = $AnimatedSprite2D


## Initializes the player facing downward.
func _ready():
	facing_direction = Vector2.DOWN


## Handles movement input and physics each frame.
## Updates velocity based on WASD/arrow input and calls move_and_slide().
func _physics_process(_delta):
	var move_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if move_input:
		facing_direction = move_input

	velocity = move_input * move_speed

	move_and_slide()
	_animate()


## Updates the animation based on current movement state and facing direction.
## Selects between idle/walk states and up/down/left/right directions.
## Only changes animation if different from current to avoid restarting.
func _animate():
	var state = "walk" if velocity.length() > 0 else "idle"
	var direction : String

	if abs(facing_direction.x) > abs(facing_direction.y):
		direction = "right" if facing_direction.x > 0 else "left"
	else:
		direction = "down" if facing_direction.y > 0 else "up"

	var anim_name = state + "_" + direction
	if anim.animation != anim_name:
		anim.play(anim_name)


## Debug function that periodically prints the current tool.
## Prints every 3 seconds (180 frames at 60fps) to avoid console spam.
func _process(_delta):
	# Debug: print current tool occasionally
	var tools_node = $Tools
	if tools_node and tools_node.current_tool != null:
		# Only print occasionally to avoid spam
		if Engine.get_frames_drawn() % 180 == 0:  # Every 3 seconds at 60fps
			print("Current tool: ", tools_node.current_tool)
