class_name ToolButton
extends TextureButton

@export var tool : PlayerTools.Tool
@export var crop_seed : CropData

@onready var quantity_text : Label = $QuantityText
var is_selected = false:
    set(value):
        is_selected = value
        _update_visual_state()

func _ready():
    quantity_text.text = ""
    pivot_offset = size / 2
    # Connect the pressed signal explicitly
    GameManager.ChangeSeedQuantity.connect(_on_change_seed_quantity)
    self.pressed.connect(_on_button_pressed)
    _update_visual_state()  # Initialize visual state

func _on_pressed():
    GameManager.SetPlayerTool.emit(tool, crop_seed)

func set_selected(value: bool):
    is_selected = value

func _update_visual_state():
    if is_selected:
        # Add a border or change appearance to indicate selection
        modulate = Color.YELLOW  # Make the button yellow when selected
    else:
        modulate = Color.WHITE  # Normal color when not selected

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