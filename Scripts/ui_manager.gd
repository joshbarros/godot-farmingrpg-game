extends CanvasLayer

var tool_buttons : Array[ToolButton]

func _ready():
    # Get the HBoxContainer that contains the tool buttons
    var hbox_container = $HBoxContainer
    if hbox_container:
        for child in hbox_container.get_children():
            if child is ToolButton:
                tool_buttons.append(child)

    # Connect to GameManager if it exists
    if GameManager:
        GameManager.SetPlayerTool.connect(_on_set_player_tool)
    else:
        print("Warning: GameManager not found, UI manager won't receive tool updates")

func _on_set_player_tool(tool: PlayerTools.Tool, seed: CropData):
    for button in tool_buttons:
        if button.tool != tool or button.crop_seed != seed:
            button.modulate = Color.WHITE
        else:
            button.modulate = Color.LIME_GREEN