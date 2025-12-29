extends CanvasLayer

var tool_buttons : Array[ToolButton]

func _ready():
    for child in $ToolButtons.get_children():
        if child is ToolButton:
            tool_buttons.append(child)
    
    GameManager.SetPlayerTool.connect(_on_set_player_tool)

func _on_set_player_tool(tool: PlayerTools.Tool, seed: CropData):
    for button in tool_buttons:
        if button.tool != tool or button.crop_seed != seed:
            button.modulate = Color.WHITE
        else:
            button.modulate = Color.LIME_GREEN