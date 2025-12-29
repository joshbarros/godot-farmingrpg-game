class_name ToolButton
extends TextureButton

@export var tool : PlayerTools.Tool
@export var crop_seed : CropData

@onready var quantity_text : Label = $QuantityText

func _ready():
    quantity_text.text = ""
    pivot_offset = size / 2

func _on_pressed():
    print("Tool button pressed: ", tool)  # Debug print
    # Find the player's tools component to change the selected tool
    var tools_node = get_node_or_null("/root/Main/Player/Tools")
    if tools_node and tools_node is PlayerTools:
        print("Found tools node, setting tool: ", tool)  # Debug print
        tools_node.set_tool(tool, crop_seed)
    else:
        print("Could not find tools node or wrong type")  # Debug print

func _on_mouse_entered():
    scale.x = 1.05
    scale.y = 1.05

func _on_mouse_exited():
    scale.x = 1
    scale.y = 1

func _on_change_seed_quantity(crop_data: CropData, quantity: int):
    if crop_data != crop_seed:
        return
    quantity_text.text = str(quantity)