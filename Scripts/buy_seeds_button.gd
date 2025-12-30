class_name BuySeedButton
extends BaseButton

@export var crop_data : CropData

@onready var price_text : Label = $PriceLabel

func _ready():
    pressed.connect(_on_pressed)

    if not crop_data:
        print("BuySeedButton: No crop_data assigned!")
        return

    if price_text:
        price_text.text = "$ " + str(crop_data.seed_price)

func _on_pressed():
    if not crop_data:
        print("BuySeedButton: Cannot buy - no crop_data assigned!")
        return

    print("BuySeedButton: Trying to buy seed for ", crop_data.resource_path)
    GameManager.try_buy_seed(crop_data)