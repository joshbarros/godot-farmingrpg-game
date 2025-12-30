## GameManager - Global Game State Manager (Autoloaded Singleton)
##
## This script manages all global game state including day progression, money,
## seed inventory, and acts as the central hub for game-wide signals.
##
## Signals:
##   - NewDay(day: int): Emitted when a new day begins
##   - SetPlayerTool(tool: PlayerTools.Tool, crop_seed: CropData): Emitted when player changes tools
##   - HarvestCrop(crop: Crop): Emitted when a crop is harvested
##   - ChangeSeedQuantity(crop_data: CropData, quantity: int): Emitted when seed count changes
##   - ChangeMoney(money: int): Emitted when player's money changes
##
## Usage:
##   Access via the autoloaded singleton: GameManager.day, GameManager.money, etc.
extends Node

## Emitted when a new day starts. Connected by FarmManager and Crop instances.
signal NewDay(day : int)

## Emitted when the player selects a new tool. Connected by Tools and UIManager.
signal SetPlayerTool(tool : PlayerTools.Tool, crop_seed: CropData)

## Emitted when a crop is harvested. Connected by FarmManager.
signal HarvestCrop(crop : Crop)

## Emitted when seed quantity changes. Connected by ToolButton for UI updates.
signal ChangeSeedQuantity(crop_data: CropData, quantity : int)

## Emitted when money changes. Connected by UIManager for display updates.
signal ChangeMoney(money : int)

## Current in-game day number, starts at 1.
var day : int = 1

## Player's current money balance.
var money : int = 0

## Array of all available crop types in the game.
## Preloaded at startup for quick access.
var all_crop_data : Array[CropData] = [
	preload("res://Crops/tomato.tres"),
	preload("res://Crops/corn.tres"),
]

## Dictionary tracking how many seeds of each crop type the player owns.
## Key: CropData resource, Value: quantity owned.
var owned_seeds : Dictionary[CropData, int]


## Initializes the game state with starting seeds and money.
func _ready():
	for cd in all_crop_data:
		give_seed.call_deferred(cd, 2)
	give_money.call_deferred(10)  # Start with some money
	print("Day ", day, " has started. Press ENTER to advance to the next day.")


## Handles unhandled input events.
## Listens for ENTER key to advance to the next day.
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):  # ENTER key
		set_next_day()


## Advances the game to the next day and emits NewDay signal.
## This triggers crop growth checks and tile state resets.
func set_next_day():
	day += 1
	NewDay.emit(day)


## Harvests a crop, giving the player money and cleaning up the crop node.
## @param crop: The Crop instance to harvest.
func harvest_crop(crop : Crop):
	give_money(crop.crop_data.sell_price)
	HarvestCrop.emit(crop)
	crop.queue_free()


## Attempts to purchase a seed of the given crop type.
## Does nothing if player doesn't have enough money.
## @param crop_data: The type of seed to buy.
func try_buy_seed(crop_data: CropData):
	if money < crop_data.seed_price:
		return

	money -= crop_data.seed_price
	owned_seeds[crop_data] += 1
	ChangeMoney.emit(money)
	ChangeSeedQuantity.emit(crop_data, owned_seeds[crop_data])


## Consumes one seed of the given type from inventory.
## Called when planting a seed.
## @param crop_data: The type of seed to consume.
func consume_seed(crop_data : CropData):
	owned_seeds[crop_data] -= 1
	ChangeSeedQuantity.emit(crop_data, owned_seeds[crop_data])


## Adds money to the player's balance and emits ChangeMoney signal.
## @param amount: The amount of money to add.
func give_money(amount : int):
	money += amount
	ChangeMoney.emit(money)


## Adds seeds to the player's inventory.
## Initializes the dictionary entry if this is the first seed of this type.
## @param crop_data: The type of seed to add.
## @param amount: The number of seeds to add.
func give_seed(crop_data : CropData, amount : int):
	if owned_seeds.has(crop_data):
		owned_seeds[crop_data] += amount
	else:
		owned_seeds[crop_data] = amount

	ChangeSeedQuantity.emit(crop_data, owned_seeds[crop_data])
