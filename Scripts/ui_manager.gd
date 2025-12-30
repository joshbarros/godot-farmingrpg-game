extends CanvasLayer

var tool_buttons : Array[ToolButton]

@onready var day_text : Label = $DayText
@onready var money_text : Label = $MoneyText

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

func _on_set_player_tool(tool: PlayerTools.Tool, _crop_seed: CropData):
    for button in tool_buttons:
        if button.tool != tool or button.crop_seed != _crop_seed:
            button.modulate = Color.WHITE
        else:
            button.modulate = Color.LIME_GREEN

func _on_new_day(day: int):
    print("UI Manager: _on_new_day called with day=", day)
    _update_day_text(day)

func _on_change_money(money: int):
    _update_money_text(money)

func _update_day_text(day: int):
    if day_text:
        day_text.text = "Day " + str(day)

func _update_money_text(money: int):
    if money_text:
        money_text.text = "$ " + str(money)
