extends Node2D

var current_day: int = 1
@onready var farm_manager := $FarmManager

func _ready():
    # Connect input for day progression
    print("Day ", current_day, " has started. Press ENTER to advance to the next day.")

func _input(event):
    if event.is_action_pressed("ui_accept"):  # ENTER key
        advance_day()

func advance_day():
    current_day += 1
    print("Day ", current_day, " has started.")

    # Notify GameManager of the new day (which will propagate to farm manager)
    if GameManager:
        GameManager.NewDay.emit(current_day)
    else:
        # Fallback to direct call if GameManager is not available
        farm_manager._on_new_day(current_day)