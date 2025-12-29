extends Node

signal NewDay(day : int)
signal SetPlayerTool(tool : PlayerTools.Tool, seed: CropData)
signal HarvestCrop(crop : Crop)
signal ChangeSeedQuantity(crop_data: CropData, quantity : int)
signal ChangeMoney(money : int)

var day : int = 1
var money : int = 0

var all_crop_data : Array[CropData] = [
	preload("res://Crops/tomato.tres"),
	preload("res://Crops/corn.tres"),
]

var owned_seeds : Dictionary[CropData, int]

func _ready():
	pass

func set_next_day():
	pass

func harvest_crop(crop : Crop):
	pass

func try_buy_seed(crop_data: CropData):
	if money < crop_data.seed_price:
		return
	
	money -= crop_data.seed_price
	owned_seeds[crop_data] += 1
	ChangeMoney.emit(money)
	ChangeSeedQuantity.emit(crop_data, owned_seeds[crop_data])

func consume_seed(crop_data : CropData):
	owned_seeds[crop_data] -= 1
	ChangeSeedQuantity.emit(crop_data, owned_seeds[crop_data])

func give_money(amount : int):
	money += amount
	ChangeMoney.emit(money)
