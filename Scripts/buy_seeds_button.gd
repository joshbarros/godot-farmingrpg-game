## BuySeedButton - Shop Seed Purchase Button
##
## This script handles buttons in the shop UI for purchasing seeds.
## Each button is configured with a specific crop type and displays its price.
##
## Usage:
##   1. Add a BuySeedButton node to the UI
##   2. Assign a CropData resource to the crop_data export
##   3. Add a Label child named "PriceLabel" to display the price
##
## Dependencies:
##   - GameManager: Calls try_buy_seed() to process purchase
##   - CropData: Resource containing seed_price for display
class_name BuySeedButton
extends BaseButton

## The crop type this button sells. Set in the inspector.
@export var crop_data : CropData

## Label displaying the seed price ("$ X").
@onready var price_text : Label = $PriceLabel


## Initializes the button by connecting the pressed signal and setting price text.
func _ready():
	pressed.connect(_on_pressed)

	if not crop_data:
		print("BuySeedButton: No crop_data assigned!")
		return

	if price_text:
		price_text.text = "$ " + str(crop_data.seed_price)


## Called when the button is pressed.
## Attempts to purchase a seed through GameManager.
## Does nothing if crop_data is not assigned.
func _on_pressed():
	if not crop_data:
		print("BuySeedButton: Cannot buy - no crop_data assigned!")
		return

	print("BuySeedButton: Trying to buy seed for ", crop_data.resource_path)
	GameManager.try_buy_seed(crop_data)
